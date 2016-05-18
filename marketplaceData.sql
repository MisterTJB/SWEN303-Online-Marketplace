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

CREATE ROLE SWEN303 PASSWORD 'SWEN303' SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


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

CREATE TABLE stock (
    sid integer NOT NULL,
    uid integer,
    label character varying(100),
    price numeric(10,4),
    quantity integer
);


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

COPY stock (sid, uid, label, price, quantity) FROM stdin;
1	1	Camera	12.9000	3
2	1	Hat	30.0000	1
3	2	Bald Eagle	999.9900	10
4	2	Kiwi	49999.9900	3
5	3	Snakes and Ladders	1.0000	1
6	3	Monopoly	3.0000	1
7	4	Holy Grail	0.9900	1
8	5	Meaning of Life	42.0000	20
9	5	Cactus	9.9900	3
10	5	Iris	9.9900	15
11	6	Knives	15.5000	4
12	6	Sword	49.9700	8
13	7	Kryptonite	0.5000	100
14	7	S Clothing Patch	5.9900	1000
15	8	Table	10.0000	1
16	9	Small Chair	5.0000	1
17	10	Coffee	4.9900	10
18	10	Muffin	3.5000	10
\.


--
-- Name: stock_sid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('stock_sid_seq', 18, true);


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

