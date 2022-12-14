//Question 3
//Author: Nedim Hodzic

MATCH (n) OPTIONAL MATCH (n)-[r]-()
DELETE n, r;

MATCH (n:Suppliers)
REMOVE n:Suppliers;

MATCH (n:Parts)
REMOVE n:Parts;

MATCH (n:Projects)
REMOVE n:Projects;

MATCH (n:SPJ)
REMOVE n:SPJ;

drop constraint sidIdx if exists;
drop constraint sidExists if exists;

create constraint sidIdx FOR (s:Suppliers) REQUIRE s.sid IS UNIQUE;
create constraint sidExists for (s:Suppliers) require s.sid is not null;

CREATE (:Suppliers {sid:1, sname: "ned"});
CREATE (:Suppliers {sid:2, sname: "bob"});
CREATE (:Suppliers {sid:3, sname: "joe"});

drop constraint pidIdx if exists;
drop constraint pidExists if exists;

create constraint pidIdx FOR (p:Parts) REQUIRE p.pid IS UNIQUE;
create constraint pidExists for (p:Parts) require p.pid is not null;

CREATE (:Parts {pid:1, pname: "wood"});
CREATE (:Parts {pid:2, pname: "metal"});
CREATE (:Parts {pid:3, pname: "plastic"});

drop constraint jidIdx if exists;
drop constraint jidExists if exists;

create constraint jidIdx FOR (j:Projects) REQUIRE j.jid IS UNIQUE;
create constraint jidExists for (j:Projects) require j.jid is not null;

CREATE (:Projects {jid:1, jname: "table"});
CREATE (:Projects {jid:2, jname: "oven"});
CREATE (:Projects {jid:3, jname: "monitor"});

MATCH (s:Suppliers{sid:1})
MATCH (p:Parts{pid:1})
MATCH (j:Projects{jid:1})
MERGE (spj:SPJ{qty:10})
CREATE (s)-[:SUPPLIED]->(spj)
CREATE (p)-[:PART_USED]->(spj)
CREATE (j)-[:PROJECT_IDEA]->(spj);

MATCH (s:Suppliers{sid:2})
MATCH (p:Parts{pid:2})
MATCH (j:Projects{jid:2})
MERGE (spj:SPJ{qty:15})
CREATE (s)-[:SUPPLIED]->(spj)
CREATE (p)-[:PART_USED]->(spj)
CREATE (j)-[:PROJECT_IDEA]->(spj);

MATCH (s:Suppliers{sid:3})
MATCH (p:Parts{pid:3})
MATCH (j:Projects{jid:3})
MERGE (spj:SPJ{qty:43})
CREATE (s)-[:SUPPLIED]->(spj)
CREATE (p)-[:PART_USED]->(spj)
CREATE (j)-[:PROJECT_IDEA]->(spj);