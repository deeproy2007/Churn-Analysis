####    Customer Churn Analytics & Financial Risk Intelligence
SQL-Driven Churn Segmentation, Asset Loss Analysis & Retention Strategy
Table of Contents
Executive Summary
Business Problem
Project Objectives
Dataset Overview
Technical Stack
Analytical Workflow
Key Features
SQL Analysis Breakdown
Risk Segmentation Methodology
Financial Impact Analysis
Dashboard Overview
Key Insights
Business Recommendations
Performance Optimization
Project Outcome
Future Improvements
Executive Summary

This project focuses on identifying customer churn risk and quantifying the financial impact of churn using SQL-based analytics and Power BI dashboards.

Instead of only measuring churn percentage, the analysis was designed to answer three critical business questions:

Which customers create the highest financial risk?
What behavioral patterns drive churn?
How much revenue can be protected through targeted retention strategies?

The project analyzed customer behavior, activity status, geography, product ownership, credit profile, and account balance to build a risk-based customer segmentation framework.

Key findings revealed:

Approximately 31% of customers belong to the high-risk segment
Inactive customers show 1.32× higher churn risk
Germany and France contribute the highest concentration of asset loss
Customers with only one product demonstrate significantly higher churn probability
Estimated asset loss from churn reached nearly $186M

A churn reduction simulation also demonstrated that even a modest retention improvement could recover millions in customer assets.

Business Problem

Customer churn directly impacts profitability, customer lifetime value, and asset retention.

Traditional churn reporting often focuses only on churn percentages without identifying:

high-value customers at risk
financial exposure concentration
behavioral drivers behind churn
actionable retention priorities

This project addresses that gap by combining churn analytics with financial impact assessment.

Project Objectives
Analyze customer churn behavior using SQL
Identify high-risk customer segments
Measure financial exposure caused by churn
Detect major churn drivers
Create business-focused KPIs
Build executive dashboards in Power BI
Simulate potential savings from churn reduction
Dataset Overview

The dataset contains customer banking information including:

Category	Fields
Customer Info	CustomerId, Gender, Geography, Age
Financial Metrics	Balance, EstimatedSalary, CreditScore
Customer Behavior	Tenure, NumOfProducts, IsActiveMember
Target Variable	Exited (Churn Status)
Technical Stack
Tool	Purpose
MySQL	Data cleaning, transformation, analytics
Power BI	Dashboard development & visualization
SQL Window Functions	Advanced segmentation & ranking
DAX	KPI calculations
Data Modeling	Business logic integration
Analytical Workflow
1. Data Validation

Performed integrity checks to detect:

duplicate customer IDs
unrealistic age values
invalid balances
abnormal salary values
incorrect credit scores
2. Feature Engineering

Created derived analytical features such as:

age segments
tenure groups
balance-to-salary ratio
balance quartiles
exposure tiers
3. Risk Analysis

Measured churn lift across:

geography
product ownership
activity status
credit bands
customer segments
4. Financial Impact Assessment

Calculated:

total asset exposure
churn-related asset loss
high-risk segment concentration
simulated savings opportunities
Key Features
Customer Risk Segmentation

Customers classified into:

High Exposure
Moderate Exposure
Low Exposure

based on multiple churn-driving behaviors.

Churn Lift Analysis

Compared subgroup churn rates against the overall baseline churn rate to identify disproportionately risky customer groups.

Financial Exposure Modeling

Measured total balance concentration among churned customers to estimate business impact.

Retention Scenario Simulation

Modeled potential asset recovery using hypothetical churn reduction improvements.

Executive Dashboarding

Built interactive Power BI dashboards for:

executive overview
root cause analysis
risk prioritization
churn reduction simulation
SQL Analysis Breakdown
Data Quality Validation

Validated dataset integrity before analysis.

Key checks included:

duplicate records
invalid ages
negative balances
unrealistic salaries
abnormal credit scores
Feature Engineering

Created:

age_segment
tenure_segment
balance_salary_ratio
balance_quartile

using CASE statements and window functions.

Churn Driver Analysis

Analyzed churn patterns across:

geography
customer activity
product ownership
gender
credit score bands

using lift ratio comparisons.

Multi-Factor Risk Modeling

Built a custom exposure index using weighted behavioral conditions:

Risk Driver	Weight
Inactive customer	2.5
One product only	1.8
Low credit score	1.6
Age above 45	1.1
Exposure Segmentation Logic
Exposure Score	Segment
≥ 3	High Exposure
= 2	Moderate Exposure
< 2	Low Exposure
Risk Segmentation Methodology

The project uses behavioral scoring instead of simple churn labels.

This allows businesses to:

prioritize intervention
focus on financially valuable customers
reduce retention costs
allocate resources efficiently
Financial Impact Analysis
Key Metrics
Metric	Value
Total Customers	10K
Churn Rate	20%
High-Risk Customers	31%
Estimated Asset Loss	$186M
Simulation Findings

Retention improvement scenarios showed that:

a 10–15% churn reduction could recover millions in customer assets
targeting inactive high-value customers provides the highest ROI
Germany and France represent the most critical intervention regions
Dashboard Overview
1. Executive Overview

Displays:

total customers
churn rate
asset loss
high-risk percentage
customer exposure distribution
2. Root Cause Analysis

Analyzes:

geography-wise churn
activity-based churn risk
product-level churn exposure
regional concentration
3. Churn Risk Segments & Priorities

Highlights:

highest-risk customer clusters
asset concentration
priority segments
churn vs total assets relationship
4. Churn Reduction Impact Simulator

Demonstrates:

projected savings
simulated asset recovery
retention ROI estimation
strategic recommendations
Key Insights
Inactive customers are significantly more likely to churn
Customers with only one product represent the highest behavioral risk
Germany has the highest churn concentration
High-risk customers hold a major portion of total assets
Small retention improvements generate substantial financial recovery
Business Recommendations
Immediate Priorities
Focus on High-Exposure Customers

Prioritize customers with:

inactivity
low engagement
high balances
single-product ownership
Regional Retention Campaigns

Launch targeted retention programs in:

Germany
France

where churn-related asset concentration is highest.

Product Expansion Strategy

Encourage cross-selling to customers owning only one product to improve engagement and retention.

Customer Re-Engagement Programs

Implement:

personalized outreach
loyalty incentives
proactive customer support
engagement campaigns

for inactive customers.

Performance Optimization

Implemented SQL optimization techniques including:

composite indexing
execution plan analysis
filtered indexing strategies

Indexes created for:

NumOfProducts + IsActiveMember
Exited + Balance
CreditScore
Age

This improved filtering and aggregation efficiency for large-scale analysis.

Project Outcome

This project demonstrates:

advanced SQL analytics
business-focused problem solving
financial impact modeling
dashboard storytelling
customer risk segmentation
executive-level reporting

The analysis moves beyond descriptive reporting and focuses on actionable business intelligence.

Future Improvements

Potential future enhancements:

predictive churn modeling using machine learning
real-time churn monitoring pipeline
customer lifetime value integration
automated retention scoring
deployment using cloud-based analytics platforms
Final Recommendation

The strongest business opportunity is not reducing churn everywhere equally.

The highest ROI comes from protecting high-value inactive customers concentrated in high-risk regions.

A focused retention strategy targeting these customers can significantly reduce asset loss while improving operational efficiency and long-term profitability.
