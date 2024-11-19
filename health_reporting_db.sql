--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Homebrew)
-- Dumped by pg_dump version 14.14 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    cname character varying(50) NOT NULL,
    population bigint
);


ALTER TABLE public.country OWNER TO postgres;

--
-- Name: discover; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discover (
    cname character varying(50),
    disease_code character varying(50),
    first_enc_date date
);


ALTER TABLE public.discover OWNER TO postgres;

--
-- Name: disease; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.disease (
    disease_code character varying(50) NOT NULL,
    pathogen character varying(20),
    description character varying(140),
    id integer
);


ALTER TABLE public.disease OWNER TO postgres;

--
-- Name: diseasetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.diseasetype (
    id integer NOT NULL,
    description character varying(140)
);


ALTER TABLE public.diseasetype OWNER TO postgres;

--
-- Name: diseasetype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.diseasetype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.diseasetype_id_seq OWNER TO postgres;

--
-- Name: diseasetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.diseasetype_id_seq OWNED BY public.diseasetype.id;


--
-- Name: doctor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctor (
    email character varying(60) NOT NULL,
    degree character varying(20)
);


ALTER TABLE public.doctor OWNER TO postgres;

--
-- Name: patientdisease; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patientdisease (
    email character varying(60),
    disease_code character varying(50)
);


ALTER TABLE public.patientdisease OWNER TO postgres;

--
-- Name: patients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patients (
    email character varying(60)
);


ALTER TABLE public.patients OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    email character varying(60) NOT NULL,
    name character varying(30),
    surname character varying(40),
    salary integer,
    phone character varying(20),
    cname character varying(50) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: patientdiseases; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.patientdiseases AS
 SELECT users.name,
    users.surname,
    disease.description
   FROM (((public.users
     JOIN public.patients ON (((users.email)::text = (patients.email)::text)))
     JOIN public.patientdisease ON (((patients.email)::text = (patientdisease.email)::text)))
     JOIN public.disease ON (((patientdisease.disease_code)::text = (disease.disease_code)::text)));


ALTER TABLE public.patientdiseases OWNER TO postgres;

--
-- Name: publicservant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publicservant (
    email character varying(60) NOT NULL,
    department character varying(50)
);


ALTER TABLE public.publicservant OWNER TO postgres;

--
-- Name: record; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.record (
    email character varying(60),
    cname character varying(50),
    disease_code character varying(50),
    total_deaths integer,
    total_patients integer
);


ALTER TABLE public.record OWNER TO postgres;

--
-- Name: specialize; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.specialize (
    id integer,
    email character varying(60)
);


ALTER TABLE public.specialize OWNER TO postgres;

--
-- Name: diseasetype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diseasetype ALTER COLUMN id SET DEFAULT nextval('public.diseasetype_id_seq'::regclass);


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.country (cname, population) FROM stdin;
Kazakhstan	19000000
USA	331000000
Canada	38000000
Germany	83000000
France	67000000
Japan	126000000
Brazil	213000000
Australia	25600000
India	1390000000
Russia	144000000
South Africa	59300000
\.


--
-- Data for Name: discover; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discover (cname, disease_code, first_enc_date) FROM stdin;
Kazakhstan	COVID-19	2019-11-17
Kazakhstan	TB	1990-06-15
Kazakhstan	FLU	2005-10-10
Kazakhstan	HIV	1981-06-05
Kazakhstan	MALARIA	1970-03-12
Kazakhstan	ASTHMA	1995-03-15
Kazakhstan	DIABETES	1992-02-02
Kazakhstan	ANEMIA	1950-08-15
Kazakhstan	OBESITY	2000-04-10
Kazakhstan	ALZHEIMER	2008-11-03
\.


--
-- Data for Name: disease; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.disease (disease_code, pathogen, description, id) FROM stdin;
COVID-19	virus	Coronavirus disease	1
FLU	virus	Influenza	1
TB	bacteria	Tuberculosis	1
HIV	virus	Human Immunodeficiency Virus	1
MALARIA	parasite	Malaria infection	1
DIABETES	N/A	Diabetes mellitus	2
ASTHMA	N/A	Chronic respiratory condition	9
ALZHEIMER	N/A	Neurodegenerative disorder	8
ANEMIA	N/A	Blood disorder	7
OBESITY	N/A	Excessive body weight	2
\.


