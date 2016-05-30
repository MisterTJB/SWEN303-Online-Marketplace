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

CREATE TABLE product_complaints (
    cid SERIAL,
    pid integer,
    username character varying(50),
    complaint text,
    reviewed boolean DEFAULT false
);

CREATE TABLE user_complaints (
    cid SERIAL,
    complainant character varying(50),
    username character varying(50),
    complaint text,
    reviewed boolean DEFAULT false
);

CREATE TABLE permitted_categories(
    cid SERIAL,
    category ltree
);

INSERT INTO permitted_categories(category) VALUES ('Electronics.Photography.Cameras');
INSERT INTO permitted_categories(category) VALUES ('Clothes.Headwear.Hats');
INSERT INTO permitted_categories(category) VALUES ('Animals.Birds.Birds_of_Prey');
INSERT INTO permitted_categories(category) VALUES ('Animals.Birds.Flightless');
INSERT INTO permitted_categories(category) VALUES ('Games.Board_Games.Childrens');
INSERT INTO permitted_categories(category) VALUES ('Games.Board_Games.Evil');
INSERT INTO permitted_categories(category) VALUES ('Artefacts.Religious');

--
-- Name: stock; Type: TABLE; Schema: public; Owner: -; Tablespace:
--
CREATE TYPE listing_status AS ENUM ('pending', 'unsuccessful', 'listed', 'sold', 'deleted');
CREATE TABLE stock (
    sid SERIAL,
    uid integer,
    label text,
    description text,
    price numeric(10,2),
    quantity integer,
    category ltree,
    status listing_status DEFAULT 'pending',
    votes integer DEFAULT 0,
    voters text[] DEFAULT ARRAY[]::text[],
    selling_at_list boolean DEFAULT true,
    valuations numeric(10,2)[] DEFAULT ARRAY[]::numeric(10,2)[],
    valuers text[] DEFAULT ARRAY[]::text[]
);

CREATE TABLE site_parameters (
    parameter text,
    value integer
);

INSERT INTO site_parameters VALUES ('PRODUCTS_IN_QUEUE', 10);
INSERT INTO site_parameters VALUES ('VOTES_REQUIRED', 3);
INSERT INTO site_parameters VALUES ('VALUATIONS_REQUIRED', 3);
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
    tid SERIAL,
    uid integer,
    products integer[]
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

INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters, selling_at_list, valuations, valuers) VALUES (1,'Camera','Description', 12.90,3,'Electronics.Photography.Cameras', 'pending', 3, ARRAY['admin', 'j0nny', 'james'], true, ARRAY[]::numeric(10,2)[], ARRAY[]::text[]);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters, selling_at_list, valuations, valuers) VALUES (3,	'Hat','Description',	30.00, 1,   'Clothes.Headwear.Hats', 'unsuccessful', 2, ARRAY['admin', 'j0nny'], true, ARRAY[]::numeric(10,2)[], ARRAY[]::text[]);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters, selling_at_list, valuations, valuers) VALUES (9,	'Bald Eagle','Description',	999.99,	10,  'Animals.Birds.Birds_of_Prey', 'pending', 2, ARRAY['admin', 'j0nny'], true, ARRAY[]::numeric(10,2)[], ARRAY[]::text[]);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters, selling_at_list, valuations, valuers) VALUES (2,	'Kiwi', 'Description', 49999.99,	3,   'Animals.Birds.Flightless', 'sold', 3, ARRAY['admin', 'j0nny', 'james'], true, ARRAY[]::numeric(10,2)[], ARRAY[]::text[]);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters, selling_at_list, valuations, valuers) VALUES (2,	'Snakes and Ladders','Description',	1.0000,	1,   'Games.Board_Games.Childrens', 'sold', 3, ARRAY['admin', 'j0nny', 'james'], true, ARRAY[]::numeric(10,2)[], ARRAY[]::text[]);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters, selling_at_list, valuations, valuers) VALUES (3,	'Monopoly',	'Description', 3.00,	1,   'Games.Board_Games.Evil', 'sold', 3, ARRAY['admin', 'j0nny', 'james'], true, ARRAY[]::numeric(10,2)[], ARRAY[]::text[]);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters, selling_at_list, valuations, valuers) VALUES (3,	'Holy Grail',	'Description',0.99,	1,   'Artefacts.Religious', 'listed', 3, ARRAY['admin', 'j0nny', 'james'], true, ARRAY[1.00, 3.00], ARRAY['admin', 'j0nny']);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters, selling_at_list, valuations, valuers) VALUES (5,	'Meaning of Life',	'Description',42.00,	20,  'Truths.Existential', 'listed', 3, ARRAY['admin', 'j0nny', 'james'], true, ARRAY[3, 5], ARRAY['admin', 'tim']);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters, selling_at_list, valuations, valuers) VALUES (5,	'Cactus',	'Description',9.99,	3,   'Plants.Succulent.Evil.Prickly', 'listed', 3, ARRAY['admin', 'j0nny', 'james'], true, ARRAY[3, 5], ARRAY['admin', 'tim']);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters, selling_at_list, valuations, valuers) VALUES (5,	'Iris',	'Description',9.99,	15,  'Plants.Perennial', 'listed', 3, ARRAY['admin', 'j0nny', 'james'], true, ARRAY[3, 5], ARRAY['admin', 'tim']);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters, selling_at_list, valuations, valuers) VALUES (6,	'Knives',	'Description',15.50,	4,   'Homeware.Kitchen.Preparation.Sharp', 'listed', 3, ARRAY['admin', 'j0nny', 'james'], true, ARRAY[3, 5], ARRAY['admin', 'tim']);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters, selling_at_list, valuations, valuers) VALUES (6,	'Sword',	'Description',49.97,	8,  'Weaponry.Sharp', 'listed', 3, ARRAY['admin', 'j0nny', 'james'], true, ARRAY[3, 5], ARRAY['admin', 'tim']);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters, selling_at_list, valuations, valuers) VALUES (7,	'Kryptonite',	'Description',0.50,	100, 'Weaponry.Superhero_Specific.Superman', 'listed', 3, ARRAY['admin', 'j0nny', 'james'], true, ARRAY[3, 5], ARRAY['admin', 'tim']);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters, selling_at_list, valuations, valuers) VALUES (7,	'S Clothing Patch',	'Description',5.99,	1000,    'Clothes.Patches', 'listed', 3, ARRAY['admin', 'j0nny', 'james'], true, ARRAY[3, 5], ARRAY['admin', 'tim']);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters, selling_at_list, valuations, valuers) VALUES (8,	'Table',	'Description',10.00,	1,   'Homeware.Office.Tables', 'listed', 3, ARRAY['admin', 'j0nny', 'james'], true, ARRAY[3, 5], ARRAY['admin', 'tim']);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (9,	'Small Chair',	'Description',5.00,	1,   'Homeware.Office.Chairs', 'pending', 2, ARRAY['admin', 'j0nny']);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (9,'Coffee', 'Description',4.99,	10,  'Drugs.Stimulants.Caffeine', 'pending', 2, ARRAY['admin', 'j0nny']);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (9,'Muffin', 'Description',3.50,	10,  'Food.Baking', 'pending', 2, ARRAY['admin', 'j0nny']);
INSERT INTO stock(uid, label, description, price, quantity, category, status, votes, voters) VALUES (9,	'99 Problems',	'I have too many problems; buy them off of me',5.00,	1,   'Truths.Existential', 'pending', 2, ARRAY['grod', 'nicky']);



----
---- Name: stock_sid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
----
--
--SELECT pg_catalog.setval('stock_sid_seq', 19, true);





--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY users (uid, username, realname, password) FROM stdin;
1	admin	Sally Smith	1337
2	tim	Tim bathgate	tim
3	nicky	Nicky Van Hulst	nicky
4	zoo	Monty Python	dinosaur
5	qwerty	Zoe Curtis	purple
6	j0nnny	Thea Queen	something
7	james	Kara Danvers	secure
8	Cam	Camile Jones	12345
9	grod	Cameron Smith	dfgh
\.


--
-- Name: users_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('users_uid_seq', 9, true);


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
