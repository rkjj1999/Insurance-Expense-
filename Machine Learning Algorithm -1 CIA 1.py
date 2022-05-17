#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
df = pd.read_csv('C:/Users/HP/Downloads/NAICExpense.csv')
df.head()


# In[2]:


##correlation


# In[3]:


df = pd.DataFrame(NAICExpense)
print(df.describe())


# In[ ]:


##correlation


# In[4]:


import pandas as pd
from scipy.stats import pearsonr
df = pd.read_csv("C:/Users/HP/Downloads/NAICExpense.csv")
list1 = df['STAFFWAGE']
list2 = df['COMPANY']


# In[5]:


import matplotlib.pyplot as plt


# In[8]:


import seaborn as sns
import matplotlib.pyplot as plt

# loading dataset
import pandas as pd
data = pd.read_csv('C:/Users/HP/Downloads/NAICExpense.csv')

# draw lineplot
sns.catplot(x="COMPANY", y="STAFFWAGE", data=data)


# In[7]:


import pandas as pd
import matplotlib.pyplot as plt

dataframe = pd.read_csv("C:/Users/HP/Downloads/NAICExpense.csv")

Attribute = dataframe["AGENTWAGE"]


columns = [Attribute]

fig, ax = plt.subplots()
ax.boxplot(columns)
plt.show()


# In[ ]:




