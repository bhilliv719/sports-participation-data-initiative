-- Sports Participation Data Initiative — Franklin Township High School (2024)
-- Author: William Hill
-- Description: SQL queries used to analyze student sports participation survey data
--              collected from 500+ students across grades 9-12

-- =============================================
-- 1. Overall participation rate by grade
-- =============================================
SELECT 
    grade,
    COUNT(*) AS total_respondents,
    SUM(CASE WHEN currently_participates = 'Yes' THEN 1 ELSE 0 END) AS active_athletes,
    ROUND(SUM(CASE WHEN currently_participates = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS participation_rate
FROM survey_responses
GROUP BY grade
ORDER BY grade;

-- =============================================
-- 2. Most common barriers to participation
-- =============================================
SELECT 
    barrier,
    COUNT(*) AS total_selected,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_responses), 1) AS pct_of_respondents
FROM survey_barriers
GROUP BY barrier
ORDER BY total_selected DESC;

-- =============================================
-- 3. Confidence level vs participation rate
--    (tests correlation between self-confidence and joining sports)
-- =============================================
SELECT 
    athletic_confidence,
    COUNT(*) AS total_students,
    SUM(CASE WHEN currently_participates = 'Yes' THEN 1 ELSE 0 END) AS active_athletes,
    ROUND(SUM(CASE WHEN currently_participates = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS participation_rate
FROM survey_responses
GROUP BY athletic_confidence
ORDER BY participation_rate DESC;

-- =============================================
-- 4. Most effective communication channels
--    (how students actually hear about sports)
-- =============================================
SELECT 
    channel,
    COUNT(*) AS students_reached,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_responses), 1) AS pct_of_respondents
FROM survey_channels
GROUP BY channel
ORDER BY students_reached DESC;

-- =============================================
-- 5. Non-athletes who expressed interest in joining
--    (identifies high-opportunity group by grade)
-- =============================================
SELECT 
    grade,
    COUNT(*) AS non_athletes,
    SUM(CASE WHEN considered_joining = 'Yes' THEN 1 ELSE 0 END) AS interested_in_joining,
    ROUND(SUM(CASE WHEN considered_joining = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS interest_rate
FROM survey_responses
WHERE currently_participates = 'No'
GROUP BY grade
ORDER BY interest_rate DESC;

-- =============================================
-- 6. Top factors that would increase likelihood of joining
-- =============================================
SELECT 
    factor,
    COUNT(*) AS times_selected,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_responses), 1) AS pct_of_respondents
FROM survey_improvement_factors
GROUP BY factor
ORDER BY times_selected DESC
LIMIT 5;

-- =============================================
-- 7. Interest in recreational/non-competitive options
-- =============================================
SELECT 
    recreational_interest,
    COUNT(*) AS total_responses,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM survey_responses), 1) AS pct_of_respondents
FROM survey_responses
GROUP BY recreational_interest
ORDER BY total_responses DESC;

-- =============================================
-- 8. Sports interest among non-participating students
--    (identifies which sports have most untapped demand)
-- =============================================
SELECT 
    sport_interest,
    COUNT(*) AS interested_students
FROM survey_sport_interest
WHERE respondent_id IN (
    SELECT respondent_id FROM survey_responses
    WHERE currently_participates = 'No'
)
GROUP BY sport_interest
ORDER BY interested_students DESC
LIMIT 10;

-- =============================================
-- 9. Participation rate by gender
-- =============================================
SELECT 
    gender,
    COUNT(*) AS total_students,
    SUM(CASE WHEN currently_participates = 'Yes' THEN 1 ELSE 0 END) AS active_athletes,
    ROUND(SUM(CASE WHEN currently_participates = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS participation_rate
FROM survey_responses
GROUP BY gender
ORDER BY participation_rate DESC;

-- =============================================
-- 10. Cross-tab: grade vs top barrier
--     (identifies if different grades face different obstacles)
-- =============================================
SELECT 
    r.grade,
    b.barrier,
    COUNT(*) AS frequency
FROM survey_responses r
JOIN survey_barriers b ON r.respondent_id = b.respondent_id
GROUP BY r.grade, b.barrier
ORDER BY r.grade, frequency DESC;
