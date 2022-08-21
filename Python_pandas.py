# -*- coding: utf-8 -*-
"""Pandas.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1DZw2Hc6Lz57LuZm9oaVpiaIS5yCC9Mk4
"""

from google.colab import files 
uploaded = files.upload()

# import data
import pandas as pd
df = pd.read_csv("sample-store.csv")

# convert order date and ship date to datetime in the original dataframe
df['Order Date'] = pd.to_datetime(df['Order Date'], format = '%m/%d/%Y')
df['Ship Date'] = pd.to_datetime(df['Ship Date'], format = '%m/%d/%Y')
df

# preview top 5 rows
df.head()

#TODO 01 - how many columns, rows in this dataset
df.shape

#TODO 02 - is there any missing values?, if there is which column? how many nan values?
df.info()
df.isna().sum()

#TODO 03 - your friend ask for 'California' data, filter it and export csv for him
df[df['State'] == 'California']
df_CA = df[df['State'] == 'California']
df_CA
df_CA.to_csv('df_CA.csv', index = False)

#TODO 04 - your friend as for all order date in 'Calfironia' and 'Texas' in 2017 (look at Order Date), send him csv file 
df_CA_TX = df.query('State == "California" | State == "Texas"')
df_2017 = df_CA_TX[df_CA_TX['Order Date'].dt.year == 2017]
df_2017
df_2017.to_csv('df_2017.csv', index = False)

#TODO 05 - how much total sales, average, and standard deviation of sales your company make in 2017
df2017 = df[df['Order Date'].dt.year ==2017]
df2017['Sales'].describe()
df2017['Sales'].agg(['sum', 'mean', 'std'])

#TODO 06- which segment has the highest profit in 2018
df2018 = df[df['Order Date'].dt.year ==2018]
df2018.groupby('Segment')['Profit'].agg(['sum', 'max'])

#TODO 07 - which top 5 states have the least total sales between 15 April 2019 -  31 December 2019
df2019_Apr_Dec = df[(df['Order Date'] >= '2019-04-15') & (df['Order Date'] <= '2019-12-31')]
df2019_Apr_Dec.groupby('State')['Sales'].sum().sort_values().head(50)

#TODO 08 - what is the proportion of total sales (%) in west + central in 2019 e.g. 25%
df2019 = df[df['Order Date'].dt.year ==2019]
df2019_WC = df2019.query('Region == "West" | Region == "Central"')
sale2019WC = df2019_WC['Sales'].sum()
sale2019total = df2019['Sales'].sum()
proportion = (sale2019WC/ sale2019total)*100
print(f"{proportion.round(2)} % of total sales")

#TODO 09- find top 10 popular products in terms of number of orders vs. total sales during 2019-2020
df19_20 = df[(df['Order Date'].dt.year == 2019) | (df['Order Date'].dt.year == 2020)]
df19_20
top10_order = df19_20["Product Name"].value_counts().head(10)
top10_order
top10_sales =df19_20.groupby('Product Name')['Sales'].sum().sort_values(ascending=False).head(10)  
top10_sales

#TODO 10- plot at least 2 plots, any plot you think interesting
df2019.groupby(['Category'])['Sales'].sum()\
    .sort_values(ascending = False).head(10)\
    .plot(kind = 'bar')