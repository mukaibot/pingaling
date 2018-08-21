--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5 (Ubuntu 10.5-0ubuntu0.18.04)
-- Dumped by pg_dump version 10.5 (Ubuntu 10.5-0ubuntu0.18.04)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: check_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.check_type AS ENUM (
    'endpoint',
    'cron'
);


--
-- Name: health_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.health_status AS ENUM (
    'pending',
    'healthy',
    'unhealthy'
);


--
-- Name: incident_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.incident_status AS ENUM (
    'open',
    'closed',
    'resolved',
    'auto_resolved'
);


--
-- Name: notification_channel_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.notification_channel_type AS ENUM (
    'slack',
    'pagerduty'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: endpoints; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.endpoints (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    description text,
    next_check timestamp with time zone,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    "interval" integer DEFAULT 30,
    retries integer DEFAULT 2,
    CONSTRAINT interval_must_be_positive CHECK (("interval" > 0)),
    CONSTRAINT retries_must_be_positive CHECK ((retries >= 0))
);


--
-- Name: endpoints_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.endpoints_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: endpoints_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.endpoints_id_seq OWNED BY public.endpoints.id;


--
-- Name: health_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.health_statuses (
    id bigint NOT NULL,
    status public.health_status NOT NULL,
    type public.check_type NOT NULL,
    endpoint_id bigint NOT NULL,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: health_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.health_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: health_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.health_statuses_id_seq OWNED BY public.health_statuses.id;


--
-- Name: incidents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.incidents (
    id bigint NOT NULL,
    endpoint_id bigint NOT NULL,
    status public.incident_status NOT NULL,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.incidents_id_seq OWNED BY public.incidents.id;


--
-- Name: notification_channels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification_channels (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    type public.notification_channel_type NOT NULL,
    data jsonb NOT NULL,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    description character varying(255)
);


--
-- Name: notification_channels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notification_channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notification_channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notification_channels_id_seq OWNED BY public.notification_channels.id;


--
-- Name: notification_policies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification_policies (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    endpoint_id bigint NOT NULL,
    channel_id bigint NOT NULL,
    limit_sending boolean DEFAULT false,
    monday_start timestamp without time zone,
    monday_end timestamp without time zone,
    tuesday_start timestamp without time zone,
    tuesday_end timestamp without time zone,
    wednesday_start timestamp without time zone,
    wednesday_end timestamp without time zone,
    thursday_start timestamp without time zone,
    thursday_end timestamp without time zone,
    friday_start timestamp without time zone,
    friday_end timestamp without time zone,
    saturday_start timestamp without time zone,
    saturday_end timestamp without time zone,
    sunday_start timestamp without time zone,
    sunday_end timestamp without time zone
);


--
-- Name: notification_policies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notification_policies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notification_policies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notification_policies_id_seq OWNED BY public.notification_policies.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


--
-- Name: endpoints id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.endpoints ALTER COLUMN id SET DEFAULT nextval('public.endpoints_id_seq'::regclass);


--
-- Name: health_statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.health_statuses ALTER COLUMN id SET DEFAULT nextval('public.health_statuses_id_seq'::regclass);


--
-- Name: incidents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incidents ALTER COLUMN id SET DEFAULT nextval('public.incidents_id_seq'::regclass);


--
-- Name: notification_channels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_channels ALTER COLUMN id SET DEFAULT nextval('public.notification_channels_id_seq'::regclass);


--
-- Name: notification_policies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_policies ALTER COLUMN id SET DEFAULT nextval('public.notification_policies_id_seq'::regclass);


--
-- Name: endpoints endpoints_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.endpoints
    ADD CONSTRAINT endpoints_pkey PRIMARY KEY (id);


--
-- Name: health_statuses health_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.health_statuses
    ADD CONSTRAINT health_statuses_pkey PRIMARY KEY (id);


--
-- Name: incidents incidents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: notification_channels notification_channels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_channels
    ADD CONSTRAINT notification_channels_pkey PRIMARY KEY (id);


--
-- Name: notification_policies notification_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_policies
    ADD CONSTRAINT notification_policies_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: endpoints_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX endpoints_name_index ON public.endpoints USING btree (name);


--
-- Name: health_statuses health_statuses_endpoint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.health_statuses
    ADD CONSTRAINT health_statuses_endpoint_id_fkey FOREIGN KEY (endpoint_id) REFERENCES public.endpoints(id) ON DELETE CASCADE;


--
-- Name: incidents incidents_endpoint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incidents
    ADD CONSTRAINT incidents_endpoint_id_fkey FOREIGN KEY (endpoint_id) REFERENCES public.endpoints(id);


--
-- Name: notification_policies notification_policies_channel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_policies
    ADD CONSTRAINT notification_policies_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES public.notification_channels(id);


--
-- Name: notification_policies notification_policies_endpoint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_policies
    ADD CONSTRAINT notification_policies_endpoint_id_fkey FOREIGN KEY (endpoint_id) REFERENCES public.endpoints(id);


--
-- PostgreSQL database dump complete
--

INSERT INTO public."schema_migrations" (version) VALUES (20180723201002), (20180811061147), (20180814105520), (20180815073448), (20180815101537), (20180815101641), (20180817043833), (20180819003041), (20180819104324), (20180820105743);

