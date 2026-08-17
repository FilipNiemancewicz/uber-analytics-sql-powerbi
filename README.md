# uber-analytics-sql-powerbi

# 🚖 Uber Ride Operations & Revenue Analytics (SQL + Power BI)

## 📌 Project Overview
An end-to-end Business Intelligence project analyzing **150,000+ Uber ride bookings**. The goal was to extract and clean relational data using **SQL**, build a star-schema dimensional model, calculate business-critical metrics using **DAX**, and design an executive-ready multi-page dashboard in **Power BI**.

---

## 🎯 Key Business Questions Answered
* **Revenue & Growth:** Which vehicle categories and payment methods generate the highest revenue?
* **Cancellations & Lost Revenue:** Why are rides cancelled, who cancels most frequently (driver vs customer), and what are the peak cancellation hours?
* **Fleet Performance & Quality:** How do customer and driver ratings correlate across different vehicle categories (*Premier Sedan*, *Auto*, *eBike*, etc.)?

---

## 🛠️ Tech Stack & Methods
* **SQL (Database & Querying):** Data cleansing, handling NULLs, aggregation, window functions, and preparing views for BI consumption.
* **Power BI (Visual Design & UX):** Custom modern UI, responsive containers, custom bookmarks/slicers, and theme styling.
* **DAX (Data Modeling & Measures):**
  * Dynamic Revenue calculation (`Total Revenue`, `Lost Revenue`).
  * Completion & Cancellation rates (`Completion Rate %`, `Cancellation Rate %`).
  * Unit economics (`Avg Revenue per Order`, `Avg Revenue per KM`).

---

## 📊 Dashboard Architecture & Pages

### 1. Overall Performance (Executive Summary)
* High-level KPIs: Total Orders (150K), Total Revenue (47.26M), Completion Rate (62%), Avg Customer Rating (4.40).
* Monthly order volume trends and revenue split across vehicle types and payment channels.

### 2. Vehicle Analysis
* Fleet breakdown comparing ride volume, revenue contribution, and average ratings across categories (*Auto*, *Bike*, *eBike*, *Go Sedan*, *Premier Sedan*, *Uber XL*).

### 3. Cancellation & Lost Revenue
* Deep dive into unfulfilled bookings.
* Hourly cancellation distribution showing operational peak bottlenecks (morning & evening rush hours).
* Root-cause breakdown of cancellation reasons (e.g., driver delay, incorrect address).

### 4. Revenue & Financial Insights
* Detailed revenue stream breakdown, unit economics metrics, and payment gateway distribution (UPI, Cash, Cards, Uber Wallet).

---

## 📸 Dashboard Preview
<img width="1314" height="739" alt="image" src="https://github.com/user-attachments/assets/c0f1a5b7-5b89-45ae-b807-32fe9524ecf7" />
<img width="1316" height="743" alt="image" src="https://github.com/user-attachments/assets/c534941a-d7d2-41ff-a7fc-f7c78ddb2a0f" />
<img width="1334" height="751" alt="image" src="https://github.com/user-attachments/assets/5b5e8dbf-df36-4e42-82ef-f066ea0a05e5" />
<img width="1312" height="735" alt="image" src="https://github.com/user-attachments/assets/c87c943e-cbe7-4f72-8c7e-99edb8fe476e" />
<img width="1309" height="741" alt="image" src="https://github.com/user-attachments/assets/869612e5-0d17-44a2-a1be-9f2ece47f07d" />




---

## 💻 Sample SQL Queries

<img width="1158" height="129" alt="image" src="https://github.com/user-attachments/assets/731a3e72-9b22-4b60-a99d-f2f78f5010a5" />
<img width="817" height="50" alt="image" src="https://github.com/user-attachments/assets/361ef032-9c18-4c23-a215-2014e6b2c641" />

<img width="961" height="206" alt="image" src="https://github.com/user-attachments/assets/3183ca35-9696-435b-89a4-648f56414e25" />
<img width="771" height="167" alt="image" src="https://github.com/user-attachments/assets/eb2f5347-a1fa-48f7-b837-542607bce274" />

<img width="929" height="169" alt="image" src="https://github.com/user-attachments/assets/998ac646-136a-4554-bb44-dda04c1bb71f" />
<img width="452" height="129" alt="image" src="https://github.com/user-attachments/assets/12d80951-74c0-4473-983c-fdfece3c5626" />

<img width="715" height="161" alt="image" src="https://github.com/user-attachments/assets/063682de-270d-4dbb-9ac0-a39676a242ba" />
<img width="625" height="310" alt="image" src="https://github.com/user-attachments/assets/6b5a6d72-7e3f-43d3-8cb5-cdf6ae88f3d6" />

<img width="531" height="280" alt="image" src="https://github.com/user-attachments/assets/08bd6f6e-e72d-4189-bbc7-7bd0ac98db9b" />
<img width="445" height="46" alt="image" src="https://github.com/user-attachments/assets/a107880d-221d-465e-ba29-fb1d7031b866" />








ORDER BY CancellationRatePct DESC;
