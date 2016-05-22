--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: 303; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE "SWEN303" WITH TEMPLATE = template0 ENCODING = 'SQL_ASCII' LC_COLLATE = 'C' LC_CTYPE = 'C';




\connect "SWEN303"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

CREATE EXTENSION ltree;

CREATE ROLE SWEN303 PASSWORD 'SWEN303' SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: plpgsql_call_handler(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION plpgsql_call_handler() RETURNS language_handler
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_call_handler';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: stock; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--
CREATE TYPE listing_status AS ENUM ('pending', 'unsuccessful', 'listed');
CREATE TABLE stock (
    sid SERIAL,
    uid integer,
    label text,
    description text,
    price numeric(10,4),
    quantity integer,
    category ltree,
    status listing_status,
    votes integer,
    voters text[]
);

CREATE TABLE site_parameters (
    parameter text,
    value integer
);

INSERT INTO site_parameters VALUES ('PRODUCTS_IN_QUEUE', 10);
INSERT INTO site_parameters VALUES ('VOTES_REQUIRED', 10);
INSERT INTO site_parameters VALUES ('COMPLAINTS_REQUIRED', 5);
INSERT INTO site_parameters VALUES ('VALUATIONS_REQUIRED', 5);


--
-- Name: stock_sid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stock_sid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stock_sid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stock_sid_seq OWNED BY stock.sid;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE transactions (
    tid integer NOT NULL,
    sid integer,
    uid integer,
    type character varying(10)
);


--
-- Name: transactions_tid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transactions_tid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transactions_tid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE transactions_tid_seq OWNED BY transactions.tid;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    uid integer NOT NULL,
    username character varying(50) UNIQUE,
    realname character varying(100),
    password character varying(50) NOT NULL
);


CREATE TABLE invite_codes (
    code character varying(100) NOT NULL,
    invited_by character varying(100),
    used boolean
);

INSERT INTO invite_codes VALUES (uuid_generate_v4(), 'admin', false);
INSERT INTO invite_codes VALUES (uuid_generate_v4(), 'admin', false);
INSERT INTO invite_codes VALUES (uuid_generate_v4(), 'admin', false);

--
-- Name: users_uid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- Name: users_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_uid_seq OWNED BY users.uid;


--
-- Name: sid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stock ALTER COLUMN sid SET DEFAULT nextval('stock_sid_seq'::regclass);


--
-- Name: tid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY transactions ALTER COLUMN tid SET DEFAULT nextval('transactions_tid_seq'::regclass);


--
-- Name: uid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN uid SET DEFAULT nextval('users_uid_seq'::regclass);


--
-- Data for Name: stock; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (1,'Camera','Description', 12.90,3,'Electronics.Photography.Cameras', 'pending', 3, ARRAY['admin', 'MEME', 'test']);
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (1,	'Hat','Description',	30.00, 1,   'Clothes.Headwear.Hats', 'unsuccessful');
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (2,	'Bald Eagle','Description',	999.99,	10,  'Animals.Birds.Birds_of_Prey', 'unsuccessful');
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (2,	'Kiwi', 'Description', 49999.99,	3,   'Animals.Birds.Flightless', 'listed');
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (3,	'Snakes and Ladders','Description',	1.0000,	1,   'Games.Board_Games.Childrens', 'listed');
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (3,	'Monopoly',	'Description', 3.00,	1,   'Games.Board_Games.Evil', 'listed');
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (4,	'Holy Grail',	'Description',0.99,	1,   'Artefacts.Religious', 'listed');
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (5,	'Meaning of Life',	'Description',42.00,	20,  'Truths.Existential', 'listed');
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (5,	'Cactus',	'Description',9.99,	3,   'Plants.Succulent.Evil.Prickly', 'listed');
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (5,	'Iris',	'Description',9.99,	15,  'Plants.Perennial', 'listed');
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (6,	'Knives',	'Description',15.50,	4,   'Homeware.Kitchen.Preparation.Sharp', 'listed');
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (6,	'Sword',	'Description',49.97,	8,  'Weaponry.Sharp', 'listed');
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (7,	'Kryptonite',	'Description',0.50,	100, 'Weaponry.Superhero_Specific.Superman', 'listed');
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (7,	'S Clothing Patch',	'Description',5.99,	1000,    'Clothes.Patches', 'listed');
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (8,	'Table',	'Description',10.00,	1,   'Homeware.Office.Tables', 'listed');
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (9,	'Small Chair',	'Description',5.00,	1,   'Homeware.Office.Chairs', 'listed');
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (10,'Coffee', 'Description',4.99,	10,  'Drugs.Stimulants.Caffeine', 'listed');
--INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (10,'Muffin', 'Description',3.50,	10,  'Food.Baking', 'listed');
--INSERT INTO stock VALUES (19, 3, 'Primis', 340.59, 46,'Category_B.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (20, 10, 'Tempor Turpis', 125.25, 17,'Category_B.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (21, 8, 'Odio', 739.34, 3,'Category_B.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (22, 6, 'Aenean', 481.49, 6,'Category_B.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (23, 8, 'Amet Justo', 488.26, 18,'Category_B.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (24, 9, 'Elementum Nullam Varius', 76.81, 24,'Category_B.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (25, 1, 'Ultrices Vel Augue', 263.54, 5,'Category_B.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (26, 9, 'Molestie', 774.26, 41,'Category_B.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (27, 4, 'Turpis Integer', 90.76, 33,'Category_B.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (28, 7, 'Proin Eu Mi', 169.16, 41,'Category_B.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (29, 3, 'Amet', 61.31, 12,'Category_B.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (30, 7, 'Non Velit', 33.28, 22,'Category_B.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (31, 7, 'Malesuada In', 230.19, 0,'Category_B.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (32, 2, 'Dis', 730.88, 50,'Category_B.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (33, 6, 'Justo In', 307.55, 24,'Category_C.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (34, 5, 'Quam Nec Dui', 631.24, 12,'Category_C.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (35, 2, 'Justo', 66.51, 12,'Category_C.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (36, 7, 'Leo Odio', 169.06, 29,'Category_C.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (37, 5, 'Vulputate Justo In', 7.44, 0,'Category_C.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (38, 7, 'Metus Sapien Ut', 126.55, 11,'Category_C.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (39, 10, 'Lobortis', 794.61, 17,'Category_C.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (40, 9, 'Elementum', 122.98, 5,'Category_C.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (41, 10, 'In Consequat', 565.97, 50,'Category_C.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (42, 10, 'Ut', 975.45, 49,'Category_C.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (43, 5, 'Placerat', 832.15, 43,'Category_C.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (44, 6, 'Turpis Nec', 576.09, 22,'Category_C.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (45, 7, 'Praesent Blandit', 360.1, 1,'Category_C.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (46, 5, 'Id', 407.25, 2,'Category_C.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (47, 6, 'Ut', 283.58, 43,'Category_C.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (48, 4, 'Venenatis Tristique Fusce', 443.88, 36,'Category_C.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (49, 3, 'Maecenas Leo Odio', 487.01, 18,'Category_D.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (50, 8, 'Aliquam Quis Turpis', 40.81, 23,'Category_D.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (51, 7, 'Cubilia Curae', 269.2, 28,'Category_D.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (52, 4, 'Tellus Semper Interdum', 277.42, 46,'Category_D.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (53, 3, 'Pellentesque', 343.2, 5,'Category_D.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (54, 2, 'Sapien Iaculis Congue', 144.03, 9,'Category_D.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (55, 2, 'At', 220.85, 45,'Category_D.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (56, 4, 'Odio', 941.5, 0,'Category_D.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (57, 8, 'Dapibus', 441.04, 26,'Category_D.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (58, 5, 'Metus Sapien Ut', 194.98, 33,'Category_D.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (59, 3, 'Iaculis Congue Vivamus', 75.32, 44,'Category_D.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (60, 2, 'Potenti', 574.82, 48,'Category_D.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (61, 2, 'Est Congue Elementum', 618.35, 31,'Category_D.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (62, 1, 'Etiam Justo', 19.22, 39,'Category_D.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (63, 4, 'Ante Ipsum', 77.85, 29,'Category_D.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (64, 1, 'Odio Condimentum', 708.19, 40,'Category_D.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (65, 7, 'Pede Justo Lacinia', 966.53, 3,'Category_A.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (66, 9, 'Nunc', 916.95, 14,'Category_A.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (67, 4, 'Quam', 299.79, 39,'Category_A.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (68, 5, 'Lobortis Sapien', 561.19, 31,'Category_A.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (69, 9, 'Justo Nec Condimentum', 926.45, 29,'Category_A.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (70, 1, 'Vestibulum Proin Eu', 901.79, 15,'Category_A.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (71, 2, 'Tristique Tortor Eu', 574.97, 1,'Category_A.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (72, 6, 'Est Quam Pharetra', 962.52, 22,'Category_A.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (73, 10, 'Nonummy Integer', 32.91, 9,'Category_A.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (74, 9, 'Nulla Nisl Nunc', 809.31, 50,'Category_A.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (75, 5, 'Massa', 731.1, 38,'Category_A.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (76, 4, 'Potenti Cras In', 349.28, 50,'Category_A.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (77, 1, 'Pretium Quis', 248.84, 22,'Category_A.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (78, 5, 'Donec', 229.86, 24,'Category_A.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (79, 8, 'Tincidunt', 356.31, 40,'Category_A.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (80, 10, 'Iaculis Congue', 990.53, 30,'Category_A.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (81, 2, 'Sagittis Sapien', 815.85, 9,'Category_B.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (82, 6, 'Nisl Duis', 452.11, 11,'Category_B.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (83, 1, 'Hac', 806.21, 34,'Category_B.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (84, 6, 'Duis', 869.74, 48,'Category_B.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (85, 1, 'Venenatis Lacinia', 730.39, 36,'Category_B.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (86, 8, 'Vestibulum Proin Eu', 999.74, 28,'Category_B.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (87, 8, 'Blandit Mi In', 30.5, 42,'Category_B.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (88, 7, 'Cursus Id Turpis', 47.7, 49,'Category_B.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (89, 8, 'Odio Odio', 60.15, 11,'Category_B.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (90, 5, 'Ut', 293.66, 29,'Category_B.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (91, 5, 'Ornare', 186.6, 36,'Category_B.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (92, 1, 'Mattis Odio Donec', 363.51, 44,'Category_B.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (93, 4, 'Imperdiet Sapien', 781.16, 10,'Category_B.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (94, 4, 'Dolor', 407.21, 46,'Category_B.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (95, 4, 'Purus', 421.38, 21,'Category_B.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (96, 7, 'Pulvinar', 51.5, 47,'Category_B.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (97, 2, 'Tempor Convallis Nulla', 829.81, 15,'Category_C.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (98, 4, 'Eget', 784.75, 5,'Category_C.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (99, 9, 'Scelerisque Mauris Sit', 67.97, 27,'Category_C.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (100, 9, 'Ut', 818.67, 28,'Category_C.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (101, 5, 'Magna Ac Consequat', 297.49, 33,'Category_C.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (102, 10, 'Tempus Semper', 551.31, 14,'Category_C.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (103, 3, 'Convallis', 831.4, 48,'Category_C.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (104, 7, 'Vestibulum Ante', 101.2, 0,'Category_C.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (105, 5, 'Volutpat Convallis', 972.45, 6,'Category_C.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (106, 4, 'In Libero Ut', 349.6, 49,'Category_C.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (107, 7, 'Libero Nullam Sit', 388.65, 2,'Category_C.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (108, 6, 'Fusce Consequat', 954.76, 37,'Category_C.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (109, 5, 'Cras', 917.42, 23,'Category_C.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (110, 9, 'Vestibulum Velit', 282.12, 10,'Category_C.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (111, 10, 'Semper', 948.41, 48,'Category_C.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (112, 4, 'Tristique In', 309.63, 41,'Category_C.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (113, 8, 'In Felis', 718.93, 2,'Category_D.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (114, 1, 'Nonummy', 412.01, 0,'Category_D.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (115, 6, 'At', 966.75, 7,'Category_D.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (116, 5, 'Erat Tortor Sollicitudin', 210.34, 47,'Category_D.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (117, 5, 'Posuere Felis Sed', 581.4, 40,'Category_D.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (118, 8, 'Nulla', 512.56, 32,'Category_D.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (119, 3, 'In Purus', 993.36, 46,'Category_D.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (120, 8, 'Massa Tempor', 849.44, 5,'Category_D.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (121, 9, 'Ultrices', 866.57, 33,'Category_D.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (122, 7, 'Nulla Pede', 101.39, 49,'Category_D.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (123, 9, 'Non Ligula', 478.15, 33,'Category_D.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (124, 7, 'Dictumst Aliquam', 378.73, 21,'Category_D.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (125, 2, 'Ipsum Dolor Sit', 813.4, 46,'Category_D.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (126, 7, 'Neque', 320.21, 21,'Category_D.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (127, 6, 'Vehicula Consequat Morbi', 814.32, 27,'Category_D.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (128, 9, 'Dignissim', 380.95, 38,'Category_D.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (129, 4, 'Placerat Praesent Blandit', 228.11, 27,'Category_A.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (130, 7, 'Mauris', 99.0, 27,'Category_A.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (131, 10, 'Viverra', 450.44, 3,'Category_A.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (132, 10, 'In Tempus Sit', 13.72, 6,'Category_A.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (133, 2, 'Massa Donec Dapibus', 685.26, 5,'Category_A.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (134, 10, 'Curae Mauris Viverra', 566.74, 19,'Category_A.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (135, 9, 'Lectus Pellentesque', 908.69, 49,'Category_A.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (136, 1, 'Odio In', 833.49, 27,'Category_A.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (137, 1, 'Morbi Quis', 795.33, 9,'Category_A.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (138, 4, 'Ipsum Dolor', 111.59, 18,'Category_A.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (139, 4, 'Porttitor Id', 372.24, 6,'Category_A.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (140, 5, 'Ipsum', 834.53, 11,'Category_A.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (141, 3, 'Diam Vitae', 317.02, 50,'Category_A.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (142, 9, 'Primis In', 517.15, 45,'Category_A.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (143, 5, 'Tristique Tortor', 241.31, 48,'Category_A.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (144, 9, 'Curae', 950.81, 29,'Category_A.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (145, 2, 'Cras Pellentesque Volutpat', 185.15, 5,'Category_B.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (146, 5, 'Dapibus', 242.89, 24,'Category_B.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (147, 2, 'Duis', 602.41, 21,'Category_B.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (148, 10, 'Diam', 848.19, 45,'Category_B.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (149, 5, 'Condimentum Curabitur', 156.91, 43,'Category_B.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (150, 7, 'Morbi Odio', 447.26, 15,'Category_B.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (151, 7, 'Donec', 926.42, 41,'Category_B.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (152, 9, 'Habitasse Platea Dictumst', 811.15, 38,'Category_B.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (153, 3, 'At', 727.19, 3,'Category_B.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (154, 3, 'Nam Tristique Tortor', 53.32, 12,'Category_B.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (155, 3, 'Id Luctus Nec', 856.45, 27,'Category_B.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (156, 6, 'Venenatis Non', 6.67, 31,'Category_B.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (157, 6, 'Enim Lorem Ipsum', 134.24, 31,'Category_B.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (158, 1, 'Duis Consequat', 143.17, 45,'Category_B.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (159, 2, 'Mi Sit Amet', 281.67, 34,'Category_B.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (160, 10, 'Vulputate Vitae Nisl', 579.76, 4,'Category_B.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (161, 8, 'Integer', 863.38, 24,'Category_C.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (162, 8, 'Diam Erat', 341.52, 38,'Category_C.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (163, 2, 'Nullam Molestie Nibh', 168.88, 35,'Category_C.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (164, 5, 'Praesent', 888.33, 12,'Category_C.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (165, 3, 'Vestibulum Ante', 941.93, 23,'Category_C.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (166, 2, 'Montes Nascetur', 200.14, 16,'Category_C.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (167, 6, 'Vestibulum', 809.12, 34,'Category_C.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (168, 8, 'Mus', 598.36, 43,'Category_C.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (169, 7, 'Ridiculus', 338.98, 19,'Category_C.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (170, 1, 'Dis Parturient Montes', 995.24, 11,'Category_C.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (171, 6, 'Blandit Lacinia', 428.84, 41,'Category_C.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (172, 3, 'Cras', 464.99, 14,'Category_C.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (173, 9, 'Blandit', 334.35, 29,'Category_C.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (174, 2, 'Pellentesque', 940.6, 19,'Category_C.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (175, 7, 'Congue Eget', 65.72, 11,'Category_C.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (176, 4, 'Mauris', 249.51, 25,'Category_C.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (177, 10, 'Venenatis', 766.85, 12,'Category_D.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (178, 1, 'In Tempus Sit', 485.29, 43,'Category_D.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (179, 3, 'Sollicitudin', 329.74, 19,'Category_D.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (180, 3, 'Placerat Ante Nulla', 783.98, 47,'Category_D.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (181, 10, 'Odio', 661.86, 0,'Category_D.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (182, 9, 'Vitae Quam', 825.53, 17,'Category_D.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (183, 10, 'Curabitur Gravida', 948.69, 46,'Category_D.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (184, 9, 'Consequat', 367.86, 43,'Category_D.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (185, 2, 'Ac Leo', 910.99, 11,'Category_D.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (186, 3, 'Sed Magna', 976.92, 14,'Category_D.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (187, 3, 'Nam', 477.66, 10,'Category_D.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (188, 1, 'Velit Id', 871.11, 35,'Category_D.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (189, 6, 'Ut', 285.03, 42,'Category_D.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (190, 6, 'Justo Etiam', 598.33, 13,'Category_D.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (191, 9, 'Vel', 309.47, 7,'Category_D.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (192, 9, 'Ultrices', 290.01, 32,'Category_D.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (193, 9, 'Duis Faucibus Accumsan', 20.09, 40,'Category_A.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (194, 7, 'Metus', 922.46, 34,'Category_A.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (195, 5, 'Vel Pede', 922.15, 45,'Category_A.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (196, 1, 'Vivamus Metus Arcu', 886.02, 31,'Category_A.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (197, 6, 'Vestibulum Proin', 925.66, 9,'Category_A.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (198, 6, 'Semper Rutrum Nulla', 54.77, 16,'Category_A.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (199, 5, 'Nibh', 715.75, 22,'Category_A.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (200, 9, 'Sit Amet', 141.84, 6,'Category_A.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (201, 9, 'Mauris Viverra Diam', 906.77, 25,'Category_A.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (202, 9, 'Gravida', 795.11, 20,'Category_A.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (203, 1, 'Fusce', 185.12, 0,'Category_A.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (204, 9, 'Libero Non', 689.49, 31,'Category_A.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (205, 10, 'Vulputate Justo', 834.9, 40,'Category_A.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (206, 2, 'Ipsum Primis', 248.3, 29,'Category_A.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (207, 7, 'Urna Ut Tellus', 466.53, 3,'Category_A.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (208, 10, 'Quam', 980.16, 46,'Category_A.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (209, 4, 'Velit', 59.19, 48,'Category_B.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (210, 1, 'Enim Blandit', 737.03, 41,'Category_B.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (211, 1, 'Morbi A Ipsum', 825.17, 33,'Category_B.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (212, 3, 'Sapien', 610.55, 22,'Category_B.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (213, 6, 'Dolor Morbi Vel', 47.52, 1,'Category_B.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (214, 2, 'Congue Vivamus', 476.44, 45,'Category_B.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (215, 9, 'A Nibh', 339.87, 12,'Category_B.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (216, 7, 'Volutpat Convallis Morbi', 396.98, 8,'Category_B.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (217, 7, 'Rutrum Ac', 205.59, 3,'Category_B.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (218, 5, 'Nullam', 524.32, 25,'Category_B.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (219, 4, 'Mauris', 890.24, 26,'Category_B.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (220, 3, 'Luctus Et', 643.08, 27,'Category_B.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (221, 5, 'Lacus At Velit', 103.09, 17,'Category_B.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (222, 6, 'Molestie Nibh In', 588.82, 15,'Category_B.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (223, 8, 'Ut Rhoncus Aliquet', 788.38, 14,'Category_B.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (224, 2, 'Mauris Eget', 127.8, 25,'Category_B.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (225, 4, 'Hac Habitasse Platea', 36.04, 20,'Category_C.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (226, 9, 'Lacus Curabitur', 764.94, 35,'Category_C.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (227, 6, 'Justo', 641.99, 21,'Category_C.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (228, 10, 'Mi Sit', 698.81, 36,'Category_C.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (229, 6, 'Sapien In Sapien', 418.72, 35,'Category_C.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (230, 8, 'Pede Morbi Porttitor', 426.33, 36,'Category_C.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (231, 5, 'Duis Faucibus Accumsan', 998.91, 46,'Category_C.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (232, 10, 'Dolor Morbi Vel', 409.68, 43,'Category_C.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (233, 4, 'Ac Leo Pellentesque', 758.13, 30,'Category_C.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (234, 10, 'Ut Blandit', 307.03, 32,'Category_C.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (235, 2, 'Enim Blandit', 710.6, 48,'Category_C.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (236, 1, 'Dui Luctus Rutrum', 142.56, 37,'Category_C.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (237, 5, 'Et', 804.79, 42,'Category_C.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (238, 5, 'Elementum In', 808.73, 44,'Category_C.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (239, 4, 'Nullam Orci', 461.19, 37,'Category_C.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (240, 3, 'Amet', 166.32, 0,'Category_C.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (241, 1, 'Nec Nisi', 529.82, 43,'Category_D.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (242, 2, 'Rutrum Neque Aenean', 136.82, 31,'Category_D.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (243, 2, 'Suscipit A', 43.35, 35,'Category_D.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (244, 8, 'Eros Vestibulum', 456.52, 35,'Category_D.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (245, 2, 'Nec Molestie', 722.15, 50,'Category_D.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (246, 1, 'At', 782.3, 32,'Category_D.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (247, 7, 'Eleifend Donec', 45.66, 4,'Category_D.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (248, 8, 'Dis', 638.75, 15,'Category_D.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (249, 9, 'Vehicula', 882.91, 39,'Category_D.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (250, 6, 'Mauris', 850.1, 12,'Category_D.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (251, 4, 'Convallis Nulla', 265.93, 26,'Category_D.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (252, 7, 'Felis Donec', 335.97, 33,'Category_D.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (253, 3, 'Et Ultrices Posuere', 921.69, 27,'Category_D.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (254, 1, 'Posuere Cubilia', 137.02, 18,'Category_D.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (255, 10, 'Quis', 965.14, 2,'Category_D.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (256, 4, 'Justo', 233.22, 1,'Category_D.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (257, 8, 'Curae Donec', 125.56, 18,'Category_A.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (258, 2, 'Imperdiet Sapien Urna', 812.21, 23,'Category_A.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (259, 3, 'Proin Risus', 473.11, 14,'Category_A.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (260, 10, 'Tortor', 594.75, 8,'Category_A.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (261, 4, 'Feugiat Et', 764.15, 22,'Category_A.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (262, 1, 'In', 557.92, 35,'Category_A.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (263, 3, 'Diam', 64.91, 19,'Category_A.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (264, 6, 'Velit Nec', 607.03, 14,'Category_A.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (265, 8, 'In Felis Donec', 86.5, 41,'Category_A.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (266, 4, 'Elit Sodales', 685.43, 31,'Category_A.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (267, 7, 'Fringilla', 761.29, 22,'Category_A.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (268, 10, 'Ultrices Libero Non', 453.22, 13,'Category_A.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (269, 3, 'Elit Ac', 403.61, 1,'Category_A.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (270, 2, 'Arcu Libero Rutrum', 104.98, 42,'Category_A.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (271, 5, 'Ornare', 338.43, 14,'Category_A.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (272, 8, 'Volutpat Erat Quisque', 643.81, 46,'Category_A.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (273, 3, 'Massa', 579.49, 40,'Category_B.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (274, 10, 'Curae Mauris Viverra', 579.97, 8,'Category_B.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (275, 1, 'Praesent Blandit Lacinia', 439.46, 27,'Category_B.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (276, 10, 'Volutpat Sapien Arcu', 868.65, 23,'Category_B.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (277, 1, 'Augue Quam Sollicitudin', 202.75, 48,'Category_B.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (278, 6, 'Cum Sociis', 255.97, 7,'Category_B.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (279, 3, 'Turpis Integer', 245.1, 12,'Category_B.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (280, 7, 'Nibh', 837.45, 17,'Category_B.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (281, 10, 'Aliquet At Feugiat', 273.98, 8,'Category_B.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (282, 7, 'Metus', 204.52, 18,'Category_B.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (283, 9, 'In', 644.93, 25,'Category_B.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (284, 8, 'Justo', 633.04, 9,'Category_B.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (285, 4, 'Dictumst Morbi Vestibulum', 684.49, 21,'Category_B.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (286, 7, 'Libero Nullam Sit', 136.37, 10,'Category_B.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (287, 7, 'Nascetur', 561.08, 27,'Category_B.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (288, 1, 'Elementum Ligula', 19.72, 5,'Category_B.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (289, 5, 'Nam Ultrices', 656.71, 43,'Category_C.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (290, 5, 'Amet', 559.87, 50,'Category_C.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (291, 9, 'Cras Pellentesque Volutpat', 58.69, 26,'Category_C.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (292, 9, 'Mauris', 850.34, 38,'Category_C.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (293, 7, 'Curabitur', 989.11, 45,'Category_C.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (294, 6, 'Tellus Nisi Eu', 132.1, 3,'Category_C.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (295, 4, 'At', 899.16, 32,'Category_C.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (296, 2, 'Id Nulla', 327.71, 3,'Category_C.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (297, 9, 'Lobortis', 81.76, 41,'Category_C.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (298, 9, 'Nulla Nunc', 812.86, 9,'Category_C.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (299, 8, 'Vel Lectus', 218.59, 6,'Category_C.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (300, 9, 'Odio', 40.13, 5,'Category_C.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (301, 3, 'In', 917.71, 4,'Category_C.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (302, 10, 'In Hac', 671.84, 9,'Category_C.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (303, 6, 'Nisi Venenatis Tristique', 210.12, 29,'Category_C.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (304, 9, 'Dictumst', 282.83, 23,'Category_C.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (305, 9, 'Interdum Venenatis', 291.31, 35,'Category_D.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (306, 4, 'Ullamcorper Augue A', 63.36, 14,'Category_D.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (307, 10, 'Arcu Sed', 683.4, 41,'Category_D.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (308, 6, 'Quam Pede Lobortis', 895.33, 1,'Category_D.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (309, 5, 'Erat', 190.26, 23,'Category_D.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (310, 10, 'Eget Tincidunt Eget', 332.11, 31,'Category_D.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (311, 10, 'Vitae', 204.53, 15,'Category_D.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (312, 3, 'At', 225.22, 38,'Category_D.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (313, 10, 'Lacus At', 722.24, 19,'Category_D.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (314, 7, 'Duis Ac Nibh', 114.2, 40,'Category_D.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (315, 5, 'Egestas', 637.63, 20,'Category_D.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (316, 3, 'Est Donec', 778.18, 37,'Category_D.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (317, 1, 'Maecenas', 367.15, 34,'Category_D.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (318, 1, 'At Dolor', 127.75, 42,'Category_D.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (319, 10, 'Maecenas Rhoncus', 812.42, 11,'Category_D.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (320, 10, 'Eleifend Pede Libero', 858.37, 35,'Category_D.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (321, 1, 'Nulla Suspendisse Potenti', 537.73, 24,'Category_A.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (322, 7, 'Et', 845.53, 40,'Category_A.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (323, 1, 'Magna Bibendum Imperdiet', 739.66, 5,'Category_A.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (324, 6, 'Proin Interdum', 824.19, 44,'Category_A.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (325, 7, 'Id Luctus', 609.46, 28,'Category_A.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (326, 8, 'Sem Mauris', 715.55, 45,'Category_A.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (327, 9, 'Quisque', 704.0, 50,'Category_A.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (328, 6, 'Iaculis Congue Vivamus', 138.4, 34,'Category_A.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (329, 7, 'Sapien In Sapien', 942.38, 32,'Category_A.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (330, 2, 'Viverra', 471.7, 30,'Category_A.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (331, 2, 'Justo', 437.91, 27,'Category_A.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (332, 10, 'Sit', 105.17, 39,'Category_A.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (333, 4, 'Ipsum Primis', 705.3, 45,'Category_A.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (334, 4, 'Tristique', 434.68, 32,'Category_A.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (335, 5, 'Metus Vitae Ipsum', 482.21, 35,'Category_A.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (336, 3, 'Urna Ut Tellus', 718.33, 25,'Category_A.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (337, 1, 'Volutpat', 623.37, 21,'Category_B.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (338, 7, 'Nulla Nunc', 938.09, 10,'Category_B.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (339, 10, 'Vestibulum Aliquet', 129.44, 24,'Category_B.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (340, 5, 'Lacus Curabitur', 234.07, 29,'Category_B.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (341, 10, 'Posuere Cubilia', 570.0, 31,'Category_B.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (342, 8, 'Dictumst Maecenas Ut', 869.9, 31,'Category_B.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (343, 6, 'Elit', 398.18, 46,'Category_B.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (344, 4, 'Id Ligula Suspendisse', 92.89, 16,'Category_B.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (345, 8, 'Habitasse Platea Dictumst', 407.95, 45,'Category_B.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (346, 6, 'Neque', 744.21, 16,'Category_B.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (347, 3, 'A Odio In', 91.68, 15,'Category_B.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (348, 2, 'Mi', 874.94, 3,'Category_B.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (349, 7, 'Nec Euismod', 286.3, 29,'Category_B.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (350, 4, 'Cubilia Curae', 209.37, 30,'Category_B.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (351, 10, 'Pellentesque Volutpat', 668.55, 14,'Category_B.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (352, 9, 'Velit', 829.09, 40,'Category_B.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (353, 7, 'Sagittis Sapien Cum', 341.3, 6,'Category_C.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (354, 5, 'Nulla Ac', 747.59, 6,'Category_C.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (355, 9, 'Mauris', 609.22, 10,'Category_C.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (356, 8, 'Pede Justo', 410.33, 32,'Category_C.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (357, 9, 'Pede Libero Quis', 200.54, 3,'Category_C.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (358, 4, 'Quisque Id Justo', 783.95, 5,'Category_C.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (359, 9, 'Consequat Lectus', 405.62, 5,'Category_C.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (360, 1, 'Tempus Vivamus', 782.68, 10,'Category_C.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (361, 9, 'Ipsum Primis In', 589.67, 16,'Category_C.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (362, 2, 'Ipsum', 780.3, 33,'Category_C.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (363, 7, 'Sociis Natoque Penatibus', 189.2, 3,'Category_C.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (364, 1, 'Aliquet', 231.91, 46,'Category_C.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (365, 4, 'At', 438.66, 16,'Category_C.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (366, 5, 'At', 1.09, 50,'Category_C.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (367, 9, 'Duis Faucibus Accumsan', 948.2, 27,'Category_C.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (368, 2, 'Odio Curabitur', 61.01, 37,'Category_C.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (369, 5, 'Ac Leo', 875.71, 23,'Category_D.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (370, 7, 'Nunc Vestibulum Ante', 599.21, 5,'Category_D.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (371, 2, 'Luctus Nec', 464.86, 41,'Category_D.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (372, 8, 'Vitae Mattis Nibh', 444.01, 25,'Category_D.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (373, 9, 'Pellentesque', 758.62, 18,'Category_D.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (374, 2, 'Pede', 201.21, 44,'Category_D.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (375, 7, 'Sapien', 540.87, 15,'Category_D.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (376, 1, 'At Dolor Quis', 533.99, 10,'Category_D.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (377, 2, 'Placerat Praesent Blandit', 786.31, 8,'Category_D.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (378, 4, 'Augue Vestibulum Ante', 598.4, 3,'Category_D.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (379, 3, 'Etiam Vel Augue', 816.49, 14,'Category_D.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (380, 1, 'Lectus In', 735.41, 5,'Category_D.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (381, 6, 'Sapien', 789.8, 6,'Category_D.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (382, 5, 'Dolor Morbi', 158.72, 36,'Category_D.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (383, 6, 'Vehicula', 166.3, 7,'Category_D.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (384, 8, 'Dictumst', 94.2, 17,'Category_D.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (385, 4, 'Ut', 765.08, 49,'Category_A.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (386, 5, 'Faucibus Accumsan Odio', 952.87, 1,'Category_A.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (387, 9, 'Lectus In', 118.92, 14,'Category_A.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (388, 9, 'Montes Nascetur Ridiculus', 211.73, 2,'Category_A.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (389, 6, 'Aenean', 332.99, 10,'Category_A.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (390, 5, 'Nulla', 931.4, 17,'Category_A.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (391, 9, 'Mattis', 242.3, 32,'Category_A.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (392, 7, 'Pharetra Magna', 807.28, 49,'Category_A.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (393, 5, 'Id', 743.18, 31,'Category_A.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (394, 4, 'Lacus', 811.19, 27,'Category_A.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (395, 7, 'Justo', 101.95, 23,'Category_A.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (396, 8, 'Curabitur', 132.27, 39,'Category_A.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (397, 9, 'Donec Semper', 184.0, 22,'Category_A.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (398, 2, 'Sed Tincidunt', 245.63, 14,'Category_A.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (399, 8, 'Vulputate', 919.03, 21,'Category_A.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (400, 6, 'Ac Est Lacinia', 86.48, 11,'Category_A.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (401, 8, 'Volutpat Erat', 187.78, 29,'Category_B.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (402, 2, 'Non Interdum In', 95.94, 9,'Category_B.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (403, 5, 'Egestas Metus Aenean', 416.54, 4,'Category_B.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (404, 5, 'Tortor Sollicitudin Mi', 267.06, 19,'Category_B.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (405, 1, 'At', 723.44, 22,'Category_B.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (406, 7, 'Ligula Nec Sem', 519.92, 20,'Category_B.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (407, 4, 'Sagittis Dui', 265.59, 45,'Category_B.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (408, 9, 'Praesent Id', 614.38, 25,'Category_B.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (409, 9, 'Et', 769.74, 37,'Category_B.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (410, 9, 'Dapibus Duis At', 966.97, 5,'Category_B.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (411, 4, 'Pede Justo Eu', 652.71, 29,'Category_B.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (412, 1, 'Suscipit', 363.3, 23,'Category_B.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (413, 10, 'Quam A', 330.3, 40,'Category_B.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (414, 7, 'Ante Ipsum', 658.83, 3,'Category_B.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (415, 2, 'Sem Sed', 181.95, 43,'Category_B.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (416, 4, 'Mauris Vulputate', 538.67, 39,'Category_B.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (417, 1, 'Vestibulum Proin Eu', 138.2, 1,'Category_C.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (418, 7, 'Lectus Suspendisse Potenti', 310.83, 30,'Category_C.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (419, 5, 'Iaculis', 565.27, 7,'Category_C.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (420, 7, 'Hendrerit At Vulputate', 769.68, 27,'Category_C.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (421, 8, 'Volutpat', 895.94, 10,'Category_C.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (422, 8, 'Sagittis Sapien', 79.78, 43,'Category_C.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (423, 6, 'Sem', 409.54, 46,'Category_C.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (424, 9, 'Metus Arcu', 705.28, 50,'Category_C.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (425, 8, 'Molestie Nibh In', 683.45, 33,'Category_C.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (426, 3, 'Morbi A Ipsum', 528.66, 12,'Category_C.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (427, 2, 'Hac Habitasse Platea', 682.35, 31,'Category_C.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (428, 10, 'Turpis Enim', 790.14, 35,'Category_C.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (429, 10, 'Curabitur At', 992.94, 49,'Category_C.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (430, 6, 'Sollicitudin', 57.42, 1,'Category_C.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (431, 6, 'Tincidunt', 750.73, 42,'Category_C.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (432, 4, 'Molestie Nibh', 453.13, 45,'Category_C.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (433, 9, 'Ac', 775.18, 27,'Category_D.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (434, 9, 'Odio', 548.38, 48,'Category_D.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (435, 9, 'Sit Amet Turpis', 11.37, 22,'Category_D.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (436, 1, 'Sit Amet', 598.06, 7,'Category_D.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (437, 6, 'Nulla Tellus In', 329.23, 3,'Category_D.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (438, 6, 'Nec Euismod', 920.55, 47,'Category_D.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (439, 2, 'Ligula', 620.8, 9,'Category_D.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (440, 2, 'Vestibulum Aliquet Ultrices', 583.1, 47,'Category_D.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (441, 6, 'Amet Nunc', 81.24, 29,'Category_D.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (442, 1, 'Curae Mauris', 328.77, 5,'Category_D.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (443, 3, 'Sagittis Sapien', 175.97, 44,'Category_D.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (444, 8, 'Amet Eros Suspendisse', 681.21, 0,'Category_D.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (445, 4, 'Mauris', 834.55, 22,'Category_D.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (446, 9, 'Quam A', 868.3, 21,'Category_D.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (447, 10, 'Nam Dui Proin', 101.95, 37,'Category_D.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (448, 9, 'Morbi Quis', 467.84, 47,'Category_D.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (449, 9, 'Eleifend Quam A', 639.9, 26,'Category_A.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (450, 9, 'Est Donec', 301.41, 7,'Category_A.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (451, 9, 'In Congue', 831.1, 41,'Category_A.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (452, 1, 'Vestibulum Ante Ipsum', 676.81, 41,'Category_A.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (453, 6, 'In Faucibus', 3.24, 41,'Category_A.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (454, 4, 'Lacinia Sapien Quis', 836.16, 15,'Category_A.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (455, 10, 'Nunc Commodo Placerat', 105.29, 29,'Category_A.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (456, 3, 'Vestibulum Eget', 661.19, 40,'Category_A.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (457, 9, 'Odio In Hac', 459.82, 24,'Category_A.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (458, 7, 'Nunc Purus Phasellus', 982.49, 50,'Category_A.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (459, 6, 'At', 300.6, 5,'Category_A.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (460, 10, 'Neque Sapien', 739.77, 19,'Category_A.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (461, 5, 'Nulla Justo Aliquam', 648.22, 14,'Category_A.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (462, 9, 'Volutpat', 299.55, 14,'Category_A.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (463, 7, 'Tristique Est Et', 656.92, 11,'Category_A.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (464, 7, 'Eu Orci Mauris', 807.82, 43,'Category_A.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (465, 7, 'Nulla', 343.69, 18,'Category_B.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (466, 9, 'Accumsan Felis Ut', 676.41, 16,'Category_B.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (467, 4, 'Luctus', 387.08, 34,'Category_B.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (468, 6, 'Dolor Vel', 991.41, 10,'Category_B.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (469, 3, 'Nibh In', 81.67, 24,'Category_B.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (470, 2, 'Euismod Scelerisque Quam', 674.26, 44,'Category_B.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (471, 7, 'Eros', 407.89, 41,'Category_B.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (472, 9, 'Vitae Nisi', 375.17, 38,'Category_B.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (473, 1, 'A Ipsum', 220.74, 26,'Category_B.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (474, 7, 'Dapibus At Diam', 19.46, 5,'Category_B.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (475, 9, 'Pellentesque', 907.64, 44,'Category_B.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (476, 5, 'Maecenas', 220.52, 36,'Category_B.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (477, 9, 'Ante Ipsum Primis', 878.07, 39,'Category_B.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (478, 7, 'Donec Diam', 753.88, 3,'Category_B.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (479, 4, 'Libero Convallis Eget', 309.11, 26,'Category_B.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (480, 7, 'Suspendisse Potenti Cras', 665.7, 27,'Category_B.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (481, 2, 'Magnis Dis Parturient', 601.98, 31,'Category_C.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (482, 3, 'Primis', 979.12, 39,'Category_C.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (483, 9, 'Tempus', 289.17, 41,'Category_C.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (484, 10, 'At', 162.75, 23,'Category_C.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (485, 4, 'Vel Pede', 452.56, 29,'Category_C.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (486, 1, 'Habitasse Platea Dictumst', 6.36, 49,'Category_C.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (487, 10, 'Congue Diam', 949.66, 28,'Category_C.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (488, 7, 'Lacinia', 790.47, 18,'Category_C.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (489, 5, 'Vestibulum Ante', 193.34, 9,'Category_C.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (490, 2, 'Venenatis Turpis Enim', 404.27, 21,'Category_C.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (491, 2, 'Est Donec Odio', 318.83, 13,'Category_C.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (492, 1, 'Sapien', 506.78, 11,'Category_C.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (493, 1, 'Augue Quam', 711.13, 42,'Category_C.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (494, 8, 'Nulla', 976.83, 10,'Category_C.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (495, 3, 'Eget Eleifend', 200.2, 25,'Category_C.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (496, 4, 'Ligula In', 829.93, 8,'Category_C.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (497, 2, 'Odio Cras', 197.45, 27,'Category_D.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (498, 5, 'Parturient Montes', 629.32, 44,'Category_D.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (499, 4, 'Nulla Quisque', 73.45, 5,'Category_D.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (500, 9, 'Rhoncus', 647.23, 5,'Category_D.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (501, 8, 'Ligula Vehicula', 706.79, 40,'Category_D.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (502, 10, 'Montes Nascetur Ridiculus', 438.59, 28,'Category_D.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (503, 6, 'Ante', 143.61, 30,'Category_D.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (504, 5, 'Nec Sem Duis', 33.55, 30,'Category_D.Subcategory_B.Subsubcategory_D');
--
--INSERT INTO stock VALUES (505, 6, 'Mauris Enim Leo', 929.69, 14,'Category_D.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (506, 8, 'Eleifend', 615.19, 15,'Category_D.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (507, 9, 'Viverra Eget', 725.49, 23,'Category_D.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (508, 3, 'Viverra Eget', 183.14, 9,'Category_D.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (509, 8, 'Placerat', 150.12, 4,'Category_D.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (510, 3, 'Tristique', 325.75, 8,'Category_D.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (511, 1, 'Eleifend Quam', 836.59, 47,'Category_D.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (512, 1, 'Dui', 612.28, 4,'Category_D.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (513, 6, 'Nonummy Integer', 18.75, 9,'Category_A.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (514, 7, 'Pede Posuere', 814.07, 50,'Category_A.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (515, 3, 'Consequat Metus Sapien', 923.42, 24,'Category_A.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (516, 9, 'Praesent Blandit Lacinia', 530.34, 20,'Category_A.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (517, 10, 'Hac Habitasse', 675.11, 9,'Category_A.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (518, 6, 'Augue Vestibulum', 377.27, 45,'Category_A.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (519, 1, 'Donec', 659.92, 16,'Category_A.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (520, 3, 'Vel Augue', 430.1, 23,'Category_A.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (521, 10, 'Vel Est', 508.05, 26,'Category_A.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (522, 8, 'Rutrum Neque', 869.33, 16,'Category_A.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (523, 9, 'Gravida Nisi At', 903.51, 6,'Category_A.Subcategory_C.Subsubcategory_C');
--
--INSERT INTO stock VALUES (524, 2, 'In', 288.33, 45,'Category_A.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (525, 9, 'Nulla Ultrices', 670.25, 35,'Category_A.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (526, 1, 'Dictumst Etiam', 463.51, 35,'Category_A.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (527, 4, 'Felis Fusce', 887.71, 23,'Category_A.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (528, 4, 'Curabitur At Ipsum', 453.25, 17,'Category_A.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (529, 5, 'Luctus Et Ultrices', 838.44, 42,'Category_B.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (530, 2, 'Tortor Duis Mattis', 663.52, 6,'Category_B.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (531, 9, 'Quam', 926.57, 31,'Category_B.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (532, 9, 'Vivamus', 316.6, 34,'Category_B.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (533, 2, 'Nulla Mollis Molestie', 716.99, 43,'Category_B.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (534, 1, 'Sapien', 933.79, 10,'Category_B.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (535, 6, 'Tortor Quis', 577.5, 13,'Category_B.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (536, 10, 'Blandit Lacinia Erat', 893.53, 19,'Category_B.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (537, 7, 'Ac Lobortis Vel', 317.93, 47,'Category_B.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (538, 6, 'Nibh Ligula Nec', 748.7, 10,'Category_B.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (539, 7, 'Ante', 269.73, 24,'Category_B.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (540, 6, 'Congue', 877.98, 11,'Category_B.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (541, 6, 'Ante Nulla', 473.36, 1,'Category_B.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (542, 5, 'In', 494.85, 30,'Category_B.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (543, 2, 'Lobortis', 585.43, 42,'Category_B.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (544, 5, 'Nonummy Integer', 874.41, 11,'Category_B.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (545, 6, 'Volutpat', 220.5, 25,'Category_C.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (546, 6, 'Praesent Blandit', 806.29, 31,'Category_C.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (547, 9, 'Natoque Penatibus Et', 138.81, 24,'Category_C.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (548, 8, 'Amet Eleifend Pede', 854.55, 24,'Category_C.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (549, 9, 'Posuere Nonummy', 901.42, 37,'Category_C.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (550, 4, 'Vitae Quam', 646.56, 43,'Category_C.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (551, 2, 'Non', 311.12, 14,'Category_C.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (552, 5, 'Est Quam', 811.32, 44,'Category_C.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (553, 2, 'Rutrum', 103.9, 25,'Category_C.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (554, 4, 'Donec Odio Justo', 459.37, 44,'Category_C.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (555, 5, 'Faucibus', 801.9, 42,'Category_C.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (556, 5, 'Luctus Et Ultrices', 10.07, 48,'Category_C.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (557, 2, 'Eget Vulputate', 441.87, 29,'Category_C.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (558, 2, 'Consectetuer Adipiscing Elit', 843.48, 34,'Category_C.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (559, 7, 'Nulla Elit Ac', 972.37, 39,'Category_C.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (560, 8, 'Porttitor Lacus', 347.83, 16,'Category_C.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (561, 3, 'Sed', 984.95, 49,'Category_D.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (562, 6, 'Imperdiet Et Commodo', 751.58, 0,'Category_D.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (563, 8, 'Vulputate Justo', 605.58, 9,'Category_D.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (564, 2, 'Consequat Varius', 919.57, 34,'Category_D.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (565, 10, 'Donec Semper', 475.93, 47,'Category_D.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (566, 3, 'Aenean Lectus', 587.51, 3,'Category_D.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (567, 9, 'Id Lobortis Convallis', 893.48, 48,'Category_D.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (568, 4, 'Eu Magna Vulputate', 297.95, 38,'Category_D.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (569, 6, 'Molestie', 446.4, 4,'Category_D.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (570, 10, 'Ultrices Posuere', 391.37, 13,'Category_D.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (571, 3, 'Rutrum Rutrum Neque', 38.4, 16,'Category_D.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (572, 6, 'Ridiculus Mus Etiam', 94.74, 48,'Category_D.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (573, 7, 'Iaculis Congue', 377.75, 25,'Category_D.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (574, 5, 'Imperdiet Nullam', 30.12, 5,'Category_D.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (575, 5, 'Duis Bibendum Morbi', 912.61, 10,'Category_D.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (576, 8, 'A Suscipit Nulla', 501.38, 30,'Category_D.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (577, 8, 'Volutpat In', 251.41, 5,'Category_A.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (578, 4, 'Proin', 308.87, 13,'Category_A.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (579, 6, 'Odio In', 462.67, 36,'Category_A.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (580, 10, 'Quisque Arcu', 279.58, 32,'Category_A.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (581, 9, 'Adipiscing Elit', 952.33, 30,'Category_A.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (582, 8, 'Nulla Facilisi', 136.57, 47,'Category_A.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (583, 2, 'Ut Volutpat Sapien', 413.52, 15,'Category_A.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (584, 10, 'Sit Amet', 731.02, 32,'Category_A.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (585, 7, 'Morbi Porttitor Lorem', 780.22, 20,'Category_A.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (586, 8, 'Eu Est', 854.29, 15,'Category_A.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (587, 9, 'Turpis Elementum', 916.21, 31,'Category_A.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (588, 4, 'Congue', 648.33, 5,'Category_A.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (589, 6, 'In Consequat Ut', 694.34, 15,'Category_A.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (590, 8, 'Ligula', 97.64, 2,'Category_A.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (591, 9, 'Erat Quisque', 599.42, 40,'Category_A.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (592, 9, 'Felis Sed', 716.95, 18,'Category_A.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (593, 2, 'In Ante Vestibulum', 295.86, 11,'Category_B.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (594, 6, 'Mattis', 820.58, 31,'Category_B.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (595, 3, 'Ante Ipsum Primis', 456.48, 8,'Category_B.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (596, 2, 'Sit', 742.76, 4,'Category_B.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (597, 4, 'Rutrum Nulla', 955.37, 39,'Category_B.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (598, 9, 'Consequat Nulla', 377.4, 46,'Category_B.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (599, 8, 'Rhoncus Sed', 757.53, 13,'Category_B.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (600, 5, 'Neque Sapien Placerat', 428.85, 49,'Category_B.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (601, 6, 'Nunc Vestibulum Ante', 825.31, 49,'Category_B.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (602, 5, 'Vitae Quam Suspendisse', 677.55, 50,'Category_B.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (603, 4, 'Ut Erat Curabitur', 636.95, 5,'Category_B.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (604, 5, 'Tempor', 911.5, 18,'Category_B.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (605, 1, 'Vehicula Consequat Morbi', 827.02, 32,'Category_B.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (606, 3, 'Non Interdum In', 549.41, 6,'Category_B.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (607, 6, 'Justo', 369.15, 41,'Category_B.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (608, 3, 'Nulla Facilisi Cras', 615.98, 17,'Category_B.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (609, 7, 'Orci Luctus Et', 602.58, 7,'Category_C.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (610, 6, 'Convallis Duis', 468.49, 12,'Category_C.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (611, 8, 'Id', 155.23, 20,'Category_C.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (612, 10, 'Sit Amet Nunc', 713.84, 29,'Category_C.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (613, 10, 'Non', 324.49, 8,'Category_C.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (614, 7, 'Est Lacinia Nisi', 973.84, 15,'Category_C.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (615, 6, 'Metus Aenean Fermentum', 231.44, 5,'Category_C.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (616, 8, 'Lacus Curabitur At', 939.57, 11,'Category_C.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (617, 6, 'Sed Magna At', 624.81, 3,'Category_C.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (618, 10, 'Interdum Venenatis Turpis', 641.46, 36,'Category_C.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (619, 3, 'Ultrices Posuere', 389.38, 46,'Category_C.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (620, 9, 'Accumsan Odio', 334.33, 31,'Category_C.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (621, 8, 'Volutpat Sapien Arcu', 123.78, 31,'Category_C.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (622, 1, 'Elit Sodales', 317.61, 11,'Category_C.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (623, 1, 'Dictumst', 400.24, 48,'Category_C.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (624, 8, 'Id', 198.69, 50,'Category_C.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (625, 3, 'Integer Aliquet', 221.93, 9,'Category_D.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (626, 4, 'Sed Interdum', 265.75, 44,'Category_D.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (627, 5, 'Sed Accumsan', 993.49, 17,'Category_D.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (628, 8, 'Orci Luctus', 774.23, 3,'Category_D.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (629, 3, 'Lacus', 26.73, 14,'Category_D.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (630, 5, 'Sit', 83.95, 23,'Category_D.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (631, 6, 'Cras Mi', 24.88, 19,'Category_D.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (632, 6, 'Ut', 738.39, 18,'Category_D.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (633, 2, 'Volutpat Eleifend', 78.12, 45,'Category_D.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (634, 2, 'Tempus Semper Est', 907.97, 0,'Category_D.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (635, 10, 'Ultrices Posuere Cubilia', 999.14, 47,'Category_D.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (636, 9, 'Dictumst Aliquam Augue', 976.59, 17,'Category_D.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (637, 5, 'Id Lobortis', 346.17, 33,'Category_D.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (638, 10, 'Magna Ac Consequat', 303.2, 6,'Category_D.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (639, 5, 'Eget', 12.86, 4,'Category_D.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (640, 3, 'Lacus Purus Aliquet', 661.52, 1,'Category_D.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (641, 2, 'Lobortis', 693.68, 46,'Category_A.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (642, 10, 'Posuere Cubilia', 595.47, 13,'Category_A.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (643, 8, 'Erat Id', 485.37, 26,'Category_A.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (644, 4, 'Luctus Nec Molestie', 944.22, 5,'Category_A.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (645, 10, 'Erat Eros Viverra', 474.81, 31,'Category_A.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (646, 2, 'Neque Sapien Placerat', 938.44, 27,'Category_A.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (647, 7, 'Curabitur', 373.62, 0,'Category_A.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (648, 2, 'Ligula Suspendisse Ornare', 899.73, 43,'Category_A.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (649, 3, 'Vivamus', 39.92, 7,'Category_A.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (650, 10, 'Curae Donec', 838.55, 31,'Category_A.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (651, 7, 'Orci Nullam', 243.81, 25,'Category_A.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (652, 6, 'Mattis Egestas Metus', 364.78, 31,'Category_A.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (653, 10, 'Sollicitudin', 34.38, 11,'Category_A.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (654, 2, 'Donec Ut Mauris', 840.55, 21,'Category_A.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (655, 8, 'Ipsum Praesent', 695.26, 42,'Category_A.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (656, 8, 'Purus Eu', 127.9, 9,'Category_A.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (657, 4, 'Pulvinar Sed Nisl', 424.69, 31,'Category_B.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (658, 10, 'Odio Consequat Varius', 463.11, 45,'Category_B.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (659, 6, 'Ultrices Aliquet Maecenas', 517.83, 2,'Category_B.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (660, 2, 'Quis Turpis', 603.06, 44,'Category_B.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (661, 1, 'Est Quam Pharetra', 116.96, 48,'Category_B.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (662, 4, 'Et Ultrices Posuere', 102.54, 28,'Category_B.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (663, 5, 'In Felis', 690.27, 11,'Category_B.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (664, 7, 'Fringilla Rhoncus', 838.76, 1,'Category_B.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (665, 8, 'Posuere Cubilia', 78.22, 34,'Category_B.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (666, 4, 'Augue A Suscipit', 904.44, 32,'Category_B.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (667, 1, 'Enim In Tempor', 297.8, 47,'Category_B.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (668, 2, 'Sem Sed', 733.81, 46,'Category_B.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (669, 3, 'Libero Ut', 276.34, 4,'Category_B.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (670, 1, 'Sapien Iaculis', 259.38, 23,'Category_B.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (671, 3, 'Quis Tortor Id', 134.97, 0,'Category_B.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (672, 3, 'Id Pretium', 252.53, 40,'Category_B.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (673, 5, 'Neque Sapien', 767.58, 12,'Category_C.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (674, 6, 'Nulla Dapibus Dolor', 334.94, 37,'Category_C.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (675, 6, 'Aliquam Non Mauris', 867.42, 20,'Category_C.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (676, 6, 'Luctus Rutrum Nulla', 67.04, 36,'Category_C.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (677, 7, 'Molestie', 117.75, 9,'Category_C.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (678, 4, 'Libero Convallis Eget', 824.7, 36,'Category_C.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (679, 2, 'Euismod Scelerisque Quam', 837.31, 10,'Category_C.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (680, 7, 'Purus Aliquet', 432.58, 42,'Category_C.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (681, 2, 'Libero', 94.29, 35,'Category_C.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (682, 1, 'Curabitur Convallis Duis', 140.38, 28,'Category_C.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (683, 7, 'Sed Magna', 699.61, 24,'Category_C.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (684, 3, 'Congue Vivamus', 605.99, 14,'Category_C.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (685, 4, 'Vestibulum', 383.63, 37,'Category_C.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (686, 7, 'Id Ligula Suspendisse', 211.47, 13,'Category_C.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (687, 6, 'Pede Ac', 967.53, 37,'Category_C.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (688, 1, 'Ante', 279.76, 10,'Category_C.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (689, 5, 'Pellentesque', 731.46, 23,'Category_D.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (690, 6, 'Sodales Scelerisque Mauris', 55.33, 18,'Category_D.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (691, 10, 'Tristique Tortor', 531.06, 23,'Category_D.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (692, 3, 'Lacinia Erat', 520.33, 25,'Category_D.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (693, 1, 'Arcu Adipiscing Molestie', 889.77, 1,'Category_D.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (694, 2, 'Aliquam', 331.28, 35,'Category_D.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (695, 3, 'Pellentesque Quisque', 158.51, 24,'Category_D.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (696, 8, 'Molestie', 980.62, 3,'Category_D.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (697, 6, 'Odio Cras Mi', 804.71, 43,'Category_D.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (698, 3, 'Quis Augue', 403.9, 36,'Category_D.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (699, 7, 'Feugiat Et', 502.02, 26,'Category_D.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (700, 10, 'In Porttitor', 284.14, 40,'Category_D.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (701, 4, 'Dolor', 783.13, 33,'Category_D.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (702, 2, 'Justo', 889.12, 14,'Category_D.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (703, 3, 'Euismod Scelerisque Quam', 363.4, 28,'Category_D.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (704, 2, 'Donec Posuere Metus', 336.48, 43,'Category_D.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (705, 3, 'Vestibulum Velit', 440.49, 39,'Category_A.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (706, 2, 'Eu Sapien', 535.48, 3,'Category_A.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (707, 8, 'In', 969.85, 27,'Category_A.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (708, 7, 'Ultrices Posuere', 780.55, 37,'Category_A.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (709, 5, 'Nec Euismod', 153.99, 38,'Category_A.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (710, 6, 'Eleifend Pede', 333.26, 21,'Category_A.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (711, 3, 'Eu', 124.08, 39,'Category_A.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (712, 5, 'Scelerisque Mauris', 31.22, 40,'Category_A.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (713, 8, 'Volutpat', 190.72, 31,'Category_A.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (714, 8, 'In Felis', 270.25, 33,'Category_A.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (715, 10, 'Orci Nullam', 981.7, 34,'Category_A.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (716, 2, 'Vulputate Ut', 986.38, 26,'Category_A.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (717, 8, 'Pellentesque', 792.03, 28,'Category_A.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (718, 3, 'Rutrum', 679.42, 43,'Category_A.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (719, 6, 'Praesent Lectus Vestibulum', 88.03, 23,'Category_A.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (720, 2, 'Ligula', 702.62, 46,'Category_A.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (721, 3, 'Posuere Felis', 279.53, 11,'Category_B.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (722, 1, 'Turpis', 189.85, 42,'Category_B.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (723, 10, 'Duis Bibendum Felis', 83.03, 3,'Category_B.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (724, 8, 'Quis Lectus', 405.98, 45,'Category_B.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (725, 6, 'Duis Aliquam', 395.2, 5,'Category_B.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (726, 6, 'Natoque Penatibus Et', 504.33, 27,'Category_B.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (727, 7, 'Iaculis Congue Vivamus', 897.46, 20,'Category_B.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (728, 4, 'Ante Ipsum', 137.96, 46,'Category_B.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (729, 5, 'Ut Massa', 99.65, 24,'Category_B.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (730, 5, 'Pede Morbi Porttitor', 909.77, 1,'Category_B.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (731, 6, 'Eros Suspendisse', 911.31, 50,'Category_B.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (732, 1, 'At Nulla', 596.81, 26,'Category_B.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (733, 2, 'Amet Turpis Elementum', 794.62, 36,'Category_B.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (734, 5, 'Maecenas Rhoncus Aliquam', 921.04, 18,'Category_B.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (735, 8, 'Lacinia Eget', 245.98, 32,'Category_B.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (736, 3, 'Etiam Vel Augue', 891.28, 0,'Category_B.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (737, 6, 'Nisi Venenatis', 904.49, 41,'Category_C.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (738, 7, 'Curae Mauris Viverra', 680.2, 4,'Category_C.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (739, 4, 'Sapien', 544.57, 24,'Category_C.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (740, 8, 'Amet Erat', 428.36, 30,'Category_C.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (741, 9, 'Viverra Dapibus Nulla', 540.47, 5,'Category_C.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (742, 8, 'Posuere Cubilia Curae', 819.55, 33,'Category_C.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (743, 10, 'A', 462.44, 24,'Category_C.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (744, 3, 'Iaculis Justo In', 74.08, 18,'Category_C.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (745, 1, 'Cras', 88.58, 48,'Category_C.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (746, 9, 'Congue', 916.59, 15,'Category_C.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (747, 8, 'Penatibus', 678.68, 47,'Category_C.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (748, 10, 'In Felis', 111.44, 31,'Category_C.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (749, 6, 'Pulvinar Nulla', 974.9, 28,'Category_C.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (750, 4, 'Commodo Placerat', 558.65, 29,'Category_C.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (751, 8, 'Mattis', 480.73, 24,'Category_C.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (752, 9, 'Placerat Ante', 188.02, 44,'Category_C.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (753, 4, 'Sapien Non Mi', 108.66, 19,'Category_D.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (754, 5, 'Ultrices', 221.92, 9,'Category_D.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (755, 6, 'Mauris', 226.33, 33,'Category_D.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (756, 2, 'Id Consequat In', 263.61, 21,'Category_D.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (757, 6, 'Ut', 356.72, 31,'Category_D.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (758, 4, 'Faucibus Cursus Urna', 551.77, 43,'Category_D.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (759, 3, 'Ultrices Aliquet Maecenas', 925.43, 12,'Category_D.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (760, 9, 'Ut Tellus', 299.8, 0,'Category_D.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (761, 1, 'Eu', 715.02, 18,'Category_D.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (762, 7, 'A Odio In', 960.54, 2,'Category_D.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (763, 4, 'Vestibulum Vestibulum Ante', 243.68, 10,'Category_D.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (764, 10, 'Tellus', 484.06, 25,'Category_D.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (765, 2, 'Varius Integer', 815.39, 48,'Category_D.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (766, 9, 'At', 324.32, 11,'Category_D.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (767, 6, 'Et Ultrices', 823.65, 6,'Category_D.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (768, 3, 'Ipsum', 742.94, 20,'Category_D.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (769, 7, 'Tellus In Sagittis', 887.57, 26,'Category_A.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (770, 8, 'Vestibulum Vestibulum Ante', 153.66, 36,'Category_A.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (771, 3, 'Non Velit', 890.41, 48,'Category_A.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (772, 2, 'Dui', 500.75, 6,'Category_A.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (773, 2, 'Suspendisse Potenti', 971.26, 0,'Category_A.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (774, 3, 'Id Justo', 921.2, 3,'Category_A.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (775, 10, 'Nullam Orci Pede', 170.93, 2,'Category_A.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (776, 10, 'Quis Justo', 237.7, 20,'Category_A.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (777, 8, 'Aliquam', 263.09, 27,'Category_A.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (778, 6, 'Et', 264.51, 50,'Category_A.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (779, 7, 'Turpis Sed', 296.1, 6,'Category_A.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (780, 10, 'Sit', 256.75, 11,'Category_A.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (781, 10, 'Etiam Faucibus Cursus', 39.88, 10,'Category_A.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (782, 3, 'Dis Parturient', 915.0, 28,'Category_A.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (783, 1, 'Posuere Cubilia', 8.57, 6,'Category_A.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (784, 7, 'Congue', 433.88, 19,'Category_A.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (785, 7, 'Tellus In', 695.61, 1,'Category_B.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (786, 8, 'Eget', 457.01, 5,'Category_B.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (787, 7, 'Lectus Suspendisse Potenti', 895.48, 4,'Category_B.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (788, 4, 'Nam Nulla', 478.0, 30,'Category_B.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (789, 3, 'Suscipit Nulla Elit', 486.13, 50,'Category_B.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (790, 4, 'Aliquam Non', 498.5, 38,'Category_B.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (791, 2, 'Consectetuer Adipiscing Elit', 107.02, 7,'Category_B.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (792, 1, 'Amet Sapien Dignissim', 477.31, 13,'Category_B.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (793, 10, 'Posuere Cubilia Curae', 612.59, 49,'Category_B.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (794, 2, 'Sapien', 351.22, 33,'Category_B.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (795, 9, 'Sapien Arcu Sed', 592.46, 8,'Category_B.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (796, 7, 'Cubilia Curae Donec', 907.63, 17,'Category_B.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (797, 5, 'Arcu', 223.95, 18,'Category_B.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (798, 10, 'Lacinia', 983.19, 1,'Category_B.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (799, 1, 'Mattis Nibh Ligula', 109.35, 32,'Category_B.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (800, 9, 'Morbi Odio Odio', 319.89, 17,'Category_B.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (801, 2, 'In Consequat Ut', 859.46, 7,'Category_C.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (802, 5, 'Sed Augue Aliquam', 613.87, 32,'Category_C.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (803, 10, 'Nisl', 588.63, 7,'Category_C.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (804, 9, 'Pellentesque At Nulla', 439.84, 20,'Category_C.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (805, 8, 'Nibh', 157.06, 37,'Category_C.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (806, 5, 'Id Mauris Vulputate', 171.08, 44,'Category_C.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (807, 6, 'Aliquam', 319.65, 14,'Category_C.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (808, 7, 'Nisi At', 868.02, 2,'Category_C.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (809, 10, 'Nisi Eu Orci', 488.87, 41,'Category_C.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (810, 1, 'Justo Lacinia Eget', 119.06, 44,'Category_C.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (811, 10, 'Ut', 828.42, 0,'Category_C.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (812, 5, 'Nulla Elit Ac', 410.43, 39,'Category_C.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (813, 7, 'Faucibus', 991.34, 24,'Category_C.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (814, 9, 'Sit Amet', 571.01, 49,'Category_C.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (815, 5, 'Convallis', 873.11, 0,'Category_C.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (816, 8, 'Elementum', 178.56, 49,'Category_C.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (817, 3, 'Sapien In Sapien', 29.67, 3,'Category_D.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (818, 10, 'Suscipit Ligula', 374.4, 18,'Category_D.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (819, 5, 'In Quis', 570.88, 40,'Category_D.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (820, 3, 'Maecenas Rhoncus Aliquam', 133.73, 16,'Category_D.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (821, 3, 'Lacus Morbi', 330.25, 33,'Category_D.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (822, 9, 'Quam Sollicitudin Vitae', 378.02, 22,'Category_D.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (823, 1, 'Maecenas Rhoncus', 293.12, 27,'Category_D.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (824, 1, 'Justo', 548.24, 25,'Category_D.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (825, 3, 'Blandit Nam', 176.47, 33,'Category_D.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (826, 9, 'Amet', 621.44, 4,'Category_D.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (827, 1, 'Quis Libero Nullam', 285.51, 6,'Category_D.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (828, 6, 'Dictumst Aliquam Augue', 713.88, 21,'Category_D.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (829, 3, 'Vitae Ipsum', 147.63, 47,'Category_D.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (830, 9, 'Vel Enim Sit', 472.74, 7,'Category_D.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (831, 2, 'Erat Tortor', 317.33, 28,'Category_D.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (832, 9, 'Ante Vestibulum Ante', 57.1, 20,'Category_D.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (833, 9, 'Ultrices Libero Non', 123.77, 42,'Category_A.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (834, 4, 'In Tempor Turpis', 57.64, 26,'Category_A.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (835, 8, 'Volutpat Eleifend Donec', 77.71, 13,'Category_A.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (836, 3, 'Ornare', 42.85, 31,'Category_A.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (837, 1, 'Praesent Blandit Nam', 809.61, 49,'Category_A.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (838, 6, 'Sapien Ut Nunc', 947.11, 32,'Category_A.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (839, 9, 'Ipsum Primis In', 74.15, 26,'Category_A.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (840, 10, 'Vivamus', 935.92, 9,'Category_A.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (841, 5, 'Sollicitudin Mi', 700.94, 43,'Category_A.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (842, 7, 'Risus Praesent', 283.63, 1,'Category_A.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (843, 5, 'Donec', 105.72, 19,'Category_A.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (844, 9, 'Aliquam Non Mauris', 963.21, 41,'Category_A.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (845, 5, 'Maecenas', 107.97, 24,'Category_A.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (846, 5, 'Habitasse', 180.75, 33,'Category_A.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (847, 6, 'Aliquet Ultrices Erat', 513.69, 0,'Category_A.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (848, 10, 'Neque', 78.82, 29,'Category_A.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (849, 4, 'Mus Vivamus', 859.0, 44,'Category_B.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (850, 2, 'At Nulla Suspendisse', 470.7, 37,'Category_B.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (851, 9, 'At Nibh In', 802.38, 32,'Category_B.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (852, 5, 'Quam Nec', 737.37, 4,'Category_B.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (853, 5, 'Nunc Nisl', 72.58, 1,'Category_B.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (854, 7, 'In Faucibus Orci', 287.67, 14,'Category_B.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (855, 9, 'Odio Condimentum Id', 945.21, 23,'Category_B.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (856, 6, 'A', 90.25, 30,'Category_B.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (857, 2, 'Cubilia Curae', 724.86, 14,'Category_B.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (858, 8, 'Libero', 4.63, 18,'Category_B.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (859, 2, 'Cras', 362.54, 6,'Category_B.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (860, 4, 'Morbi Odio Odio', 299.02, 44,'Category_B.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (861, 4, 'Massa', 22.23, 10,'Category_B.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (862, 7, 'Dictumst', 767.71, 10,'Category_B.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (863, 6, 'Enim In Tempor', 572.61, 6,'Category_B.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (864, 1, 'Et Eros Vestibulum', 686.73, 22,'Category_B.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (865, 5, 'Morbi Quis', 740.16, 36,'Category_C.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (866, 9, 'Adipiscing Molestie Hendrerit', 837.26, 31,'Category_C.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (867, 2, 'Erat Id Mauris', 902.61, 50,'Category_C.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (868, 2, 'Eget Tempus Vel', 990.49, 20,'Category_C.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (869, 6, 'Ipsum Dolor', 64.84, 11,'Category_C.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (870, 2, 'Ante Ipsum', 754.46, 5,'Category_C.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (871, 2, 'Sed Nisl Nunc', 755.11, 39,'Category_C.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (872, 7, 'Nisl', 349.84, 18,'Category_C.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (873, 3, 'Accumsan', 65.08, 42,'Category_C.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (874, 10, 'Nulla', 681.76, 29,'Category_C.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (875, 4, 'Sit', 190.95, 19,'Category_C.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (876, 5, 'Congue Etiam Justo', 682.51, 36,'Category_C.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (877, 8, 'Eu Magna Vulputate', 943.02, 15,'Category_C.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (878, 8, 'Ullamcorper Augue', 925.39, 48,'Category_C.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (879, 8, 'Justo', 294.55, 13,'Category_C.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (880, 1, 'Cubilia', 735.23, 34,'Category_C.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (881, 9, 'Nisi', 123.25, 19,'Category_D.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (882, 4, 'Sed Tincidunt', 624.94, 31,'Category_D.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (883, 1, 'Auctor', 375.19, 16,'Category_D.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (884, 8, 'Nulla', 528.89, 32,'Category_D.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (885, 1, 'Rhoncus Mauris', 71.17, 47,'Category_D.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (886, 1, 'Accumsan Felis Ut', 267.96, 8,'Category_D.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (887, 9, 'Convallis Tortor', 240.61, 2,'Category_D.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (888, 3, 'A Libero', 312.35, 17,'Category_D.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (889, 2, 'Cursus Id', 144.49, 8,'Category_D.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (890, 1, 'Luctus', 263.51, 17,'Category_D.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (891, 7, 'Cum', 321.27, 27,'Category_D.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (892, 7, 'Odio Condimentum', 655.26, 6,'Category_D.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (893, 5, 'Lacinia Nisi Venenatis', 105.37, 26,'Category_D.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (894, 9, 'Ultrices', 886.04, 14,'Category_D.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (895, 1, 'Lectus In', 252.55, 13,'Category_D.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (896, 5, 'In Faucibus Orci', 816.02, 19,'Category_D.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (897, 7, 'Amet Diam In', 903.22, 11,'Category_A.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (898, 10, 'Pretium Iaculis Diam', 826.81, 23,'Category_A.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (899, 6, 'Erat Quisque', 666.47, 23,'Category_A.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (900, 10, 'Amet', 464.82, 3,'Category_A.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (901, 8, 'Neque', 604.28, 27,'Category_A.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (902, 3, 'Ultrices', 84.08, 1,'Category_A.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (903, 9, 'Id Consequat In', 607.93, 22,'Category_A.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (904, 5, 'Tellus Nisi Eu', 612.62, 3,'Category_A.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (905, 10, 'Quam', 519.6, 40,'Category_A.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (906, 6, 'Dapibus At Diam', 380.93, 44,'Category_A.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (907, 5, 'Semper Rutrum Nulla', 703.53, 27,'Category_A.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (908, 6, 'Integer Ac', 447.77, 49,'Category_A.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (909, 3, 'Condimentum', 6.84, 25,'Category_A.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (910, 7, 'Sit', 449.27, 46,'Category_A.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (911, 1, 'Porttitor', 105.43, 23,'Category_A.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (912, 7, 'Ut', 747.77, 42,'Category_A.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (913, 2, 'In Est Risus', 27.5, 3,'Category_B.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (914, 4, 'Sed', 439.66, 44,'Category_B.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (915, 6, 'Metus Aenean', 100.12, 50,'Category_B.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (916, 5, 'Tristique Est', 356.16, 30,'Category_B.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (917, 3, 'Non Pretium', 504.02, 46,'Category_B.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (918, 9, 'Sit', 971.21, 17,'Category_B.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (919, 8, 'Sapien', 931.41, 27,'Category_B.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (920, 4, 'Enim Leo Rhoncus', 497.48, 0,'Category_B.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (921, 1, 'Scelerisque', 420.15, 10,'Category_B.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (922, 6, 'Eu Sapien', 159.39, 44,'Category_B.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (923, 4, 'Eget Massa Tempor', 856.81, 11,'Category_B.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (924, 7, 'Porttitor Id Consequat', 860.65, 32,'Category_B.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (925, 7, 'Varius', 959.23, 45,'Category_B.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (926, 6, 'Magnis Dis', 993.29, 36,'Category_B.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (927, 3, 'Molestie Lorem Quisque', 142.88, 19,'Category_B.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (928, 3, 'Libero Non Mattis', 504.49, 28,'Category_B.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (929, 1, 'Nulla Integer', 543.07, 0,'Category_C.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (930, 10, 'Nibh', 115.01, 20,'Category_C.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (931, 10, 'Eget Massa', 787.65, 9,'Category_C.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (932, 5, 'Adipiscing Elit Proin', 615.98, 22,'Category_C.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (933, 9, 'Magna At Nunc', 350.05, 22,'Category_C.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (934, 7, 'Cras Non', 878.45, 9,'Category_C.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (935, 7, 'Mattis', 805.17, 27,'Category_C.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (936, 7, 'Viverra Dapibus', 315.77, 20,'Category_C.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (937, 8, 'Pede Ac', 845.37, 34,'Category_C.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (938, 6, 'In Purus Eu', 312.67, 38,'Category_C.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (939, 8, 'Nulla Ut', 955.58, 10,'Category_C.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (940, 10, 'Justo', 451.01, 12,'Category_C.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (941, 6, 'Lectus Pellentesque Eget', 532.82, 0,'Category_C.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (942, 5, 'Vel Dapibus', 609.39, 11,'Category_C.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (943, 2, 'Tortor Quis', 714.77, 22,'Category_C.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (944, 1, 'Orci Pede Venenatis', 452.56, 22,'Category_C.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (945, 10, 'Ullamcorper Purus', 444.95, 50,'Category_D.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (946, 2, 'Tellus', 549.68, 44,'Category_D.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (947, 7, 'Ac Nibh', 73.86, 3,'Category_D.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (948, 8, 'Quis Justo', 544.6, 20,'Category_D.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (949, 8, 'Suspendisse Ornare Consequat', 215.48, 41,'Category_D.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (950, 5, 'Lobortis', 196.95, 2,'Category_D.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (951, 6, 'Eu', 828.35, 50,'Category_D.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (952, 3, 'Placerat Ante Nulla', 854.29, 0,'Category_D.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (953, 1, 'Vel Est Donec', 251.31, 50,'Category_D.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (954, 8, 'Vestibulum Vestibulum Ante', 797.44, 27,'Category_D.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (955, 1, 'Dolor Vel', 245.14, 21,'Category_D.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (956, 8, 'Erat', 153.21, 50,'Category_D.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (957, 5, 'Vestibulum Quam Sapien', 799.9, 28,'Category_D.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (958, 6, 'Dui Luctus', 748.2, 40,'Category_D.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (959, 5, 'Eget Rutrum At', 807.57, 10,'Category_D.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (960, 10, 'Platea', 574.4, 5,'Category_D.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (961, 7, 'Penatibus Et', 251.74, 12,'Category_A.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (962, 1, 'Molestie Sed Justo', 943.61, 45,'Category_A.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (963, 2, 'Semper', 553.31, 16,'Category_A.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (964, 8, 'Orci Luctus', 567.0, 19,'Category_A.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (965, 8, 'Consectetuer Eget', 629.43, 27,'Category_A.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (966, 9, 'Dis Parturient Montes', 520.45, 18,'Category_A.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (967, 7, 'Ut Suscipit', 89.29, 32,'Category_A.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (968, 5, 'In', 715.78, 4,'Category_A.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (969, 4, 'Sapien Iaculis', 270.37, 39,'Category_A.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (970, 6, 'Sollicitudin Vitae Consectetuer', 272.24, 15,'Category_A.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (971, 8, 'Est Et', 454.26, 20,'Category_A.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (972, 4, 'Gravida', 75.73, 10,'Category_A.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (973, 8, 'Maecenas Leo Odio', 324.34, 49,'Category_A.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (974, 8, 'Sit Amet Nunc', 427.11, 47,'Category_A.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (975, 6, 'Lorem', 899.36, 36,'Category_A.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (976, 5, 'Sit', 999.99, 3,'Category_A.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (977, 5, 'Ultrices', 91.77, 17,'Category_B.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (978, 9, 'Lectus Vestibulum', 107.84, 43,'Category_B.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (979, 6, 'Adipiscing Elit Proin', 988.69, 30,'Category_B.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (980, 7, 'Proin Leo Odio', 92.33, 48,'Category_B.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (981, 6, 'Pellentesque', 377.47, 20,'Category_B.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (982, 1, 'Etiam', 29.02, 38,'Category_B.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (983, 9, 'Ut', 50.89, 50,'Category_B.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (984, 5, 'Libero Non', 276.65, 1,'Category_B.Subcategory_B.Subsubcategory_D');
--INSERT INTO stock VALUES (985, 1, 'In Porttitor Pede', 992.23, 44,'Category_B.Subcategory_C.Subsubcategory_A');
--INSERT INTO stock VALUES (986, 2, 'Nulla Quisque Arcu', 786.97, 14,'Category_B.Subcategory_C.Subsubcategory_B');
--INSERT INTO stock VALUES (987, 3, 'Vitae', 576.99, 46,'Category_B.Subcategory_C.Subsubcategory_C');
--INSERT INTO stock VALUES (988, 4, 'Laoreet Ut', 741.76, 40,'Category_B.Subcategory_C.Subsubcategory_D');
--INSERT INTO stock VALUES (989, 4, 'Quisque Porta', 334.84, 14,'Category_B.Subcategory_D.Subsubcategory_A');
--INSERT INTO stock VALUES (990, 10, 'Tincidunt In Leo', 122.35, 24,'Category_B.Subcategory_D.Subsubcategory_B');
--INSERT INTO stock VALUES (991, 7, 'Sapien', 211.52, 39,'Category_B.Subcategory_D.Subsubcategory_C');
--INSERT INTO stock VALUES (992, 5, 'Imperdiet Et', 335.68, 23,'Category_B.Subcategory_D.Subsubcategory_D');
--INSERT INTO stock VALUES (993, 8, 'Nunc Donec', 611.39, 23,'Category_C.Subcategory_A.Subsubcategory_A');
--INSERT INTO stock VALUES (994, 7, 'In', 328.62, 34,'Category_C.Subcategory_A.Subsubcategory_B');
--INSERT INTO stock VALUES (995, 7, 'Ac Diam', 543.75, 30,'Category_C.Subcategory_A.Subsubcategory_C');
--INSERT INTO stock VALUES (996, 6, 'Metus Arcu', 24.32, 11,'Category_C.Subcategory_A.Subsubcategory_D');
--INSERT INTO stock VALUES (997, 8, 'Mi', 613.97, 27,'Category_C.Subcategory_B.Subsubcategory_A');
--INSERT INTO stock VALUES (998, 7, 'Quam Nec', 303.85, 6,'Category_C.Subcategory_B.Subsubcategory_B');
--INSERT INTO stock VALUES (999, 3, 'Et Eros', 534.01, 22,'Category_C.Subcategory_B.Subsubcategory_C');
--INSERT INTO stock VALUES (1000, 7, 'Integer Pede Justo', 967.8, 4,'Category_C.Subcategory_B.Subsubcategory_D');
--\.


----
---- Name: stock_sid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
----
--
--SELECT pg_catalog.setval('stock_sid_seq', 19, true);


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY transactions (tid, sid, uid, type) FROM stdin;
1	3	1	PURCHASE
2	1	10	PURCHASE
3	4	3	PURCHASE
4	5	4	PURCHASE
5	14	1	PURCHASE
6	14	10	PURCHASE
7	14	8	PURCHASE
8	18	7	PURCHASE
9	17	7	PURCHASE
10	18	11	PURCHASE
11	11	11	PURCHASE
12	11	11	PURCHASE
13	11	11	PURCHASE
14	11	11	PURCHASE
15	9	11	PURCHASE
16	3	11	PURCHASE
17	17	11	PURCHASE
18	13	11	PURCHASE
\.


--
-- Name: transactions_tid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('transactions_tid_seq', 18, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY users (uid, username, realname, password) FROM stdin;
1	admin	Sally Smith	1337
2	j0nny	John Diggle	password
3	james	James Green	green
4	zoo	Monty Python	dinosaur
5	qwerty	Zoe Curtis	purple
6	Cambel	Thea Queen	something
7	Waities	Kara Danvers	secure
8	Cam	Camile Jones	12345
9	grod	Cameron Smith	dfgh
10	flash	Barry Allen	falsh
11	arrow	Oliver Queen	arrow
12	rarnoldb	Rose Arnold	LohUedMaQq
13	hwheelerc	Harold Wheeler	4cRkQFZ6
14	nmarshalld	Nicholas Marshall	JCxjBsDUb
15	cpeterse	Carlos Peters	DdqHUcD69DUO
16	rmorenof	Roy Moreno	EZPhYMb4GLP
17	amasong	Andrea Mason	2x1jLKv
18	spriceh	Scott Price	DjzQWv
19	amurphyi	Anthony Murphy	cKAt3r
20	scoxj	Sarah Cox	gX7UG3GBrFhf
21	cjohnsonk	Catherine Johnson	2GPuaniMLd
22	jramirezl	Jeffrey Ramirez	M90jslLQO3U7
23	jthompsonm	Jennifer Thompson	tGpljKD
24	jhudsonn	Jesse Hudson	bZK6yfwv
25	jmontgomeryo	Joshua Montgomery	3HFKB4fn
26	aburtonp	Anna Burton	VG9M3IG
27	mgardnerq	Matthew Gardner	jBY0Dx
28	jcruzr	Judith Cruz	idtKki3N
29	khunts	Kevin Hunt	FzNqQLPI8Ra
30	mfowlert	Margaret Fowler	aKVhhA5w9bar
31	awatsonu	Anna Watson	uQsyna14
32	ccruzv	Carl Cruz	R9PL6qFIO
33	wmartinezw	Willie Martinez	YX7k4j82N9
34	sdavisx	Steve Davis	pWhvPO
35	pcolemany	Paul Coleman	ta1EbSEQ1
36	clewisz	Christine Lewis	3IZQHKu1j
37	mrobinson10	Maria Robinson	9EWloV
38	hmorris11	Helen Morris	xhNEgl
39	kkelly12	Keith Kelly	vObXlmIXF
40	cfox13	Charles Fox	7be3pMTEb
41	csanders14	Catherine Sanders	oDjPGisQnupf
42	ncruz15	Nancy Cruz	lx49hm3p
43	kcoleman16	Karen Coleman	05Jvi5H
44	kblack17	Kevin Black	KnurDI8zLX
45	jhicks18	John Hicks	79g60E
46	mturner19	Matthew Turner	Ejggj4S5
47	ereed1a	Eugene Reed	ZYMafq0cym
48	mcollins1b	Melissa Collins	EGFsEk
49	nsullivan1c	Nancy Sullivan	rmrnnyl
50	jpeters1d	Jack Peters	aZRcohL3s
51	lfernandez1e	Lawrence Fernandez	wJiTV6kmWmhr
52	astone1f	Annie Stone	uxg7oiX7G9
53	gsanchez1g	Gregory Sanchez	is4w1kbQVP
54	ecastillo1h	Evelyn Castillo	whr28uN72J
55	dharvey1i	Deborah Harvey	FmlrBmI7l
56	thowell1j	Todd Howell	mT5mozGi
57	sfreeman1k	Sarah Freeman	yu6DHl
58	pgrant1l	Paula Grant	LOzMxvn
59	ryoung1m	Robin Young	m9MczoF2Xqp2
60	gbryant1n	Gerald Bryant	xeAcbc
61	cbrown1o	Christine Brown	mWNp8kP6ga
62	jgeorge1p	Jennifer George	KjsaoczPQl
63	hjames1q	Harry James	MYSrb3EkA6Y0
64	jkelly1r	Joan Kelly	ISbwGg5I
65	vharper1s	Victor Harper	fxKJayrpLSfg
66	sharvey1t	Shirley Harvey	HyPv4Ab
67	cellis1u	Christopher Ellis	6tNSPecbN
68	mharvey1v	Maria Harvey	0fTW5MwKz
69	dwilliams1w	Diane Williams	QDjrrWX0SPk
70	pdixon1x	Patricia Dixon	tUePRI9jjsWs
71	tprice1y	Tina Price	ilAnqJzztla
72	ajackson1z	Andrea Jackson	BuaW2l
73	cmatthews20	Cheryl Matthews	wOagKAs
74	hbailey21	Heather Bailey	zt1DsHrGc
75	dkennedy22	Donald Kennedy	CVHOOoZaO
76	jfranklin23	Jeffrey Franklin	zGaUDlaQ3
77	rspencer24	Roger Spencer	z2pzzH2qh
78	wgonzales25	Wayne Gonzales	Sd3xEBtFF
79	pstone26	Phyllis Stone	LqHNdRjR
80	mlynch27	Martha Lynch	67gpn57EL
81	fpeterson28	Frank Peterson	FaJ0vmTw8
82	sspencer29	Sharon Spencer	F75VZbys4
83	jgarcia2a	Johnny Garcia	8SfRwKAOg
84	jschmidt2b	Jeffrey Schmidt	hd2WMpTnMr
85	mpatterson2c	Michael Patterson	4qPcY9pu97Qm
86	ariley2d	Ashley Riley	lTj7k86U
87	sruiz2e	Samuel Ruiz	66qtcmYT2J
88	cryan2f	Charles Ryan	Orev6LNZFOLo
89	jwatson2g	Jeremy Watson	d7XQAr
90	jwest2h	Jane West	9OoYnrn1J3Re
91	jreynolds2i	Jose Reynolds	jAxz30pWwm
92	rrice2j	Roy Rice	cEhT3iSFg5Za
93	pallen2k	Patricia Allen	wmNee7j1
94	jhayes2l	Jane Hayes	u4GgDcC
95	wholmes2m	Wanda Holmes	tIGs0EGV
96	hevans2n	Helen Evans	xnX53U
97	cnguyen2o	Christina Nguyen	07hE1Fnf
98	cmason2p	Christopher Mason	pylvodC
99	ahenry2q	Angela Henry	YAJekbhpX2g
100	blynch2r	Beverly Lynch	HNmGnFQesC
101	dcarroll2s	Deborah Carroll	JitxIG9lz
102	lbryant2t	Lori Bryant	pS6SUJllxdC
103	hrose2u	Henry Rose	s5b92D
104	lwatson2v	Larry Watson	37l8Z8H
105	nnelson2w	Norma Nelson	bOh2mMr0C9QH
106	blynch2x	Bonnie Lynch	nFVEjJB
107	acox2y	Arthur Cox	tywbmq
108	kwashington2z	Kathy Washington	u0lfnSwm
109	jharris30	Joan Harris	eujyDWR
110	jjones31	Jack Jones	C251dlfDR
111	kaustin32	Kimberly Austin	g4G54Ecz7
112	dcole33	Diana Cole	WHWEQOl
113	kchapman34	Keith Chapman	3EFylk
114	hcarr35	Harold Carr	KhnTlb
115	pboyd36	Paul Boyd	3ZMyj4N
116	dlittle37	Doris Little	p18EkHh9lP
117	twebb38	Theresa Webb	yzIWpn3
118	fjames39	Fred James	3vR4Tf5Izoa
119	hreid3a	Howard Reid	vLtqTWf7n
120	swatkins3b	Sarah Watkins	8d6Zgy
121	lgraham3c	Lawrence Graham	fN5xg4
122	rdavis3d	Raymond Davis	0Y4UcNDhW2F
123	sfowler3e	Sharon Fowler	LEGZrOrTztI
124	ajohnston3f	Annie Johnston	JmaFLr
125	pwarren3g	Peter Warren	h4dURbl
126	mhamilton3h	Marilyn Hamilton	K0EvXUKt
127	lkim3i	Larry Kim	iY3ZSD
128	cchapman3j	Christopher Chapman	SnsncU30
129	dwest3k	Diana West	axrt3xhaM
130	spierce3l	Shawn Pierce	txUQ3e9p
131	bmiller3m	Benjamin Miller	CGyspfEJF
132	alawrence3n	Ashley Lawrence	7gAQ4M0tqe
133	mgardner3o	Melissa Gardner	iDUIMMI
134	rbrown3p	Rose Brown	ihIb3S13LxQn
135	dgriffin3q	Denise Griffin	7Sx68FXEV3
136	thudson3r	Todd Hudson	mNpqjBWjkrq
137	bmorris3s	Billy Morris	lnvWZI1
138	fjordan3t	Fred Jordan	p76HUGU
139	jstewart3u	Jack Stewart	bKSRh7wxhX
140	jdixon3v	James Dixon	tAcjVkVzn
141	jromero3w	James Romero	OB3ICmJK
142	jwebb3x	Jesse Webb	7YOoB4q3YE8u
143	lstanley3y	Larry Stanley	9EygBr
144	shawkins3z	Shirley Hawkins	ReXqpS
145	acampbell40	Ashley Campbell	2qHcgF
146	rgibson41	Raymond Gibson	hACdquN
147	sgray42	Stephanie Gray	5BF3UnpR
148	snichols43	Steven Nichols	M7zcH2uo
149	cwashington44	Cynthia Washington	yueGLbFb
150	jtucker45	Judith Tucker	0AzNayaE
151	kgordon46	Kenneth Gordon	suqBq25Ai
152	sdunn47	Sarah Dunn	EXYkhxNWPy5
153	brobinson48	Brenda Robinson	fhyGED
154	speters49	Scott Peters	pF8cFrFhtHDh
155	ahill4a	Angela Hill	vmnwKU
156	sarnold4b	Scott Arnold	pEdQsxxt
157	csims4c	Carolyn Sims	y6PKNwEDq
158	dnelson4d	Dorothy Nelson	Ow81dbV
159	cryan4e	Carolyn Ryan	tKaEpShI
160	sdunn4f	Samuel Dunn	ltzHUYqWCiA
161	rallen4g	Ronald Allen	gVpsnpV3P1i
162	boliver4h	Beverly Oliver	Hp62X7Tr
163	jprice4i	Jose Price	AuDrWqS7
164	mmorris4j	Margaret Morris	a4D2TZ8GAxV
165	rortiz4k	Ruby Ortiz	HcAItTg
166	barnold4l	Barbara Arnold	1ff2pVkv9SdH
167	jmason4m	Jonathan Mason	ff72nnYJ4
168	landerson4n	Lawrence Anderson	yBS1Or51
169	asims4o	Anna Sims	IFDm8QO
170	rtorres4p	Ruby Torres	a3vNBh
171	agonzales4q	Amy Gonzales	mPDl4hp4CBE
172	slee4r	Susan Lee	vT6aOFsew4
173	acook4s	Anna Cook	KVuAvn
174	rwatkins4t	Ralph Watkins	0f2RxO1dFVV
175	lreid4u	Lillian Reid	f6EefZpe
176	hbrooks4v	Helen Brooks	8xegwLd
177	rpowell4w	Raymond Powell	BwB0qsCUc
178	ayoung4x	Andrea Young	dMD2Xlwey
179	bbaker4y	Brenda Baker	PYVtjegX
180	jreyes4z	Judith Reyes	TwDdrcnCU
181	gcarr50	Gerald Carr	DVEuroG1
182	rmendoza51	Russell Mendoza	P1rsSy
183	mrogers52	Matthew Rogers	f1YPTPY
184	ehamilton53	Elizabeth Hamilton	KHpUysSn
185	eoliver54	Eric Oliver	mb6DLYVrOgyk
186	roliver55	Robin Oliver	9MMQfV
187	tedwards56	Timothy Edwards	zAq6aYEleXh
188	tlong57	Theresa Long	f1fE1hvoTfzn
189	rryan58	Russell Ryan	qCNFxrpLkuLC
190	hstanley59	Helen Stanley	M6ZMkVWRQO
191	twebb5a	Theresa Webb	dkh5w0
192	bfranklin5b	Bonnie Franklin	EPIXiIViQM
193	rclark5c	Randy Clark	jzEdL3MyhwDB
194	jwright5d	Joan Wright	jGQZ0wbc1KCn
195	kmorales5e	Karen Morales	4NdqkWNeFB
196	mreynolds5f	Margaret Reynolds	I650so95q
197	jnichols5g	Judy Nichols	ltTWOx
198	kgriffin5h	Karen Griffin	27k3Y0
199	pwilliamson5i	Paul Williamson	cM4qca
200	jfernandez5j	Judith Fernandez	nC6aULqMcv
201	jjenkins5k	John Jenkins	3doYaEiK3v
202	rmason5l	Rebecca Mason	gAIjxX2IlPl
203	dmurray5m	Donald Murray	GuQSeFQpuY
204	ksimpson5n	Kathy Simpson	IQThorrxhy3
205	lhayes5o	Larry Hayes	XI1YYadTaRpP
206	klee5p	Kathy Lee	vpJX6JxmK
207	nwilson5q	Norma Wilson	CmTcagNl
208	bbowman5r	Brenda Bowman	430aJbkdG3
209	janderson5s	Juan Anderson	CAqdsmxUB
210	akennedy5t	Arthur Kennedy	4xpSovE
211	nlittle5u	Nicholas Little	CDUKQna
212	lferguson5v	Lawrence Ferguson	c742Pt4A
213	jford5w	Jason Ford	Xryozc
214	aharrison5x	Amanda Harrison	lo90eT5n
215	rbaker5y	Rose Baker	x5wNpDHrBwQk
216	mharris5z	Michael Harris	Uoezwa
217	kwest60	Kathleen West	7Buyg3wRvTMA
218	abennett61	Anthony Bennett	brxqNhpOt
219	carmstrong62	Charles Armstrong	TUco7ChC4H
220	jhunt63	Jeremy Hunt	Gwq3X7l
221	bfowler64	Billy Fowler	7VGL7H
222	jberry65	Jose Berry	zfJP3zHP
223	mlittle66	Mary Little	JAteoD6YYbn
224	kmeyer67	Kathryn Meyer	Xpx27vS2
225	jhowell68	Jason Howell	DGPXKcyT6w
226	mlong69	Mildred Long	Zj9jPHWzL7J
227	sweaver6a	Sharon Weaver	VjGP4gUQpw
228	kshaw6b	Kevin Shaw	HyznOKb
229	lthomas6c	Louis Thomas	djYK66r
230	amcdonald6d	Alice Mcdonald	12U9hGL
231	rgutierrez6e	Rebecca Gutierrez	4UWL2zBEhWI
232	jray6f	Jose Ray	mgsyIU78V
233	whicks6g	Wayne Hicks	guV9ZjpFu
234	iray6h	Irene Ray	NNwBS49
235	baustin6i	Beverly Austin	pdJ3xW
236	kwashington6j	Kathleen Washington	rJ2xpsXe09
237	awilson6k	Alan Wilson	Oxg9G8REr
238	gallen6l	Gerald Allen	UpQbA9
239	jmedina6m	Jean Medina	GFPyJTqVp0
240	ehayes6n	Eric Hayes	UstveAYKPE
241	khoward6o	Keith Howard	DDGkE4LIC
242	smiller6p	Sarah Miller	12GCSQWxRB
243	trobertson6q	Timothy Robertson	WiasSXh
244	criley6r	Carlos Riley	KpTpk7AH
245	rfrazier6s	Robin Frazier	psl0GSLFl0Ol
246	aford6t	Antonio Ford	7WzDitGKI
247	jbrown6u	Juan Brown	qGss2KzC04ia
248	jpeterson6v	Judith Peterson	nMsKDJcJh
249	wkennedy6w	Willie Kennedy	HShABfCo6ZL
250	mrussell6x	Michelle Russell	nUv0cr
251	drodriguez6y	Denise Rodriguez	6q1RH8
252	lclark6z	Louis Clark	wBgwOTTb2n4V
253	kclark70	Keith Clark	bVZ7RSQa
254	hmurphy71	Harold Murphy	wIM6YUcO
255	mfox72	Margaret Fox	KxbP6V1W
256	bdaniels73	Barbara Daniels	txekZF6Kc
257	jcastillo74	John Castillo	1hXp7Z9f
258	rdixon75	Rose Dixon	l0wsQGY
259	bjordan76	Barbara Jordan	oGNzTxUVqN
260	jharper77	Jesse Harper	OTzwmT5
261	awilson78	Anne Wilson	GCO5wEe
262	jdunn79	Juan Dunn	fFBulh4
263	jbanks7a	Jeffrey Banks	y8ozMDKI
264	ibrown7b	Irene Brown	dOnShD40c
265	wjones7c	Willie Jones	bOgrii
266	llewis7d	Laura Lewis	UNwEW9JY
267	sgreen7e	Steve Green	BAYQ8ZJFbq
268	cpalmer7f	Carl Palmer	tOp6CWliWaAo
269	lharris7g	Laura Harris	UZnqNh41Gi
270	jlittle7h	Jessica Little	jc1yFQAlt
271	wford7i	Wanda Ford	GnWbFxayBQn
272	pbutler7j	Paula Butler	FY2AlIrG6
273	hreyes7k	Helen Reyes	yF4rdJAX6bc
274	awallace7l	Albert Wallace	10ilfYxTP
275	bgardner7m	Bobby Gardner	oiRSaxo
276	plittle7n	Phyllis Little	AkgipHnsugld
277	rgonzales7o	Roy Gonzales	evjkxPZsU76G
278	dfisher7p	Debra Fisher	ElB9k632y
279	jcarter7q	Jason Carter	sxguP19nvg1x
280	cgordon7r	Craig Gordon	MPKgn9Z
281	ltorres7s	Larry Torres	9wY0ywPQiJeQ
282	jgilbert7t	Judith Gilbert	dyXgvvzi7o8m
283	mcunningham7u	Martin Cunningham	pSso8aY9z4
284	spalmer7v	Susan Palmer	jgzSd1
285	krussell7w	Kathleen Russell	Rejp0R3ZA
286	pwhite7x	Phyllis White	uP1jyd
287	tdean7y	Theresa Dean	fK5yiQ6SKA0
288	ahanson7z	Aaron Hanson	d3laESE
289	jsimpson80	Joshua Simpson	IB0umlbol
290	ldixon81	Louis Dixon	sYIorFoMVcV
291	sstewart82	Shawn Stewart	2BW9BpJO
292	epowell83	Eric Powell	jgEzfaogepZ
293	delliott84	Doris Elliott	cBp5Qa0gmfez
294	barmstrong85	Beverly Armstrong	hRqwcO0
295	bwatkins86	Bruce Watkins	u7NKRJgbYKm
296	blane87	Brenda Lane	AHMe2X
297	mgeorge88	Marie George	iKR6A0HMvd
298	skennedy89	Stephen Kennedy	fg8lFlMqqpC
299	bspencer8a	Bonnie Spencer	Qn74II
300	welliott8b	Walter Elliott	VluSaC7hZwKA
301	scollins8c	Shirley Collins	Iw7K81lbF68B
302	jharvey8d	Jesse Harvey	I3uTm2D
303	mreyes8e	Mildred Reyes	v5huPlTL
304	knichols8f	Katherine Nichols	RZWNlja10N3B
305	lhill8g	Lillian Hill	ZXTXSsgS
306	efox8h	Earl Fox	eMFqFhD
307	aalvarez8i	Ann Alvarez	VYTqEjCdBC
308	efields8j	Edward Fields	qzzqW0AVZVy
309	agreen8k	Antonio Green	8Ywozf
310	breyes8l	Bonnie Reyes	VenWuZ9Q8gfk
311	tgrant8m	Theresa Grant	ej66Fn
312	fbailey8n	Frank Bailey	M35BqjUUrV
313	nvasquez8o	Nicole Vasquez	mPGBBC
314	aromero8p	Andrew Romero	uIuI1G
315	aharrison8q	Andrea Harrison	whqNBr
316	dthomas8r	Donald Thomas	ZRvzThtzL5F
317	frodriguez8s	Frances Rodriguez	KQvjnKio
318	manderson8t	Mildred Anderson	Q3Ham6JasnW
319	sjohnston8u	Shirley Johnston	6iUPPhz8i
320	jhamilton8v	James Hamilton	OxWhMBk0
321	jnichols8w	Jonathan Nichols	xziA6EHukE
322	drichardson8x	Douglas Richardson	mfNGja1GO7EW
323	sbryant8y	Steve Bryant	CyMVHQXDY
324	rdean8z	Rose Dean	zxctNUd
325	wjohnston90	William Johnston	OEUEp9FMYio
326	hmoreno91	Harold Moreno	3Mj5iVwW
327	jwebb92	Judy Webb	zA8pRqiyhebE
328	akelley93	Arthur Kelley	DJweEdwTjU
329	ewatson94	Earl Watson	uVYr0iUtlcR4
330	jburton95	Jason Burton	ua12aCvAp
331	cmurphy96	Cynthia Murphy	dOFbTqUTT
332	bwatson97	Barbara Watson	WOgmSz
333	wmorris98	Walter Morris	gQfuzze
334	hsimpson99	Howard Simpson	SiiOSrFq7
335	rgrant9a	Roger Grant	xrwnxV4W
336	msimpson9b	Marie Simpson	k82My5cn6
337	bray9c	Billy Ray	5SzwKP
338	blawrence9d	Benjamin Lawrence	sXY0gtwJKF2
339	jmeyer9e	Joseph Meyer	vn6MCifIQEB
340	esims9f	Emily Sims	yhtMeIdU
341	sfox9g	Sarah Fox	D8XkAsdM
342	bclark9h	Bobby Clark	ycL4JSQdog
343	vstephens9i	Victor Stephens	b9wxv5lJ
344	kwhite9j	Kathy White	U4Tr2o1WDCE
345	jgilbert9k	Jimmy Gilbert	zgbT1Zhv
346	rshaw9l	Ruth Shaw	nea6O3dRatd
347	awest9m	Amy West	bdgsVWpVy6mJ
348	nbaker9n	Nicholas Baker	gfK4FA4rd
349	drussell9o	Dennis Russell	UzZB0tdF
350	dmorales9p	Doris Morales	5X89EJ
351	bstevens9q	Benjamin Stevens	Kp3LN5XOFRv
352	wstone9r	Wayne Stone	jFGCXguw
353	bwoods9s	Bruce Woods	jRXs9wZ3E2y
354	mcoleman9t	Matthew Coleman	cwk7ydVLK
355	jjenkins9u	Julie Jenkins	TguSPpOZ5vA
356	adean9v	Arthur Dean	J8ml51TTH
357	bthomas9w	Brenda Thomas	2xExwm5EkE
358	mlee9x	Maria Lee	f3BLnoo9um
359	jbanks9y	Judith Banks	hVBaFU3izU
360	dcoleman9z	David Coleman	Pb0n1s1A
361	bcunninghama0	Brian Cunningham	yfFfjKYx
362	apiercea1	Alice Pierce	2EHWAB
363	jlonga2	Jacqueline Long	BsIxFBbT
364	cmitchella3	Charles Mitchell	1kK4ZLK1
365	kmontgomerya4	Kathryn Montgomery	ZBJgKY
366	vdavisa5	Victor Davis	Rx51jkmh8
367	crodrigueza6	Carolyn Rodriguez	nAUIuCB
368	dharta7	Douglas Hart	GDrseUD2Y6
369	lportera8	Linda Porter	kGLNgfTl5G
370	jmasona9	Joan Mason	6rtW4A
371	lshawaa	Lisa Shaw	ehsEwu3l7oLx
372	kcoleab	Kevin Cole	swjoGvJy
373	eperkinsac	Emily Perkins	dUzL4f2IFHR
374	ralvarezad	Robert Alvarez	DJLuptbrWf
375	sryanae	Sean Ryan	bqODzbp
376	jjonesaf	Jennifer Jones	LHyCAwCy
377	abanksag	Andrea Banks	grSgErQjiCg
378	jhenryah	Joseph Henry	76aCOAw
379	lcookai	Lois Cook	pHJ1HyUwn
380	jcarteraj	Johnny Carter	bqSxd2
381	pnicholsak	Phillip Nichols	ZnuFbdmkJ
382	dallenal	Donna Allen	foCF0KOCUaQ
383	llittleam	Larry Little	B7BQUGR
384	lwelchan	Lois Welch	pNn4DRL
385	mbarnesao	Mark Barnes	puPcaGnJ
386	fchapmanap	Frank Chapman	pWhgk05Lf0
387	mhayesaq	Michelle Hayes	fYyOT21yBUc
388	eleear	Ernest Lee	pnTUOjBqx
389	kbakeras	Kevin Baker	8bixUuRtqSi
390	mhicksat	Martha Hicks	mwQhDKO
391	scrawfordau	Steven Crawford	c2uajFdZQ
392	jstanleyav	Joan Stanley	3nxulkagFx
393	mturneraw	Melissa Turner	FGtmHvym2P
394	dturnerax	Dennis Turner	rFpfDTVQf
395	hjamesay	Harry James	SISYX9DByKTm
396	shuntaz	Steven Hunt	Pl38Fr8HtMG
397	mgilbertb0	Marilyn Gilbert	OkbiDVkgn
398	sgilbertb1	Stephen Gilbert	bjen0rUP
399	dmorrisonb2	Debra Morrison	pikVaBaM
400	krichardsonb3	Kathryn Richardson	L5c992bRgFuU
401	pjacksonb4	Phillip Jackson	Z0vxLi
402	jcunninghamb5	Jack Cunningham	yEbeJgcmVpGz
403	rtaylorb6	Richard Taylor	O4HdnxXNmEPl
404	ckellyb7	Carol Kelly	Diaw8Q38V
405	mcastillob8	Maria Castillo	PIUkF3jKdl
406	gpayneb9	Gerald Payne	loxd0gLF9DG
407	tgomezba	Timothy Gomez	NeEP43JR
408	khansenbb	Keith Hansen	GAZne6iQt4
409	cjohnsonbc	Catherine Johnson	J5XCHbYHTZB
410	rjohnstonbd	Randy Johnston	Syh4otdn
411	mperezbe	Marilyn Perez	tiKceEgPChHs
412	krobinsonbf	Karen Robinson	IB2FaV
413	lhendersonbg	Lillian Henderson	DbWnQVu
414	enguyenbh	Emily Nguyen	HbYUCdKCK
415	bhamiltonbi	Bruce Hamilton	FLeu2N63
416	ccolemanbj	Catherine Coleman	reQV6sQ
417	tkimbk	Todd Kim	ZMwHZPCt
418	jrileybl	Juan Riley	fjOBJPEi0nqa
419	hrodriguezbm	Harry Rodriguez	OQ2ABZuXW
420	sbarnesbn	Samuel Barnes	3oRuW8z
421	pkingbo	Philip King	U4g34Z
422	mcunninghambp	Mildred Cunningham	Qw3UmkOT8k
423	jdixonbq	Jacqueline Dixon	AVha3wOz
424	aknightbr	Arthur Knight	3ybZEwQeD
425	nbradleybs	Nicholas Bradley	0eaQYo3C7S
426	bclarkbt	Bonnie Clark	CQ2NXikCp
427	mgreenebu	Mildred Greene	BHPS83DSq
428	skennedybv	Sandra Kennedy	o9dz5Uf0uqba
429	lmeyerbw	Louis Meyer	dBUOfPvxK
430	fblackbx	Frances Black	pG4T7g3K
431	pburtonby	Peter Burton	7qJ34GsL
432	swatkinsbz	Sara Watkins	E8JenKO04gDZ
433	aduncanc0	Angela Duncan	wKiyLEY4K4N
434	gcarpenterc1	Gerald Carpenter	JnF5Gq
435	shillc2	Sean Hill	OM73GZVF
436	mcarrollc3	Maria Carroll	Jko3QAWE8q
437	jmccoyc4	Joan Mccoy	afxFLuIx5o
438	dwagnerc5	Debra Wagner	X7ueo3
439	jspencerc6	Jason Spencer	ynWeg3H1l
440	ghartc7	Gary Hart	OmHCeIpTRbs
441	fpiercec8	Fred Pierce	q6r1QD2u6
442	ehansonc9	Eugene Hanson	T6WE77w
443	jmcdonaldca	Julia Mcdonald	zPvP7Uhh
444	brichardscb	Brandon Richards	gVx0Ol0L
445	jallencc	Juan Allen	jRwPNbjqDA
446	rwhitecd	Rose White	bkUu1WIB6
447	akelleyce	Andrew Kelley	kaQBmkhAR
448	kjonescf	Kenneth Jones	6F1vahXT1nZJ
449	bwrightcg	Billy Wright	wbc2aykDP
450	jwrightch	Jeremy Wright	VcfHuU2Vl
451	bcoleci	Billy Cole	ugewTMM39jy
452	jhendersoncj	James Henderson	VCmbm3sK4fD
453	wnguyenck	Wanda Nguyen	NgW5Lr
454	lmartinezcl	Louis Martinez	NZXPIXi
455	egilbertcm	Evelyn Gilbert	0lbdT9w
456	rmurphycn	Robin Murphy	YbtkuK9dysio
457	sturnerco	Steve Turner	WdxI5RLNeAPt
458	klarsoncp	Kathy Larson	WMPqtf
459	candersoncq	Cynthia Anderson	uD7ZvcoI
460	dhawkinscr	Donna Hawkins	gd4VUmo
461	mholmescs	Michelle Holmes	LsTiZqvB9
462	palvarezct	Patricia Alvarez	CDrg1aMwsRaS
463	sthompsoncu	Sara Thompson	EEvnIG
464	rcolemancv	Russell Coleman	Yb2jbi62
465	aolivercw	Aaron Oliver	r7lH4BIXpsa
466	lcolecx	Louis Cole	Hiqys9
467	ahickscy	Arthur Hicks	hJeuW24aRo
468	bwilliamsoncz	Betty Williamson	GVwd4VdR
469	rcampbelld0	Robert Campbell	6fZ8bzvwmx
470	hmurphyd1	Harry Murphy	zi9KCV
471	gmillsd2	George Mills	9PPUrM
472	plopezd3	Phillip Lopez	NIkTlf
473	smillsd4	Sean Mills	xGAyzflVG9lo
474	pgutierrezd5	Patrick Gutierrez	992N0l03
475	chayesd6	Carol Hayes	gxLrM6Snqrt
476	vwhited7	Virginia White	fMVKEfnMsoQ
477	jelliottd8	Jonathan Elliott	70DZu7
478	hmurphyd9	Harold Murphy	SLaKpPx
479	rbradleyda	Rebecca Bradley	AQ3O86H94
480	rsimsdb	Randy Sims	hxW5MFvqjMs
481	mgordondc	Maria Gordon	8uGOgd
482	kgeorgedd	Kenneth George	RO53lvn
483	ealvarezde	Eugene Alvarez	uUh3KTD1qt5
484	dbishopdf	Dorothy Bishop	QhpgX0t
485	jlawrencedg	Joseph Lawrence	uhXnTRoVaKCy
486	tkingdh	Tina King	2ovMMLKG8b
487	ecarrdi	Elizabeth Carr	L47n4Lxsvsnj
488	thilldj	Todd Hill	85xAW6rX1C
489	bgutierrezdk	Bobby Gutierrez	iD6SwnY
490	agilbertdl	Anne Gilbert	4upEFgeP2n5G
491	dreynoldsdm	Diane Reynolds	Lm9EcBD3
492	rpiercedn	Robin Pierce	q3o0Bz5Nw
493	preiddo	Philip Reid	wBTf4zp7
494	wfranklindp	Walter Franklin	yKqzX5f7ep
495	ltaylordq	Lawrence Taylor	wsPE1ihZPycS
496	madamsdr	Martha Adams	MWVy370By8B
497	epetersds	Evelyn Peters	mwSSN5I
498	spetersdt	Steven Peters	zhpZzMx
499	rmcdonalddu	Russell Mcdonald	KWBghKEH1S
500	gcookdv	George Cook	tq7QD1VUteLq
501	bpiercedw	Bonnie Pierce	doEF5byQdV
502	dfisherdx	Donald Fisher	LDv6ufu
503	kdixondy	Kimberly Dixon	PdjPqqS
504	cwelchdz	Cheryl Welch	U60PZAD2DIT
505	ppeterse0	Paula Peters	JYg9w6prU7
506	jmorgane1	Jack Morgan	5XO9gZ
507	aevanse2	Ashley Evans	7wVkqW2
508	ndiaze3	Nicholas Diaz	7PI4WgSYUm
509	jcastilloe4	Johnny Castillo	kFB2L6VZfA
510	bgarciae5	Betty Garcia	HhZc1wu8s
511	spereze6	Shirley Perez	DSePMbetlmY
512	aramireze7	Anna Ramirez	ZkR6OV
513	mholmese8	Marilyn Holmes	7kcLjQhWGQXK
514	jdanielse9	Julia Daniels	Ca3ue2
515	amorganea	Amy Morgan	98cZQrX
516	jrogerseb	Janet Rogers	v3A3wssteg7
517	swelchec	Susan Welch	0NRDLMjP
518	pgordoned	Philip Gordon	BIPINkOH
519	cmedinaee	Catherine Medina	lycq8qz8dX
520	dturneref	Donna Turner	Nl4WVms9
521	anelsoneg	Arthur Nelson	WDQvHP
522	rmedinaeh	Ronald Medina	7KF5IYR99
523	dgonzalesei	Douglas Gonzales	hXv8pG72BpTR
524	rnicholsej	Raymond Nichols	ZaLQSk
525	hbutlerek	Henry Butler	NJZXeTV9iHIM
526	twalkerel	Teresa Walker	mrY9pxcyNLh3
527	rkimem	Ryan Kim	x0KQ5G
528	pwarrenen	Phyllis Warren	sBuowfHv
529	ljameseo	Larry James	wFvJ6ipbX
530	ajenkinsep	Alan Jenkins	ffIf8MYi
531	fhickseq	Frances Hicks	hwaXQH7EQ
532	ggibsoner	Gerald Gibson	cRZNEAJt5v
533	bnelsones	Bobby Nelson	v0COTFX6ttr
534	tedwardset	Terry Edwards	1WscShydMu
535	jbryanteu	Jessica Bryant	l2VTpM
536	sarnoldev	Stephanie Arnold	1xyVUrjDq5vs
537	aduncanew	Anne Duncan	AoILeuv91k1
538	kellisex	Kenneth Ellis	u3ow0Ck
539	rmartiney	Roger Martin	iHKWRe
540	jortizez	Jason Ortiz	CMeu2bWAVSB
541	rmarshallf0	Randy Marshall	QrgpwV
542	cchapmanf1	Carl Chapman	KYYqbU
543	kmitchellf2	Keith Mitchell	i6FivR
544	badamsf3	Brian Adams	as9QIWKiwOHb
545	afrazierf4	Ann Frazier	PN8omeJW
546	mcrawfordf5	Martin Crawford	Y3DZWX5BA
547	tgardnerf6	Tammy Gardner	0HNPrKqam
548	jwhitef7	Jack White	qJlGqcjb3
549	gturnerf8	George Turner	EKvChWVY
550	dhenryf9	Diana Henry	GIWSH0qwwWx
551	dhicksfa	Dorothy Hicks	lrBiwRdJ9p
552	njacksonfb	Nicholas Jackson	E7zpZ90di
553	lfoxfc	Louis Fox	5UI4Q9pE52
554	cdunnfd	Catherine Dunn	angY99puUkM
555	dwarrenfe	Diana Warren	bBw0nsxLo
556	jlewisff	Jean Lewis	DPSzSJTU
557	dsandersfg	Dennis Sanders	9aWMi3B
558	gboydfh	George Boyd	6k5EB7
559	amarshallfi	Adam Marshall	ClOwfn
560	acastillofj	Andrea Castillo	08HyYASq
561	ecarpenterfk	Edward Carpenter	mbtmNJ
562	aburkefl	Ashley Burke	wJoWAdOd
563	jrobinsonfm	Joseph Robinson	xOKyzBt4MlA
564	abakerfn	Ashley Baker	ZY4I3l
565	ejohnsonfo	Ernest Johnson	EOZL5HMP
566	lwheelerfp	Lawrence Wheeler	9uyw6w
567	roliverfq	Raymond Oliver	hQ4nYtnog
568	pduncanfr	Pamela Duncan	VVy3cMEwLPI
569	hpowellfs	Howard Powell	TVUvMG6Z
570	rbradleyft	Rose Bradley	QlGWKOnXIIx
571	hhudsonfu	Helen Hudson	BjoyG57FVy
572	tharveyfv	Tammy Harvey	tDopDM
573	kgriffinfw	Kimberly Griffin	X93cfG
574	daustinfx	Diane Austin	g7YqaUEZ
575	solsonfy	Shawn Olson	8hwZ8xiXsWk
576	jsmithfz	James Smith	JEpK0n2C
577	mfrazierg0	Maria Frazier	auy32QJpM
578	ledwardsg1	Lillian Edwards	cLKc2aPOG
579	dreidg2	Diana Reid	5nVYSvHAK
580	brobinsong3	Bonnie Robinson	N30g6t1DKc
581	jperezg4	Jerry Perez	CERuhr2fwiF
582	psanchezg5	Phyllis Sanchez	IhQ11OFhjKil
583	mbishopg6	Mark Bishop	IxxhfEDEqpk
584	agonzalezg7	Adam Gonzalez	HFsgUfG
585	lalvarezg8	Laura Alvarez	1B1uUprnkB
586	kromerog9	Kathy Romero	rpBDPC1v
587	vriveraga	Victor Rivera	LjiYdAf1a
588	areedgb	Albert Reed	y1v5meQQ0
589	swilliamsongc	Sean Williamson	FSWHbF
590	nyounggd	Nicholas Young	kC9qO7efvcPv
591	cfordge	Clarence Ford	ywWcEDUGJdi
592	mpattersongf	Marilyn Patterson	HC3z8KY
593	jwebbgg	Justin Webb	2PshwVL44V
594	ashawgh	Andrew Shaw	wFkS6l
595	rscottgi	Robin Scott	Jwb2zguR3gGL
596	ncoopergj	Norma Cooper	ObogutEX
597	jmendozagk	Johnny Mendoza	84mH8zi6K
598	jrodriguezgl	James Rodriguez	3rx9r194gEM
599	hellisgm	Howard Ellis	R1xUUDTpovCV
600	tjohnsongn	Teresa Johnson	QSFR68v
601	phansengo	Phyllis Hansen	hjFGJhWou
602	amccoygp	Alice Mccoy	Sao89w
603	pvasquezgq	Patrick Vasquez	sU0SQw0iR
604	jbradleygr	Joyce Bradley	zW2ukOwluh1
605	jleegs	Julie Lee	wqI3pjTrB
606	dtaylorgt	Dennis Taylor	6HYB6Job8D2g
607	arichardsongu	Angela Richardson	kGDD8d2BL9
608	tchapmangv	Timothy Chapman	KPmzwStE
609	celliottgw	Cheryl Elliott	8MBUeTBf
610	asmithgx	Ashley Smith	fbzjs79J28U
611	wknightgy	Walter Knight	eHbTJy7
612	dlonggz	Doris Long	ckuwv1VjK0W
613	ldanielsh0	Larry Daniels	bFNO2biQqc0x
614	lalexanderh1	Lois Alexander	DYNXEFps
615	mrogersh2	Mark Rogers	LpLUqv9
616	aevansh3	Anthony Evans	H7hR3XDm7TH
617	jturnerh4	John Turner	YyYIGWDu6
618	mgreeneh5	Maria Greene	4WDbuiG5y7
619	jcampbellh6	John Campbell	l7diTy059
620	gnicholsh7	George Nichols	JNfIzIBf
621	chamiltonh8	Carlos Hamilton	ULt822Nv
622	kweaverh9	Karen Weaver	YE2BzqW1brY
623	fmendozaha	Frank Mendoza	oiaZkGU
624	frichardshb	Frances Richards	jz0miJmo9t
625	arobertshc	Alice Roberts	N5vSDYTh9G9
626	gtuckerhd	Gloria Tucker	TLRqly
627	ecunninghamhe	Earl Cunningham	A15ge8og
628	arogershf	Angela Rogers	WM3k2t
629	dbrookshg	Denise Brooks	JRUJWEgIC78
630	jarnoldhh	Jonathan Arnold	VzA05V2Tdn3F
631	barnoldhi	Barbara Arnold	FjAXHUOkPUnX
632	lstephenshj	Lori Stephens	Jzubeot
633	jtuckerhk	John Tucker	N189ht
634	kparkerhl	Kevin Parker	ektomREaDM
635	jharperhm	Johnny Harper	slcHt0bC
636	pwheelerhn	Peter Wheeler	Yfk6R1M
637	ehallho	Eugene Hall	m5jOycQL6I
638	sschmidthp	Shirley Schmidt	1kZixLfrTPg
639	blarsonhq	Bonnie Larson	JRtRzTYByk
640	tblackhr	Timothy Black	cEMdpjgdUMDK
641	ibutlerhs	Irene Butler	fmckxG
642	jallenht	Jean Allen	J63gLylQDsU
643	mburnshu	Martin Burns	nply6BdSpo
644	jkellyhv	Jacqueline Kelly	DLRCsOXUugk
645	kgibsonhw	Kelly Gibson	KWQY2gFu
646	mhallhx	Martin Hall	9kAqCZ
647	rmorrishy	Raymond Morris	BnlkpKy
648	twilliamshz	Todd Williams	mKqf5L3
649	jlawrencei0	Jessica Lawrence	XgHi7D
650	ereynoldsi1	Emily Reynolds	HoTuh1M
651	kmorenoi2	Kathryn Moreno	CrBNCkBYp55
652	brodriguezi3	Benjamin Rodriguez	BYLUHQF
653	srileyi4	Sara Riley	iRogTzEL
654	bleei5	Billy Lee	MUVLcd
655	lriverai6	Lillian Rivera	fpGCrW33
656	mshawi7	Melissa Shaw	0sfgCOj8M63H
657	awoodsi8	Albert Woods	XpeVBK9e3
658	sreyesi9	Scott Reyes	txQSe70q
659	mfieldsia	Marie Fields	azAlIwMEHcX
660	lmoralesib	Laura Morales	kfmiqCwuo
661	twallaceic	Teresa Wallace	R4gdZpP
662	ccruzid	Christina Cruz	c4dh7Wft
663	rbennettie	Roy Bennett	0MjJ0Q9k4
664	mclarkif	Mildred Clark	6osEQkVdJ5pF
665	mperryig	Michelle Perry	WEoD0Hfey
666	jduncanih	Joan Duncan	ZMPdn8
667	jbrooksii	Jessica Brooks	Rx7UQULlC7SJ
668	mgutierrezij	Mildred Gutierrez	QxTR4scV15
669	smedinaik	Samuel Medina	71s1bN8fQ
670	jlittleil	Joseph Little	ckalHtk67qE1
671	psimsim	Phyllis Sims	ba7rOT
672	epattersonin	Evelyn Patterson	tSECYY4t4AF
673	hmatthewsio	Harold Matthews	vt86kMgjZ6Rj
674	ndiazip	Norma Diaz	crBEnGjTW0
675	aalleniq	Arthur Allen	5OPEJTH
676	aandrewsir	Amy Andrews	VMMfmJWaN9l
677	kbennettis	Kimberly Bennett	6TWol4J
678	tburtonit	Thomas Burton	ztyDYv60qK
679	wcarteriu	Walter Carter	dygosAkm
680	drossiv	Donna Ross	UUv1rGQQxW66
681	wmendozaiw	William Mendoza	c89uh1Rg8
682	krogersix	Karen Rogers	aGXVlBJD
683	pbrooksiy	Pamela Brooks	aKR4zy7Nhfts
684	elopeziz	Elizabeth Lopez	i8RwVke
685	jnicholsj0	Jose Nichols	sp7z6I04qEo
686	jcruzj1	Jessica Cruz	GJDuI4
687	wcarpenterj2	Wanda Carpenter	s3x3wW03k
688	hmartinezj3	Helen Martinez	28slZJQ
689	ajamesj4	Aaron James	M8uixiweDXn
690	cmendozaj5	Christine Mendoza	7gncViTqp4
691	gpricej6	Gregory Price	g0aKbrnE
692	mboydj7	Martha Boyd	Oob6MT2vIDD
693	jdeanj8	Julia Dean	rwZW2z4aHd4V
694	nthomasj9	Norma Thomas	tUSkPLsbTD
695	rbarnesja	Raymond Barnes	zVGEv3
696	showelljb	Sarah Howell	t4jlouhJ
697	rhendersonjc	Ralph Henderson	DgGoE1
698	hwestjd	Helen West	yOKMKT2elRt
699	kbaileyje	Kevin Bailey	ZfABDv8fLTx
700	afergusonjf	Aaron Ferguson	Aet5NLwN
701	ntorresjg	Norma Torres	76Nm0TsfF
702	kmarshalljh	Kimberly Marshall	BmCQAubHh
703	adayji	Ann Day	K6s5DliULd
704	jhawkinsjj	Julie Hawkins	bUhRXd83hbB
705	cbennettjk	Catherine Bennett	ZK6UbCa
706	mmccoyjl	Michelle Mccoy	95o6Wv45P
707	rcoxjm	Ronald Cox	GDgKl9m
708	bcarrjn	Benjamin Carr	u1yMtP
709	fsimpsonjo	Frank Simpson	vh2QCb436P
710	jrichardsjp	Jeffrey Richards	NgQyXoKLr
711	jwelchjq	Joyce Welch	MDePsNqD
712	mrobertsjr	Martha Roberts	gIIeluaM
713	jhowelljs	Joseph Howell	vULS8v3bwB
714	awilsonjt	Albert Wilson	dqEJv5wO
715	kleeju	Karen Lee	krzfYhzH0O
716	rstanleyjv	Richard Stanley	MFwbO3
717	cnguyenjw	Clarence Nguyen	RK8AvuXiRg
718	etorresjx	Evelyn Torres	JB1tHC
719	rstevensjy	Roy Stevens	kOfZOpt6Cx
720	mkingjz	Maria King	KJWPyV
721	jmeyerk0	Jonathan Meyer	N5sKDot
722	rnguyenk1	Richard Nguyen	jktezfkLs
723	lfordk2	Lillian Ford	D6CoFap
724	jcooperk3	Janet Cooper	3DWm1Ei
725	pmcdonaldk4	Paula Mcdonald	IgDbpby8Cso
726	rkingk5	Rachel King	j8JRZH4apF
727	tbakerk6	Teresa Baker	qq1r3DQPVC8
728	cgarciak7	Craig Garcia	HWMmfnB2sq1
729	scarterk8	Sean Carter	1UPAIuRXe6
730	pharrisk9	Philip Harris	6gVjSgb7g
731	pbryantka	Phyllis Bryant	n7zy4eKzIXv
732	ahallkb	Andrew Hall	IRZ1PPM
733	abarneskc	Adam Barnes	7cXV6O9yS
734	kmoraleskd	Karen Morales	OqiVZfp03EOx
735	dfranklinke	Doris Franklin	8kuLan3gg
736	jbarneskf	Julie Barnes	16hqx82Kz7qc
737	tfergusonkg	Tammy Ferguson	cBS6W2
738	jwilliamskh	Jessica Williams	FFFGq4YW
739	hbrookski	Harold Brooks	KNR52iH
740	cnguyenkj	Christine Nguyen	h5WT7T
741	jwarrenkk	Jane Warren	q7MOtTqZZb
742	golsonkl	Gregory Olson	H2hXbd4wxFBD
743	asullivankm	Albert Sullivan	eaUkqck02r
744	lfergusonkn	Laura Ferguson	ZHjxxS
745	bbarnesko	Betty Barnes	pKbDjc6oYBg
746	amillerkp	Alan Miller	0TcYN3ZQ
747	sleekq	Sharon Lee	HniOGATB
748	kfranklinkr	Kathy Franklin	A0j6ifg6OdM
749	efranklinks	Elizabeth Franklin	RMa7wOY4
750	jcrawfordkt	Joyce Crawford	eZ8ePGQ
751	jgriffinku	Joshua Griffin	0iWoNYjJ0
752	chuntkv	Craig Hunt	LVxojuun4Ok2
753	cmorenokw	Christine Moreno	rY28Qxey9
754	rlittlekx	Rose Little	8FbuxsfAmEe
755	skingky	Sean King	C6hob7b9Ymm
756	ashawkz	Alan Shaw	KRLzmq6wEkp
757	rcoxl0	Richard Cox	4jDTIq9Y
758	jwatkinsl1	Janet Watkins	9toktkXF4ud
759	rrayl2	Roy Ray	j57Wjm6FN6
760	ajenkinsl3	Anna Jenkins	F9cO3vZLcOv6
761	ksimpsonl4	Kathy Simpson	Ol4LSnIwRQU
762	jjohnsonl5	Jose Johnson	hZydaY
763	dcarpenterl6	Diane Carpenter	N802N68
764	mandersonl7	Maria Anderson	Xti6iy
765	rwoodl8	Roy Wood	f5bHLel9
766	hbakerl9	Henry Baker	OXD4mQOKQR
767	hfullerla	Howard Fuller	BD8uN3
768	wfisherlb	Wanda Fisher	Slkl1h3N
769	csimmonslc	Charles Simmons	EBbAKxqW
770	jandrewsld	James Andrews	Ajvwqs1D
771	rgonzalesle	Robert Gonzales	fg4BTfR6G
772	kcunninghamlf	Kathryn Cunningham	hUeReev6z0
773	bmyerslg	Billy Myers	vxYYik
774	rrodriguezlh	Robin Rodriguez	PONxP5B
775	tmcdonaldli	Tina Mcdonald	nmEM7lXJPZ
776	egrahamlj	Earl Graham	8nbevf2
777	farmstronglk	Frances Armstrong	jpED1ES
778	egrantll	Eric Grant	V8krTpha
779	kbryantlm	Katherine Bryant	JvqtVZL8KakD
780	ajacobsln	Alan Jacobs	kXGqJWMoVQy5
781	gwatkinslo	George Watkins	fcyhbM9r0F
782	fmartinlp	Frances Martin	gHRYj49EVq
783	wsnyderlq	William Snyder	LdbyJ1MQ
784	fgonzaleslr	Fred Gonzales	ObJ1SFnUkEW
785	tporterls	Thomas Porter	9pdLp0z
786	jwilliamsonlt	James Williamson	jDBQEQqMWdD
787	wmorrislu	William Morris	6DbQb0F
788	sgeorgelv	Sara George	VG9t9LDoM
789	cmatthewslw	Carl Matthews	JA5TgOCHl
790	mfreemanlx	Margaret Freeman	o0Nq1fhxMz
791	jramosly	Jacqueline Ramos	F1CtnO9svpMi
792	agibsonlz	Arthur Gibson	eLnZVcSV8p
793	nsimpsonm0	Nicholas Simpson	u2VxFEdGW5
794	hdixonm1	Howard Dixon	yD2zpmtU4Gm
795	jwestm2	Jonathan West	bqkm5RP
796	wlawrencem3	Willie Lawrence	oAzWbr
797	vharrisonm4	Virginia Harrison	7zAVVo5w58c
798	bpricem5	Bobby Price	s56q7YE3Tn
799	bpricem6	Benjamin Price	Sx46pF
800	dvasquezm7	Donald Vasquez	ExmNm9XRYq
801	ghawkinsm8	Gary Hawkins	Txhi6Y
802	krichardsonm9	Kathy Richardson	qJdeqIZHO
803	fgilbertma	Fred Gilbert	vmgJaFe6b
804	ehansenmb	Earl Hansen	XI1YbsUrq
805	svasquezmc	Susan Vasquez	ZCmNZ9
806	clewismd	Christine Lewis	AwiJ2tQFXjk
807	lleeme	Lori Lee	NmgmVbdyUFk
808	wmurphymf	Willie Murphy	aJz45LwPo72
809	rrossmg	Roger Ross	jaj5B75EI
810	ataylormh	Amy Taylor	GW8Mmw3TyR
811	kmoralesmi	Katherine Morales	Vq4SSLVlH
812	elongmj	Eric Long	dSjR2HLy6S
813	bmcdonaldmk	Brandon Mcdonald	egxdacvNZ
814	tbishopml	Theresa Bishop	y3XocX
815	jthomasmm	Justin Thomas	knyjJ03gG64
816	polivermn	Phyllis Oliver	Kx2NpH
817	eburkemo	Evelyn Burke	mZPZ60b
818	shuntermp	Stephen Hunter	Vr3CslVb
819	lhallmq	Laura Hall	i2efui
820	pdavismr	Paul Davis	vLnkBA
821	cparkerms	Clarence Parker	aH8e14EHZ59a
822	ahuntmt	Alan Hunt	ocYTOqt4F
823	dmedinamu	Diana Medina	tmWQo39aYR
824	gpalmermv	Gerald Palmer	zDgZbF1a9
825	cwilsonmw	Clarence Wilson	e6csv0i
826	glittlemx	Gregory Little	Kd5LYhn
827	gcookmy	Gary Cook	mnWxFNn2xG1
828	kharpermz	Katherine Harper	zfdLmZ
829	pramosn0	Patrick Ramos	U4Y9PuYz8sD
830	rhudsonn1	Ryan Hudson	iqVDDfFX
831	jnguyenn2	Joan Nguyen	L87aJLVBoK
832	dweavern3	David Weaver	rlbSkyR4X
833	jmurphyn4	Joseph Murphy	G8ZFaWp5Yo
834	mjordann5	Martha Jordan	P8jIEAp
835	jlongn6	Joan Long	ZNuCM4xfMEu
836	sreedn7	Stephanie Reed	GD0uISqfcO
837	cruizn8	Carl Ruiz	EpnGxvzc
838	fwilsonn9	Fred Wilson	EudKrEx0HA
839	cmedinana	Christine Medina	GKjJXqB
840	jrodrigueznb	Jose Rodriguez	Eg0DHfo73
841	hthompsonnc	Howard Thompson	pwjiWIhU2
842	mharrisnd	Mark Harris	Im3Rl7guBXS
843	jedwardsne	Joyce Edwards	Ft0tmJ
844	npattersonnf	Norma Patterson	hYrLori
845	ngrayng	Nancy Gray	ZzlH8pUuU5
846	rjenkinsnh	Russell Jenkins	zxgrwo
847	bgomezni	Brenda Gomez	zQZKR9
848	rdaynj	Roy Day	FEGT72h
849	rfergusonnk	Robin Ferguson	Y7d8oqf
850	lholmesnl	Lillian Holmes	D92B8mGnlzh
851	smendozanm	Steven Mendoza	N27l6vk
852	ttorresnn	Tammy Torres	waPufdGy
853	dgriffinno	Douglas Griffin	1EcaB6Fv2U
854	rwallacenp	Robert Wallace	hsz76Mnc32b1
855	fleenq	Frank Lee	Ur6vR6d
856	dwardnr	Daniel Ward	sVr5xgMOXgg3
857	jhernandezns	Jack Hernandez	tLZRrD
858	dcolemannt	David Coleman	kPn7cTt
859	tmarshallnu	Todd Marshall	iwdezd6H
860	bmcdonaldnv	Betty Mcdonald	fP2K47Sj1U
861	pharveynw	Pamela Harvey	dFsWCoAUgJKg
862	mrichardsonnx	Michelle Richardson	YQpuGhm91
863	hparkerny	Heather Parker	PZ37IX1
864	msimpsonnz	Mildred Simpson	Bx3B5DavWJ
865	halleno0	Henry Allen	6lLRrSA
866	smorrisono1	Sarah Morrison	CmByLKD
867	dspencero2	Donna Spencer	PDfJ1ErpC
868	estewarto3	Evelyn Stewart	XgnYaDRo4e
869	rschmidto4	Rachel Schmidt	gsCdTg7a0SXi
870	cmoraleso5	Christine Morales	oMWizk3Q0
871	acruzo6	Antonio Cruz	elVZsf3v0nF
872	sspencero7	Sara Spencer	aPig6A
873	lfraziero8	Larry Frazier	FxPrd11wy
874	tmendozao9	Tammy Mendoza	q0Vwnvp0X
875	fgrahamoa	Frank Graham	kGmM4c
876	rporterob	Rachel Porter	WlL5U2
877	athomasoc	Alice Thomas	kqaBQH
878	rroseod	Ruby Rose	0RlLLwWjXH
879	ewallaceoe	Eric Wallace	0u5un262
880	pfergusonof	Paula Ferguson	dXehRwrN
881	jreedog	Jason Reed	N4oSeXZ5
882	kmorganoh	Kathryn Morgan	G0q3JuSUl0
883	bruizoi	Bruce Ruiz	oF5dNj
884	kperezoj	Karen Perez	1M2bnpBW
885	jmurrayok	Judy Murray	H3SsOc
886	pbradleyol	Phyllis Bradley	iQyODDydQ5cF
887	wbanksom	Willie Banks	SpJ8HqLxscax
888	kriveraon	Kelly Rivera	dCWxKNLe
889	ayoungoo	Anne Young	YLFCie0Xz7i2
890	brichardsonop	Brian Richardson	CCfTwQ
891	rwallaceoq	Russell Wallace	n0vO1uzpxPWW
892	hhicksor	Howard Hicks	ayYR53
893	cwhiteos	Carolyn White	IZSlytB3WRiY
894	tgilbertot	Thomas Gilbert	puCfNyfz
895	dalexanderou	Deborah Alexander	DTQAHw
896	elittleov	Edward Little	9qRgyzdRqj
897	irussellow	Irene Russell	ycllGMrW
898	sscottox	Susan Scott	GPnaSTMz6
899	astoneoy	Anthony Stone	N1hMlFP
900	jreynoldsoz	Joshua Reynolds	y8JBprnNo
901	ncookp0	Nancy Cook	RYi2oO6
902	mwheelerp1	Michael Wheeler	03zoD8D
903	jmoralesp2	Joshua Morales	ZxssCWIh84S
904	smontgomeryp3	Steven Montgomery	dTAqeXjAF4
905	ebowmanp4	Edward Bowman	OBpFf49QUm
906	dsimpsonp5	Daniel Simpson	ftg5iwmM
907	kpattersonp6	Kenneth Patterson	Wuo2oCu
908	nwelchp7	Norma Welch	ZeLwRMYLoG
909	rwatkinsp8	Raymond Watkins	V4Krt5
910	rcolemanp9	Ryan Coleman	tyMtTKkL
911	dmontgomerypa	Debra Montgomery	ksfdal0LO3
912	elittlepb	Evelyn Little	vE0eCj
913	esanchezpc	Eric Sanchez	5TeuKJSS4AT
914	ghuntpd	Gerald Hunt	cjG5FDgx6lS0
915	aleepe	Arthur Lee	v0fUD2HKdj
916	mwoodpf	Mark Wood	7ZxVQad
917	tharperpg	Tina Harper	oLLSp2aS2euW
918	dmorganph	Douglas Morgan	bWyhsYi6Cg
919	dstanleypi	Denise Stanley	GBy5GJsYsQ
920	asimpsonpj	Arthur Simpson	vU4uzJlK6EWE
921	rholmespk	Roger Holmes	PTTbvd
922	mwagnerpl	Marilyn Wagner	or2dfFIrw
923	brichardsonpm	Billy Richardson	a2xsI5XD0r
924	agreenepn	Anne Greene	z2Y3XjsuTav
925	aboydpo	Anne Boyd	r0obDXrnz
926	lhartpp	Lois Hart	1Lpcb6pYHKIl
927	bhillpq	Billy Hill	Kyu0fHFN8b
928	whansenpr	Wanda Hansen	iQwdBW
929	hhenryps	Henry Henry	TWUsDmeI
930	mwagnerpt	Margaret Wagner	uzADAVcqr9m
931	hpricepu	Howard Price	P47szY
932	tgreenpv	Terry Green	oJqL7NWHay
933	cbrookspw	Christopher Brooks	9DP7h7n
934	ajamespx	Arthur James	XebFxdSxfkky
935	bwoodpy	Bobby Wood	VLuEjjCgGo9
936	lalexanderpz	Lisa Alexander	nh904VQjALid
937	pwillisq0	Phyllis Willis	LZMN2R6E
938	chansenq1	Christina Hansen	csU12P2i
939	anicholsq2	Amanda Nichols	mKITmhapE
940	jrobertsq3	Jose Roberts	SpxgkNs
941	pwestq4	Patricia West	Sp47tNBfjgQe
942	pgeorgeq5	Phyllis George	YnstlYa
943	ccastilloq6	Christine Castillo	EVAu0njk
944	twatkinsq7	Thomas Watkins	avZ1H3OEN
945	lryanq8	Lori Ryan	2HPDvR3IGrh
946	bholmesq9	Brenda Holmes	Htutc9g85CRe
947	rtuckerqa	Raymond Tucker	u6zKFxK0Sazn
948	wnelsonqb	Wayne Nelson	CU1HfxcrEN
949	aphillipsqc	Annie Phillips	Iiq8mq
950	ghallqd	Gloria Hall	IkhNx9Pg
951	pfloresqe	Paula Flores	j3aTof
952	apriceqf	Antonio Price	EgJxtrWJ
953	cjonesqg	Christina Jones	oHadgUbG
954	rallenqh	Ronald Allen	gWns6tQ
955	echavezqi	Eugene Chavez	QwB8USP
956	emillerqj	Earl Miller	ZuSkNWom
957	kwilliamsqk	Kathy Williams	VpD3HHq
958	jrussellql	Joseph Russell	i7wZyBqvHRaE
959	rarmstrongqm	Roy Armstrong	tgKykGTf
960	agarzaqn	Alan Garza	Yr950MO7Pen4
961	rjohnsonqo	Rose Johnson	3v6mW01wU91q
962	jparkerqp	Jonathan Parker	XmU4eh4vMIm
963	lfordqq	Lois Ford	zrm6u9eWM
964	rreidqr	Ruby Reid	4XqAQLqo
965	ecoxqs	Edward Cox	PVaVQG
966	cstevensqt	Clarence Stevens	8klp5ju1a
967	jrichardsonqu	Johnny Richardson	9Ai4jHgwYh
968	jmartinqv	Juan Martin	SPu4QodNNh
969	amorenoqw	Andrew Moreno	nyffMt72zit8
970	fharperqx	Fred Harper	tBkTPM
971	jhenryqy	Janet Henry	0qgWCtq8v
972	cthompsonqz	Clarence Thompson	pk18NNUdT7
973	ahillr0	Annie Hill	oE6H3pEO89
974	abarnesr1	Anna Barnes	npAhfJp7kjOY
975	shernandezr2	Sean Hernandez	4Gegv1
976	syoungr3	Stephen Young	uvwAZGta
977	awoodr4	Amanda Wood	oB7LkA
978	rbutlerr5	Ryan Butler	53E4ya
979	apattersonr6	Antonio Patterson	M2dtkwlf4
980	bmcdonaldr7	Billy Mcdonald	JQNJbnXFpSuP
981	jgarzar8	Jacqueline Garza	jI7Yy7M
982	srussellr9	Steven Russell	jutLHM
983	jchavezra	Jason Chavez	8ETaoG
984	jharveyrb	Jose Harvey	siiJEZG
985	brossrc	Brandon Ross	TeZRsPznqYp
986	abutlerrd	Ann Butler	LSobvLlB
987	dgarciare	Debra Garcia	Sag4Zu0
988	sthompsonrf	Sean Thompson	YICULD
989	ssanchezrg	Sean Sanchez	IjmgYkU3N
990	rstephensrh	Ronald Stephens	Sh2c7RAwOBE
991	ahawkinsri	Adam Hawkins	ktGanV5X
992	drussellrj	Denise Russell	JDKZnFe5
993	jgreenrk	James Green	e0QoyC
994	whowardrl	Wanda Howard	zkgqxWFeckbk
995	crogersrm	Craig Rogers	n4HvJMKvjMj2
996	rwalkerrn	Randy Walker	bkG92XhiLZ7S
997	rharrisonro	Robert Harrison	mG658YlxXRk
998	rfordrp	Raymond Ford	gF0E482rgL
999	charveyrq	Carl Harvey	oeSMOzhoG2z
1000	dfowlerrr	Denise Fowler	Cb4IVeI
\.


--
-- Name: users_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('users_uid_seq', 1000, true);


--
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM pgsql;
GRANT ALL ON SCHEMA public TO pgsql;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

