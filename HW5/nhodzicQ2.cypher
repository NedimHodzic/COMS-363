//Question 2
//Author: Nedim Hodzic

//2a.
MATCH (u:User)-[:POSTED]->(t:Tweet)
WHERE t.post_month = 2 AND t.post_year = 2016
RETURN u.screen_name AS screenname, u.sub_category AS party, t.retweet_count AS retweetCount
ORDER BY t.retweet_count DESC LIMIT 5;

//2b.
MATCH (u:User)-[:POSTED]->(t:Tweet)
MATCH (h:Hashtag)-[:TAGGED]->(t:Tweet)
WHERE u.location = "Ohio" OR u.location = "Alaska"
RETURN DISTINCT h.name AS hashtagName
ORDER BY h.name LIMIT 5;

//2c.
MATCH (u:User)
WHERE u.sub_category = "democrat"
RETURN u.screen_name AS screenname, u.sub_category AS party, u.followers AS numFollowers
ORDER BY u.followers desc LIMIT 5;

//2d.
MATCH (t:Tweet)-[:MENTIONED]->(mentioned:User)
MATCH (poster:User)-[:POSTED]->(t:Tweet)
WHERE poster.sub_category = "GOP"
WITH mentioned, collect(DISTINCT poster.screen_name) AS listMentioningUsers, count(poster.screen_name) AS countMentions
RETURN mentioned.screen_name AS mentionedUser, reverse(listMentioningUsers) as listMentioningUsers
ORDER BY countMentions DESC LIMIT 5;

//2e.
MATCH (u:User)-[:POSTED]->(t:Tweet)
MATCH (h:Hashtag)-[:TAGGED]->(t:Tweet)
where u.location <> "na" AND u.location IS NOT null
WITH h, count(DISTINCT u.location) AS numstates, collect(DISTINCT u.location) AS statelist
RETURN h.name as hashtag, numstates, statelist
ORDER BY size(statelist) DESC LIMIt 3;