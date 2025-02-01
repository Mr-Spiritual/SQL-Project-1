USE project1_indian_elections_2024;

SELECT * FROM constituencywise_details;

SELECT * FROM constituencywise_results;

SELECT * FROM partywise_results;

SELECT * FROM states;

SELECT * FROM statewise_results;

-- 1. Total seats in the General Parliamentary Elections 2024, India
SELECT DISTINCT COUNT(Parliament_constituency)
AS Total_Seats_in_Loksabha
FROM constituencywise_results;

-- 2. Statewise seats present for elections to be contested
SELECT
s.state AS State_Name, COUNT(cr.parliament_constituency) AS Total_seats
FROM constituencywise_results cr
INNER JOIN statewise_results sr 
ON cr.parliament_constituency = sr.parliament_constituency

INNER JOIN states s 
ON sr.state_ID = s.state_ID

GROUP BY s.state
ORDER BY Total_seats;

-- 3. Total seats won by National Democratic Alliance
SELECT
SUM(CASE
		WHEN PARTY IN(
        'Bharatiya Janata Party - BJP',
        'Telugu Desam - TDP',
        'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS',
        'AJSU Party - AJSUP',
        'Apna Dal (Soneylal) - ADAL',
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS',
        'Janasena Party - JnP',
        'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV',
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD',
        'Sikkim Krantikari Morcha - SKM',
        'United Peopleâ€™s Party, Liberal - UPPL') 
		THEN Won
	ELSE 0
END) AS NDA_Seats_Won
FROM 
partywise_results;

-- 4. partywise seats won by NDA member parties
SELECT
party AS Party_name, won AS seats_won
FROM partywise_results
WHERE party IN(
        'Bharatiya Janata Party - BJP',
        'Telugu Desam - TDP',
        'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS',
        'AJSU Party - AJSUP',
        'Apna Dal (Soneylal) - ADAL',
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS',
        'Janasena Party - JnP',
        'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV',
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD',
        'Sikkim Krantikari Morcha - SKM',
        'United Peopleâ€™s Party, Liberal - UPPL') 
ORDER BY seats_won DESC, Party_name;

-- 5. Total seats won by I.N.D.I Alliance
SELECT
SUM(CASE
		WHEN PARTY IN(
        'Indian National Congress - INC',
        'Samajwadi Party - SP',
        'All India Trinamool Congress - AITC',
        'Dravida Munnetra Kazhagam - DMK',
        'Communist Party of India  (Marxist) - CPI(M)',
        'Rashtriya Janata Dal - RJD',
        'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
        'Aam Aadmi Party - AAAP',
        'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
        'Communist Party of India - CPI',
        'Jharkhand Mukti Morcha - JMM',
        'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
        'Indian Union Muslim League - IUML',
        'Jammu & Kashmir National Conference - JKN',
        'Viduthalai Chiruthaigal Katchi - VCK',
        'Bharat Adivasi Party - BHRTADVSIP',
        'Kerala Congress - KEC',
        'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
        'Rashtriya Loktantrik Party - RLTP',
        'Revolutionary Socialist Party - RSP'
        ) THEN Won
	ELSE 0
END) AS INDI_Seats_Won
FROM 
partywise_results;

-- 6. partywise seats won by I.N.D.I.A member parties
SELECT
party AS Party_name, won AS seats_won
FROM partywise_results
WHERE party IN(
        'Indian National Congress - INC',
        'Samajwadi Party - SP',
        'All India Trinamool Congress - AITC',
        'Dravida Munnetra Kazhagam - DMK',
        'Communist Party of India  (Marxist) - CPI(M)',
        'Rashtriya Janata Dal - RJD',
        'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
        'Aam Aadmi Party - AAAP',
        'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
        'Communist Party of India - CPI',
        'Jharkhand Mukti Morcha - JMM',
        'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
        'Indian Union Muslim League - IUML',
        'Jammu & Kashmir National Conference - JKN',
        'Viduthalai Chiruthaigal Katchi - VCK',
        'Bharat Adivasi Party - BHRTADVSIP',
        'Kerala Congress - KEC',
        'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
        'Rashtriya Loktantrik Party - RLTP',
        'Revolutionary Socialist Party - RSP') 
