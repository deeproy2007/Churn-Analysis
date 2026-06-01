# Customer Churn Analytics & Financial Risk Intelligence

SQL-based churn analysis project focused on identifying high-risk customers, measuring financial exposure, and building actionable retention strategies using SQL and Power BI.

---

# Table of Contents

- Executive Summary
- Business Problem
- Project Objectives
- Tools & Technologies
- Dataset Overview
- SQL Analysis
- Dashboard Pages
- Key Insights
- Recommendations
- Project Outcome

---

# Executive Summary

This project analyzes customer churn behavior and its financial impact on a banking business.

Instead of only tracking churn percentage, the analysis focuses on:

- identifying high-risk customer segments
- detecting the main churn drivers
- measuring asset loss caused by churn
- estimating potential savings through retention strategies

The project combines SQL-based analytics with Power BI dashboards to create a business-focused churn intelligence system.

### Key Findings

- Overall churn rate: **20%**
- High-risk customers: **31%**
- Inactive customers show **1.32× higher churn risk**
- Germany and France have the highest churn exposure
- Estimated asset loss due to churn: **$186M**

---

# Business Problem

Customer churn directly affects revenue, customer lifetime value, and asset retention.

The goal of this project was to identify:

- which customers are most likely to churn
- which segments create the highest financial risk
- where the business should focus retention efforts

---

# Project Objectives

- Perform customer churn analysis using SQL
- Build customer risk segments
- Identify major churn drivers
- Measure financial impact of churn
- Create executive-level Power BI dashboards
- Simulate potential savings from churn reduction

---

# Tools & Technologies

| Tool | Purpose |
|---|---|
| MySQL | Data cleaning and analysis |
| Power BI | Dashboard visualization |
| SQL Window Functions | Segmentation and ranking |
| DAX | KPI calculations |

---

# Dataset Overview

The dataset contains customer banking information including:

- Customer ID
- Geography
- Gender
- Age
- Credit Score
- Balance
- Salary
- Tenure
- Number of Products
- Activity Status
- Churn Status

---

# SQL Analysis

## Data Validation

Performed checks for:

- duplicate customer IDs
- invalid ages
- negative balances
- unrealistic salary values
- abnormal credit scores

---

## Feature Engineering

Created analytical features such as:

- age segments
- tenure segments
- balance-to-salary ratio
- balance quartiles
- churn exposure score

---

## Churn Driver Analysis

Analyzed churn behavior across:

- geography
- activity status
- product ownership
- credit score segments
- customer demographics

---

## Risk Segmentation

Customers were classified into:

- High Exposure
- Low Exposure

based on behavioral and financial risk indicators.

---

## Financial Impact Analysis

Calculated:

- total customer assets
- churn-related asset loss
- high-risk asset concentration
- potential retention savings

---

# Dashboard Pages

## 1. Executive Overview

Displays:

![image alt](https://github.com/deeproy2007/Churn-Analysis/blob/main/Dashboards%20Pictures/Exclusive%20Overview.jpeg?raw=true)


This executive overview page provides a high-level view of customer churn exposure, financial risk, and retention priorities.

The dashboard tracks:

- total customer base
- overall churn rate
- estimated asset loss
- percentage of high-risk customers

I also developed a customer exposure segmentation model to identify high-risk behavioral groups and quantify churn concentration.
One of the key findings showed that inactive customers have 1.32x higher churn risk, making re-engagement campaigns a critical retention strategy.


---

## 2. Root Cause Analysis

Analyzes: Why did they churn, who is most at risk, and where should we act first?

![image alt](https://github.com/deeproy2007/Churn-Analysis/blob/main/Dashboards%20Pictures/Root%20Cause%20Analysis.jpeg?raw=true)

This Root Cause Analysis dashboard identifies the key factors driving customer churn. The analysis reveals that customer inactivity is the strongest churn
indicator, while Germany represents the highest-risk geography. Additional analysis shows that churn varies significantly across customer exposure segments and product ownership groups. These insights help businesses prioritize retention efforts, reduce customer attrition, and protect high-value assets through targeted interventions.
---

## 3. Churn Risk Segments & Priorities

Highlights:

![image alt](https://github.com/deeproy2007/Churn-Analysis/blob/main/Dashboards%20Pictures/Churn%20Risk.jpeg?raw=true)


---

## 4. Churn Reduction Simulator

Simulates:


![image alt](https://github.com/deeproy2007/Churn-Analysis/blob/main/Dashboards%20Pictures/Churn%20Reduction%20Impact%20Simulator.jpeg?raw=true)


---

# Key Insights



---

# Recommendations

- Focus on inactive high-value customers
- Launch retention campaigns in Germany and France
- Improve customer engagement strategies
- Increase product adoption through cross-selling
- Prioritize high-exposure customer segments

---

# Project Outcome

This project demonstrates:

- advanced SQL analytics
- business-focused problem solving
- customer risk segmentation
- financial impact analysis
- dashboard storytelling using Power BI

The analysis goes beyond basic churn reporting and focuses on actionable business intelligence for retention strategy and risk reduction.
