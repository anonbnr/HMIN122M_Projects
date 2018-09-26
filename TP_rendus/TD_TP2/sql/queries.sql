@script_table.sql
@script_remplissage.sql


-- QUESTION 1
-- script_tables.sql: création des tables de la base de données
-- script_remplissage.sql: remplissage des tables crées.

set autotrace on
SET LINESIZE 200

--QUESTION 2
/*expliciter le plan d'exécution choisi par l'optimiseur en utilisant l'option d'autotrace pour visualiser des statistiques sur les opérations effectués pour la requête*/
explain plan for select nom from ville where insee='34172';
select plan_table_output from table(dbms_xplan.display()); --afficher le résultat d'explicitation du plan d'exécution choisi par l'optimiseur pour la requête

-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Plan hash value: 2371920588
--
-- ---------------------------------------------------------------------------
-- | Id  | Operation	  | Name  | Rows  | Bytes | Cost (%CPU)| Time	  |
-- ---------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT  |	  |	3 |   168 |    68   (0)| 00:00:01 |
-- |*  1 |  TABLE ACCESS FULL| VILLE |	3 |   168 |    68   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------
--
-- Predicate Information (identified by operation id):
-- ---------------------------------------------------
--
-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
--    1 - filter("INSEE"='34172')
--
-- Note
-- -----
--    - dynamic sampling used for this statement (level=2)
--
-- 17 rows selected.
--
--
-- Execution Plan
-- ----------------------------------------------------------
-- Plan hash value: 2137789089
--
-- ---------------------------------------------------------------------------------------------
-- | Id  | Operation			  | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT		  |	    |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- |   1 |  COLLECTION ITERATOR PICKLER FETCH| DISPLAY |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------------------------
--
--
-- Statistics
-- ----------------------------------------------------------
-- 	 13  recursive calls
-- 	 12  db block gets
-- 	 52  consistent gets
-- 	  0  physical reads
-- 	  0  redo size
--        1534  bytes sent via SQL*Net to client
-- 	511  bytes received via SQL*Net from client
-- 	  3  SQL*Net roundtrips to/from client
-- 	  1  sorts (memory)
-- 	  0  sorts (disk)
-- 	 17  rows processed

--QUESTION 3
alter table ville add constraint PK_VILLE PRIMARY KEY(insee);

--QUESTION 4
explain plan for select nom from ville where insee='34172';
select plan_table_output from table(dbms_xplan.display());

-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Plan hash value: 2141926878
--
-- ----------------------------------------------------------------------------------------
-- | Id  | Operation		    | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
-- ----------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT	    |	       |     1 |    56 |     2	 (0)| 00:00:01 |
-- |   1 |  TABLE ACCESS BY INDEX ROWID| VILLE    |     1 |    56 |     2	 (0)| 00:00:01 |
-- |*  2 |   INDEX UNIQUE SCAN	    | PK_VILLE |     1 |       |     1	 (0)| 00:00:01 |
-- ----------------------------------------------------------------------------------------
--
-- Predicate Information (identified by operation id):
--
-- PLAN_TABLE_OUTPUT
-- ----------------------------------------------------------
-- Plan hash value: 2137789089
--
-- ---------------------------------------------------------------------------------------------
-- | Id  | Operation			  | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT		  |	    |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- |   1 |  COLLECTION ITERATOR PICKLER FETCH| DISPLAY |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------------------------
--
--
-- Statistics
-- ----------------------------------------------------------
-- 	 14  recursive calls
-- 	 12  db block gets
-- 	 50  consistent gets
-- 	  0  physical reads
-- 	  0  redo size
--        1435  bytes sent via SQL*Net to client
-- 	500  bytes received via SQL*Net from client
-- 	  2  SQL*Net roundtrips to/from client
-- 	  1  sorts (memory)
-- 	  0  sorts (disk)
-- 	 14  rows processed
--

-- QUESTION 5
explain plan for select departement.nom from departement, ville where insee='34172' and departement.id = ville.dep;
select plan_table_output from table(dbms_xplan.display());

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Plan hash value: 1182727008

----------------------------------------------------------------------------------------------
| Id  | Operation		     | Name	     | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT	     |		     |	   1 |	  39 |	   3   (0)| 00:00:01 |
|   1 |  NESTED LOOPS		     |		     |	   1 |	  39 |	   3   (0)| 00:00:01 |
|   2 |   TABLE ACCESS BY INDEX ROWID| VILLE	     |	   1 |	   8 |	   2   (0)| 00:00:01 |
|*  3 |    INDEX UNIQUE SCAN	     | PK_VILLE      |	   1 |	     |	   1   (0)| 00:00:01 |
|   4 |   TABLE ACCESS BY INDEX ROWID| DEPARTEMENT   |	  82 |	2542 |	   1   (0)| 00:00:01 |
|*  5 |    INDEX UNIQUE SCAN	     | SYS_C00388842 |	   1 |	     |	   0   (0)| 00:00:01 |

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   3 - access("INSEE"='34172')
   5 - access("DEPARTEMENT"."ID"="VILLE"."DEP")

18 rows selected.

Statistics
----------------------------------------------------------
	 17  recursive calls
	 12  db block gets
	 50  consistent gets
	  0  physical reads
	  0  redo size
       2008 bytes sent via SQL*Net to client
	511  bytes received via SQL*Net from client
	  3  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	 18  rows processed

-- QUESTION 6
explain plan for select departement.nom from departement, ville where departement.id = ville.dep;
select plan_table_output from table(dbms_xplan.display());

