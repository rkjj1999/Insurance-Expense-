install.packages("caret")
library("caret")

datas= read.csv("C:/Users/ronit/Downloads/NAICExpense (1) (1).csv")
dim(datas)


## 
colnames(datas)
head(datas)
## 


summary(datas)

## Insights:-  

options("scipen"= 100, "digits"= 4)

## Scaling
attach(datas)


exp= EXPENSES*1000
ls= LONGLOSS*1000
sl=SHORTLOSS*1000
gpwp= GPWPERSONAL*1000
gpwc= GPWCOMM*1000
asset_s=ASSETS*1000
cash_s= CASH*1000

datas.scaled= cbind.data.frame(datas, exp, ls, sl, gpwp, gpwc, asset_s,
                               cash_s)



colnames(datas.scaled)= c("COMPANY_NAME","GROUP","MUTUAL","STOCK","RBC","STAFFWAGE","AGENTWAGE","LIQUIDRATIO","EXPENSES","LONGLOSS","SHORTLOSS","GPWPERSONAL","GPWCOMM","ASSETS","CASH")

rm( exp, ls, sl, gpwp, gpwc, asset_s, cash_s)

datas= datas.scaled
dim(datas)

plot(datas)
plot(datas.scaled)

cor(RBC,STAFFWAGE, method= "spearman" )


## Correlation Graphs

install.packages("corrplot")
library("corrplot")

data(datas)
corr= cor(datas[,(2:14)])
corr

corrplot(corr, method= "pie")
corrplot(corr, method= "color")
corrplot(corr, method= "number")

head(round(corr,2))

corrplot(corr, type = "upper")

corrplot(corr, type= "lower")

corrplot(corr, type = "upper", col= c("black", "blue"), bg= "lightblue")


## Other graphs

library(ggplot2)

grouping(datas)

## Box plot 


boxplot(EXPENSES ~GROUP , data = datas, col= "#FFE0B2", "#FFE0B3")

boxplot(EXPENSES ~ MUTUAL , data = datas, col= "#FFE0B2", "#FFE0B3")

## Created a column name TOTAL_ASSET that is the sum of ASSETS and CASH
## this sum is the sum of fixed and current assets that will be required to compute the relationship with the EXPENSES
datas$TOTAL_ASSET = (ASSETS+CASH)
colnames(datas)

boxplot(EXPENSES~CASH, data=datas, main= "Expense Box Plot",
        xlab="cash",ylab="Expenses")


## Pareto Chart

install.packages("qcc")
library(qcc)

freqdist= table(GROUP)
pareto.chart(freqdist, main="GROUP pareto Chart", xlab= "GROUP", ylab= "Frequency",
             col= topo.colors(length(freqdist)))

freqdist1= table(MUTUAL)
len= length(freqdist1)
pareto.chart(freqdist1, main= "MUTUAL pareto Chart", col= topo.colors(len))
freqdist= table(STOCK)

pareto.chart(freqdist, main="STOCK pareto Chart", xlab= "STOCK", ylab= "Frequency",
             col= topo.colors(length(freqdist)))

## Data Preparation

library("caret")
dim(datas)
install.packages("tidyverse")
library(purrr)

map(datas, class)

## Subseting all the unwanted/null columns

datasa= datas1a
colnames(datasa)
datasa= subset(datasa, select = -c(NA.2))
datasa= subset(datasa, select = -c(NA.3))
datasa= subset(datasa, select = -c(NA.4))
datasa= subset(datasa, select = -c(NA.5))
datasa= subset(datasa, select = -c(NA.6))
datasa= subset(datasa, select = -c(NA.1))
datasa= subset(datasa, select = -c(15))
colnames(datasa)

## Now data is ready for its Modeling

attach(datasa)
datasa$Moneytary_Assets = (LIQUIDRATIO*EXPENSES)
colnames(datasa)

## Data Modeling

## Model 1 (Linear regression of EXPENSES & Moneytary Assets)

map(~ lm(Moneytary_Assets~ EXPENSES, data = datasa))


simple.fit= lm(Moneytary_Assets~LONGLOSS, data= datasa)
summary(simple.fit)
plot(simple.fit)

plot(Moneytary_Assets~LONGLOSS, data = datasa, pch= 19, col= "red")
abline(simple.fit, col= "black")
cor(Moneytary_Assets,LONGLOSS)

multi.fit=lm(Moneytary_Assets~LONGLOSS+SHORTLOSS, data = datasa)
summary(multi.fit)
plot(multi.fit)


## Model 2
simple.fit= lm(TOTAL_ASSET~LONGLOSS, data= datasa)
summary(simple.fit)
plot(simple.fit)
## Hit <Return> to see next plot: 
multi.fit= lm(TOTAL_ASSET~LONGLOSS+SHORTLOSS+EXPENSES+GPWPERSONAL+GPWCOMM+STAFFWAGE+AGENTWAGE
              +RBC, data=datasa)
summary(multi.fit)
plot(multi.fit)


plot(TOTAL_ASSET~LONGLOSS, data = datasa, pch= 19, col= "red")
abline(simple.fit, col= "black")
cor(TOTAL_ASSET,LONGLOSS)


library(ggplot2)
colnames(datasa)


## Checking with the heat maps
library(pheatmap)
pheatmap(datasa[,8:14], cluster_rows = TRUE, cluster_cols = TRUE, clustering_method = "complete")
