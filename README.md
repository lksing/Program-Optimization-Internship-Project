# Sabre Program Usage Project

**Hi there! Here is my project contribution in a nutshell:**
In this project at my Sabre internship, I identified over 50% of rate codes for removal, developed a solution for ongoing optimization of rate codes, and presented my process improvement recommendations to hospitality executives from Sabre's top 2 hotelier suppliers. My efforts were the critical first steps for the Product team to improve Sabre's rate management system according to long-time customer needs. 

**If you're short on time,and feel free to directly view examples of my skills in this project:**

- SQL - several queries [here](SQL-prep.sql) and [here](SQL-program-analysis.sql) I developed using aggregations, joins, and case statements to transform data for visualization.
- Excel - a [PivotTable](#pivottable-for-programs-based-on-bookings) I created to synthesize a view of top performing hotel programs by bookings.
- Stakeholder Communication - sample of how I would distill insights to an [executive](#executive-summary) audience vs. explaining the process to a [technical](#approach) audience.

**If you'd like to dig deeper into my work on this project, feel free to navigate by section:**

- [Project Background](#project-background)
- [Executive Summary](#executive-summary)
- [Approach](#approach)
- [Gathering Data](#gathering-data)
- [Developing Deeper Analysis](#developing-deeper-analysis)
- [Findings](#findings)
- [Challenges](#challenges)
- [Learnings](#learnings)

## Project Background
For several years, internal and external customers expressed needs for rate code data:
- Internally, the Product team needed to identify certain inactive rate codes and agency codes to clean the supplier rate management table for Sabre’s top customers.
- Externally, suppliers have expressed their need for (1) an easier way to manage rates and (2) an improved rate management system from Sabre.

## Executive Summary
- Findings: Over 50% of rates are identified for removal from program tables for Sabre's top 2 suppliers next quarter. Once Product team carries out deletion, Product team anticipates increases in program database speed and performance, resulting in a tangibly improved user experience for Sabre's clients. 
- Recommendations: For Product team - continue using developed queries to clean program tables and consider meeting with data engineering team to discuss implementing further identified business process improvements for program data. 

## Approach
To begin to tackle this task of identifying program rate codes for deletion, I needed carefully consider how our project defined a rate code no longer in use so that we could confidently remove it while reducing the risk, as much as possible, of removing a program rate code actively in use.

My approach was to identify rates that haven’t been booked across all chains for a given supplier within a certain period, so if a rate code was booked even once under a particular hotel chain, that rate has marked as having been booked and can be kept. However, if a rate hadn’t been booked at all under any chain, it was marked as not booked and a candidate for removal. Since I checked rates in the way across all chains, our team could be confident confident that these rates we found not booked in the time period were safe for removal from Sabre's system.

## Gathering Data
Since extracting the specific combination of agency data, program data, and booking data from Sabre's databases had not been done before, I learned a great deal from just the process of developing a method to efficiently and accurately extract the data (see sections on [Challenges](#challenges) and [Learnings](#learnings)). 

[Here](SQL-rate-code-removal.sql) are anonymized samples of queries I developed to extract data from multiple sources, including three tables in the Google Cloud Platform and a legacy database. 

## Developing Deeper Analysis
In interviews I conducted with subject matter experts to better understand program usage, I began realize that it was the unique combination between three data fields that uniquely identified a program. I hadn't heard other team members refer to program in this way - it was an insight I gleaned when I was learning about program usage. I proposed this idea to team members, who agreed that this combination could indeed identify a specific program, and actually solved a long-time problem with not being able to easily identify any given program. 

While the analysis idea I developed wasn't initially a part of the ask to clean up program tables (I just needed to find the rate codes for deletion), by putting this combination of 3 data fields together, I opened up the possibility to unlock another view of program data that hadn't been visible before - the performance of rate programs in hotel bookings. This 3-field combination, combined with my skills in SQL and Excel, allowed me to gather and transform data from multiple sources to create a view not possible before because the data was all dispersed.

After developing these [SQL queries](SQL-program-analysis.sql) to create a data extract, I created a PivotTable in Excel, where suppliers could view bookings by various descriptors like agency code, rate code, and chain code.

### Extract of SQL query shown in Excel
![excel_extract](https://github.com/user-attachments/assets/bbd18412-2db0-4a5c-ad72-863b4b4a742f)

### PivotTable for Programs based on Bookings
![anon_pivot](https://github.com/user-attachments/assets/892f2efb-d159-48a1-b51e-9d8ba340881b)


Any of Sabre's clients could then use this data to:
1. Identify and prioritize top programs
2. Identify and re-strategize for programs with lower bookings
3. Gather information to improve negotiations for rate programs


## Findings
From my SQL queries, I found that over 50% of rates could be removed for Sabre's top 2 suppliers, which meant that moving forward, after Sabre's Product team removed those rates, Sabre's system will have over 50% less rates to search through. Because of my analysis, the Product team antipates increases in database processing speed and performance, resulting in a tangibly improved user experience for Sabre's clients.

## Challenges
- Analyzing Data from an Unfamiliar Data Ecosystem: Since I had never worked with travel data in Sabre's ecosystem before, I didn't fully understand the context from which I was pulling data. After receiving feedback that my initial extracts on agency data didn't look quite right, I later discovered where I had made assumptions about the data, and learned how I can modify my queries to reflect characteristics about the tables. One assumption I had was that the table I was querying from only contained the most recent statuses, when in reality the table also stored previous versions of statuses. From this, I learned how to extract only the most relevant, recent status and to keep in mind, moving forward, if a table contains the dimension of time. Another assumption I had was that the type of booking I was investigating was all that was stored in a bookings table, however I later realized that our team was interested only in a particular type of booking, called negotiated rate bookings, and therefore I needed to add filters on my queries to reflect these booking. 
- Anticipating Stakeholder Questions: Leading up to presenting my findings to Marriott and Hilton executives, I knew I wanted to keep the presentation concise, with results and actionable next steps prominent, but I wasn't quite sure what other questions they would have for me. After presenting, I ended up receiving a few questions about my process, including how I identified rate codes for deletion and ensured that only negotiated rate code bookings were analyzed. I was able to address their questions, since I reviewed my entire workflow in preparation for the presentation. The experience taught me the importance of being able to fully understand and explain my workflow to clarify questions and verify my process so that key stakeholders can trust my analysis results. 

## Learnings
- I learned to ask often: how can I do this process better? Initially the process for data cleaning and extraction was relatively manual - it included asking other team members to create data extracts, and using Excel VLOOKUP functions on those extracts. When I found out quickly that 1.5M rows of data would be processed very slowly in Excel, I knew I needed to find a better way, and was able to use Python to speed things up. However, I recognized there were still a lot of limitations with this approach (such as relying on other people to get data, needing to batch many files, and the whole set up being local), so I asked another team member: first of all, did this approach look correct to accomplish our project goal? And second of all, was there a better way I could do this? Because I asked these questions, this team member gave me an idea which would change the scope, and scale of what was possible for my analysis - completing rate analysis primarily using BigQuery, where I was able to pull from the 3 data sources necessary for quickly and accurately bringing together data to form a picture of rate usage.
- I also learned to ask myself frequently: why can I trust my numbers? I learned pretty quickly that since I was 3 months into the travel industry, I didn’t have an experiential “sense” yet for the data, so it was important to frequently interview subject matter experts on the data so I could understand which filters and fields were suitable to use and which were not. 
- Lastly, I learned to take an active role in clarifying the ask. As I went about in my analysis, I found there were many details and considerations that popped up that I needed to clarify and ask subject matter experts about, for example: how would solving our current (at the time) problem serve our ultimate goal of finding programs for deletion? We were getting tied up in a complicated problem with finding relationships between various types of agency codes between several tables, but asking that question kept us on track to stay focused on the rates as our criteria for deletion.