-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Plan hash value: 211249738
--
-- ----------------------------------------------------------------------------------
-- | Id  | Operation	   | Name	 | Rows  | Bytes | Cost (%CPU)| Time	 |
-- ----------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT   |		 | 40241 |  1375K|    72   (2)| 00:00:01 |
-- |*  1 |  HASH JOIN	   |		 | 40241 |  1375K|    72   (2)| 00:00:01 |
-- |   2 |   TABLE ACCESS FULL| DEPARTEMENT |   104 |  3224 |     3   (0)| 00:00:01 |
-- |   3 |   TABLE ACCESS FULL| VILLE	 | 40241 |   157K|    68   (0)| 00:00:01 |
-- ----------------------------------------------------------------------------------
--
--
-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Predicate Information (identified by operation id):
-- ---------------------------------------------------
--
--    1 - access("DEPARTEMENT"."ID"="VILLE"."DEP")
--
-- Note
-- -----
--    - dynamic sampling used for this statement (level=2)
--
-- 19 rows selected.
--
--
-- Execution Plan
-- ----------------------------------------------------------
-- Plan hash value: 2137789089
--
-- ---------------------------------------------------------------------------------------------
-- | Id  | Operation			  | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT		  |	    |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- |   1 |  COLLECTION ITERATOR PICKLER FETCH| DISPLAY |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------------------------
--
--
-- Statistics
-- ---------------------------------------------------------
-- 	 12  db block gets
-- 	 50  consistent gets
-- 	  0  physical reads
-- 	  0  redo size
--        1760  bytes sent via SQL*Net to client
-- 	511  bytes received via SQL*Net from client;
-- 	  3  SQL*Net roundtrips to/from client
-- 	  1  sorts (memory)
-- 	  0  sorts (disk)
-- 	 19  rows processed

-- QUESTION 7
explain plan for select ville.nom, departement.nom from ville, departement where departement.id='91' and ville.dep=departement.id;
select plan_table_output from table(dbms_xplan.display());

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Plan hash value: 3197113083

----------------------------------------------------------------------------------------------
| Id  | Operation		     | Name	     | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT	     |		     |	 759 | 66033 |	  69   (0)| 00:00:01 |
|   1 |  NESTED LOOPS		     |		     |	 759 | 66033 |	  69   (0)| 00:00:01 |
|   2 |   TABLE ACCESS BY INDEX ROWID| DEPARTEMENT   |	   1 |	  31 |	   1   (0)| 00:00:01 |
|*  3 |    INDEX UNIQUE SCAN	     | SYS_C00388842 |	   1 |	     |	   1   (0)| 00:00:01 |
|*  4 |   TABLE ACCESS FULL	     | VILLE	     |	 759 | 42504 |	  68   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   3 - access("DEPARTEMENT"."ID"='91')
   4 - filter("VILLE"."DEP"='91')

Note
-----
   - dynamic sampling used for this statement (level=2)

21 rows selected.
--
--
-- Execution Plan
-- ----------------------------------------------------------
-- Plan hash value: 2137789089
--
-- ---------------------------------------------------------------------------------------------
-- | Id  | Operation			  | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT		  |	    |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- |   1 |  COLLECTION ITERATOR PICKLER FETCH| DISPLAY |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------------------------
--

Statistics
----------------------------------------------------------
	 20  recursive calls
	 12  db block gets
	 54  consistent gets
	  0  physical reads
	  0  redo size
       1979  bytes sent via SQL*Net to client
	511  bytes received via SQL*Net from client
	  3  SQL*Net roundtrips to/from client
	  1  sorts (memory)
	  0  sorts (disk)
	 21  rows processed

explain plan for select departement.nom from departement where departement.id='92';
select plan_table_output from table(dbms_xplan.display());

-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Plan hash value: 180346705
--
-- ---------------------------------------------------------------------------------------------
-- | Id  | Operation		    | Name	    | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT	    |		    |	  1 |	 31 |	  1   (0)| 00:00:01 |
-- |   1 |  TABLE ACCESS BY INDEX ROWID| DEPARTEMENT   |	  1 |	 31 |	  1   (0)| 00:00:01 |
-- |*  2 |   INDEX UNIQUE SCAN	    | SYS_C00388842 |	  1 |	    |	  1   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------------------------
--
-- Predicate Information (identified by operation id):
--
-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------
--
--    2 - access("DEPARTEMENT"."ID"='92')
--
-- 14 rows selected.
--
--
-- Execution Plan
-- ----------------------------------------------------------
-- Plan hash value: 2137789089
--
-- ---------------------------------------------------------------------------------------------
-- | Id  | Operation			  | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT		  |	    |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- |   1 |  COLLECTION ITERATOR PICKLER FETCH| DISPLAY |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------------------------
--
--
-- Statistics
-- ----------------------------------------------------------
-- 	 14  recursive calls
-- 	 12  db block gets
-- 	 52  consistent gets
-- 	  0  physical reads
-- 	  0  redo size
--        1477  bytes sent via SQL*Net to client
-- 	500  bytes received via SQL*Net from client
-- 	  2  SQL*Net roundtrips to/from client
-- 	  1  sorts (memory)
-- 	  0  sorts (disk)
-- 	 14  rows processed

-- QUESTION 8
--1st query (QUESTION 5)
explain plan for select /*+ use_nl(departement ville)*/ departement.nom from departement, ville where insee='34172' and departement.id = ville.dep;
select plan_table_output from table(dbms_xplan.display());
-- SAME OUTPUT AS QUESTION 5

--2nd query (QUESTION 6)
explain plan for select /*+ use_nl(departement ville)*/ departement.nom from departement, ville where departement.id = ville.dep;
select plan_table_output from table(dbms_xplan.display());

-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Plan hash value: 1651012225
--
-- ----------------------------------------------------------------------------------
-- | Id  | Operation	   | Name	 | Rows  | Bytes | Cost (%CPU)| Time	 |
-- ----------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT   |		 | 40241 |  1375K|  6908   (1)| 00:01:23 |
-- |   1 |  NESTED LOOPS	   |		 | 40241 |  1375K|  6908   (1)| 00:01:23 |
-- |   2 |   TABLE ACCESS FULL| DEPARTEMENT |   104 |  3224 |     3   (0)| 00:00:01 |
-- |*  3 |   TABLE ACCESS FULL| VILLE	 |   387 |  1548 |    66   (0)| 00:00:01 |
-- ----------------------------------------------------------------------------------
--
--
-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Predicate Information (identified by operation id):
-- ---------------------------------------------------
--
--    3 - filter("DEPARTEMENT"."ID"="VILLE"."DEP")
--
-- Note
-- -----
--    - dynamic sampling used for this statement (level=2)
--
-- 19 rows selected.
--
--
-- Execution Plan
-- ----------------------------------------------------------
-- Plan hash value: 2137789089
--
-- ---------------------------------------------------------------------------------------------
-- | Id  | Operation			  | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT		  |	    |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- |   1 |  COLLECTION ITERATOR PICKLER FETCH| DISPLAY |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------------------------
--
--
-- Statistics
-- ----------------------------------------------------------
-- 	 15  recursive calls
-- 	 12  db block gets
-- 	 54  consistent gets
-- 	  0  physical reads
-- 	  0  redo size
--        1761  bytes sent via SQL*Net to client
-- 	511  bytes received via SQL*Net from client
-- 	  3  SQL*Net roundtrips to/from client
-- 	  1  sorts (memory)
-- 	  0  sorts (disk)
-- 	 19  rows processed
--

--3rd query (QUESTION 7)
explain plan for select /*use nl(departement ville)*/ ville.nom, departement.nom from departement, ville where departement.id='92';
select plan_table_output from table(dbms_xplan.display());
-- SAME OUTPUT AS QUESTION 7

-- QUESTION 9
create index idx_dep_ville on ville(dep);
--1st query (QUESTION 2) //attribute departement from table ville not used in query

--2nd query (QUESTION 4) //attribute departement from table ville not used in query

--3rd query (QUESTION 5) //attribute departement from table ville not used in query

--4th query (QUESTION 6)
explain plan for select departement.nom from departement, ville where departement.id = ville.dep;
select plan_table_output from table(dbms_xplan.display());

-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Plan hash value: 3151218067
--
-- ---------------------------------------------------------------------------------------
-- | Id  | Operation	      | Name	      | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT      | 	      | 40241 |  1375K|    27	(4)| 00:00:01 |
-- |*  1 |  HASH JOIN	      | 	      | 40241 |  1375K|    27	(4)| 00:00:01 |
-- |   2 |   TABLE ACCESS FULL   | DEPARTEMENT   |   104 |  3224 |     3	(0)| 00:00:01 |
-- |   3 |   INDEX FAST FULL SCAN| IDX_DEP_VILLE | 40241 |   157K|    23	(0)| 00:00:01 |
-- ---------------------------------------------------------------------------------------
--
--
-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Predicate Information (identified by operation id):
-- ---------------------------------------------------
--
--    1 - access("DEPARTEMENT"."ID"="VILLE"."DEP")
--
-- Note
-- -----
--    - dynamic sampling used for this statement (level=2)
--
-- 19 rows selected.
--
--
-- Execution Plan
-- ----------------------------------------------------------
-- Plan hash value: 2137789089
--
-- ---------------------------------------------------------------------------------------------
-- | Id  | Operation			  | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT		  |	    |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- |   1 |  COLLECTION ITERATOR PICKLER FETCH| DISPLAY |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------------------------
--
--
-- Statistics
-- ----------------------------------------------------------
-- 	 15  recursive calls
-- 	 12  db block gets
-- 	 50  consistent gets
-- 	  0  physical reads
-- 	  0  redo size
--        1801  bytes sent via SQL*Net to client
-- 	511  bytes received via SQL*Net from client
-- 	  3  SQL*Net roundtrips to/from client
-- 	  1  sorts (memory)
-- 	  0  sorts (disk)
-- 	 19  rows processed
--

--5th query
explain plan for select ville.nom, departement.nom from ville, departement where departement.id='91' and ville.dep=departement.id;
select plan_table_output from table(dbms_xplan.display());

-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Plan hash value: 2966802174
--
-- ----------------------------------------------------------------------------------------------
-- | Id  | Operation		     | Name	     | Rows  | Bytes | Cost (%CPU)| Time     |
-- ----------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT	     |		     |	 196 | 16660 |	   4   (0)| 00:00:01 |
-- |   1 |  NESTED LOOPS		     |		     |	 196 | 16660 |	   4   (0)| 00:00:01 |
-- |   2 |   TABLE ACCESS BY INDEX ROWID| DEPARTEMENT   |	   1 |	  31 |	   1   (0)| 00:00:01 |
-- |*  3 |    INDEX UNIQUE SCAN	     | SYS_C00388842 |	   1 |	     |	   1   (0)| 00:00:01 |
-- |   4 |   TABLE ACCESS BY INDEX ROWID| VILLE	     |	 196 | 10584 |	   3   (0)| 00:00:01 |
-- |*  5 |    INDEX RANGE SCAN	     | IDX_DEP_VILLE |	 196 |	     |	   1   (0)| 00:00:01 |
--
-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
--
-- Predicate Information (identified by operation id):
-- ---------------------------------------------------
--
--    3 - access("DEPARTEMENT"."ID"='91')
--    5 - access("VILLE"."DEP"='91')
--
-- Note
-- -----
--    - dynamic sampling used for this statement (level=2)
--
-- 22 rows selected.
--
--
-- Execution Plan
-- ----------------------------------------------------------
-- Plan hash value: 2137789089
--
-- ---------------------------------------------------------------------------------------------
-- | Id  | Operation			  | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT		  |	    |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- |   1 |  COLLECTION ITERATOR PICKLER FETCH| DISPLAY |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------------------------
--
--
-- Statistics
-- ----------------------------------------------------------
-- 	 17  recursive calls
-- 	 12  db block gets
-- 	 50  consistent gets
-- 	  0  physical reads
-- 	  0  redo size
--        2075  bytes sent via SQL*Net to client
-- 	511  bytes received via SQL*Net from client
-- 	  3  SQL*Net roundtrips to/from client
-- 	  1  sorts (memory)
-- 	  0  sorts (disk)
-- 	 22  rows processed
--

-- QUESTION 10
explain plan for select ville.nom, departement.nom, region.nom from ville, departement, region where ville.dep = departement.id and departement.reg = region.id;
select plan_table_output from table(dbms_xplan.display());

-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Plan hash value: 424771235
--
-- -----------------------------------------------------------------------------------
-- | Id  | Operation	    | Name	  | Rows  | Bytes | Cost (%CPU)| Time	  |
-- -----------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT    |		  | 40241 |  5501K|    75   (2)| 00:00:01 |
-- |*  1 |  HASH JOIN	    |		  | 40241 |  5501K|    75   (2)| 00:00:01 |
-- |*  2 |   HASH JOIN	    |		  |   104 |  8736 |	7  (15)| 00:00:01 |
-- |   3 |    TABLE ACCESS FULL| REGION	  |    27 |  1080 |	3   (0)| 00:00:01 |
-- |   4 |    TABLE ACCESS FULL| DEPARTEMENT |   104 |  4576 |	3   (0)| 00:00:01 |
-- |   5 |   TABLE ACCESS FULL | VILLE	  | 40241 |  2200K|    68   (0)| 00:00:01 |
--
-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------
--
-- Predicate Information (identified by operation id):
-- ---------------------------------------------------
--
--    1 - access("VILLE"."DEP"="DEPARTEMENT"."ID")
--    2 - access("DEPARTEMENT"."REG"="REGION"."ID")
--
-- Note
-- -----
--    - dynamic sampling used for this statement (level=2)
--
-- 22 rows selected.
--
--
-- Execution Plan
-- ----------------------------------------------------------
-- Plan hash value: 2137789089
--
-- ---------------------------------------------------------------------------------------------
-- | Id  | Operation			  | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT		  |	    |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- |   1 |  COLLECTION ITERATOR PICKLER FETCH| DISPLAY |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------------------------
--
--
-- Statistics
-- ----------------------------------------------------------
-- 	 17  recursive calls
-- 	 12  db block gets
-- 	 54  consistent gets
-- 	  0  physical reads
-- 	  0  redo size
--        1988  bytes sent via SQL*Net to client
-- 	511  bytes received via SQL*Net from client
-- 	  3  SQL*Net roundtrips to/from client
-- 	  1  sorts (memory)
-- 	  0  sorts (disk)
-- 	 22  rows processed

-- QUESTION 11
create index idx_reg_departement on departement(reg);
explain plan for select ville.nom, departement.nom, region.nom from ville, departement, region where ville.dep = departement.id and departement.reg = region.id;
select plan_table_output from table(dbms_xplan.display());

-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Plan hash value: 3309180011
--
-- -----------------------------------------------------------------------------------------------------
-- | Id  | Operation		      | Name		    | Rows  | Bytes | Cost (%CPU)| Time     |
-- -----------------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT	      | 		    | 40241 |  5501K|	 74   (0)| 00:00:01 |
-- |*  1 |  HASH JOIN		      | 		    | 40241 |  5501K|	 74   (0)| 00:00:01 |
-- |   2 |   NESTED LOOPS		      | 		    |	    |	    |		 |	    |
-- |   3 |    NESTED LOOPS 	      | 		    |	104 |  8736 |	  6   (0)| 00:00:01 |
-- |   4 |     TABLE ACCESS FULL	      | REGION		    |	 27 |  1080 |	  3   (0)| 00:00:01 |
-- |*  5 |     INDEX RANGE SCAN	      | IDX_REG_DEPARTEMENT |	  4 |	    |	  0   (0)| 00:00:01 |
--
-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- |   6 |    TABLE ACCESS BY INDEX ROWID| DEPARTEMENT	    |	  4 |	176 |	  1   (0)| 00:00:01 |
-- |   7 |   TABLE ACCESS FULL	      | VILLE		    | 40241 |  2200K|	 68   (0)| 00:00:01 |
-- -----------------------------------------------------------------------------------------------------
--
-- Predicate Information (identified by operation id):
-- ---------------------------------------------------
--
--    1 - access("VILLE"."DEP"="DEPARTEMENT"."ID")
--    5 - access("DEPARTEMENT"."REG"="REGION"."ID")
--
-- Note
--
-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----
--    - dynamic sampling used for this statement (level=2)
--
-- 24 rows selected.
--
--
-- Execution Plan
-- ----------------------------------------------------------
-- Plan hash value: 2137789089
--
-- ---------------------------------------------------------------------------------------------
-- | Id  | Operation			  | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT		  |	    |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- |   1 |  COLLECTION ITERATOR PICKLER FETCH| DISPLAY |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------------------------
--
--
-- Statistics
-- ----------------------------------------------------------
-- 	 19  recursive calls
-- 	 12  db block gets
-- 	 60  consistent gets
-- 	  0  physical reads
-- 	  0  redo size
--        2375  bytes sent via SQL*Net to client
-- 	511  bytes received via SQL*Net from client
-- 	  3  SQL*Net roundtrips to/from client
-- 	  1  sorts (memory)
-- 	  0  sorts (disk)
-- 	 24  rows processed
--
-- QUESTION 12
explain plan for select ville.nom, departement.nom, region.nom from ville, departement, region where region.id=91 and ville.dep=departement.id and departement.reg=region.id;
select plan_table_output from table(dbms_xplan.display());

-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Plan hash value: 1689416358
--
-- ------------------------------------------------------------------------------------------------------
-- | Id  | Operation		       | Name		     | Rows  | Bytes | Cost (%CPU)| Time     |
-- ------------------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT	       |		     |	3410 |	 466K|	  21   (0)| 00:00:01 |
-- |   1 |  NESTED LOOPS		       |		     |	     |	     |		  |	     |
-- |   2 |   NESTED LOOPS		       |		     |	3410 |	 466K|	  21   (0)| 00:00:01 |
-- |   3 |    NESTED LOOPS 	       |		     |	   5 |	 420 |	   2   (0)| 00:00:01 |
-- |   4 |     TABLE ACCESS BY INDEX ROWID| REGION 	     |	   1 |	  40 |	   1   (0)| 00:00:01 |
-- |*  5 |      INDEX UNIQUE SCAN	       | SYS_C00388841	     |	   1 |	     |	   1   (0)| 00:00:01 |
--
-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- |   6 |     TABLE ACCESS BY INDEX ROWID| DEPARTEMENT	     |	   5 |	 220 |	   1   (0)| 00:00:01 |
-- |*  7 |      INDEX RANGE SCAN	       | IDX_REG_DEPARTEMENT |	   5 |	     |	   0   (0)| 00:00:01 |
-- |*  8 |    INDEX RANGE SCAN	       | IDX_DEP_VILLE	     |	 682 |	     |	   1   (0)| 00:00:01 |
-- |   9 |   TABLE ACCESS BY INDEX ROWID  | VILLE		     |	 682 | 38192 |	   6   (0)| 00:00:01 |
-- ------------------------------------------------------------------------------------------------------
--
-- Predicate Information (identified by operation id):
-- ---------------------------------------------------
--
--    5 - access("REGION"."ID"=91)
--    7 - access("DEPARTEMENT"."REG"=91)
--
-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--    8 - access("VILLE"."DEP"="DEPARTEMENT"."ID")
--
-- Note
-- -----
--    - dynamic sampling used for this statement (level=2)
--
-- 27 rows selected.
--
--
-- Execution Plan
-- ----------------------------------------------------------
-- Plan hash value: 2137789089
--
-- ---------------------------------------------------------------------------------------------
-- | Id  | Operation			  | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT		  |	    |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- |   1 |  COLLECTION ITERATOR PICKLER FETCH| DISPLAY |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------------------------
--
--
-- Statistics
-- ----------------------------------------------------------
-- 	 21  recursive calls
-- 	 12  db block gets
-- 	 56  consistent gets
-- 	  0  physical reads
-- 	  0  redo size
--        2617  bytes sent via SQL*Net to client
-- 	511  bytes received via SQL*Net from client
-- 	  3  SQL*Net roundtrips to/from client
-- 	  1  sorts (memory)
-- 	  0  sorts (disk)
-- 	 27  rows processed

--QUESTION 13
explain plan for select ville.nom from ville where ville.dep LIKE '7%';
select plan_table_output from table(dbms_xplan.display());

-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Plan hash value: 428725444
--
-- ---------------------------------------------------------------------------------------------
-- | Id  | Operation		    | Name	    | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT	    |		    |  4183 |	220K|	 35   (0)| 00:00:01 |
-- |   1 |  TABLE ACCESS BY INDEX ROWID| VILLE	    |  4183 |	220K|	 35   (0)| 00:00:01 |
-- |*  2 |   INDEX RANGE SCAN	    | IDX_DEP_VILLE |  4183 |	    |	 10   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------------------------
--
-- Predicate Information (identified by operation id):
--
-- PLAN_TABLE_OUTPUT
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------
--
--    2 - access("VILLE"."DEP" LIKE '7%')
--        filter("VILLE"."DEP" LIKE '7%')
--
-- Note
-- -----
--    - dynamic sampling used for this statement (level=2)
--
-- 19 rows selected.
--
--
-- Execution Plan
-- ----------------------------------------------------------
-- Plan hash value: 2137789089
--
-- ---------------------------------------------------------------------------------------------
-- | Id  | Operation			  | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT		  |	    |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- |   1 |  COLLECTION ITERATOR PICKLER FETCH| DISPLAY |  8168 | 16336 |	 29   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------------------------
--
--
-- Statistics
-- ----------------------------------------------------------
-- 	 18  recursive calls
-- 	 12  db block gets
-- 	 56  consistent gets
-- 	  0  physical reads
-- 	  0  redo size
--        1784  bytes sent via SQL*Net to client
-- 	511  bytes received via SQL*Net from client
-- 	  3  SQL*Net roundtrips to/from client
-- 	  1  sorts (memory)
-- 	  0  sorts (disk)
-- 	 19  rows processed
--
--QUESTION 14
exec dbms_stats.gather_table_stats('brima','ville'); --adds the cost details for table 'ville'
exec dbms_stats.gather_table_stats('brima','departement'); --adds the cost details for table 'departement'
exec dbms_stats.gather_table_stats('brima','region'); --adds the cost details for table 'region'
SELECT * FROM USER_TAB_COL_STATISTICS;

-- TABLE_NAME		       COLUMN_NAME		      NUM_DISTINCT LOW_VALUE
-- ------------------------------ ------------------------------ ------------ ----------------------------------------------------------------
-- HIGH_VALUE							    DENSITY  NUM_NULLS NUM_BUCKETS LAST_ANAL SAMPLE_SIZE GLO USE AVG_COL_LEN HISTOGRAM
-- ---------------------------------------------------------------- ---------- ---------- ----------- --------- ----------- --- --- ----------- ---------------
-- DEPARTEMENT		       REG					27 80
-- C15F								 .004807692	     0		27 25-SEP-18	     104 YES NO 	   3 FREQUENCY
--
-- DEPARTEMENT		       NOM				       104 41696E
-- 5976656C696E6573						 .009615385	     0		 1 25-SEP-18	     104 YES NO 	  11 NONE
--
-- DEPARTEMENT		       ID				       104 31
-- 393838								 .009615385	     0		 1 25-SEP-18	     104 YES NO 	   3 NONE
--
--
-- TABLE_NAME		       COLUMN_NAME		      NUM_DISTINCT LOW_VALUE
-- ------------------------------ ------------------------------ ------------ ----------------------------------------------------------------
-- HIGH_VALUE							    DENSITY  NUM_NULLS NUM_BUCKETS LAST_ANAL SAMPLE_SIZE GLO USE AVG_COL_LEN HISTOGRAM
-- ---------------------------------------------------------------- ---------- ---------- ----------- --------- ----------- --- --- ----------- ---------------
-- REGION			       NOM					27 414C53414345
-- 52484F4E452D414C504553						 .037037037	     0		 1 25-SEP-18	      27 YES NO 	  13 NONE
--
-- REGION			       ID					27 80
-- C15F								 .037037037	     0		 1 25-SEP-18	      27 YES NO 	   3 NONE
--
-- VILLE			       DEP				       100 31
-- 393734								 .000013621	     0		98 25-SEP-18	    5516 YES NO 	   3 FREQUENCY
--
--
-- TABLE_NAME		       COLUMN_NAME		      NUM_DISTINCT LOW_VALUE
-- ------------------------------ ------------------------------ ------------ ----------------------------------------------------------------
-- HIGH_VALUE							    DENSITY  NUM_NULLS NUM_BUCKETS LAST_ANAL SAMPLE_SIZE GLO USE AVG_COL_LEN HISTOGRAM
-- ---------------------------------------------------------------- ---------- ---------- ----------- --------- ----------- --- --- ----------- ---------------
-- VILLE			       NOM				     33772 41415354
-- 5A5559545045454E45						  .00002961	     0		 1 25-SEP-18	   36601 YES NO 	  13 NONE
--
-- VILLE			       INSEE				     36601 3130303032
-- 3937343234							 .000027322	     0		 1 25-SEP-18	   36601 YES NO 	   6 NONE
--
--
-- 8 rows selected.
--
--
-- Execution Plan
-- ----------------------------------------------------------
-- Plan hash value: 847852727
--
-- ------------------------------------------------------------------------------------------------------------------
-- | Id  | Operation			       | Name			 | Rows  | Bytes | Cost (%CPU)| Time	 |
-- ------------------------------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT		       |			 |   105 | 18060 |   278   (2)| 00:00:04 |
-- |   1 |  VIEW				       | USER_TAB_COL_STATISTICS |   105 | 18060 |   278   (2)| 00:00:04 |
-- |   2 |   UNION-ALL			       |			 |	 |	 |	      | 	 |
-- |   3 |    CONCATENATION		       |			 |	 |	 |	      | 	 |
-- |*  4 |     FILTER			       |			 |	 |	 |	      | 	 |
-- |*  5 |      HASH JOIN OUTER		       |			 |     5 |   885 |    74   (2)| 00:00:01 |
-- |   6 |       NESTED LOOPS OUTER	       |			 |     5 |   865 |    70   (0)| 00:00:01 |
-- |   7 |        NESTED LOOPS OUTER	       |			 |     5 |   815 |    35   (0)| 00:00:01 |
-- |   8 | 	NESTED LOOPS		       |			 |     5 |   685 |    34   (0)| 00:00:01 |
-- |   9 | 	 NESTED LOOPS		       |			 |    16 |  1408 |    14   (0)| 00:00:01 |
-- |  10 | 	  NESTED LOOPS		       |			 |     3 |   204 |    13   (0)| 00:00:01 |
-- |* 11 | 	   TABLE ACCESS BY INDEX ROWID | OBJ$			 |     3 |   138 |    10   (0)| 00:00:01 |
-- |* 12 | 	    INDEX RANGE SCAN	       | I_OBJ5 		 |     4 |	 |     7   (0)| 00:00:01 |
-- |* 13 | 	     TABLE ACCESS CLUSTER      | TAB$			 |     1 |    13 |     2   (0)| 00:00:01 |
-- |* 14 | 	      INDEX UNIQUE SCAN        | I_OBJ# 		 |     1 |	 |     1   (0)| 00:00:01 |
-- |* 15 | 	   INDEX RANGE SCAN	       | I_USER2		 |     1 |    22 |     1   (0)| 00:00:01 |
-- |  16 | 	  TABLE ACCESS CLUSTER	       | COL$			 |     6 |   120 |     1   (0)| 00:00:01 |
-- |* 17 | 	   INDEX UNIQUE SCAN	       | I_OBJ# 		 |     1 |	 |     0   (0)| 00:00:01 |
-- |* 18 | 	 TABLE ACCESS BY INDEX ROWID   | HIST_HEAD$		 |     1 |    49 |     2   (0)| 00:00:01 |
-- |* 19 | 	  INDEX RANGE SCAN	       | I_HH_OBJ#_INTCOL#	 |     1 |	 |     1   (0)| 00:00:01 |
-- |  20 | 	TABLE ACCESS BY INDEX ROWID    | COLTYPE$		 |     1 |    26 |     1   (0)| 00:00:01 |
-- |* 21 | 	 INDEX UNIQUE SCAN	       | I_COLTYPE2		 |     1 |	 |     0   (0)| 00:00:01 |
-- |* 22 |        TABLE ACCESS BY INDEX ROWID     | OBJ$			 |     1 |    10 |     7   (0)| 00:00:01 |
-- |* 23 | 	INDEX RANGE SCAN	       | I_OBJ3 		 |    21 |	 |     1   (0)| 00:00:01 |
-- |  24 |       INDEX FAST FULL SCAN	       | I_USER2		 |   619 |  2476 |     3   (0)| 00:00:01 |
-- |  25 |      NESTED LOOPS		       |			 |     1 |    32 |     4   (0)| 00:00:01 |
-- |* 26 |       INDEX RANGE SCAN		       | I_OBJ4 		 |     1 |    12 |     3   (0)| 00:00:01 |
-- |* 27 |       INDEX RANGE SCAN		       | I_USER2		 |     1 |    20 |     1   (0)| 00:00:01 |
-- |* 28 |     FILTER			       |			 |	 |	 |	      | 	 |
-- |* 29 |      HASH JOIN OUTER		       |			 |     7 |  1239 |   179   (1)| 00:00:03 |
-- |  30 |       NESTED LOOPS OUTER	       |			 |     7 |  1211 |   176   (1)| 00:00:03 |
-- |  31 |        NESTED LOOPS OUTER	       |			 |     7 |  1141 |   127   (1)| 00:00:02 |
-- |* 32 | 	HASH JOIN		       |			 |     7 |   959 |   120   (1)| 00:00:02 |
-- |  33 | 	 NESTED LOOPS		       |			 |	 |	 |	      | 	 |
-- |  34 | 	  NESTED LOOPS		       |			 |     7 |   805 |   116   (0)| 00:00:02 |
-- |  35 | 	   NESTED LOOPS 	       |			 |    47 |  3102 |    22   (0)| 00:00:01 |
-- |* 36 | 	    TABLE ACCESS BY INDEX ROWID| OBJ$			 |     8 |   368 |    14   (0)| 00:00:01 |
-- |* 37 | 	     INDEX RANGE SCAN	       | I_OBJ5 		 |    13 |	 |     7   (0)| 00:00:01 |
-- |  38 | 	    TABLE ACCESS CLUSTER       | COL$			 |     6 |   120 |     1   (0)| 00:00:01 |
-- |* 39 | 	     INDEX UNIQUE SCAN	       | I_OBJ# 		 |     1 |	 |     0   (0)| 00:00:01 |
-- |* 40 | 	   INDEX RANGE SCAN	       | I_HH_OBJ#_INTCOL#	 |     1 |	 |     1   (0)| 00:00:01 |
-- |* 41 | 	  TABLE ACCESS BY INDEX ROWID  | HIST_HEAD$		 |     1 |    49 |     2   (0)| 00:00:01 |
-- |  42 | 	 INDEX FAST FULL SCAN	       | I_USER2		 |   619 | 13618 |     3   (0)| 00:00:01 |
-- |* 43 | 	TABLE ACCESS CLUSTER	       | COLTYPE$		 |     1 |    26 |     1   (0)| 00:00:01 |
-- |* 44 |        TABLE ACCESS BY INDEX ROWID     | OBJ$			 |     1 |    10 |     7   (0)| 00:00:01 |
-- |* 45 | 	INDEX RANGE SCAN	       | I_OBJ3 		 |    21 |	 |     1   (0)| 00:00:01 |
-- |  46 |       INDEX FAST FULL SCAN	       | I_USER2		 |   619 |  2476 |     3   (0)| 00:00:01 |
-- |* 47 |      TABLE ACCESS CLUSTER	       | TAB$			 |     1 |    13 |     2   (0)| 00:00:01 |
-- |* 48 |       INDEX UNIQUE SCAN 	       | I_OBJ# 		 |     1 |	 |     1   (0)| 00:00:01 |
-- |  49 |      NESTED LOOPS		       |			 |     1 |    32 |     4   (0)| 00:00:01 |
-- |* 50 |       INDEX RANGE SCAN		       | I_OBJ4 		 |     1 |    12 |     3   (0)| 00:00:01 |
-- |* 51 |       INDEX RANGE SCAN		       | I_USER2		 |     1 |    20 |     1   (0)| 00:00:01 |
-- |* 52 |    FILTER			       |			 |	 |	 |	      | 	 |
-- |* 53 |     HASH JOIN			       |			 |     4 |   600 |    23   (9)| 00:00:01 |
-- |  54 |      NESTED LOOPS		       |			 |	 |	 |	      | 	 |
-- |  55 |       NESTED LOOPS		       |			 |    58 |  6206 |    22   (5)| 00:00:01 |
-- |* 56 |        HASH JOIN		       |			 |     9 |   522 |     4  (25)| 00:00:01 |
-- |  57 | 	TABLE ACCESS FULL	       | FIXED_OBJ$		 |   913 | 13695 |     3   (0)| 00:00:01 |
-- |  58 | 	FIXED TABLE FULL	       | X$KQFTA		 |   913 | 39259 |     0   (0)| 00:00:01 |
-- |* 59 |        INDEX RANGE SCAN 	       | I_HH_OBJ#_COL# 	 |     6 |	 |     1   (0)| 00:00:01 |
-- |* 60 |       TABLE ACCESS BY INDEX ROWID      | HIST_HEAD$		 |     6 |   294 |     2   (0)| 00:00:01 |
-- |  61 |      FIXED TABLE FULL		       | X$KQFCO		 | 12326 |   517K|     1 (100)| 00:00:01 |
-- ------------------------------------------------------------------------------------------------------------------
--
-- Predicate Information (identified by operation id):
-- ---------------------------------------------------
--
--    4 - filter("O"."TYPE#"<>4 AND "O"."TYPE#"<>5 AND "O"."TYPE#"<>7 AND "O"."TYPE#"<>8 AND "O"."TYPE#"<>9
-- 	      AND "O"."TYPE#"<>10 AND "O"."TYPE#"<>11 AND "O"."TYPE#"<>12 AND "O"."TYPE#"<>13 AND "O"."TYPE#"<>14 AND
-- 	      "O"."TYPE#"<>22 AND "O"."TYPE#"<>87 AND "O"."TYPE#"<>88 OR BITAND("U"."SPARE1",16)=0 OR ("O"."TYPE#"=4 OR
-- 	      "O"."TYPE#"=5 OR "O"."TYPE#"=7 OR "O"."TYPE#"=8 OR "O"."TYPE#"=9 OR "O"."TYPE#"=10 OR "O"."TYPE#"=11 OR
-- 	      "O"."TYPE#"=12 OR "O"."TYPE#"=13 OR "O"."TYPE#"=14 OR "O"."TYPE#"=22 OR "O"."TYPE#"=87) AND
-- 	      (SYS_CONTEXT('userenv','current_edition_name')='ORA$BASE' AND "U"."TYPE#"<>2 OR "U"."TYPE#"=2 AND
-- 	      "U"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')) OR  EXISTS (SELECT 0 FROM SYS."USER$"
-- 	      "U2",SYS."OBJ$" "O2" WHERE "O2"."TYPE#"=88 AND "O2"."DATAOBJ#"=:B1 AND "U2"."TYPE#"=2 AND
-- 	      "O2"."OWNER#"="U2"."USER#" AND "U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')))))
--    5 - access("OT"."OWNER#"="U"."USER#"(+))
--   11 - filter(BITAND("O"."FLAGS",128)=0)
--   12 - access("O"."SPARE3"=USERENV('SCHEMAID') AND "O"."TYPE#"=2)
--        filter("O"."TYPE#"=2 AND  NOT EXISTS (SELECT 0 FROM "SYS"."TAB$" "T" WHERE "T"."OBJ#"=:B1 AND
-- 	      (BITAND("T"."PROPERTY",8192)=8192 OR BITAND("T"."PROPERTY",512)=512)))
--   13 - filter(BITAND("T"."PROPERTY",8192)=8192 OR BITAND("T"."PROPERTY",512)=512)
--   14 - access("T"."OBJ#"=:B1)
--   15 - access("O"."OWNER#"="U"."USER#")
--   17 - access("O"."OBJ#"="C"."OBJ#")
--   18 - filter("H"."TIMESTAMP#" IS NOT NULL)
--   19 - access("C"."OBJ#"="H"."OBJ#" AND "C"."INTCOL#"="H"."INTCOL#")
--   21 - access("C"."OBJ#"="AC"."OBJ#"(+) AND "C"."INTCOL#"="AC"."INTCOL#"(+))
--   22 - filter("OT"."TYPE#"(+)=13)
--   23 - access("AC"."TOID"="OT"."OID$"(+))
--   26 - access("O2"."DATAOBJ#"=:B1 AND "O2"."TYPE#"=88)
--   27 - access("O2"."OWNER#"="U2"."USER#" AND "U2"."TYPE#"=2 AND
-- 	      "U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')))
--        filter("U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')))
--   28 - filter((LNNVL("O"."TYPE#"=2) OR LNNVL( NOT EXISTS (SELECT 0 FROM "SYS"."TAB$" "T" WHERE
-- 	      "T"."OBJ#"=:B1 AND (BITAND("T"."PROPERTY",8192)=8192 OR BITAND("T"."PROPERTY",512)=512)))) AND
-- 	      ("O"."TYPE#"<>4 AND "O"."TYPE#"<>5 AND "O"."TYPE#"<>7 AND "O"."TYPE#"<>8 AND "O"."TYPE#"<>9 AND
-- 	      "O"."TYPE#"<>10 AND "O"."TYPE#"<>11 AND "O"."TYPE#"<>12 AND "O"."TYPE#"<>13 AND "O"."TYPE#"<>14 AND
-- 	      "O"."TYPE#"<>22 AND "O"."TYPE#"<>87 AND "O"."TYPE#"<>88 OR BITAND("U"."SPARE1",16)=0 OR ("O"."TYPE#"=4 OR
-- 	      "O"."TYPE#"=5 OR "O"."TYPE#"=7 OR "O"."TYPE#"=8 OR "O"."TYPE#"=9 OR "O"."TYPE#"=10 OR "O"."TYPE#"=11 OR
-- 	      "O"."TYPE#"=12 OR "O"."TYPE#"=13 OR "O"."TYPE#"=14 OR "O"."TYPE#"=22 OR "O"."TYPE#"=87) AND
-- 	      (SYS_CONTEXT('userenv','current_edition_name')='ORA$BASE' AND "U"."TYPE#"<>2 OR "U"."TYPE#"=2 AND
-- 	      "U"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')) OR  EXISTS (SELECT 0 FROM SYS."USER$"
-- 	      "U2",SYS."OBJ$" "O2" WHERE "O2"."TYPE#"=88 AND "O2"."DATAOBJ#"=:B2 AND "U2"."TYPE#"=2 AND
-- 	      "O2"."OWNER#"="U2"."USER#" AND "U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id'))))))
--   29 - access("OT"."OWNER#"="U"."USER#"(+))
--   32 - access("O"."OWNER#"="U"."USER#")
--   36 - filter(BITAND("O"."FLAGS",128)=0)
--   37 - access("O"."SPARE3"=USERENV('SCHEMAID'))
--        filter("O"."TYPE#"=3 OR "O"."TYPE#"=4)
--   39 - access("O"."OBJ#"="C"."OBJ#")
--   40 - access("C"."OBJ#"="H"."OBJ#" AND "C"."INTCOL#"="H"."INTCOL#")
--   41 - filter("H"."TIMESTAMP#" IS NOT NULL)
--   43 - filter("C"."OBJ#"="AC"."OBJ#"(+) AND "C"."INTCOL#"="AC"."INTCOL#"(+))
--   44 - filter("OT"."TYPE#"(+)=13)
--   45 - access("AC"."TOID"="OT"."OID$"(+))
--   47 - filter(BITAND("T"."PROPERTY",8192)=8192 OR BITAND("T"."PROPERTY",512)=512)
--   48 - access("T"."OBJ#"=:B1)
--   50 - access("O2"."DATAOBJ#"=:B1 AND "O2"."TYPE#"=88)
--   51 - access("O2"."OWNER#"="U2"."USER#" AND "U2"."TYPE#"=2 AND
-- 	      "U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')))
--        filter("U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')))
--   52 - filter(USERENV('SCHEMAID')=0)
--   53 - access("C"."KQFCOTOB"="FT"."KQFTAOBJ" AND "H"."INTCOL#"="C"."KQFCOCNO")
--   56 - access("FT"."KQFTAOBJ"="FOBJ"."OBJ#" AND "FT"."KQFTAVER"="FOBJ"."TIMESTAMP"-TO_DATE(' 1991-01-01
-- 	      00:00:00', 'syyyy-mm-dd hh24:mi:ss'))
--   59 - access("H"."OBJ#"="FT"."KQFTAOBJ")
--   60 - filter("H"."TIMESTAMP#" IS NOT NULL)
--
--
-- Statistics
-- ----------------------------------------------------------
-- 	  0  recursive calls
-- 	  0  db block gets
-- 	 65  consistent gets
-- 	  0  physical reads
-- 	  0  redo size
--        1917  bytes sent via SQL*Net to client
-- 	500  bytes received via SQL*Net from client
-- 	  2  SQL*Net roundtrips to/from client
-- 	  0  sorts (memory)
-- 	  0  sorts (disk)
-- 	  8  rows processed
