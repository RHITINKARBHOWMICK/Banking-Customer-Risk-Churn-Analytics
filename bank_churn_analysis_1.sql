USE BankingChurnAnalytics;
GO

SELECT
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Churned_Customers,
    SUM(CASE WHEN Exited = 0 THEN 1 ELSE 0 END) AS Existing_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM dbo.banking_customers;

SELECT
    Complain,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM dbo.banking_customers
GROUP BY Complain
ORDER BY Churn_Rate_Percent DESC;

SELECT
    SatisfactionScore,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM dbo.banking_customers
GROUP BY SatisfactionScore
ORDER BY SatisfactionScore;

SELECT
    CardType,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM dbo.banking_customers
GROUP BY CardType
ORDER BY Churn_Rate_Percent DESC;

SELECT
    Age_Group,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM dbo.banking_customers
GROUP BY Age_Group
ORDER BY Churn_Rate_Percent DESC;

SELECT
    IsActiveMember,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM dbo.banking_customers
GROUP BY IsActiveMember
ORDER BY Churn_Rate_Percent DESC;

SELECT
    NumOfProducts,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM dbo.banking_customers
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

SELECT
    Geography,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS Churn_Rate_Percent
FROM dbo.banking_customers
GROUP BY Geography
ORDER BY Churn_Rate_Percent DESC;


USE BankingChurnAnalytics;
GO

CREATE OR ALTER VIEW dbo.vw_CustomerAnalytics
AS
SELECT
    CustomerId,
    Surname,
    Geography,
    Gender,
    Age,
    Age_Group,
    CreditScore,
    CreditScore_Group,
    Tenure,
    Tenure_Group,
    Balance,
    Balance_Group,
    NumOfProducts,
    HasCrCard,
    IsActiveMember,
    EstimatedSalary,
    Salary_Group,
    Exited,
    Complain,
    SatisfactionScore,
    CardType,
    PointEarned,
    Point_Earned_Group
FROM dbo.banking_customers;
GO

SELECT TOP 10 *
FROM dbo.vw_CustomerAnalytics;

SELECT COUNT(*) AS Total_Customers
FROM dbo.vw_CustomerAnalytics;



USE BankingChurnAnalytics;
GO

SELECT
    CustomerId,
    Complain,
    SatisfactionScore,
    IsActiveMember,
    NumOfProducts,
    Exited
FROM dbo.vw_CustomerAnalytics;

SELECT
    CustomerId,
    Complain,
    SatisfactionScore,
    IsActiveMember,
    NumOfProducts,

    (
        CASE 
            WHEN Complain = 1 THEN 3
            ELSE 0
        END
        +
        CASE
            WHEN SatisfactionScore <= 2 THEN 3
            ELSE 0
        END
        +
        CASE
            WHEN IsActiveMember = 0 THEN 2
            ELSE 0
        END
        +
        CASE
            WHEN NumOfProducts = 1 THEN 1
            WHEN NumOfProducts >= 3 THEN 1
            ELSE 0
        END
    ) AS Risk_Score

FROM dbo.vw_CustomerAnalytics;

SELECT
    CustomerId,
    Complain,
    SatisfactionScore,
    IsActiveMember,
    NumOfProducts,

    (
        CASE 
            WHEN Complain = 1 THEN 3
            ELSE 0
        END
        +
        CASE
            WHEN SatisfactionScore <= 2 THEN 3
            ELSE 0
        END
        +
        CASE
            WHEN IsActiveMember = 0 THEN 2
            ELSE 0
        END
        +
        CASE
            WHEN NumOfProducts = 1 THEN 1
            WHEN NumOfProducts >= 3 THEN 1
            ELSE 0
        END
    ) AS Risk_Score,

    CASE
        WHEN
            (
                CASE WHEN Complain = 1 THEN 3 ELSE 0 END
                +
                CASE WHEN SatisfactionScore <= 2 THEN 3 ELSE 0 END
                +
                CASE WHEN IsActiveMember = 0 THEN 2 ELSE 0 END
                +
                CASE
                    WHEN NumOfProducts = 1 THEN 1
                    WHEN NumOfProducts >= 3 THEN 1
                    ELSE 0
                END
            ) >= 6
        THEN 'High Risk'

        WHEN
            (
                CASE WHEN Complain = 1 THEN 3 ELSE 0 END
                +
                CASE WHEN SatisfactionScore <= 2 THEN 3 ELSE 0 END
                +
                CASE WHEN IsActiveMember = 0 THEN 2 ELSE 0 END
                +
                CASE
                    WHEN NumOfProducts = 1 THEN 1
                    WHEN NumOfProducts >= 3 THEN 1
                    ELSE 0
                END
            ) >= 3
        THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS Risk_Segment

