# Sports Participation Data Initiative — Franklin Township High School (2024)

## Overview
This project was initiated to understand why student sports participation was declining at Franklin Township High School and identify actionable ways to improve enrollment across athletic programs. The analysis combined survey data from 500+ students with existing participation records to uncover trends by grade, gender, and sport.

Findings were presented directly to coaching staff and school administration, contributing to a **15% increase in sports participation** among targeted student groups.

---

## Tools Used
- **Google Forms** — Survey design and data collection
- **Excel** — Data cleaning, segmentation, and statistical summaries
- **Tableau** — Dashboards visualizing participation trends by grade, gender, and sport
- **SQL** — Querying and filtering participation records to identify enrollment gaps

---

## Project Workflow

**1. Survey Design**
Developed a 14-question survey covering five key areas: basic demographics, sports interest, barriers to participation, program awareness, and suggestions for improvement. Distributed to 500+ students across all grade levels (9th–12th).

**2. Data Collection & Cleaning**
Collected responses via Google Forms, exported to Excel, removed incomplete entries, and standardized categorical responses for analysis.

**3. Analysis**
- Segmented responses by grade and current athlete vs. non-athlete status
- Ranked most common barriers to participation
- Analyzed correlation between athletic confidence and participation rates
- Evaluated which communication channels students used to hear about sports

**4. Visualization**
Built Tableau dashboards to display participation trends by grade, gender, and sport — enabling staff to quickly identify underrepresented groups and high-opportunity segments.

**5. Presentation & Impact**
Presented data-driven recommendations to coaching staff and administration. Targeted outreach strategies were implemented based on findings, resulting in a 15% increase in participation among identified groups.

---

## SQL Queries

### Overall participation rate by grade
```sql
SELECT 
    grade,
    COUNT(*) AS total_respondents,
    SUM(CASE WHEN currently_participates = 'Yes' THEN 1 ELSE 0 END) AS active_athletes,
    ROUND(SUM(CASE WHEN currently_participates = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS participation_rate
FROM survey_responses
GROUP BY grade
ORDER BY grade;
```

### Most common barriers to participation
```sql
SELECT 
    barrier,
    COUNT(*) AS total_selected,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_responses), 1) AS pct_of_respondents
FROM survey_barriers
GROUP BY barrier
ORDER BY total_selected DESC;
```

### Confidence level vs participation rate
```sql
SELECT 
    athletic_confidence,
    COUNT(*) AS total_students,
    SUM(CASE WHEN currently_participates = 'Yes' THEN 1 ELSE 0 END) AS active_athletes,
    ROUND(SUM(CASE WHEN currently_participates = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS participation_rate
FROM survey_responses
GROUP BY athletic_confidence
ORDER BY participation_rate DESC;
```

### Most effective communication channels
```sql
SELECT 
    channel,
    COUNT(*) AS students_reached,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_responses), 1) AS pct_of_respondents
FROM survey_channels
GROUP BY channel
ORDER BY students_reached DESC;
```

### Non-athletes who expressed interest in joining a sport
```sql
SELECT 
    grade,
    COUNT(*) AS non_athletes,
    SUM(CASE WHEN considered_joining = 'Yes' THEN 1 ELSE 0 END) AS interested_in_joining,
    ROUND(SUM(CASE WHEN considered_joining = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS interest_rate
FROM survey_responses
WHERE currently_participates = 'No'
GROUP BY grade
ORDER BY interest_rate DESC;
```

### Top factors that would increase likelihood of joining
```sql
SELECT 
    factor,
    COUNT(*) AS times_selected,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_responses), 1) AS pct_of_respondents
FROM survey_improvement_factors
GROUP BY factor
ORDER BY times_selected DESC
LIMIT 5;
```

### Interest in non-competitive / recreational sports options
```sql
SELECT 
    recreational_interest,
    COUNT(*) AS total_responses,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_responses), 1) AS pct_of_respondents
FROM survey_responses
GROUP BY recreational_interest
ORDER BY total_responses DESC;
```

---

## Key Findings
- **Time commitment and academic workload** were the top two barriers across all grade levels
- Students with **lower athletic confidence** were significantly less likely to participate — suggesting inclusivity messaging could unlock a large untapped group
- **Friends and peers** were the most common way students heard about sports, outperforming official channels like school announcements and the website
- A large share of non-athletes expressed interest in **non-competitive or recreational options**, pointing to an opportunity beyond traditional varsity programs
- **9th and 10th graders** showed the highest interest in joining but lowest participation — indicating early outreach is critical

---

## Recommendations
1. **Introduce beginner-friendly and recreational sport options** to lower the barrier for less confident students
2. **Shift communication strategy toward peer-to-peer outreach** — student ambassadors and social media over announcements
3. **Target 9th and 10th graders early** with direct outreach before disengagement patterns set in
4. **Reduce perceived time commitment** by offering flexible scheduling or off-season trial periods

---

## Files
- [Sports_Participation_Survey.md](https://github.com/bhilliv719/sports-participation-data-initiative/blob/main/Sports_Participation_Survey.md) — Full survey questions used for data collection
- [sports_participation_queries.sql](https://github.com/bhilliv719/sports-participation-data-initiative/blob/main/sports_participation_queries.sql) — All SQL queries used in the analysis

---

## Author
**William Hill**
Sports Performance Data Analyst | NCAA DI Athlete
[LinkedIn](https://www.linkedin.com/in/) | [Notion Portfolio](https://notion.so/)
