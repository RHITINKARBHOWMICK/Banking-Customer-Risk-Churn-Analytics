# Banking-Customer-Risk-Churn-Analytics
End-to-end banking customer churn & risk analytics project using Python, SQL Server, and Power BI to identify churn drivers, segment customer risk, and develop retention strategies.  

# Banking Customer Risk & Churn Analytics

## Project Overview

This project is an end-to-end **Banking Customer Risk & Churn
Analytics** solution designed to help a bank identify customers with
high historical churn risk, understand the key factors associated with
churn, and prioritize customers for retention action.

The project combines:

-   **Python / Jupyter Notebook** for data cleaning, preparation and
    exploratory analysis
-   **SQL Server / SSMS** for structured analytics, customer risk
    scoring and segmentation
-   **Power BI** for interactive business intelligence dashboards and
    retention insights

The project follows a complete analytics workflow:

**Raw Data → Data Cleaning → Exploratory Analysis → SQL Analytics → Risk
Segmentation → Power BI Dashboard → Retention Strategy**

##  Business Problem

Customer churn can lead to significant revenue loss and higher customer
acquisition costs for banks.

The objective of this project is to answer four key business questions:

1.  **How large is the customer churn problem?**
2.  **Which customer characteristics are associated with higher
    historical churn?**
3.  **Which customers fall into high-, medium-, and low-risk segments?**
4.  **Which customers should be prioritized for retention
    intervention?**

## 🛠️ Tools & Technologies

  -----------------------------------------------------------------------
  Tool / Technology                   Purpose
  ----------------------------------- -----------------------------------
  Python                              Data cleaning, transformation and
                                      analysis

  Pandas                              Data manipulation

  NumPy                               Numerical operations

  Matplotlib / Seaborn                Exploratory data visualization

  Jupyter Notebook                    Analysis environment

  SQL Server                          Data storage and analytical
                                      querying

  SQL Server Management Studio (SSMS) SQL development and database
                                      management

  SQL                                 KPI analysis, churn analysis and
                                      risk segmentation

  Power BI                            Interactive dashboard and business
                                      reporting

  DAX                                 Measures, KPIs and calculated
                                      fields



## 📊 Dataset

The dataset contains **10,000 customer records and 24 analytical
fields**.

Important fields include:

-   `CustomerId`
-   `CreditScore`
-   `Geography`
-   `Gender`
-   `Age`
-   `Tenure`
-   `Balance`
-   `NumOfProducts`
-   `HasCrCard`
-   `IsActiveMember`
-   `EstimatedSalary`
-   `Exited`
-   `Complain`
-   `SatisfactionScore`
-   `CardType`
-   `PointEarned`

  Additional analytical grouping fields were used for segmentation,
including:

-   `Age_Group`
-   `Balance_Group`
-   `CreditScore_Group`
-   `Tenure_Group`
-   `Point_Earned_Group`
-   `Salary_Group`

  ### Target Variable

`Exited`

-   `0` = Existing customer
-   `1` = Churned customer

> Note: This project uses **historical churn analysis**. The risk
> segmentation is an analytical scoring framework and should not be
> interpreted as a machine-learning probability of future churn.

# 🔄 Project Workflow

## 1. Data Preparation --- Python

The dataset was loaded into Jupyter Notebook and prepared for analysis.

Key activities included:

-   Importing the dataset
-   Checking dataset dimensions
-   Inspecting data types
-   Checking missing values
-   Checking duplicate records
-   Validating categorical and numerical fields
-   Creating analytical groups
-   Performing exploratory data analysis

The cleaned dataset was then prepared for SQL Server analysis.

## 2. SQL Server Analytics

The cleaned customer data was loaded into a SQL Server database .

SQL Server was used to reproduce business analytics in a structured
database environment and create reusable analytical views.

Key SQL analyses included:

-   Customer-level analytics
-   Churn analysis
-   Churn rate calculations
-   Customer segmentation
-   Risk scoring
-   Risk-factor analysis
-   Historical churn by customer characteristics

  # ⚠️ Customer Risk Segmentation

A rule-based customer risk scoring framework was created using four
business indicators:

### Risk Factors

  Factor               Scoring Logic
  -------------------- -------------------------------------
  Complaint            +3 if complaint exists
  Satisfaction Score   +3 if score ≤ 2
  Active Membership    +2 if customer is inactive
  Number of Products   +1 if customer has 1 or 3+ products

The resulting score is used to classify customers into:

    Risk Score Risk Segment
  ------------ --------------
          0--2 Low Risk
          3--5 Medium Risk
            6+ High Risk


### Why this approach?

The objective was to create a simple, transparent and
interview-defensible risk framework rather than using a complex
black-box model.

This allows business users to understand **why a customer was classified
as high risk**.


