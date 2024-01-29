# Data Analytics PowerBI Report 

This project aims to leverage PowerBI to design a comprehensive Quarterly Report for a medium-sized international retailer to help enhance their business intelligence practices.

This will project will involve: 
- Extracting and transforming data
- Data Modelling
- Constructing a multi-page report
- A High-level business summary
- Analysis of high value customers
- Analysis of top perfoming products
- Creating a map visual 

## Milestone 2
### Loading and Transforming the data in PowerBI
In this milestone, the data is imported from various sources and prepared for analysis. 

#### Orders Table
The data for this table was imported from an Azure SQL Database. 
The following data cleaning took place in Power Query Editor: 
- Removing Card details for data privacy
- Splitting Order and Shipping Date columns into date and time components
- Renaming columns to align with naming conventions

#### Products Table 
The data for this table was imported from a csv file.
The following data cleaning took place in Power Query Editor: 
- Removing duplicates based on product codes
- Generating and cleaning a new weight value and units column using Column from Examples feature
- Creating a calculated column to convert into kg

#### Stores Table 
The data for this table was imported using Azure Blob Storage.
The only adjustments in this table was renaming the columns to align with naming conventions.

#### Customers Table
The data in this file was imported from 3 csv files which was combined into one table. 
The following data cleaning took place in Power Query Editor: 
- Creating a Full Name column by combining first and last name
- Renaming columns to align with naming conventions

## Milestone 3
### Creating the Data Model
This milestone focuses on laying the foundation for advanced analysis. 

#### Creating a Date Table: 
Generating a continuous date table to cover the entire period of the data. 
The following columns were added using DAX formulas: 
- Day of Week
- Month Number
- Month Name
- Quarter
- Year
- Start of Year
- Start of Quarter
- Start of Month
- Start of Week

#### Creating Relationships: 
The following relationships were established to form a star schema: 
- Orders[product_code] to Products[product_code]
- Orders[Store Code] to Stores[store code]
- Orders[User ID] to Customers[User UUID]
- Orders[Order Date] to Date[date]
- Orders[Shipping Date] to Date[date]

#### Creating a Measures Table: 
The following measures were added for analysis: 
- Total Orders = COUNTROWS(Orders)
- Total Revenue = SUMX(Orders, Orders[Product Quantity] * RELATED(Products[Sale Price]))
- Total Profit = SUMX(Orders, (RELATED(Products[Sale Price]) - RELATED(Products[Cost Price])) * Orders[Product Quantity])
- Total Customers = DISTINCTCOUNT(Orders[User ID])
- Total Quantity = SUM(Orders[Product Quantity])
- Profit YTD (Year to Date) = CALCULATE([Total Profit],DATESYTD('Date'[date]))
- Revenue YTD (Year to Date) = CALCULATE([Total Revenue],DATESYTD('Date'[date]))

#### Creating Date and Geography Hierarchy:
The Date Hierarchy was constructed with the following levels: 
- Start of Year
- Start of Quarter
- Start of Month
- Start of Week
- Date

The Geography Hierarchy was constructed with the following levels: 
- World Region: Continent
- Country: Country (A new calculated column: SWITCH('Stores'[Country Code], "GB", "United Kingdom", "US", "United States", "DE", "Germany"))
- Country Region: State or Province




