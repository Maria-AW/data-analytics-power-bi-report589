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

## Milestone 4
### Setting up the Report
In this milestone, I created the essential report pages and a navigation sidebar to facilitate easy movement across report pages. 

## Milestone 5
### Customer Detail Report
This milestone focuses on customer level analysis and enhancing the visual appeal and interactivity of the report. 

#### Creating Headline Card Visuals 
I created a card visual for total customers using the measure created earlier and renaming to display as 'Unique customers'.
I created a new measure 'Revenue per Customer' for the second card. The calculation for this measure was a follows: 
- Revenue per Customer = [Total Revenue] / [Total Customers]

<img width="215" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/1dc406e4-2c78-4136-a8df-fe1839cfc198">

#### Creating Summary Charts
I created two summary charts to visualise customers by country and customers by product data. 

<img width="375" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/e08179c4-11b4-40b8-82f4-83f848825678">

#### Creating a Line Chart
Using date hierarchy and total customers, I created a line chart to show total customers over a period of time.
The line chart includes a trend line and a forecast for the next 10 periods with a 95% confidence level. 
Users are able to drill down on month level. 

#### Creating Top 20 Customers Table 
I created the new table as follows: 
Top Customers = 
    TOPN
    (20, 
    SUMMARIZE(
        Orders,
        Customers[Full Name],
        "Revenue", [Total Revenue],
        "Number of Orders", [Total Orders]
    ),
    [Revenue], DESC)

I applied conditional formatting to the revenue column to display data bars to help visualise the revenue values

<img width="320" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/86c38cb8-ff70-4929-99b4-7605a14abeae">

#### Creating Top Customer Cards
The folling three cards were created to summarise the details of the top customer: 
1. Top Customer Name = MAXX (TOPN(1, 'Top Customers', [Revenue], DESC), 'Top Customers'[Full Name])
2. Top Customer Orders = MAXX (TOPN(1, 'Top Customers', [Revenue], DESC), 'Top Customers'[Number of Orders])
3. Top Customer Revenue = MAXX (TOPN(1, 'Top Customers', [Revenue], DESC), 'Top Customers'[Revenue])

<img width="245" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/2607c863-8626-44c2-8234-4e7b29e43a25">

#### Date Slicer
Lastly I added a date slicer to allow better interactivity for users to filter the page by year. 

Please see below for an overview of the entire Customer Detail Report: 

<img width="967" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/92d26b9b-c944-4bd7-beff-059d6d36a030">

## Milestone 6
### Executive Summary Report
In this milestone, I create a report page for a high-level executive summary to get an overview of the companies performance as a whole. 

#### Card Visuals
I created the following 3 card visuals: 
1. Total Revenue
2. Total Orders
3. Total Profit

<img width="443" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/8c82f202-abf2-4d0d-a4f6-58a7c951dfe8">

#### Revenue Trending Line Chart 
The line chart uses the date hierarchy and total revenue. 

<img width="458" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/a346e25a-7d96-4255-a5df-0e7f8ea85b03">

#### Revenue by Country and Store Type
I created two donut charts showing total revenue broken down by country and store type

<img width="440" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/c47db340-2a16-47bd-bdc6-23dcaa8d6ddf">

#### Orders by Product Category
This bar chart was created to show the number of orders by category.

<img width="427" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/cf7c3348-3529-492c-8b8e-ec1137a4299d">

#### KPIs
I created new target measures for the following 3 KPIS:
1. Quarterly Revenue: Target Revenue = [Previous Quarter Revenue] * 1.05
2. Orders: Target Orders = [Previous Quarter Orders] * 1.05
3. Profit: Target Profit= [Previous Quarter Profit] * 1.05

The Targets were equal to 5% growth in previous quarter. 

<img width="567" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/b0d78136-ea49-49d0-8c34-1afc220591f9">

Please see below for an overview of the Executive Summary Report: 

<img width="969" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/7066d089-6411-4dba-a910-374fdc0cb771">

## Milestone 7
### Product Detail Report
In this report I detail what products within inventory are performing well. This report combines all products for all regions. 

#### Gauge Visuals 
I created a set of three gauge visuals showing the current performance of order, revenue and profit against the quartley target. 
The target is 10% quarter on quarter growth. 

- Current Quarter Revenue = TOTALQTD([Total Revenue], 'Date'[Date])
- Quarterly Target Revenue = [Current Quarter Revenue] * 1.10

- Current Quarter Profit = TOTALQTD([Total Profit], 'Date'[Date])
- Quarterly Target Profit = [Current Quarter Profit] * 1.10

- Current Quarter Orders = TOTALQTD([Total Orders], 'Date'[Date])
- Quarterly Target Orders = [Current Quarter Orders] * 1.10

<img width="756" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/c932f72d-41e6-4ea2-93d2-83a982d70566">

#### Revenue by Product Category Area Chart
This chart outlines how each product category if performing over time based on revenue. 