# 📈 Key Analytical Findings

The analysis identified several notable historical churn patterns.

### Age

Historical churn increased substantially across older age groups.

  Age Group     Historical Churn Rate
  ----------- -----------------------
  18--30                        7.52%
  31--40                       12.11%
  41--50                       33.97%
  51--60                       56.21%

This suggests that age is an important dimension for customer-retention
analysis.

### Geography

Historical churn differed considerably by geography.

  Geography     Historical Churn Rate
  ----------- -----------------------
  France                       16.17%
  Germany                      32.44%
  Spain                        16.67%

Germany showed substantially higher historical churn than France and
Spain in this dataset.

### Complaint Status

Complaint status showed an extremely strong association with historical
churn:

  Complaint        Historical Churn Rate
  -------------- -----------------------
  No Complaint                     0.05%
  Complaint                       99.51%

This makes complaint handling a particularly important retention
indicator in the dataset.

### Number of Products

Historical churn varied significantly by the number of products held:

    Products   Historical Churn Rate
  ---------- -----------------------
           1                  27.71%
           2                   7.60%
           3                  82.71%
           4                 100.00%

The 3- and 4-product groups have relatively small populations, so their
very high churn rates should be interpreted cautiously.


# 🚦 Risk Segmentation Results

The final SQL risk segmentation produced the following results:

  -----------------------------------------------------------------------
  Risk                 Total        Churned       Existing     Historical
  Segment          Customers      Customers      Customers     Churn Rate
  ----------- -------------- -------------- -------------- --------------
  High Risk            1,903          1,898              5         99.74%

  Medium Risk          1,785            139          1,646          7.79%

  Low Risk             6,312              1          6,311          0.02%


  ### Business Interpretation

The risk framework successfully separates customer populations with very
different historical churn outcomes.

-   **High Risk:** Immediate retention attention
-   **Medium Risk:** Targeted engagement and monitoring
-   **Low Risk:** Relationship maintenance and potential cross-selling

> These are historical associations produced by the project's rule-based
> scoring system, not guaranteed future outcomes.


# 📊 Power BI Dashboard
## Page 1 --- Executive Risk Overview

> **Who is at risk?**

Includes:

-   Total Customers
-   Churned Customers
-   Historical Churn Rate
-   High Risk Customers
-   Average Balance
-   Average Credit Score
-   Customer risk distribution
-   Churn by risk segment
-   Churn by member status
-   Churn by complaint status
-   Churn by geography
-   Customer risk detail table
-   Interactive slicers

  ## Page 2 --- Customer Churn Drivers

> **What characteristics are associated with churn?**

Includes historical churn analysis by:

-   Age Group
-   Credit Score Group
-   Number of Products
-   Balance Group
-   Tenure Group
-   Card Type

Interactive filters allow users to explore churn patterns across
customer segments.


## Page 3 --- Risk & Retention Strategy
**Who should the bank prioritize for retention?**
Includes:

-   High Risk Customers
-   High Risk Churned Customers
-   High Risk Existing Customers
-   Medium Risk Customers
-   Low Risk Customers
-   High Risk Customers by Geography
-   High Risk Customers by Age Group
-   High Risk Customers by Number of Products
-   Customer Base & Historical Churn by Risk Segment
-   Retention Action Plan
-   High-Risk Customer Detail table

  # 💡 Business Recommendations

Based on the historical analysis, the bank could consider:

### 1. Prioritize complaint resolution

Customers with complaints demonstrated extremely high historical churn
in this dataset.

**Action:** Introduce faster complaint resolution, escalation mechanisms
and post-resolution follow-ups.

### 2. Focus on high-risk customers

The high-risk segment showed a very high historical churn rate.

**Action:** Create a retention queue for high-risk customers and
prioritize proactive outreach.

### 3. Monitor older customer segments

Historical churn increased considerably among older age groups.

**Action:** Develop targeted engagement and relationship-management
strategies for higher-churn age segments.

### 4. Investigate geographic differences

Germany showed higher historical churn than France and Spain.

**Action:** Investigate regional differences in customer experience,
product usage, pricing, service quality and competitive pressure.

### 5. Investigate unusual product relationships

Customers with 3 or 4 products showed very high historical churn rates,
but these groups are relatively small.

**Action:** Investigate whether these customers have specific product
combinations, service issues or relationship characteristics before
implementing broad retention policies.
  
  
  
  
 # 👤 Project Objective for Resume

This project demonstrates the ability to take a real-world banking
customer dataset through a complete analytics lifecycle:

**Python → SQL Server → Power BI → Business Recommendations**

The emphasis is on transforming raw customer data into **actionable
churn and customer-risk insights** rather than simply creating
visualizations.

                                      