ORDER BY seats_won DESC, Party_name;

-- 7. Add new column field in the 'partywise_results' table to get the party alliance as NDA, I.N.D.I.A, or other
ALTER TABLE partywise_results
ADD COLUMN Party_Alliance VARCHAR(50);

UPDATE partywise_results
SET Party_Alliance = 'NDA'
WHERE party IN (
		'Bharatiya Janata Party - BJP',
        'Telugu Desam - TDP',
        'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS',
        'AJSU Party - AJSUP',
        'Apna Dal (Soneylal) - ADAL',
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS',
        'Janasena Party - JnP',
        'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV',
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD',
        'Sikkim Krantikari Morcha - SKM',
        'United Peopleâ€™s Party, Liberal - UPPL'
);

UPDATE partywise_results
SET Party_Alliance = 'I.N.D.I.A'
WHERE party IN (
		'Indian National Congress - INC',
        'Samajwadi Party - SP',
        'All India Trinamool Congress - AITC',
        'Dravida Munnetra Kazhagam - DMK',
        'Communist Party of India  (Marxist) - CPI(M)',
        'Rashtriya Janata Dal - RJD',
        'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
        'Aam Aadmi Party - AAAP',
        'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
        'Communist Party of India - CPI',
        'Jharkhand Mukti Morcha - JMM',
        'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
        'Indian Union Muslim League - IUML',
        'Jammu & Kashmir National Conference - JKN',
        'Viduthalai Chiruthaigal Katchi - VCK',
        'Bharat Adivasi Party - BHRTADVSIP',
        'Kerala Congress - KEC',
        'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
        'Rashtriya Loktantrik Party - RLTP',
        'Revolutionary Socialist Party - RSP'
);

UPDATE partywise_results
SET party_alliance = 'Others'
WHERE party_alliance IS NULL;

-- 8. Party Alliance seat won (most)
SELECT 
Party_Alliance, SUM(WON) AS seats_won
FROM partywise_results
GROUP BY Party_Alliance
ORDER BY seats_won DESC;

-- 9. Winning candidates name, the party name, total votes and margin of votes for a specific state or constituency
SELECT cr.Winning_Candidate, cr.Constituency_Name, s.State, pr.Party, cr.Total_Votes, cr.Margin
FROM constituencywise_results AS cr
INNER JOIN partywise_results AS pr ON cr.Party_ID = pr.Party_ID
INNER JOIN statewise_results AS sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
INNER JOIN states AS s ON s.State_ID = sr.State_ID
WHERE cr.Constituency_Name = 'SHIRUR'; -- Change the name accordingly

-- 10. Distribution of EVM votes vs Postal Votes for candidates in a specific constituency
SELECT 
cd.Candidate, cd.EVM_Votes, cd.Postal_Votes, cd.Total_Votes, cd.Constituency_ID, cr.Constituency_Name
FROM constituencywise_details AS cd
JOIN constituencywise_results AS cr 
ON cr.Constituency_ID = cd.Constituency_ID
WHERE cr.Constituency_Name = 'AMROHA'
ORDER BY cd.Total_Votes DESC;

-- 11. Which party won the most seats in a state, and how many seats did each party win
SELECT pr.Party, COUNT(cr.Constituency_ID) AS Seats_Won
FROM constituencywise_results cr
JOIN partywise_results pr 
	ON cr.Party_ID = pr.Party_ID
JOIN statewise_results sr
	ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s
	ON sr.state_ID = s.state_ID
WHERE
s.state = 'Telangana'
GROUP BY pr.party
ORDER BY seats_won DESC;

-- 12. What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024
SELECT
s.State AS State_Name,
SUM(CASE WHEN p.party_alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
SUM(CASE WHEN p.party_alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
SUM(CASE WHEN p.party_alliance = 'Others' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
FROM
constituencywise_results cr
JOIN partywise_results p ON cr.Party_ID = p.Party_ID
JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.State_ID
WHERE p.party_alliance IN ('NDA','I.N.D.I.A','Others') -- Filter for NDA and INDIA alliances
GROUP BY s.State
ORDER BY s.State;