-- Nedim Hodzic (nhodzic)

use HW1_Q1;

-- a. (5 points) Find the number of distinct events. 
select count(vid) as num_events from events;

/* 
b. (6 points) List all event(s) that were not held on ISU Campus.  Show only the vid and sched_date values of 
these events. You can use 'ISU Campus' in your query without  worrying about the upper case or lower case. 
*/
select vid, sched_date from events where location != "ISU Campus";

/*
c. (10 points) Find all venues and events that  Pak participated in. Show the event vid, sched_date, and location. 
Do not list duplicate rows. Use 'Pak' directly in your query. You do not need to use any wildcard, upper case, or 
lower case when specifying the names. 
*/
select events.vid, events.sched_date, events.location from events
inner join participates on participates.vid = events.vid
inner join persons on persons.pid = participates.pid where persons.pname = "Pak"
group by vid, sched_date, location;

/*
d. (10 points) Find the event(s) that Pak or John have participated in. List all the attributes of the events ordered 
by the sched_date value from the most recent event first. You do not need to use any wildcard, upper case, or 
lower case when specifying the names.   
*/
select events.vid, events.sched_date, events.location from events
inner join participates on participates.vid = events.vid
inner join persons on persons.pid = participates.pid where persons.pname = "Pak" or persons.pname = "John"
group by vid, sched_date, location order by sched_date desc;

/*
e. (8 points) Find the venue id that all three people, John, Mary, and Jane have participated in the events 
associated with that  venue id. You do not need to use any wildcard, upper case, or lower case when specifying 
the names of the people. 
*/
select p1.vid from participates p1 
inner join persons pe1 on p1.pid = pe1.pid and pe1.pname = "John" and p1.vid in
(select p2.vid from participates p2
	inner join persons pe2 on p2.pid = pe2.pid and pe2.pname = "Mary" and p2.vid in
	(select p3.vid from participates p3, persons pe3 where p3.pid = pe3.pid and pe3.pname = "Jane")
);

/*
f. (7 points) Find the name of the person(s) who has not participated in any event. Order the result in the 
descending order of the pid values. Use the right join operator in your SQL. 
*/
select pname from participates 
right join persons on persons.pid = participates.pid where participates.pid is null;

/*
g. (9 points) Find the pid and pname of the person who attended at least two different events (different vid and 
sched_date values). 
*/
select participates.pid, persons.pname from participates, persons
where persons.pid = participates.pid group by participates.pid
having count(participates.vid) > 1;

/*
h. (10 points) Write a query with a sub-query in the where clause using the exists operator to find all the venues 
with no associated events. Show the venue_id and name of the venue(s). 
*/
select venue_id, name from venues where not exists (select vid from events where vid = venue_id);

/*
i. (9 points) Write a query with a sub-query in the where clause using the in operator to find the same 
information as in the question h. 
*/
select venue_id, name from venues where venue_id not in (select vid from events);

/*
j. (1 point) Add your full name in the comment as the sole author of the submitted  solution. 
------------
Nedim Hodzic
------------
*/
