--
-- Data for Name: diseasetype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.diseasetype (id, description) FROM stdin;
1	Infectious diseases
2	Chronic diseases
3	Genetic disorders
4	Nutritional deficiencies
5	Mental health disorders
6	Skin diseases
7	Blood disorders
8	Neurological disorders
9	Respiratory diseases
10	Musculoskeletal disorders
11	Virology
\.


--
-- Data for Name: doctor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctor (email, degree) FROM stdin;
aigerim@nu.edu.kz	MD
bolat@nu.edu.kz	PhD
daulet@nu.edu.kz	MD
gulnur@nu.edu.kz	MD
yerzhan@nu.edu.kz	PhD
ainur@nu.edu.kz	MD
bakytzhan@nu.edu.kz	PhD
zhanar@nu.edu.kz	PhD
meirzhan@nu.edu.kz	MD
saltanat@nu.edu.kz	PhD
\.


--
-- Data for Name: patientdisease; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patientdisease (email, disease_code) FROM stdin;
aigerim@nu.edu.kz	COVID-19
bolat@nu.edu.kz	DIABETES
daulet@nu.edu.kz	ASTHMA
yerzhan@nu.edu.kz	ANEMIA
ainur@nu.edu.kz	TB
bakytzhan@nu.edu.kz	HIV
zhanar@nu.edu.kz	FLU
meirzhan@nu.edu.kz	MALARIA
saltanat@nu.edu.kz	OBESITY
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patients (email) FROM stdin;
aigerim@nu.edu.kz
bolat@nu.edu.kz
daulet@nu.edu.kz
yerzhan@nu.edu.kz
ainur@nu.edu.kz
bakytzhan@nu.edu.kz
zhanar@nu.edu.kz
meirzhan@nu.edu.kz
saltanat@nu.edu.kz
\.


--
-- Data for Name: publicservant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publicservant (email, department) FROM stdin;
yerzhan@nu.edu.kz	Health Department
ainur@nu.edu.kz	Public Safety
bakytzhan@nu.edu.kz	Community Health
zhanar@nu.edu.kz	Disease Control
meirzhan@nu.edu.kz	Epidemiology
saltanat@nu.edu.kz	Infectious Diseases
aigerim@nu.edu.kz	General Medicine
bolat@nu.edu.kz	Chronic Illnesses
daulet@nu.edu.kz	Research and Development
gulnur@nu.edu.kz	Environmental Health
\.


--
-- Data for Name: record; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.record (email, cname, disease_code, total_deaths, total_patients) FROM stdin;
yerzhan@nu.edu.kz	Kazakhstan	COVID-19	500	10000
ainur@nu.edu.kz	Kazakhstan	COVID-19	1000	50000
bakytzhan@nu.edu.kz	Kazakhstan	MALARIA	200	2000
zhanar@nu.edu.kz	Kazakhstan	TB	50	3000
meirzhan@nu.edu.kz	Kazakhstan	FLU	30	10000
saltanat@nu.edu.kz	Kazakhstan	HIV	120	4000
aigerim@nu.edu.kz	Kazakhstan	ASTHMA	15	500
bolat@nu.edu.kz	Kazakhstan	DIABETES	70	7000
daulet@nu.edu.kz	Kazakhstan	ALZHEIMER	60	600
gulnur@nu.edu.kz	Kazakhstan	ANEMIA	80	8000
yerzhan@nu.edu.kz	Kazakhstan	COVID-19	500	10000
yerzhan@nu.edu.kz	USA	COVID-19	300	8000
ainur@nu.edu.kz	Kazakhstan	COVID-19	1000	50000
ainur@nu.edu.kz	India	COVID-19	200	4000
bakytzhan@nu.edu.kz	Kazakhstan	COVID-19	150	2000
bakytzhan@nu.edu.kz	Germany	COVID-19	100	3000
\.