<img width="583" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/9f5bc041-5442-46d7-ac59-53e9500d60d9">

#### Top Products Table
I created a top 10 products table as follows: 
Top Products = 
TOPN(
    10,
    SUMMARIZE(
        Products,
        Products[Description],
        Products[Category],
        "Total Revenue", [Total Revenue],
        "Total Customers", [Total Customers],
        "Total Orders", [Total Orders],
        "Profit per Order", [Total Profit]
    ),
    [Total Revenue], DESC
)

<img width="607" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/2b0086c4-043e-4fea-9de2-f66551301121">

#### Scatter Graph 
This scatter graph allows the products team to identify which product ranges are profitable and top selling. This will help them focus on which products to market promotional campaigns on. 

For this scatter graph I created a new calculated column for 'Profit Per Item'
- Profit per Item = [Sale Price] - [Cost Price]

<img width="450" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/074a44ae-d7d4-45fb-ae80-914965c72ccd">

#### Slicer Toolbar
To control how the data is filtered on this page, I created a slicer pop-out toolbar which can be hidden when not in use. 

The following steps took place to create this slicer toolbar: 
1. Add a filter icon on the top of the navigation bar and set the tooltip text to 'Open Slicer Panel'.
2. Create a new navigation bar 3X the size of the original and bring to the top of the stacking order.
3. Add two new slicers as a verticle list: Products[Category] and Stores[Country].
4. Ensure that it is possible to select multiple items for Products[Category] but only one for Stores[Country].
5. Group the slicers with the new navigation bar.
6. Add a back button to hide the slicer toolbar when not in use and add to the group created above.
7. Create two new bookmarks one with the toolbar hidden (Name this: 'Slicer Bar Closed') and one with the toolbar open (Name this: 'Slicer Bar Open').
8. Right click and ensure data is unchecked.
9. Format both Filter button and Back button with the action setting on.
10. For each button assign the type to the appropriate bookmark. 

<img width="234" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/d994b4d0-c75c-480a-9cea-9bad622c149c">

Please see below for an overview of the entire Product Detail Report: 
<img width="1106" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/ba5454d6-3df8-4828-b85b-e7dc0dfc0e65">

## Milestone 8
### Stores Map Page
This page will allow regional managers to easily check stores under their controls quartely profit and targets. 

#### Map Visual
- Location of the map is set to the geography hierarchy
- Bubble size is set to Profit YTD

#### Country Slicer
The slicer field is set to Stores[Country] and in the slicer style Tile. 
I ensured that Multi-select was allowed and Select All was an option in the slicer. 

<img width="1108" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/633ce554-8ff8-4e17-8842-ce46ee36db38">

#### Stores Drillthrough Page
This page is to summarise the progress and performance of a given store. 
The visuals included:
- A table with top 5 products
- A column chart of Total Orders by product catergory
- Gauges for Profit YTD against 20% year-on-year growth target
- Card visual showing the selected store

<img width="1108" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/2fa0e72a-6d90-4292-83a6-9ab757d04e6c">

#### Stores Tooltip Page
Allows users to see each stores year to date profit performance against the profit target 

<img width="316" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/f434fab3-6707-49c2-b2e8-24dcceeb01cc">

## Milestone 9
### Cross-Filtering and Navigation 
In this milestone I will fix the cross filtering to avoid certain visuals being automatically filtered. 
I will also be completing the navigation bar so each page can be easily navigated to. 

#### Fixing the cross-filtering 
1. Executive Summary page: Ensuring that the Product Category bar chart and Top 10 Products table are not filtering the KPIs
2. Customer Detail page:
   - Top 20 Customers table should not filter any other visual.
   - Total Customers by Product Donus Chart should not affect the customers line graph
   - Total Customers by Country donut chart should cross-filter Total Customers by Product donut Chart
3. Product Detail page:
   - Orders vs. Profitability scatter graph should not affect any other visuals
   - Top 10 Products table should not affect any other visuals
   
#### Completing the navigation bar
Here I add navigation buttons for the report pages and format in the following way:
- Each button has been formatted to be a different colour On Hover
- Each button has Action format option turned on
- Type set as page navigation
- Destination set to the appropriate report page
- Lastly the buttons were grouped together 

<img width="42" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/aacad4b0-8c37-4c39-ba89-117c41c2e515">
<img width="44" alt="image" src="https://github.com/Maria-AW/data-analytics-power-bi-report589/assets/150281299/eccb0aca-0d45-4904-9622-f9ca4f1142f9">

## Milestone 10 
### SQL Queries
In this milestone I used SQL to query data which can give insights to clients who do not have access to PowerBI 
Please see question_1 to question_5 for further data insights on: 
1. How many staff there are in all of the UK stores
2. Which month in 2022 had the highest revenue
3. Which German store type had the highest revenue for 2022
4. A view where the rows are the store types and the columns are the total sales, percentage of total sales and the count of orders
5. Which product category generated the most profit for the "Wiltshire, UK" region in 2021