FROM dbo.vw_CustomerAnalytics;


  SELECT
    Risk_Segment,
    COUNT(*) AS Total_Customers,

    SUM(
        CASE
            WHEN Exited = 1 THEN 1
            ELSE 0
        END
    ) AS Churned_Customers,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Exited = 1 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS Historical_Churn_Rate

FROM
(
    SELECT
        Exited,

        (
            CASE WHEN Complain = 1 THEN 3 ELSE 0 END
            +
            CASE WHEN SatisfactionScore <= 2 THEN 3 ELSE 0 END
            +
            CASE WHEN IsActiveMember = 0 THEN 2 ELSE 0 END
            +
            CASE
                WHEN NumOfProducts = 1 THEN 1
                WHEN NumOfProducts >= 3 THEN 1
                ELSE 0
            END
        ) AS Risk_Score

    FROM dbo.vw_CustomerAnalytics
) AS CustomerRisk

CROSS APPLY
(
    SELECT
        CASE
            WHEN Risk_Score >= 6 THEN 'High Risk'
            WHEN Risk_Score >= 3 THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS Risk_Segment
) AS Segmentation

GROUP BY Risk_Segment
ORDER BY Historical_Churn_Rate DESC;





SELECT
    Risk_Segment,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Churned_Customers,
    SUM(CASE WHEN Exited = 0 THEN 1 ELSE 0 END) AS Existing_Customers,

    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS Churn_Rate

FROM
(
    SELECT
        Exited,

        (
            CASE WHEN Complain = 1 THEN 3 ELSE 0 END
            +
            CASE WHEN SatisfactionScore <= 2 THEN 3 ELSE 0 END
            +
            CASE WHEN IsActiveMember = 0 THEN 2 ELSE 0 END
            +
            CASE
                WHEN NumOfProducts = 1 THEN 1
                WHEN NumOfProducts >= 3 THEN 1
                ELSE 0
            END
        ) AS Risk_Score

    FROM dbo.vw_CustomerAnalytics
) AS CustomerRisk

CROSS APPLY
(
    SELECT
        CASE
            WHEN Risk_Score >= 6 THEN 'High Risk'
            WHEN Risk_Score >= 3 THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS Risk_Segment
) AS Segmentation

GROUP BY Risk_Segment
ORDER BY Churn_Rate DESC;



SELECT
    'Complaint' AS Risk_Factor,
    CAST(Complain AS VARCHAR(10)) AS Factor_Value,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS Churn_Rate
FROM dbo.vw_CustomerAnalytics
GROUP BY Complain

UNION ALL

SELECT
    'Satisfaction Score',
    CAST(SatisfactionScore AS VARCHAR(10)),
    COUNT(*),
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END),
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    )
FROM dbo.vw_CustomerAnalytics
GROUP BY SatisfactionScore

UNION ALL

SELECT
    'Active Member',
    CAST(IsActiveMember AS VARCHAR(10)),
    COUNT(*),
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END),
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    )
FROM dbo.vw_CustomerAnalytics
GROUP BY IsActiveMember

UNION ALL

SELECT
    'Number of Products',
    CAST(NumOfProducts AS VARCHAR(10)),
    COUNT(*),
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END),
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    )
FROM dbo.vw_CustomerAnalytics
GROUP BY NumOfProducts

ORDER BY Risk_Factor, Factor_Value;




SELECT
    CustomerId,
    Complain,
    IsActiveMember,
    NumOfProducts,
    Exited,

    (
        CASE
            WHEN Complain = 1 THEN 3
            ELSE 0
        END
        +
        CASE
            WHEN NumOfProducts = 1 THEN 1
            WHEN NumOfProducts >= 3 THEN 2
            ELSE 0
        END
        +
        CASE
            WHEN IsActiveMember = 0 THEN 1
            ELSE 0
        END
    ) AS Risk_Score,

    CASE
        WHEN
            (
                CASE WHEN Complain = 1 THEN 3 ELSE 0 END
                +
                CASE
                    WHEN NumOfProducts = 1 THEN 1
                    WHEN NumOfProducts >= 3 THEN 2
                    ELSE 0
                END
                +
                CASE WHEN IsActiveMember = 0 THEN 1 ELSE 0 END
            ) >= 4
        THEN 'High Risk'

        WHEN
            (
                CASE WHEN Complain = 1 THEN 3 ELSE 0 END
                +
                CASE
                    WHEN NumOfProducts = 1 THEN 1
                    WHEN NumOfProducts >= 3 THEN 2
                    ELSE 0
                END
                +
                CASE WHEN IsActiveMember = 0 THEN 1 ELSE 0 END
            ) >= 2
        THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS Risk_Segment