--
-- Data for Name: specialize; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.specialize (id, email) FROM stdin;
1	aigerim@nu.edu.kz
2	aigerim@nu.edu.kz
3	aigerim@nu.edu.kz
4	daulet@nu.edu.kz
5	daulet@nu.edu.kz
6	daulet@nu.edu.kz
7	bakytzhan@nu.edu.kz
8	zhanar@nu.edu.kz
9	meirzhan@nu.edu.kz
10	saltanat@nu.edu.kz
11	aigerim@nu.edu.kz
11	bolat@nu.edu.kz
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (email, name, surname, salary, phone, cname) FROM stdin;
zhanar@nu.edu.kz	Zhanar	Yesimova	54000	8777-890-1234	Canada
meirzhan@nu.edu.kz	Meirzhan	Tursynbekov	59000	8777-901-2345	Germany
saltanat@nu.edu.kz	Saltanat	Nurgaliyeva	63000	8777-012-3456	France
bolat@nu.edu.kz	Bolat	Nurlybekov	50000	8777-234-5678	Brazil
aigerim@nu.edu.kz	Aigerim	Zhanibekova	70000	8777-123-4567	Australia
sandugashburambekova@gmail.com	Sandugash	Burambekova	70000	\N	South Africa
bakytzhan@nu.edu.kz	Bakytzhan	Orynbayev	16000	8777-789-0123	Japan
yerzhan@nu.edu.kz	Yerzhan	Sultanov	16000	8777-567-8901	Russia
valeriy.krysov6@gmail.com	Valeriy	Krysov	1000	\N	Kazakhstan
daulet@nu.edu.kz	Daulet	Kairatuly	10000	8777-345-6789	USA
\.


--
-- Name: diseasetype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.diseasetype_id_seq', 11, true);


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (cname);


--
-- Name: disease disease_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disease
    ADD CONSTRAINT disease_pkey PRIMARY KEY (disease_code);


--
-- Name: diseasetype diseasetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diseasetype
    ADD CONSTRAINT diseasetype_pkey PRIMARY KEY (id);


--
-- Name: doctor doctor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (email);


--
-- Name: publicservant publicservant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publicservant
    ADD CONSTRAINT publicservant_pkey PRIMARY KEY (email);


--
-- Name: users users_email_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_pk PRIMARY KEY (email);


--
-- Name: idx_disease_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_disease_code ON public.disease USING btree (disease_code);


--
-- Name: idx_disease_disease_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_disease_disease_code ON public.disease USING btree (disease_code);


--
-- Name: discover discover_cname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discover
    ADD CONSTRAINT discover_cname_fkey FOREIGN KEY (cname) REFERENCES public.country(cname);


--
-- Name: discover discover_disease_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discover
    ADD CONSTRAINT discover_disease_code_fkey FOREIGN KEY (disease_code) REFERENCES public.disease(disease_code);


--
-- Name: disease disease_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disease
    ADD CONSTRAINT disease_id_fkey FOREIGN KEY (id) REFERENCES public.diseasetype(id);


--
-- Name: patientdisease patientdisease_disease_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patientdisease
    ADD CONSTRAINT patientdisease_disease_code_fkey FOREIGN KEY (disease_code) REFERENCES public.disease(disease_code);


--
-- Name: record record_cname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_cname_fkey FOREIGN KEY (cname) REFERENCES public.country(cname);


--
-- Name: record record_disease_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_disease_code_fkey FOREIGN KEY (disease_code) REFERENCES public.disease(disease_code);


--
-- Name: record record_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_email_fkey FOREIGN KEY (email) REFERENCES public.publicservant(email);


--
-- Name: specialize specialize_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialize
    ADD CONSTRAINT specialize_email_fkey FOREIGN KEY (email) REFERENCES public.doctor(email);


--
-- Name: specialize specialize_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialize
    ADD CONSTRAINT specialize_id_fkey FOREIGN KEY (id) REFERENCES public.diseasetype(id);


--
-- Name: users users_cname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_cname_fkey FOREIGN KEY (cname) REFERENCES public.country(cname) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

