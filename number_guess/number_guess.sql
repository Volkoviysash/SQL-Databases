--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(22) NOT NULL,
    games_played integer DEFAULT 0 NOT NULL,
    best_game integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (2, 'user_1681816154210', 0, 0);
INSERT INTO public.users VALUES (3, 'user_1681816154209', 0, 0);
INSERT INTO public.users VALUES (4, 'user_1681816320355', 0, 0);
INSERT INTO public.users VALUES (5, 'user_1681816320354', 0, 0);
INSERT INTO public.users VALUES (7, 'user_1681816601874', 2, 0);
INSERT INTO public.users VALUES (6, 'user_1681816601875', 5, 0);
INSERT INTO public.users VALUES (25, 'user_1681817642711', 2, 261);
INSERT INTO public.users VALUES (9, 'user_1681816627760', 2, 0);
INSERT INTO public.users VALUES (8, 'user_1681816627761', 5, 0);
INSERT INTO public.users VALUES (24, 'user_1681817642712', 5, 123);
INSERT INTO public.users VALUES (11, 'user_1681816762377', 2, 0);
INSERT INTO public.users VALUES (10, 'user_1681816762378', 5, 0);
INSERT INTO public.users VALUES (13, 'user_1681816870078', 2, 0);
INSERT INTO public.users VALUES (12, 'user_1681816870079', 5, 0);
INSERT INTO public.users VALUES (14, 'user_1681817033464', 0, 0);
INSERT INTO public.users VALUES (15, 'user_1681817033463', 0, 0);
INSERT INTO public.users VALUES (27, 'user_1681817649172', 2, 98);
INSERT INTO public.users VALUES (1, 'Alex', 2, 4);
INSERT INTO public.users VALUES (26, 'user_1681817649173', 5, 17);
INSERT INTO public.users VALUES (17, 'user_1681817541415', 2, 269);
INSERT INTO public.users VALUES (16, 'user_1681817541416', 5, 61);
INSERT INTO public.users VALUES (29, 'user_1681817655406', 2, 411);
INSERT INTO public.users VALUES (28, 'user_1681817655407', 4, 272);
INSERT INTO public.users VALUES (19, 'user_1681817587583', 2, 236);
INSERT INTO public.users VALUES (18, 'user_1681817587584', 5, 93);
INSERT INTO public.users VALUES (21, 'user_1681817603420', 2, 602);
INSERT INTO public.users VALUES (20, 'user_1681817603421', 4, 63);
INSERT INTO public.users VALUES (23, 'user_1681817625991', 2, 267);
INSERT INTO public.users VALUES (22, 'user_1681817625992', 5, 63);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 29, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- PostgreSQL database dump complete
--