FROM dbo.vw_CustomerAnalytics;


SELECT
    Risk_Segment,
    COUNT(*) AS Total_Customers,

    SUM(CASE
        WHEN Exited = 1 THEN 1
        ELSE 0
    END) AS Churned_Customers,

    SUM(CASE
        WHEN Exited = 0 THEN 1
        ELSE 0
    END) AS Existing_Customers,

    ROUND(
        100.0 *
        SUM(CASE
            WHEN Exited = 1 THEN 1
            ELSE 0
        END) / COUNT(*),
        2
    ) AS Historical_Churn_Rate

FROM
(
    SELECT
        Exited,

        CASE
            WHEN
                (
                    CASE WHEN Complain = 1 THEN 3 ELSE 0 END
                    +
                    CASE
                        WHEN NumOfProducts = 1 THEN 1
                        WHEN NumOfProducts >= 3 THEN 2
                        ELSE 0
                    END
                    +
                    CASE WHEN IsActiveMember = 0 THEN 1 ELSE 0 END
                ) >= 4
            THEN 'High Risk'

            WHEN
                (
                    CASE WHEN Complain = 1 THEN 3 ELSE 0 END
                    +
                    CASE
                        WHEN NumOfProducts = 1 THEN 1
                        WHEN NumOfProducts >= 3 THEN 2
                        ELSE 0
                    END
                    +
                    CASE WHEN IsActiveMember = 0 THEN 1 ELSE 0 END
                ) >= 2
            THEN 'Medium Risk'

            ELSE 'Low Risk'
        END AS Risk_Segment

    FROM dbo.vw_CustomerAnalytics
) AS RiskData

GROUP BY Risk_Segment

ORDER BY Historical_Churn_Rate DESC;




USE BankingChurnAnalytics;
GO

CREATE OR ALTER VIEW dbo.vw_CustomerRisk
AS

WITH RiskBase AS
(
    SELECT
        CustomerId,
        Geography,
        Gender,
        Age,
        Age_Group,
        CreditScore,
        Tenure,
        Tenure_Group,
        Balance,
        Balance_Group,
        NumOfProducts,
        HasCrCard,
        IsActiveMember,
        EstimatedSalary,
        Salary_Group,
        Complain,
        SatisfactionScore,
        CardType,
        PointEarned,
        Exited,

        (
            CASE
                WHEN Complain = 1 THEN 3
                ELSE 0
            END
            +
            CASE
                WHEN NumOfProducts = 1 THEN 1
                WHEN NumOfProducts >= 3 THEN 2
                ELSE 0
            END
            +
            CASE
                WHEN IsActiveMember = 0 THEN 1
                ELSE 0
            END
        ) AS Risk_Score

    FROM dbo.banking_customers
)

SELECT
    CustomerId,
    Geography,
    Gender,
    Age,
    Age_Group,
    CreditScore,
    Tenure,
    Tenure_Group,
    Balance,
    Balance_Group,
    NumOfProducts,
    HasCrCard,
    IsActiveMember,
    EstimatedSalary,
    Salary_Group,
    Complain,
    SatisfactionScore,
    CardType,
    PointEarned,
    Exited,
    Risk_Score,

    CASE
        WHEN Risk_Score >= 4 THEN 'High Risk'
        WHEN Risk_Score >= 2 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS Risk_Segment

FROM RiskBase;
GO



SELECT TOP 20
    CustomerId,
    Complain,
    IsActiveMember,
    NumOfProducts,
    Exited,
    Risk_Score,
    Risk_Segment
FROM dbo.vw_CustomerRisk;


SELECT
    Risk_Segment,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS Historical_Churn_Rate
FROM dbo.vw_CustomerRisk
GROUP BY Risk_Segment
ORDER BY Historical_Churn_Rate DESC;

