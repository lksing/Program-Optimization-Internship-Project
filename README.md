# Program Optimization Internship Project

**Hi there! Here is my project contribution in a nutshell:**

In this project during my internship at a global travel technology company, I developed SQL scripts for ongoing optimization of codes for negotiated hotel programs, resulting in the initial removal of over 50% of redundant codes. I presented my process improvement recommendations to key stakeholders, including account managers and hospitality industry executives, who responded with the feedback that my analysis was valuable and actionable for streamlining business processes. My efforts were the critical first steps for product teams to improve delivery of negotiated hotel programs according to long-time customer needs. 

**If you're short on time, feel free to directly view examples of my skills in this project:**

- SQL - anonymized samples of queries [here](SQL-rate-code-removal.sql) and [here](SQL-program-analysis.sql) I developed using aggregations, joins, and case statements to transform data for reporting.
- Excel - a [PivotTable](#pivottable-for-programs-based-on-bookings) I created to synthesize a view of top performing hotel programs by bookings.
- Stakeholder Communication - sample of how I would distill insights to an [executive](#executive-summary) audience vs. explaining the process to a [managerial](#approach) audience.

**If you'd like to dig deeper into my work on this project, feel free to navigate by section:**

- [Executive Summary](#executive-summary)
- [Project Background](#project-background)
- [Approach](#approach)
- [Gathering Data](#gathering-data)
- [Developing Deeper Analysis](#developing-deeper-analysis)
- [Findings](#findings)
- [Challenges](#challenges)
- [Learnings](#learnings)

## Executive Summary
For several years, internal teams and external clients in the hospitality sector have expressed the need for better hotel program code management:
- Internally, product teams required a method to identify inactive codes and optimize data management for key accounts.
- Externally, suppliers sought (1) a more intuitive rate management process and (2) system enhancements to streamline hotel program operations.

Due to limitations in system design and access for many years, there was a suspected significant, but unknown number of unused program codes that prevented internal teams from making comprehensive improvements to the system. Through my analysis, the product team has identified that over 50% of outdated rate codes can be removed. This is a critical first step for enabling the product team to carry out full outdated rate code deletion next quarter, which is expected to result in improvements in database efficiency performance, enhance system responsiveness, and improve the user experience for key accounts.

## Project Background
For many years, internal hotel program code tables have enabled suppliers and customers access to hotel programs with negotiated rates, which represent a significant amount of bookings on the platform. Suppliers and customers have consistently requested improvements to the hotel program code system offered, with demand rising especially since post-COVID recovery of travel levels. 

Due to limitations in system design and access for many years, there was a suspected significant, but unknown number of unused program codes that prevented internal teams from making comprehensive improvements to the system. Through my analysis, the product team has identified outdated rate codes for removal, resulting in expected improvements in database efficiency and performance.

## Approach
To begin to tackle this task of identifying program rate codes for deletion, I needed carefully consider how our project defined a rate code no longer in use so that we could confidently remove it while reducing the risk, as much as possible, of removing a program rate code actively in use.

My approach was to identify rates that haven’t been booked across all chains for a given supplier within a certain period, so if a rate code was booked even once under a particular hotel chain, that rate has marked as having been booked and can be kept. Since I checked rate codes in the way across all chains, our team could be confident that these rates we found not booked in the time period were safe for removal from the company's system.

## Gathering Data
Since integrating multiple data sources to analyze rate code usage had not been done before, I gained valuable experience in developing a method to efficiently extract and process data (see sections on [Challenges](#challenges) and [Learnings](#learnings)). 

[Here](SQL-rate-code-removal.sql) are anonymized samples of queries I developed to extract data from multiple sources. 

## Developing Deeper Analysis
Through discussions with subject matter experts, I discovered that a specific combination of data fields provided a unique identifier for rate programs. This insight I found, which had not been previously articulated in this way, contributed to a new approach for analyzing program usage.

After developing these [SQL queries](SQL-program-analysis.sql) to create a data extract, I created a PivotTable in Excel, where suppliers could view bookings by various descriptors like agency code, rate code, and chain code.

### Extract of SQL query shown in Excel
![excel_extract](https://github.com/user-attachments/assets/bbd18412-2db0-4a5c-ad72-863b4b4a742f)

### PivotTable for Programs based on Bookings
![anon_pivot](https://github.com/user-attachments/assets/892f2efb-d159-48a1-b51e-9d8ba340881b)


Any client could then use this data to:
1. Identify and prioritize top programs
2. Identify and re-strategize for programs with lower bookings
3. Gather information to improve negotiations for rate programs


## Findings
Over 50% of outdated rate codes were identified for removal, with expected improvements in database efficiency and performance. Once implemented, these optimizations are projected to enhance system responsiveness and improve the user experience for key accounts.

## Challenges
- **Analyzing Data from an Unfamiliar Data Ecosystem:** Since I had never worked with travel data before, I initially struggled to understand the context of my queries. Feedback on my first extracts helped me identify incorrect assumptions, such as outdated statuses being stored alongside current ones, which I adjusted for accuracy. Another assumption was that all bookings in the table were relevant, but I later learned that only negotiated rate bookings mattered, requiring additional filters.
- **Anticipating Stakeholder Questions:** Before presenting to hospitality executives, I focused on keeping my findings concise and actionable but wasn’t sure what specific questions they would have. Reviewing my workflow in detail helped me confidently address queries about my methodology, reinforcing the importance of being able to provide clear explanations for stakeholder trust.

## Learnings
- **I learned to ask often:** how can I do this process better? Initially, I relied on manual methods like Excel VLOOKUP, which became inefficient with large datasets. Recognizing these limitations, I explored better tools and transitioned to using BigQuery, significantly improving scalability and efficiency.
- **I also learned to ask myself frequently: why can I trust my numbers?** Since I was new to the industry, I lacked an intuitive feel for the data. To ensure accuracy, I regularly consulted subject matter experts to validate my queries and refine my approach.
- **Lastly, I learned to take an active role in clarifying the ask.** Complex data relationships sometimes led the team off track from our primary goal, but learning to ask how each step contributed to program deletions helped us stay focused on the most impactful analysis.
