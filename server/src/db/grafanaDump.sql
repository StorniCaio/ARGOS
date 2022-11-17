--
-- PostgreSQL database dump
--

-- Dumped from database version 12.10 (Debian 12.10-1.pgdg110+1)
-- Dumped by pg_dump version 12.10 (Debian 12.10-1.pgdg110+1)

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
-- Name: alert; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.alert (
    id integer NOT NULL,
    version bigint NOT NULL,
    dashboard_id bigint NOT NULL,
    panel_id bigint NOT NULL,
    org_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    message text NOT NULL,
    state character varying(190) NOT NULL,
    settings text NOT NULL,
    frequency bigint NOT NULL,
    handler bigint NOT NULL,
    severity text NOT NULL,
    silenced boolean NOT NULL,
    execution_error text NOT NULL,
    eval_data text,
    eval_date timestamp without time zone,
    new_state_date timestamp without time zone NOT NULL,
    state_changes integer NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    "for" bigint
);


ALTER TABLE public.alert OWNER TO grafana_user;

--
-- Name: alert_configuration; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.alert_configuration (
    id integer NOT NULL,
    alertmanager_configuration text NOT NULL,
    configuration_version character varying(3) NOT NULL,
    created_at integer NOT NULL,
    "default" boolean DEFAULT false NOT NULL,
    org_id bigint DEFAULT 0 NOT NULL,
    configuration_hash character varying(32) DEFAULT 'not-yet-calculated'::character varying NOT NULL
);


ALTER TABLE public.alert_configuration OWNER TO grafana_user;

--
-- Name: alert_configuration_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.alert_configuration_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_configuration_id_seq OWNER TO grafana_user;

--
-- Name: alert_configuration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.alert_configuration_id_seq OWNED BY public.alert_configuration.id;


--
-- Name: alert_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.alert_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_id_seq OWNER TO grafana_user;

--
-- Name: alert_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.alert_id_seq OWNED BY public.alert.id;


--
-- Name: alert_image; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.alert_image (
    id integer NOT NULL,
    token character varying(190) NOT NULL,
    path character varying(190) NOT NULL,
    url character varying(2048) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    expires_at timestamp without time zone NOT NULL
);


ALTER TABLE public.alert_image OWNER TO grafana_user;

--
-- Name: alert_image_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.alert_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_image_id_seq OWNER TO grafana_user;

--
-- Name: alert_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.alert_image_id_seq OWNED BY public.alert_image.id;


--
-- Name: alert_instance; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.alert_instance (
    rule_org_id bigint NOT NULL,
    rule_uid character varying(40) DEFAULT 0 NOT NULL,
    labels text NOT NULL,
    labels_hash character varying(190) NOT NULL,
    current_state character varying(190) NOT NULL,
    current_state_since bigint NOT NULL,
    last_eval_time bigint NOT NULL,
    current_state_end bigint DEFAULT 0 NOT NULL,
    current_reason character varying(190)
);


ALTER TABLE public.alert_instance OWNER TO grafana_user;

--
-- Name: alert_notification; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.alert_notification (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    name character varying(190) NOT NULL,
    type character varying(255) NOT NULL,
    settings text NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    frequency bigint,
    send_reminder boolean DEFAULT false,
    disable_resolve_message boolean DEFAULT false NOT NULL,
    uid character varying(40),
    secure_settings text
);


ALTER TABLE public.alert_notification OWNER TO grafana_user;

--
-- Name: alert_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.alert_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_notification_id_seq OWNER TO grafana_user;

--
-- Name: alert_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.alert_notification_id_seq OWNED BY public.alert_notification.id;


--
-- Name: alert_notification_state; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.alert_notification_state (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    alert_id bigint NOT NULL,
    notifier_id bigint NOT NULL,
    state character varying(50) NOT NULL,
    version bigint NOT NULL,
    updated_at bigint NOT NULL,
    alert_rule_state_updated_version bigint NOT NULL
);


ALTER TABLE public.alert_notification_state OWNER TO grafana_user;

--
-- Name: alert_notification_state_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.alert_notification_state_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_notification_state_id_seq OWNER TO grafana_user;

--
-- Name: alert_notification_state_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.alert_notification_state_id_seq OWNED BY public.alert_notification_state.id;


--
-- Name: alert_rule; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.alert_rule (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    title character varying(190) NOT NULL,
    condition character varying(190) NOT NULL,
    data text NOT NULL,
    updated timestamp without time zone NOT NULL,
    interval_seconds bigint DEFAULT 60 NOT NULL,
    version integer DEFAULT 0 NOT NULL,
    uid character varying(40) DEFAULT 0 NOT NULL,
    namespace_uid character varying(40) NOT NULL,
    rule_group character varying(190) NOT NULL,
    no_data_state character varying(15) DEFAULT 'NoData'::character varying NOT NULL,
    exec_err_state character varying(15) DEFAULT 'Alerting'::character varying NOT NULL,
    "for" bigint DEFAULT 0 NOT NULL,
    annotations text,
    labels text,
    dashboard_uid character varying(40),
    panel_id bigint,
    rule_group_idx integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.alert_rule OWNER TO grafana_user;

--
-- Name: alert_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.alert_rule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_rule_id_seq OWNER TO grafana_user;

--
-- Name: alert_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.alert_rule_id_seq OWNED BY public.alert_rule.id;


--
-- Name: alert_rule_tag; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.alert_rule_tag (
    id integer NOT NULL,
    alert_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


ALTER TABLE public.alert_rule_tag OWNER TO grafana_user;

--
-- Name: alert_rule_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.alert_rule_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_rule_tag_id_seq OWNER TO grafana_user;

--
-- Name: alert_rule_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.alert_rule_tag_id_seq OWNED BY public.alert_rule_tag.id;


--
-- Name: alert_rule_version; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.alert_rule_version (
    id integer NOT NULL,
    rule_org_id bigint NOT NULL,
    rule_uid character varying(40) DEFAULT 0 NOT NULL,
    rule_namespace_uid character varying(40) NOT NULL,
    rule_group character varying(190) NOT NULL,
    parent_version integer NOT NULL,
    restored_from integer NOT NULL,
    version integer NOT NULL,
    created timestamp without time zone NOT NULL,
    title character varying(190) NOT NULL,
    condition character varying(190) NOT NULL,
    data text NOT NULL,
    interval_seconds bigint NOT NULL,
    no_data_state character varying(15) DEFAULT 'NoData'::character varying NOT NULL,
    exec_err_state character varying(15) DEFAULT 'Alerting'::character varying NOT NULL,
    "for" bigint DEFAULT 0 NOT NULL,
    annotations text,
    labels text,
    rule_group_idx integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.alert_rule_version OWNER TO grafana_user;

--
-- Name: alert_rule_version_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.alert_rule_version_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_rule_version_id_seq OWNER TO grafana_user;

--
-- Name: alert_rule_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.alert_rule_version_id_seq OWNED BY public.alert_rule_version.id;


--
-- Name: annotation; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.annotation (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    alert_id bigint,
    user_id bigint,
    dashboard_id bigint,
    panel_id bigint,
    category_id bigint,
    type character varying(25) NOT NULL,
    title text NOT NULL,
    text text NOT NULL,
    metric character varying(255),
    prev_state character varying(25) NOT NULL,
    new_state character varying(25) NOT NULL,
    data text NOT NULL,
    epoch bigint NOT NULL,
    region_id bigint DEFAULT 0,
    tags character varying(4096),
    created bigint DEFAULT 0,
    updated bigint DEFAULT 0,
    epoch_end bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.annotation OWNER TO grafana_user;

--
-- Name: annotation_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.annotation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.annotation_id_seq OWNER TO grafana_user;

--
-- Name: annotation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.annotation_id_seq OWNED BY public.annotation.id;


--
-- Name: annotation_tag; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.annotation_tag (
    id integer NOT NULL,
    annotation_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


ALTER TABLE public.annotation_tag OWNER TO grafana_user;

--
-- Name: annotation_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.annotation_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.annotation_tag_id_seq OWNER TO grafana_user;

--
-- Name: annotation_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.annotation_tag_id_seq OWNED BY public.annotation_tag.id;


--
-- Name: api_key; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.api_key (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    name character varying(190) NOT NULL,
    key character varying(190) NOT NULL,
    role character varying(255) NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    expires bigint,
    service_account_id bigint,
    last_used_at timestamp without time zone,
    is_revoked boolean DEFAULT false
);


ALTER TABLE public.api_key OWNER TO grafana_user;

--
-- Name: api_key_id_seq1; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.api_key_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_key_id_seq1 OWNER TO grafana_user;

--
-- Name: api_key_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.api_key_id_seq1 OWNED BY public.api_key.id;


--
-- Name: builtin_role; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.builtin_role (
    id integer NOT NULL,
    role character varying(190) NOT NULL,
    role_id bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    org_id bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.builtin_role OWNER TO grafana_user;

--
-- Name: builtin_role_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.builtin_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.builtin_role_id_seq OWNER TO grafana_user;

--
-- Name: builtin_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.builtin_role_id_seq OWNED BY public.builtin_role.id;


--
-- Name: cache_data; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.cache_data (
    cache_key character varying(168) NOT NULL,
    data bytea NOT NULL,
    expires integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.cache_data OWNER TO grafana_user;

--
-- Name: correlation; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.correlation (
    uid character varying(40) NOT NULL,
    source_uid character varying(40) NOT NULL,
    target_uid character varying(40),
    label text NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.correlation OWNER TO grafana_user;

--
-- Name: dashboard; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.dashboard (
    id integer NOT NULL,
    version integer NOT NULL,
    slug character varying(189) NOT NULL,
    title character varying(189) NOT NULL,
    data text NOT NULL,
    org_id bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    updated_by integer,
    created_by integer,
    gnet_id bigint,
    plugin_id character varying(189),
    folder_id bigint DEFAULT 0 NOT NULL,
    is_folder boolean DEFAULT false NOT NULL,
    has_acl boolean DEFAULT false NOT NULL,
    uid character varying(40),
    is_public boolean DEFAULT false NOT NULL
);


ALTER TABLE public.dashboard OWNER TO grafana_user;

--
-- Name: dashboard_acl; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.dashboard_acl (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    dashboard_id bigint NOT NULL,
    user_id bigint,
    team_id bigint,
    permission smallint DEFAULT 4 NOT NULL,
    role character varying(20),
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.dashboard_acl OWNER TO grafana_user;

--
-- Name: dashboard_acl_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.dashboard_acl_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_acl_id_seq OWNER TO grafana_user;

--
-- Name: dashboard_acl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.dashboard_acl_id_seq OWNED BY public.dashboard_acl.id;


--
-- Name: dashboard_id_seq1; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.dashboard_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_id_seq1 OWNER TO grafana_user;

--
-- Name: dashboard_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.dashboard_id_seq1 OWNED BY public.dashboard.id;


--
-- Name: dashboard_provisioning; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.dashboard_provisioning (
    id integer NOT NULL,
    dashboard_id bigint,
    name character varying(150) NOT NULL,
    external_id text NOT NULL,
    updated integer DEFAULT 0 NOT NULL,
    check_sum character varying(32)
);


ALTER TABLE public.dashboard_provisioning OWNER TO grafana_user;

--
-- Name: dashboard_provisioning_id_seq1; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.dashboard_provisioning_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_provisioning_id_seq1 OWNER TO grafana_user;

--
-- Name: dashboard_provisioning_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.dashboard_provisioning_id_seq1 OWNED BY public.dashboard_provisioning.id;


--
-- Name: dashboard_public; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.dashboard_public (
    uid character varying(40) NOT NULL,
    dashboard_uid character varying(40) NOT NULL,
    org_id bigint NOT NULL,
    time_settings text,
    template_variables text,
    access_token character varying(32) NOT NULL,
    created_by integer NOT NULL,
    updated_by integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    is_enabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public.dashboard_public OWNER TO grafana_user;

--
-- Name: dashboard_public_usage_by_day; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.dashboard_public_usage_by_day (
    id integer NOT NULL,
    public_dashboard_uid character varying(255) NOT NULL,
    day character varying(40) NOT NULL,
    views bigint NOT NULL,
    queries bigint NOT NULL,
    errors bigint NOT NULL,
    load_duration real NOT NULL
);


ALTER TABLE public.dashboard_public_usage_by_day OWNER TO grafana_user;

--
-- Name: dashboard_public_usage_by_day_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.dashboard_public_usage_by_day_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_public_usage_by_day_id_seq OWNER TO grafana_user;

--
-- Name: dashboard_public_usage_by_day_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.dashboard_public_usage_by_day_id_seq OWNED BY public.dashboard_public_usage_by_day.id;


--
-- Name: dashboard_snapshot; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.dashboard_snapshot (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    key character varying(190) NOT NULL,
    delete_key character varying(190) NOT NULL,
    org_id bigint NOT NULL,
    user_id bigint NOT NULL,
    external boolean NOT NULL,
    external_url character varying(255) NOT NULL,
    dashboard text NOT NULL,
    expires timestamp without time zone NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    external_delete_url character varying(255),
    dashboard_encrypted bytea
);


ALTER TABLE public.dashboard_snapshot OWNER TO grafana_user;

--
-- Name: dashboard_snapshot_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.dashboard_snapshot_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_snapshot_id_seq OWNER TO grafana_user;

--
-- Name: dashboard_snapshot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.dashboard_snapshot_id_seq OWNED BY public.dashboard_snapshot.id;


--
-- Name: dashboard_tag; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.dashboard_tag (
    id integer NOT NULL,
    dashboard_id bigint NOT NULL,
    term character varying(50) NOT NULL
);


ALTER TABLE public.dashboard_tag OWNER TO grafana_user;

--
-- Name: dashboard_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.dashboard_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_tag_id_seq OWNER TO grafana_user;

--
-- Name: dashboard_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.dashboard_tag_id_seq OWNED BY public.dashboard_tag.id;


--
-- Name: dashboard_usage_by_day; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.dashboard_usage_by_day (
    id integer NOT NULL,
    dashboard_id bigint NOT NULL,
    day character varying(40) NOT NULL,
    views bigint NOT NULL,
    queries bigint NOT NULL,
    errors bigint NOT NULL,
    load_duration real NOT NULL
);


ALTER TABLE public.dashboard_usage_by_day OWNER TO grafana_user;

--
-- Name: dashboard_usage_by_day_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.dashboard_usage_by_day_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_usage_by_day_id_seq OWNER TO grafana_user;

--
-- Name: dashboard_usage_by_day_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.dashboard_usage_by_day_id_seq OWNED BY public.dashboard_usage_by_day.id;


--
-- Name: dashboard_usage_sums; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.dashboard_usage_sums (
    dashboard_id bigint NOT NULL,
    updated timestamp without time zone NOT NULL,
    views_last_1_days bigint NOT NULL,
    views_last_7_days bigint NOT NULL,
    views_last_30_days bigint NOT NULL,
    views_total bigint NOT NULL,
    queries_last_1_days bigint NOT NULL,
    queries_last_7_days bigint NOT NULL,
    queries_last_30_days bigint NOT NULL,
    queries_total bigint NOT NULL,
    errors_last_1_days bigint DEFAULT 0 NOT NULL,
    errors_last_7_days bigint DEFAULT 0 NOT NULL,
    errors_last_30_days bigint DEFAULT 0 NOT NULL,
    errors_total bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.dashboard_usage_sums OWNER TO grafana_user;

--
-- Name: dashboard_version; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.dashboard_version (
    id integer NOT NULL,
    dashboard_id bigint NOT NULL,
    parent_version integer NOT NULL,
    restored_from integer NOT NULL,
    version integer NOT NULL,
    created timestamp without time zone NOT NULL,
    created_by bigint NOT NULL,
    message text NOT NULL,
    data text NOT NULL
);


ALTER TABLE public.dashboard_version OWNER TO grafana_user;

--
-- Name: dashboard_version_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.dashboard_version_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_version_id_seq OWNER TO grafana_user;

--
-- Name: dashboard_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.dashboard_version_id_seq OWNED BY public.dashboard_version.id;


--
-- Name: data_keys; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.data_keys (
    name character varying(100) NOT NULL,
    active boolean NOT NULL,
    scope character varying(30) NOT NULL,
    provider character varying(50) NOT NULL,
    encrypted_data bytea NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    label character varying(100) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.data_keys OWNER TO grafana_user;

--
-- Name: data_source; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.data_source (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    version integer NOT NULL,
    type character varying(255) NOT NULL,
    name character varying(190) NOT NULL,
    access character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    password character varying(255),
    "user" character varying(255),
    database character varying(255),
    basic_auth boolean NOT NULL,
    basic_auth_user character varying(255),
    basic_auth_password character varying(255),
    is_default boolean NOT NULL,
    json_data text,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    with_credentials boolean DEFAULT false NOT NULL,
    secure_json_data text,
    read_only boolean,
    uid character varying(40) DEFAULT 0 NOT NULL
);


ALTER TABLE public.data_source OWNER TO grafana_user;

--
-- Name: data_source_acl; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.data_source_acl (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    data_source_id bigint NOT NULL,
    team_id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission smallint NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.data_source_acl OWNER TO grafana_user;

--
-- Name: data_source_acl_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.data_source_acl_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_source_acl_id_seq OWNER TO grafana_user;

--
-- Name: data_source_acl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.data_source_acl_id_seq OWNED BY public.data_source_acl.id;


--
-- Name: data_source_cache; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.data_source_cache (
    id integer NOT NULL,
    data_source_id bigint NOT NULL,
    enabled boolean NOT NULL,
    ttl_ms bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    use_default_ttl boolean DEFAULT true NOT NULL,
    data_source_uid character varying(40) DEFAULT 0 NOT NULL,
    ttl_resources_ms bigint DEFAULT 300000 NOT NULL
);


ALTER TABLE public.data_source_cache OWNER TO grafana_user;

--
-- Name: data_source_cache_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.data_source_cache_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_source_cache_id_seq OWNER TO grafana_user;

--
-- Name: data_source_cache_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.data_source_cache_id_seq OWNED BY public.data_source_cache.id;


--
-- Name: data_source_id_seq1; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.data_source_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_source_id_seq1 OWNER TO grafana_user;

--
-- Name: data_source_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.data_source_id_seq1 OWNED BY public.data_source.id;


--
-- Name: data_source_usage_by_day; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.data_source_usage_by_day (
    id integer NOT NULL,
    data_source_id bigint NOT NULL,
    day character varying(40) NOT NULL,
    queries bigint NOT NULL,
    errors bigint NOT NULL,
    load_duration_ms bigint NOT NULL
);


ALTER TABLE public.data_source_usage_by_day OWNER TO grafana_user;

--
-- Name: data_source_usage_by_day_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.data_source_usage_by_day_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_source_usage_by_day_id_seq OWNER TO grafana_user;

--
-- Name: data_source_usage_by_day_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.data_source_usage_by_day_id_seq OWNED BY public.data_source_usage_by_day.id;


--
-- Name: entity_event; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.entity_event (
    id integer NOT NULL,
    entity_id character varying(1024) NOT NULL,
    event_type character varying(8) NOT NULL,
    created bigint NOT NULL
);


ALTER TABLE public.entity_event OWNER TO grafana_user;

--
-- Name: entity_event_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.entity_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entity_event_id_seq OWNER TO grafana_user;

--
-- Name: entity_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.entity_event_id_seq OWNED BY public.entity_event.id;


--
-- Name: file; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.file (
    path character varying(1024) NOT NULL COLLATE pg_catalog."C",
    path_hash character varying(64) NOT NULL,
    parent_folder_path_hash character varying(64) NOT NULL,
    contents bytea NOT NULL,
    etag character varying(32) NOT NULL,
    cache_control character varying(128) NOT NULL,
    content_disposition character varying(128) NOT NULL,
    updated timestamp without time zone NOT NULL,
    created timestamp without time zone NOT NULL,
    size bigint NOT NULL,
    mime_type character varying(255) NOT NULL
);


ALTER TABLE public.file OWNER TO grafana_user;

--
-- Name: file_meta; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.file_meta (
    path_hash character varying(64) NOT NULL,
    key character varying(191) NOT NULL,
    value character varying(1024) NOT NULL
);


ALTER TABLE public.file_meta OWNER TO grafana_user;

--
-- Name: kv_store; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.kv_store (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    namespace character varying(190) NOT NULL,
    key character varying(190) NOT NULL,
    value text NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.kv_store OWNER TO grafana_user;

--
-- Name: kv_store_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.kv_store_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kv_store_id_seq OWNER TO grafana_user;

--
-- Name: kv_store_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.kv_store_id_seq OWNED BY public.kv_store.id;


--
-- Name: library_element; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.library_element (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    folder_id bigint NOT NULL,
    uid character varying(40) NOT NULL,
    name character varying(150) NOT NULL,
    kind bigint NOT NULL,
    type character varying(40) NOT NULL,
    description character varying(2048) NOT NULL,
    model text NOT NULL,
    created timestamp without time zone NOT NULL,
    created_by bigint NOT NULL,
    updated timestamp without time zone NOT NULL,
    updated_by bigint NOT NULL,
    version bigint NOT NULL
);


ALTER TABLE public.library_element OWNER TO grafana_user;

--
-- Name: library_element_connection; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.library_element_connection (
    id integer NOT NULL,
    element_id bigint NOT NULL,
    kind bigint NOT NULL,
    connection_id bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    created_by bigint NOT NULL
);


ALTER TABLE public.library_element_connection OWNER TO grafana_user;

--
-- Name: library_element_connection_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.library_element_connection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.library_element_connection_id_seq OWNER TO grafana_user;

--
-- Name: library_element_connection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.library_element_connection_id_seq OWNED BY public.library_element_connection.id;


--
-- Name: library_element_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.library_element_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.library_element_id_seq OWNER TO grafana_user;

--
-- Name: library_element_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.library_element_id_seq OWNED BY public.library_element.id;


--
-- Name: license_token; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.license_token (
    id integer NOT NULL,
    token text NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.license_token OWNER TO grafana_user;

--
-- Name: license_token_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.license_token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.license_token_id_seq OWNER TO grafana_user;

--
-- Name: license_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.license_token_id_seq OWNED BY public.license_token.id;


--
-- Name: login_attempt; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.login_attempt (
    id integer NOT NULL,
    username character varying(190) NOT NULL,
    ip_address character varying(30) NOT NULL,
    created integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.login_attempt OWNER TO grafana_user;

--
-- Name: login_attempt_id_seq1; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.login_attempt_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.login_attempt_id_seq1 OWNER TO grafana_user;

--
-- Name: login_attempt_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.login_attempt_id_seq1 OWNED BY public.login_attempt.id;


--
-- Name: migration_log; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.migration_log (
    id integer NOT NULL,
    migration_id character varying(255) NOT NULL,
    sql text NOT NULL,
    success boolean NOT NULL,
    error text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE public.migration_log OWNER TO grafana_user;

--
-- Name: migration_log_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.migration_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migration_log_id_seq OWNER TO grafana_user;

--
-- Name: migration_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.migration_log_id_seq OWNED BY public.migration_log.id;


--
-- Name: ngalert_configuration; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.ngalert_configuration (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    alertmanagers text,
    created_at integer NOT NULL,
    updated_at integer NOT NULL,
    send_alerts_to smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.ngalert_configuration OWNER TO grafana_user;

--
-- Name: ngalert_configuration_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.ngalert_configuration_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ngalert_configuration_id_seq OWNER TO grafana_user;

--
-- Name: ngalert_configuration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.ngalert_configuration_id_seq OWNED BY public.ngalert_configuration.id;


--
-- Name: org; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.org (
    id integer NOT NULL,
    version integer NOT NULL,
    name character varying(190) NOT NULL,
    address1 character varying(255),
    address2 character varying(255),
    city character varying(255),
    state character varying(255),
    zip_code character varying(50),
    country character varying(255),
    billing_email character varying(255),
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.org OWNER TO grafana_user;

--
-- Name: org_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.org_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.org_id_seq OWNER TO grafana_user;

--
-- Name: org_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.org_id_seq OWNED BY public.org.id;


--
-- Name: org_user; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.org_user (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    user_id bigint NOT NULL,
    role character varying(20) NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.org_user OWNER TO grafana_user;

--
-- Name: org_user_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.org_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.org_user_id_seq OWNER TO grafana_user;

--
-- Name: org_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.org_user_id_seq OWNED BY public.org_user.id;


--
-- Name: permission; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.permission (
    id integer NOT NULL,
    role_id bigint NOT NULL,
    action character varying(190) NOT NULL,
    scope character varying(190) NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.permission OWNER TO grafana_user;

--
-- Name: permission_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permission_id_seq OWNER TO grafana_user;

--
-- Name: permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.permission_id_seq OWNED BY public.permission.id;


--
-- Name: playlist; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.playlist (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "interval" character varying(255) NOT NULL,
    org_id bigint NOT NULL,
    uid character varying(80) DEFAULT 0 NOT NULL
);


ALTER TABLE public.playlist OWNER TO grafana_user;

--
-- Name: playlist_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.playlist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.playlist_id_seq OWNER TO grafana_user;

--
-- Name: playlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.playlist_id_seq OWNED BY public.playlist.id;


--
-- Name: playlist_item; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.playlist_item (
    id integer NOT NULL,
    playlist_id bigint NOT NULL,
    type character varying(255) NOT NULL,
    value text NOT NULL,
    title text NOT NULL,
    "order" integer NOT NULL
);


ALTER TABLE public.playlist_item OWNER TO grafana_user;

--
-- Name: playlist_item_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.playlist_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.playlist_item_id_seq OWNER TO grafana_user;

--
-- Name: playlist_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.playlist_item_id_seq OWNED BY public.playlist_item.id;


--
-- Name: plugin_setting; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.plugin_setting (
    id integer NOT NULL,
    org_id bigint,
    plugin_id character varying(190) NOT NULL,
    enabled boolean NOT NULL,
    pinned boolean NOT NULL,
    json_data text,
    secure_json_data text,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    plugin_version character varying(50)
);


ALTER TABLE public.plugin_setting OWNER TO grafana_user;

--
-- Name: plugin_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.plugin_setting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plugin_setting_id_seq OWNER TO grafana_user;

--
-- Name: plugin_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.plugin_setting_id_seq OWNED BY public.plugin_setting.id;


--
-- Name: preferences; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.preferences (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    user_id bigint NOT NULL,
    version integer NOT NULL,
    home_dashboard_id bigint NOT NULL,
    timezone character varying(50) NOT NULL,
    theme character varying(20) NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    team_id bigint,
    week_start character varying(10),
    json_data text
);


ALTER TABLE public.preferences OWNER TO grafana_user;

--
-- Name: preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.preferences_id_seq OWNER TO grafana_user;

--
-- Name: preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.preferences_id_seq OWNED BY public.preferences.id;


--
-- Name: provenance_type; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.provenance_type (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    record_key character varying(190) NOT NULL,
    record_type character varying(190) NOT NULL,
    provenance character varying(190) NOT NULL
);


ALTER TABLE public.provenance_type OWNER TO grafana_user;

--
-- Name: provenance_type_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.provenance_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.provenance_type_id_seq OWNER TO grafana_user;

--
-- Name: provenance_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.provenance_type_id_seq OWNED BY public.provenance_type.id;


--
-- Name: query_history; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.query_history (
    id integer NOT NULL,
    uid character varying(40) NOT NULL,
    org_id bigint NOT NULL,
    datasource_uid character varying(40) NOT NULL,
    created_by bigint NOT NULL,
    created_at integer NOT NULL,
    comment text NOT NULL,
    queries text NOT NULL
);


ALTER TABLE public.query_history OWNER TO grafana_user;

--
-- Name: query_history_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.query_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.query_history_id_seq OWNER TO grafana_user;

--
-- Name: query_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.query_history_id_seq OWNED BY public.query_history.id;


--
-- Name: query_history_star; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.query_history_star (
    id integer NOT NULL,
    query_uid character varying(40) NOT NULL,
    user_id bigint NOT NULL,
    org_id bigint DEFAULT 1 NOT NULL
);


ALTER TABLE public.query_history_star OWNER TO grafana_user;

--
-- Name: query_history_star_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.query_history_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.query_history_star_id_seq OWNER TO grafana_user;

--
-- Name: query_history_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.query_history_star_id_seq OWNED BY public.query_history_star.id;


--
-- Name: quota; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.quota (
    id integer NOT NULL,
    org_id bigint,
    user_id bigint,
    target character varying(190) NOT NULL,
    "limit" bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.quota OWNER TO grafana_user;

--
-- Name: quota_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.quota_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quota_id_seq OWNER TO grafana_user;

--
-- Name: quota_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.quota_id_seq OWNED BY public.quota.id;


--
-- Name: recording_rules; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.recording_rules (
    id character varying(128) NOT NULL,
    target_ref_id character varying(128) NOT NULL,
    name character varying(128) NOT NULL,
    description text NOT NULL,
    org_id bigint NOT NULL,
    "interval" bigint NOT NULL,
    range bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    count boolean DEFAULT true NOT NULL,
    queries bytea NOT NULL,
    created_at timestamp without time zone NOT NULL,
    prom_name character varying(128)
);


ALTER TABLE public.recording_rules OWNER TO grafana_user;

--
-- Name: remote_write_targets; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.remote_write_targets (
    id character varying(128) NOT NULL,
    data_source_uid character varying(128) NOT NULL,
    write_path character varying(128) NOT NULL,
    org_id integer NOT NULL
);


ALTER TABLE public.remote_write_targets OWNER TO grafana_user;

--
-- Name: report; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.report (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    org_id bigint NOT NULL,
    dashboard_id bigint NOT NULL,
    name text NOT NULL,
    recipients text NOT NULL,
    reply_to text,
    message text,
    schedule_frequency character varying(32) NOT NULL,
    schedule_day character varying(32) NOT NULL,
    schedule_hour bigint NOT NULL,
    schedule_minute bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    schedule_timezone character varying(50) DEFAULT 'Europe/Stockholm'::character varying NOT NULL,
    time_from character varying(255),
    time_to character varying(255),
    pdf_landscape boolean,
    schedule_day_of_month character varying(32),
    pdf_layout character varying(255),
    pdf_orientation character varying(32),
    dashboard_uid character varying(40),
    template_vars text,
    enable_dashboard_url boolean,
    state character varying(32),
    enable_csv boolean,
    schedule_start integer,
    schedule_end integer,
    schedule_interval_frequency character varying(32),
    schedule_interval_amount bigint,
    schedule_workdays_only boolean,
    formats character varying(190) DEFAULT '["pdf"]'::character varying NOT NULL
);


ALTER TABLE public.report OWNER TO grafana_user;

--
-- Name: report_dashboards; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.report_dashboards (
    id integer NOT NULL,
    report_id bigint NOT NULL,
    dashboard_uid character varying(40) DEFAULT ''::character varying NOT NULL,
    report_variables text,
    time_to character varying(255),
    time_from character varying(255),
    created timestamp without time zone
);


ALTER TABLE public.report_dashboards OWNER TO grafana_user;

--
-- Name: report_dashboards_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.report_dashboards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_dashboards_id_seq OWNER TO grafana_user;

--
-- Name: report_dashboards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.report_dashboards_id_seq OWNED BY public.report_dashboards.id;


--
-- Name: report_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.report_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_id_seq OWNER TO grafana_user;

--
-- Name: report_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.report_id_seq OWNED BY public.report.id;


--
-- Name: report_settings; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.report_settings (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    org_id bigint NOT NULL,
    branding_report_logo_url text,
    branding_email_logo_url text,
    branding_email_footer_link text,
    branding_email_footer_text text,
    branding_email_footer_mode character varying(50)
);


ALTER TABLE public.report_settings OWNER TO grafana_user;

--
-- Name: report_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.report_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_settings_id_seq OWNER TO grafana_user;

--
-- Name: report_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.report_settings_id_seq OWNED BY public.report_settings.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.role (
    id integer NOT NULL,
    name character varying(190) NOT NULL,
    description text,
    version bigint NOT NULL,
    org_id bigint NOT NULL,
    uid character varying(40) NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    display_name character varying(190),
    group_name character varying(190),
    hidden boolean DEFAULT false NOT NULL
);


ALTER TABLE public.role OWNER TO grafana_user;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_id_seq OWNER TO grafana_user;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.role_id_seq OWNED BY public.role.id;


--
-- Name: secrets; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.secrets (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    namespace character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    value text,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.secrets OWNER TO grafana_user;

--
-- Name: secrets_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.secrets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secrets_id_seq OWNER TO grafana_user;

--
-- Name: secrets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.secrets_id_seq OWNED BY public.secrets.id;


--
-- Name: seed_assignment; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.seed_assignment (
    builtin_role character varying(190) NOT NULL,
    role_name character varying(190),
    action character varying(190),
    scope character varying(190)
);


ALTER TABLE public.seed_assignment OWNER TO grafana_user;

--
-- Name: server_lock; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.server_lock (
    id integer NOT NULL,
    operation_uid character varying(100) NOT NULL,
    version bigint NOT NULL,
    last_execution bigint NOT NULL
);


ALTER TABLE public.server_lock OWNER TO grafana_user;

--
-- Name: server_lock_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.server_lock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.server_lock_id_seq OWNER TO grafana_user;

--
-- Name: server_lock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.server_lock_id_seq OWNED BY public.server_lock.id;


--
-- Name: session; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.session (
    key character(16) NOT NULL,
    data bytea NOT NULL,
    expiry integer NOT NULL
);


ALTER TABLE public.session OWNER TO grafana_user;

--
-- Name: setting; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.setting (
    section character varying(100) NOT NULL,
    key character varying(100) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.setting OWNER TO grafana_user;

--
-- Name: short_url; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.short_url (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    uid character varying(40) NOT NULL,
    path text NOT NULL,
    created_by bigint NOT NULL,
    created_at integer NOT NULL,
    last_seen_at integer
);


ALTER TABLE public.short_url OWNER TO grafana_user;

--
-- Name: short_url_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.short_url_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.short_url_id_seq OWNER TO grafana_user;

--
-- Name: short_url_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.short_url_id_seq OWNED BY public.short_url.id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.star (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    dashboard_id bigint NOT NULL
);


ALTER TABLE public.star OWNER TO grafana_user;

--
-- Name: star_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_id_seq OWNER TO grafana_user;

--
-- Name: star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.star_id_seq OWNED BY public.star.id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    key character varying(100) NOT NULL,
    value character varying(100) NOT NULL
);


ALTER TABLE public.tag OWNER TO grafana_user;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO grafana_user;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: team; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.team (
    id integer NOT NULL,
    name character varying(190) NOT NULL,
    org_id bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    email character varying(190)
);


ALTER TABLE public.team OWNER TO grafana_user;

--
-- Name: team_group; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.team_group (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    team_id bigint NOT NULL,
    group_id character varying(190) NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.team_group OWNER TO grafana_user;

--
-- Name: team_group_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.team_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_group_id_seq OWNER TO grafana_user;

--
-- Name: team_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.team_group_id_seq OWNED BY public.team_group.id;


--
-- Name: team_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_id_seq OWNER TO grafana_user;

--
-- Name: team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.team_id_seq OWNED BY public.team.id;


--
-- Name: team_member; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.team_member (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    team_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    external boolean,
    permission smallint
);


ALTER TABLE public.team_member OWNER TO grafana_user;

--
-- Name: team_member_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.team_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_member_id_seq OWNER TO grafana_user;

--
-- Name: team_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.team_member_id_seq OWNED BY public.team_member.id;


--
-- Name: team_role; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.team_role (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    team_id bigint NOT NULL,
    role_id bigint NOT NULL,
    created timestamp without time zone NOT NULL
);


ALTER TABLE public.team_role OWNER TO grafana_user;

--
-- Name: team_role_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.team_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_role_id_seq OWNER TO grafana_user;

--
-- Name: team_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.team_role_id_seq OWNED BY public.team_role.id;


--
-- Name: temp_user; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.temp_user (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    version integer NOT NULL,
    email character varying(190) NOT NULL,
    name character varying(255),
    role character varying(20),
    code character varying(190) NOT NULL,
    status character varying(20) NOT NULL,
    invited_by_user_id bigint,
    email_sent boolean NOT NULL,
    email_sent_on timestamp without time zone,
    remote_addr character varying(255),
    created integer DEFAULT 0 NOT NULL,
    updated integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.temp_user OWNER TO grafana_user;

--
-- Name: temp_user_id_seq1; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.temp_user_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.temp_user_id_seq1 OWNER TO grafana_user;

--
-- Name: temp_user_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.temp_user_id_seq1 OWNED BY public.temp_user.id;


--
-- Name: test_data; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.test_data (
    id integer NOT NULL,
    metric1 character varying(20),
    metric2 character varying(150),
    value_big_int bigint,
    value_double double precision,
    value_float real,
    value_int integer,
    time_epoch bigint NOT NULL,
    time_date_time timestamp without time zone NOT NULL,
    time_time_stamp timestamp without time zone NOT NULL
);


ALTER TABLE public.test_data OWNER TO grafana_user;

--
-- Name: test_data_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.test_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_data_id_seq OWNER TO grafana_user;

--
-- Name: test_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.test_data_id_seq OWNED BY public.test_data.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    version integer NOT NULL,
    login character varying(190) NOT NULL,
    email character varying(190) NOT NULL,
    name character varying(255),
    password character varying(255),
    salt character varying(50),
    rands character varying(50),
    company character varying(255),
    org_id bigint NOT NULL,
    is_admin boolean NOT NULL,
    email_verified boolean,
    theme character varying(255),
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    help_flags1 bigint DEFAULT 0 NOT NULL,
    last_seen_at timestamp without time zone,
    is_disabled boolean DEFAULT false NOT NULL,
    is_service_account boolean DEFAULT false
);


ALTER TABLE public."user" OWNER TO grafana_user;

--
-- Name: user_auth; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.user_auth (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    auth_module character varying(190) NOT NULL,
    auth_id character varying(190) NOT NULL,
    created timestamp without time zone NOT NULL,
    o_auth_access_token text,
    o_auth_refresh_token text,
    o_auth_token_type text,
    o_auth_expiry timestamp without time zone,
    o_auth_id_token text
);


ALTER TABLE public.user_auth OWNER TO grafana_user;

--
-- Name: user_auth_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.user_auth_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_auth_id_seq OWNER TO grafana_user;

--
-- Name: user_auth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.user_auth_id_seq OWNED BY public.user_auth.id;


--
-- Name: user_auth_token; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.user_auth_token (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    auth_token character varying(100) NOT NULL,
    prev_auth_token character varying(100) NOT NULL,
    user_agent character varying(255) NOT NULL,
    client_ip character varying(255) NOT NULL,
    auth_token_seen boolean NOT NULL,
    seen_at integer,
    rotated_at integer NOT NULL,
    created_at integer NOT NULL,
    updated_at integer NOT NULL,
    revoked_at integer
);


ALTER TABLE public.user_auth_token OWNER TO grafana_user;

--
-- Name: user_auth_token_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.user_auth_token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_auth_token_id_seq OWNER TO grafana_user;

--
-- Name: user_auth_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.user_auth_token_id_seq OWNED BY public.user_auth_token.id;


--
-- Name: user_dashboard_views; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.user_dashboard_views (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    dashboard_id bigint NOT NULL,
    viewed timestamp without time zone NOT NULL
);


ALTER TABLE public.user_dashboard_views OWNER TO grafana_user;

--
-- Name: user_dashboard_views_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.user_dashboard_views_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_dashboard_views_id_seq OWNER TO grafana_user;

--
-- Name: user_dashboard_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.user_dashboard_views_id_seq OWNED BY public.user_dashboard_views.id;


--
-- Name: user_id_seq1; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.user_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq1 OWNER TO grafana_user;

--
-- Name: user_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.user_id_seq1 OWNED BY public."user".id;


--
-- Name: user_role; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.user_role (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    user_id bigint NOT NULL,
    role_id bigint NOT NULL,
    created timestamp without time zone NOT NULL
);


ALTER TABLE public.user_role OWNER TO grafana_user;

--
-- Name: user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.user_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_role_id_seq OWNER TO grafana_user;

--
-- Name: user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.user_role_id_seq OWNED BY public.user_role.id;


--
-- Name: user_stats; Type: TABLE; Schema: public; Owner: grafana_user
--

CREATE TABLE public.user_stats (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    billing_role character varying(40) NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.user_stats OWNER TO grafana_user;

--
-- Name: user_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: grafana_user
--

CREATE SEQUENCE public.user_stats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_stats_id_seq OWNER TO grafana_user;

--
-- Name: user_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: grafana_user
--

ALTER SEQUENCE public.user_stats_id_seq OWNED BY public.user_stats.id;


--
-- Name: alert id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert ALTER COLUMN id SET DEFAULT nextval('public.alert_id_seq'::regclass);


--
-- Name: alert_configuration id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert_configuration ALTER COLUMN id SET DEFAULT nextval('public.alert_configuration_id_seq'::regclass);


--
-- Name: alert_image id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert_image ALTER COLUMN id SET DEFAULT nextval('public.alert_image_id_seq'::regclass);


--
-- Name: alert_notification id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert_notification ALTER COLUMN id SET DEFAULT nextval('public.alert_notification_id_seq'::regclass);


--
-- Name: alert_notification_state id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert_notification_state ALTER COLUMN id SET DEFAULT nextval('public.alert_notification_state_id_seq'::regclass);


--
-- Name: alert_rule id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert_rule ALTER COLUMN id SET DEFAULT nextval('public.alert_rule_id_seq'::regclass);


--
-- Name: alert_rule_tag id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert_rule_tag ALTER COLUMN id SET DEFAULT nextval('public.alert_rule_tag_id_seq'::regclass);


--
-- Name: alert_rule_version id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert_rule_version ALTER COLUMN id SET DEFAULT nextval('public.alert_rule_version_id_seq'::regclass);


--
-- Name: annotation id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.annotation ALTER COLUMN id SET DEFAULT nextval('public.annotation_id_seq'::regclass);


--
-- Name: annotation_tag id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.annotation_tag ALTER COLUMN id SET DEFAULT nextval('public.annotation_tag_id_seq'::regclass);


--
-- Name: api_key id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.api_key ALTER COLUMN id SET DEFAULT nextval('public.api_key_id_seq1'::regclass);


--
-- Name: builtin_role id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.builtin_role ALTER COLUMN id SET DEFAULT nextval('public.builtin_role_id_seq'::regclass);


--
-- Name: dashboard id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard ALTER COLUMN id SET DEFAULT nextval('public.dashboard_id_seq1'::regclass);


--
-- Name: dashboard_acl id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard_acl ALTER COLUMN id SET DEFAULT nextval('public.dashboard_acl_id_seq'::regclass);


--
-- Name: dashboard_provisioning id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard_provisioning ALTER COLUMN id SET DEFAULT nextval('public.dashboard_provisioning_id_seq1'::regclass);


--
-- Name: dashboard_public_usage_by_day id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard_public_usage_by_day ALTER COLUMN id SET DEFAULT nextval('public.dashboard_public_usage_by_day_id_seq'::regclass);


--
-- Name: dashboard_snapshot id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard_snapshot ALTER COLUMN id SET DEFAULT nextval('public.dashboard_snapshot_id_seq'::regclass);


--
-- Name: dashboard_tag id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard_tag ALTER COLUMN id SET DEFAULT nextval('public.dashboard_tag_id_seq'::regclass);


--
-- Name: dashboard_usage_by_day id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard_usage_by_day ALTER COLUMN id SET DEFAULT nextval('public.dashboard_usage_by_day_id_seq'::regclass);


--
-- Name: dashboard_version id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard_version ALTER COLUMN id SET DEFAULT nextval('public.dashboard_version_id_seq'::regclass);


--
-- Name: data_source id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.data_source ALTER COLUMN id SET DEFAULT nextval('public.data_source_id_seq1'::regclass);


--
-- Name: data_source_acl id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.data_source_acl ALTER COLUMN id SET DEFAULT nextval('public.data_source_acl_id_seq'::regclass);


--
-- Name: data_source_cache id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.data_source_cache ALTER COLUMN id SET DEFAULT nextval('public.data_source_cache_id_seq'::regclass);


--
-- Name: data_source_usage_by_day id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.data_source_usage_by_day ALTER COLUMN id SET DEFAULT nextval('public.data_source_usage_by_day_id_seq'::regclass);


--
-- Name: entity_event id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.entity_event ALTER COLUMN id SET DEFAULT nextval('public.entity_event_id_seq'::regclass);


--
-- Name: kv_store id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.kv_store ALTER COLUMN id SET DEFAULT nextval('public.kv_store_id_seq'::regclass);


--
-- Name: library_element id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.library_element ALTER COLUMN id SET DEFAULT nextval('public.library_element_id_seq'::regclass);


--
-- Name: library_element_connection id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.library_element_connection ALTER COLUMN id SET DEFAULT nextval('public.library_element_connection_id_seq'::regclass);


--
-- Name: license_token id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.license_token ALTER COLUMN id SET DEFAULT nextval('public.license_token_id_seq'::regclass);


--
-- Name: login_attempt id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.login_attempt ALTER COLUMN id SET DEFAULT nextval('public.login_attempt_id_seq1'::regclass);


--
-- Name: migration_log id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.migration_log ALTER COLUMN id SET DEFAULT nextval('public.migration_log_id_seq'::regclass);


--
-- Name: ngalert_configuration id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.ngalert_configuration ALTER COLUMN id SET DEFAULT nextval('public.ngalert_configuration_id_seq'::regclass);


--
-- Name: org id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.org ALTER COLUMN id SET DEFAULT nextval('public.org_id_seq'::regclass);


--
-- Name: org_user id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.org_user ALTER COLUMN id SET DEFAULT nextval('public.org_user_id_seq'::regclass);


--
-- Name: permission id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.permission ALTER COLUMN id SET DEFAULT nextval('public.permission_id_seq'::regclass);


--
-- Name: playlist id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.playlist ALTER COLUMN id SET DEFAULT nextval('public.playlist_id_seq'::regclass);


--
-- Name: playlist_item id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.playlist_item ALTER COLUMN id SET DEFAULT nextval('public.playlist_item_id_seq'::regclass);


--
-- Name: plugin_setting id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.plugin_setting ALTER COLUMN id SET DEFAULT nextval('public.plugin_setting_id_seq'::regclass);


--
-- Name: preferences id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.preferences ALTER COLUMN id SET DEFAULT nextval('public.preferences_id_seq'::regclass);


--
-- Name: provenance_type id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.provenance_type ALTER COLUMN id SET DEFAULT nextval('public.provenance_type_id_seq'::regclass);


--
-- Name: query_history id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.query_history ALTER COLUMN id SET DEFAULT nextval('public.query_history_id_seq'::regclass);


--
-- Name: query_history_star id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.query_history_star ALTER COLUMN id SET DEFAULT nextval('public.query_history_star_id_seq'::regclass);


--
-- Name: quota id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.quota ALTER COLUMN id SET DEFAULT nextval('public.quota_id_seq'::regclass);


--
-- Name: report id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.report ALTER COLUMN id SET DEFAULT nextval('public.report_id_seq'::regclass);


--
-- Name: report_dashboards id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.report_dashboards ALTER COLUMN id SET DEFAULT nextval('public.report_dashboards_id_seq'::regclass);


--
-- Name: report_settings id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.report_settings ALTER COLUMN id SET DEFAULT nextval('public.report_settings_id_seq'::regclass);


--
-- Name: role id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.role ALTER COLUMN id SET DEFAULT nextval('public.role_id_seq'::regclass);


--
-- Name: secrets id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.secrets ALTER COLUMN id SET DEFAULT nextval('public.secrets_id_seq'::regclass);


--
-- Name: server_lock id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.server_lock ALTER COLUMN id SET DEFAULT nextval('public.server_lock_id_seq'::regclass);


--
-- Name: short_url id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.short_url ALTER COLUMN id SET DEFAULT nextval('public.short_url_id_seq'::regclass);


--
-- Name: star id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.star ALTER COLUMN id SET DEFAULT nextval('public.star_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: team id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.team ALTER COLUMN id SET DEFAULT nextval('public.team_id_seq'::regclass);


--
-- Name: team_group id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.team_group ALTER COLUMN id SET DEFAULT nextval('public.team_group_id_seq'::regclass);


--
-- Name: team_member id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.team_member ALTER COLUMN id SET DEFAULT nextval('public.team_member_id_seq'::regclass);


--
-- Name: team_role id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.team_role ALTER COLUMN id SET DEFAULT nextval('public.team_role_id_seq'::regclass);


--
-- Name: temp_user id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.temp_user ALTER COLUMN id SET DEFAULT nextval('public.temp_user_id_seq1'::regclass);


--
-- Name: test_data id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.test_data ALTER COLUMN id SET DEFAULT nextval('public.test_data_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq1'::regclass);


--
-- Name: user_auth id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.user_auth ALTER COLUMN id SET DEFAULT nextval('public.user_auth_id_seq'::regclass);


--
-- Name: user_auth_token id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.user_auth_token ALTER COLUMN id SET DEFAULT nextval('public.user_auth_token_id_seq'::regclass);


--
-- Name: user_dashboard_views id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.user_dashboard_views ALTER COLUMN id SET DEFAULT nextval('public.user_dashboard_views_id_seq'::regclass);


--
-- Name: user_role id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.user_role ALTER COLUMN id SET DEFAULT nextval('public.user_role_id_seq'::regclass);


--
-- Name: user_stats id; Type: DEFAULT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.user_stats ALTER COLUMN id SET DEFAULT nextval('public.user_stats_id_seq'::regclass);


--
-- Data for Name: alert; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.alert (id, version, dashboard_id, panel_id, org_id, name, message, state, settings, frequency, handler, severity, silenced, execution_error, eval_data, eval_date, new_state_date, state_changes, created, updated, "for") FROM stdin;
\.


--
-- Data for Name: alert_configuration; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.alert_configuration (id, alertmanager_configuration, configuration_version, created_at, "default", org_id, configuration_hash) FROM stdin;
1	{\n\t"alertmanager_config": {\n\t\t"route": {\n\t\t\t"receiver": "grafana-default-email",\n\t\t\t"group_by": ["grafana_folder", "alertname"]\n\t\t},\n\t\t"receivers": [{\n\t\t\t"name": "grafana-default-email",\n\t\t\t"grafana_managed_receiver_configs": [{\n\t\t\t\t"uid": "",\n\t\t\t\t"name": "email receiver",\n\t\t\t\t"type": "email",\n\t\t\t\t"isDefault": true,\n\t\t\t\t"settings": {\n\t\t\t\t\t"addresses": "<example@email.com>"\n\t\t\t\t}\n\t\t\t}]\n\t\t}]\n\t}\n}\n	v1	1668055388	t	1	e0528a75784033ae7b15c40851d89484
3	{\n\t"alertmanager_config": {\n\t\t"route": {\n\t\t\t"receiver": "grafana-default-email",\n\t\t\t"group_by": ["grafana_folder", "alertname"]\n\t\t},\n\t\t"receivers": [{\n\t\t\t"name": "grafana-default-email",\n\t\t\t"grafana_managed_receiver_configs": [{\n\t\t\t\t"uid": "",\n\t\t\t\t"name": "email receiver",\n\t\t\t\t"type": "email",\n\t\t\t\t"isDefault": true,\n\t\t\t\t"settings": {\n\t\t\t\t\t"addresses": "<example@email.com>"\n\t\t\t\t}\n\t\t\t}]\n\t\t}]\n\t}\n}\n	v1	1668149994	t	3	e0528a75784033ae7b15c40851d89484
\.


--
-- Data for Name: alert_image; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.alert_image (id, token, path, url, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: alert_instance; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.alert_instance (rule_org_id, rule_uid, labels, labels_hash, current_state, current_state_since, last_eval_time, current_state_end, current_reason) FROM stdin;
\.


--
-- Data for Name: alert_notification; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.alert_notification (id, org_id, name, type, settings, created, updated, is_default, frequency, send_reminder, disable_resolve_message, uid, secure_settings) FROM stdin;
\.


--
-- Data for Name: alert_notification_state; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.alert_notification_state (id, org_id, alert_id, notifier_id, state, version, updated_at, alert_rule_state_updated_version) FROM stdin;
\.


--
-- Data for Name: alert_rule; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.alert_rule (id, org_id, title, condition, data, updated, interval_seconds, version, uid, namespace_uid, rule_group, no_data_state, exec_err_state, "for", annotations, labels, dashboard_uid, panel_id, rule_group_idx) FROM stdin;
\.


--
-- Data for Name: alert_rule_tag; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.alert_rule_tag (id, alert_id, tag_id) FROM stdin;
\.


--
-- Data for Name: alert_rule_version; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.alert_rule_version (id, rule_org_id, rule_uid, rule_namespace_uid, rule_group, parent_version, restored_from, version, created, title, condition, data, interval_seconds, no_data_state, exec_err_state, "for", annotations, labels, rule_group_idx) FROM stdin;
\.


--
-- Data for Name: annotation; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.annotation (id, org_id, alert_id, user_id, dashboard_id, panel_id, category_id, type, title, text, metric, prev_state, new_state, data, epoch, region_id, tags, created, updated, epoch_end) FROM stdin;
\.


--
-- Data for Name: annotation_tag; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.annotation_tag (id, annotation_id, tag_id) FROM stdin;
\.


--
-- Data for Name: api_key; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.api_key (id, org_id, name, key, role, created, updated, expires, service_account_id, last_used_at, is_revoked) FROM stdin;
\.


--
-- Data for Name: builtin_role; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.builtin_role (id, role, role_id, created, updated, org_id) FROM stdin;
1	Grafana Admin	1	2022-11-10 04:43:08	2022-11-10 04:43:08	0
2	Admin	2	2022-11-10 04:43:08	2022-11-10 04:43:08	0
3	Editor	3	2022-11-10 04:43:08	2022-11-10 04:43:08	0
4	Viewer	4	2022-11-10 04:43:08	2022-11-10 04:43:08	0
5	Editor	6	2022-11-10 05:28:26	2022-11-10 05:28:26	1
6	Viewer	7	2022-11-10 05:28:26	2022-11-10 05:28:26	1
7	Editor	9	2022-11-11 07:05:24	2022-11-11 07:05:24	3
8	Viewer	10	2022-11-11 07:05:24	2022-11-11 07:05:24	3
\.


--
-- Data for Name: cache_data; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.cache_data (cache_key, data, expires, created_at) FROM stdin;
\.


--
-- Data for Name: correlation; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.correlation (uid, source_uid, target_uid, label, description) FROM stdin;
\.


--
-- Data for Name: dashboard; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.dashboard (id, version, slug, title, data, org_id, created, updated, updated_by, created_by, gnet_id, plugin_id, folder_id, is_folder, has_acl, uid, is_public) FROM stdin;
2	6	estacao-argos	Estação Argos	{"annotations":{"list":[{"builtIn":1,"datasource":{"type":"grafana","uid":"-- Grafana --"},"enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","target":{"limit":100,"matchAny":false,"tags":[],"type":"dashboard"},"type":"dashboard"}]},"editable":true,"fiscalYearStartMonth":0,"graphTooltip":0,"id":2,"links":[],"liveNow":true,"panels":[{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":0},"id":6,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  diferenca\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Vazamento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"noValue":"0","thresholds":{"mode":"absolute","steps":[{"color":"yellow","value":null}]},"unit":"currencyBRL"},"overrides":[]},"gridPos":{"h":6,"w":6,"x":10,"y":0},"id":14,"options":{"colorMode":"value","graphMode":"area","justifyMode":"auto","orientation":"auto","reduceOptions":{"calcs":["lastNotNull"],"fields":"/.*/","values":false},"text":{"titleSize":700},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VALOR as \\"Preço\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Preço","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":6,"w":8,"x":16,"y":0},"id":12,"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["sum"],"fields":"","values":false},"textMode":"value"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  abastecimento_efetivo as \\"Abastecido\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Abastecido","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":6,"x":10,"y":6},"id":4,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VAZAMENTO as \\"Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Vazamento","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":7,"x":16,"y":6},"id":15,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^SEveridade Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  SEveridade_vazamento as \\"SEveridade Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Severidade do Vazamento","transparent":true,"type":"stat"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":9},"id":2,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  entrada_combustivel,\\n  saida_combustivel\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}],[{"params":["saida_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Abastecimento","transparent":true,"type":"timeseries"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"custom":{"align":"auto","displayMode":"auto","inspect":false},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":5,"w":14,"x":10,"y":11},"id":10,"options":{"footer":{"enablePagination":false,"fields":"","reducer":["sum"],"show":false},"showHeader":true},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"hide":false,"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  id as \\"Id Ordem\\",\\n  estado as \\"Estado Ordem\\",\\n  valor as \\"Preço\\"\\nFROM ordem_servico where sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["estado"],"type":"column"}]],"table":"ordem_servico","timeColumn":"id","timeColumnType":"int4","where":[{"name":"$__unixEpochFilter","params":[],"type":"macro"}]}],"title":"Estado Ordem","transparent":true,"type":"table"}],"refresh":"1s","schemaVersion":37,"style":"dark","tags":[],"templating":{"list":[]},"time":{"from":"now-24h","to":"now"},"timepicker":{"refresh_intervals":["30ms","1s","5s","10s","15s"]},"timezone":"","title":"Estação Argos","uid":"r3lvp-44k","version":6,"weekStart":""}	1	2022-11-10 05:32:46	2022-11-10 22:35:37	1	1	0		0	f	f	r3lvp-44k	f
5	8	estacao-argos	Estação Argos	{"annotations":{"list":[{"builtIn":1,"datasource":{"type":"grafana","uid":"-- Grafana --"},"enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","target":{"limit":100,"matchAny":false,"tags":[],"type":"dashboard"},"type":"dashboard"}]},"editable":true,"fiscalYearStartMonth":0,"graphTooltip":0,"id":5,"links":[],"liveNow":true,"panels":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"smooth","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":6,"w":10,"x":0,"y":0},"id":6,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT data.timestamp as \\"time\\", data.diferenca\\nFROM dados_coletado as data INNER JOIN ORDEM_SERVICO AS ordem on data.id_ordem = ordem.id \\nWHERE ordem.estado = 'EM ANDAMENTO' \\nAND data.SENSOR = 'argos' \\nAND $__timeFilter(data.\\"timestamp\\")\\n","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Vazamento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"noValue":"0","thresholds":{"mode":"absolute","steps":[{"color":"yellow","value":null}]},"unit":"currencyBRL"},"overrides":[]},"gridPos":{"h":6,"w":6,"x":10,"y":0},"id":14,"options":{"colorMode":"value","graphMode":"area","justifyMode":"auto","orientation":"auto","reduceOptions":{"calcs":["lastNotNull"],"fields":"/.*/","values":false},"text":{"titleSize":700},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VALOR as \\"Preço\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Preço","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":6,"w":8,"x":16,"y":0},"id":12,"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["sum"],"fields":"","values":false},"textMode":"value"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  abastecimento_efetivo as \\"Abastecido\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Abastecido","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":6,"w":10,"x":0,"y":6},"id":2,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT data.timestamp as \\"time\\", \\n  data.entrada_combustivel,\\n  data.saida_combustivel\\nFROM dados_coletado as data \\nINNER JOIN ORDEM_SERVICO AS ordem on data.id_ordem = ordem.id \\nWHERE ordem.estado = 'EM ANDAMENTO' \\nAND data.SENSOR = 'argos' \\nAND $__timeFilter(data.timestamp)\\n","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}],[{"params":["saida_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Abastecimento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"noValue":"0","thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"Nm3"},"overrides":[]},"gridPos":{"h":5,"w":6,"x":10,"y":6},"id":4,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VAZAMENTO as \\"Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Vazamento","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[{"options":{"CRITICO":{"color":"dark-red","index":0}},"type":"value"}],"noValue":"NULO","thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":7,"x":16,"y":6},"id":15,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^SEveridade Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  SEveridade_vazamento as \\"SEveridade Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Severidade do Vazamento","transparent":true,"type":"stat"}],"refresh":"1s","schemaVersion":37,"style":"dark","tags":[],"templating":{"list":[]},"time":{"from":"now-24h","to":"now"},"timepicker":{"refresh_intervals":["30ms","1s","5s","10s","15s"]},"timezone":"","title":"Estação Argos","uid":"r3lvp-44k","version":8,"weekStart":""}	3	2022-11-11 21:57:11	2022-11-17 02:59:57	1	1	0		0	f	f	r3lvp-44k	f
\.


--
-- Data for Name: dashboard_acl; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.dashboard_acl (id, org_id, dashboard_id, user_id, team_id, permission, role, created, updated) FROM stdin;
1	-1	-1	\N	\N	1	Viewer	2017-06-20 00:00:00	2017-06-20 00:00:00
2	-1	-1	\N	\N	2	Editor	2017-06-20 00:00:00	2017-06-20 00:00:00
\.


--
-- Data for Name: dashboard_provisioning; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.dashboard_provisioning (id, dashboard_id, name, external_id, updated, check_sum) FROM stdin;
\.


--
-- Data for Name: dashboard_public; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.dashboard_public (uid, dashboard_uid, org_id, time_settings, template_variables, access_token, created_by, updated_by, created_at, updated_at, is_enabled) FROM stdin;
\.


--
-- Data for Name: dashboard_public_usage_by_day; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.dashboard_public_usage_by_day (id, public_dashboard_uid, day, views, queries, errors, load_duration) FROM stdin;
\.


--
-- Data for Name: dashboard_snapshot; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.dashboard_snapshot (id, name, key, delete_key, org_id, user_id, external, external_url, dashboard, expires, created, updated, external_delete_url, dashboard_encrypted) FROM stdin;
\.


--
-- Data for Name: dashboard_tag; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.dashboard_tag (id, dashboard_id, term) FROM stdin;
\.


--
-- Data for Name: dashboard_usage_by_day; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.dashboard_usage_by_day (id, dashboard_id, day, views, queries, errors, load_duration) FROM stdin;
\.


--
-- Data for Name: dashboard_usage_sums; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.dashboard_usage_sums (dashboard_id, updated, views_last_1_days, views_last_7_days, views_last_30_days, views_total, queries_last_1_days, queries_last_7_days, queries_last_30_days, queries_total, errors_last_1_days, errors_last_7_days, errors_last_30_days, errors_total) FROM stdin;
2	2022-11-11 01:25:24	0	0	0	0	0	0	0	0	0	0	0	0
\.


--
-- Data for Name: dashboard_version; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.dashboard_version (id, dashboard_id, parent_version, restored_from, version, created, created_by, message, data) FROM stdin;
3	2	8	0	1	2022-11-10 05:32:46	1		{"annotations":{"list":[{"builtIn":1,"datasource":{"type":"grafana","uid":"-- Grafana --"},"enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","target":{"limit":100,"matchAny":false,"tags":[],"type":"dashboard"},"type":"dashboard"}]},"editable":true,"fiscalYearStartMonth":0,"graphTooltip":0,"id":null,"links":[],"liveNow":true,"panels":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":0},"id":6,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom"},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":false,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  diferenca\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Vazamento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"yellow","value":null}]},"unit":"currencyBRL"},"overrides":[]},"gridPos":{"h":6,"w":6,"x":10,"y":0},"id":14,"options":{"colorMode":"value","graphMode":"area","justifyMode":"auto","orientation":"auto","reduceOptions":{"calcs":["lastNotNull"],"fields":"/.*/","values":false},"text":{"titleSize":700},"textMode":"auto"},"pluginVersion":"9.0.7","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VALOR as \\"Preço\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Preço","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":6,"w":8,"x":16,"y":0},"id":12,"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["sum"],"fields":"","values":false},"textMode":"value"},"pluginVersion":"9.0.7","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  abastecimento_efetivo as \\"Abastecido\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Abastecido","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[{"options":{"from":-1,"result":{"color":"green","index":0,"text":"Nulo"},"to":0.005},"type":"range"},{"options":{"from":0.005,"result":{"color":"yellow","index":1,"text":"Baixo"},"to":0.02},"type":"range"},{"options":{"from":0.02,"result":{"color":"orange","index":2,"text":"Médio"},"to":0.04},"type":"range"},{"options":{"from":0.04,"result":{"color":"#f74e28b8","index":3,"text":"Alto"},"to":0.06},"type":"range"},{"options":{"from":0.06,"result":{"color":"red","index":4,"text":"Crítico"},"to":0.08},"type":"range"}],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":7,"w":14,"x":10,"y":6},"id":4,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/.*/","values":false},"textMode":"auto"},"pluginVersion":"9.0.7","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VAZAMENTO as \\"Vazamento\\", SEVERIDADE_VAZAMENTO as \\"Severidade Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Vazamento","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":9},"id":2,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom"},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":false,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  entrada_combustivel,\\n  saida_combustivel\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}],[{"params":["saida_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Abastecimento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"custom":{"align":"auto","displayMode":"auto","inspect":false},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":5,"w":14,"x":10,"y":13},"id":10,"options":{"footer":{"enablePagination":false,"fields":"","reducer":["sum"],"show":false},"showHeader":true},"pluginVersion":"9.0.7","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"hide":false,"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  id as \\"Id Ordem\\",\\n  estado as \\"Estado Ordem\\",\\n  valor as \\"Preço\\"\\nFROM ordem_servico where sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["estado"],"type":"column"}]],"table":"ordem_servico","timeColumn":"id","timeColumnType":"int4","where":[{"name":"$__unixEpochFilter","params":[],"type":"macro"}]}],"title":"Estado Ordem","transparent":true,"type":"table"}],"refresh":"5s","schemaVersion":36,"style":"dark","tags":[],"templating":{"list":[]},"time":{"from":"now-24h","to":"now"},"timepicker":{"refresh_intervals":["5s","10s","15s"]},"timezone":"","title":"Estação Argos","uid":"r3lvp-44k","version":1,"weekStart":""}
4	2	1	0	2	2022-11-10 19:26:13	1		{"annotations":{"list":[{"builtIn":1,"datasource":{"type":"grafana","uid":"-- Grafana --"},"enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","target":{"limit":100,"matchAny":false,"tags":[],"type":"dashboard"},"type":"dashboard"}]},"editable":true,"fiscalYearStartMonth":0,"graphTooltip":0,"id":2,"links":[],"liveNow":true,"panels":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":0},"id":6,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":false,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  diferenca\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Vazamento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"yellow","value":null}]},"unit":"currencyBRL"},"overrides":[]},"gridPos":{"h":6,"w":6,"x":10,"y":0},"id":14,"options":{"colorMode":"value","graphMode":"area","justifyMode":"auto","orientation":"auto","reduceOptions":{"calcs":["lastNotNull"],"fields":"/.*/","values":false},"text":{"titleSize":700},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VALOR as \\"Preço\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Preço","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":6,"w":8,"x":16,"y":0},"id":12,"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["sum"],"fields":"","values":false},"textMode":"value"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  abastecimento_efetivo as \\"Abastecido\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Abastecido","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[{"options":{"from":-1,"result":{"color":"green","index":0,"text":"Nulo"},"to":0.005},"type":"range"},{"options":{"from":0.005,"result":{"color":"yellow","index":1,"text":"Baixo"},"to":0.02},"type":"range"},{"options":{"from":0.02,"result":{"color":"orange","index":2,"text":"Médio"},"to":0.04},"type":"range"},{"options":{"from":0.04,"result":{"color":"#f74e28b8","index":3,"text":"Alto"},"to":0.06},"type":"range"},{"options":{"from":0.06,"result":{"color":"red","index":4,"text":"Crítico"},"to":0.08},"type":"range"}],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":7,"w":14,"x":10,"y":6},"id":4,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/.*/","values":false},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VAZAMENTO as \\"Vazamento\\", SEVERIDADE_VAZAMENTO as \\"Severidade Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Vazamento","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":9},"id":2,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":false,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  entrada_combustivel,\\n  saida_combustivel\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}],[{"params":["saida_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Abastecimento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"custom":{"align":"auto","displayMode":"auto","inspect":false},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":5,"w":14,"x":10,"y":13},"id":10,"options":{"footer":{"enablePagination":false,"fields":"","reducer":["sum"],"show":false},"showHeader":true},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"hide":false,"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  id as \\"Id Ordem\\",\\n  estado as \\"Estado Ordem\\",\\n  valor as \\"Preço\\"\\nFROM ordem_servico where sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["estado"],"type":"column"}]],"table":"ordem_servico","timeColumn":"id","timeColumnType":"int4","where":[{"name":"$__unixEpochFilter","params":[],"type":"macro"}]}],"title":"Estado Ordem","transparent":true,"type":"table"}],"refresh":"5s","schemaVersion":37,"style":"dark","tags":[],"templating":{"list":[]},"time":{"from":"now-24h","to":"now"},"timepicker":{"refresh_intervals":["5s","10s","15s"]},"timezone":"","title":"Estação Argos","uid":"r3lvp-44k","version":2,"weekStart":""}
5	2	2	0	3	2022-11-10 19:35:58	1		{"annotations":{"list":[{"builtIn":1,"datasource":{"type":"grafana","uid":"-- Grafana --"},"enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","target":{"limit":100,"matchAny":false,"tags":[],"type":"dashboard"},"type":"dashboard"}]},"editable":true,"fiscalYearStartMonth":0,"graphTooltip":0,"id":2,"links":[],"liveNow":true,"panels":[{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":0},"id":6,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  diferenca\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Vazamento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"yellow","value":null}]},"unit":"currencyBRL"},"overrides":[]},"gridPos":{"h":6,"w":6,"x":10,"y":0},"id":14,"options":{"colorMode":"value","graphMode":"area","justifyMode":"auto","orientation":"auto","reduceOptions":{"calcs":["lastNotNull"],"fields":"/.*/","values":false},"text":{"titleSize":700},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VALOR as \\"Preço\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Preço","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":6,"w":8,"x":16,"y":0},"id":12,"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["sum"],"fields":"","values":false},"textMode":"value"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  abastecimento_efetivo as \\"Abastecido\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Abastecido","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[{"options":{"from":-1,"result":{"color":"green","index":0,"text":"Nulo"},"to":0.005},"type":"range"},{"options":{"from":0.005,"result":{"color":"yellow","index":1,"text":"Baixo"},"to":0.02},"type":"range"},{"options":{"from":0.02,"result":{"color":"orange","index":2,"text":"Médio"},"to":0.04},"type":"range"},{"options":{"from":0.04,"result":{"color":"#f74e28b8","index":3,"text":"Alto"},"to":0.06},"type":"range"},{"options":{"from":0.06,"result":{"color":"red","index":4,"text":"Crítico"},"to":0.08},"type":"range"}],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":7,"w":14,"x":10,"y":6},"id":4,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/.*/","values":false},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VAZAMENTO as \\"Vazamento\\", SEVERIDADE_VAZAMENTO as \\"Severidade Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Vazamento","transparent":true,"type":"stat"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":9},"id":2,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  entrada_combustivel,\\n  saida_combustivel\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}],[{"params":["saida_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Abastecimento","transparent":true,"type":"timeseries"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"custom":{"align":"auto","displayMode":"auto","inspect":false},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":5,"w":14,"x":10,"y":13},"id":10,"options":{"footer":{"enablePagination":false,"fields":"","reducer":["sum"],"show":false},"showHeader":true},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"hide":false,"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  id as \\"Id Ordem\\",\\n  estado as \\"Estado Ordem\\",\\n  valor as \\"Preço\\"\\nFROM ordem_servico where sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["estado"],"type":"column"}]],"table":"ordem_servico","timeColumn":"id","timeColumnType":"int4","where":[{"name":"$__unixEpochFilter","params":[],"type":"macro"}]}],"title":"Estado Ordem","transparent":true,"type":"table"}],"refresh":"5s","schemaVersion":37,"style":"dark","tags":[],"templating":{"list":[]},"time":{"from":"now-24h","to":"now"},"timepicker":{"refresh_intervals":["5s","10s","15s"]},"timezone":"","title":"Estação Argos","uid":"r3lvp-44k","version":3,"weekStart":""}
6	2	3	0	4	2022-11-10 20:24:21	1		{"annotations":{"list":[{"builtIn":1,"datasource":{"type":"grafana","uid":"-- Grafana --"},"enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","target":{"limit":100,"matchAny":false,"tags":[],"type":"dashboard"},"type":"dashboard"}]},"editable":true,"fiscalYearStartMonth":0,"graphTooltip":0,"id":2,"links":[],"liveNow":true,"panels":[{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":0},"id":6,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  diferenca\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Vazamento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"yellow","value":null}]},"unit":"currencyBRL"},"overrides":[]},"gridPos":{"h":6,"w":6,"x":10,"y":0},"id":14,"options":{"colorMode":"value","graphMode":"area","justifyMode":"auto","orientation":"auto","reduceOptions":{"calcs":["lastNotNull"],"fields":"/.*/","values":false},"text":{"titleSize":700},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VALOR as \\"Preço\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Preço","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":6,"w":8,"x":16,"y":0},"id":12,"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["sum"],"fields":"","values":false},"textMode":"value"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  abastecimento_efetivo as \\"Abastecido\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Abastecido","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":6,"x":10,"y":6},"id":4,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VAZAMENTO as \\"Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Vazamento","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":7,"x":16,"y":6},"id":15,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^SEveridade Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  SEveridade_vazamento as \\"SEveridade Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Severidade do Vazamento","transparent":true,"type":"stat"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":9},"id":2,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  entrada_combustivel,\\n  saida_combustivel\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}],[{"params":["saida_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Abastecimento","transparent":true,"type":"timeseries"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"custom":{"align":"auto","displayMode":"auto","inspect":false},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":5,"w":14,"x":10,"y":11},"id":10,"options":{"footer":{"enablePagination":false,"fields":"","reducer":["sum"],"show":false},"showHeader":true},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"hide":false,"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  id as \\"Id Ordem\\",\\n  estado as \\"Estado Ordem\\",\\n  valor as \\"Preço\\"\\nFROM ordem_servico where sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["estado"],"type":"column"}]],"table":"ordem_servico","timeColumn":"id","timeColumnType":"int4","where":[{"name":"$__unixEpochFilter","params":[],"type":"macro"}]}],"title":"Estado Ordem","transparent":true,"type":"table"}],"refresh":"5s","schemaVersion":37,"style":"dark","tags":[],"templating":{"list":[]},"time":{"from":"now-24h","to":"now"},"timepicker":{"refresh_intervals":["30ms","1s","5s","10s","15s"]},"timezone":"","title":"Estação Argos","uid":"r3lvp-44k","version":4,"weekStart":""}
7	2	4	0	5	2022-11-10 20:34:55	1		{"annotations":{"list":[{"builtIn":1,"datasource":{"type":"grafana","uid":"-- Grafana --"},"enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","target":{"limit":100,"matchAny":false,"tags":[],"type":"dashboard"},"type":"dashboard"}]},"editable":true,"fiscalYearStartMonth":0,"graphTooltip":0,"id":2,"links":[],"liveNow":true,"panels":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":6,"w":8,"x":16,"y":0},"id":12,"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["sum"],"fields":"","values":false},"textMode":"value"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  abastecimento_efetivo as \\"Abastecido\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Abastecido","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":7,"x":16,"y":6},"id":15,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^SEveridade Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  SEveridade_vazamento as \\"SEveridade Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Severidade do Vazamento","transparent":true,"type":"stat"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":8},"id":6,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  diferenca\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Vazamento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"noValue":"0","thresholds":{"mode":"absolute","steps":[{"color":"yellow","value":null}]},"unit":"currencyBRL"},"overrides":[]},"gridPos":{"h":6,"w":6,"x":10,"y":8},"id":14,"options":{"colorMode":"value","graphMode":"area","justifyMode":"auto","orientation":"auto","reduceOptions":{"calcs":["lastNotNull"],"fields":"/.*/","values":false},"text":{"titleSize":700},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VALOR as \\"Preço\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Preço","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":6,"x":10,"y":14},"id":4,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VAZAMENTO as \\"Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Vazamento","transparent":true,"type":"stat"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":17},"id":2,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  entrada_combustivel,\\n  saida_combustivel\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}],[{"params":["saida_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Abastecimento","transparent":true,"type":"timeseries"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"custom":{"align":"auto","displayMode":"auto","inspect":false},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":5,"w":14,"x":10,"y":19},"id":10,"options":{"footer":{"enablePagination":false,"fields":"","reducer":["sum"],"show":false},"showHeader":true},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"hide":false,"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  id as \\"Id Ordem\\",\\n  estado as \\"Estado Ordem\\",\\n  valor as \\"Preço\\"\\nFROM ordem_servico where sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["estado"],"type":"column"}]],"table":"ordem_servico","timeColumn":"id","timeColumnType":"int4","where":[{"name":"$__unixEpochFilter","params":[],"type":"macro"}]}],"title":"Estado Ordem","transparent":true,"type":"table"}],"refresh":"1s","schemaVersion":37,"style":"dark","tags":[],"templating":{"list":[]},"time":{"from":"now-24h","to":"now"},"timepicker":{"refresh_intervals":["30ms","1s","5s","10s","15s"]},"timezone":"","title":"Estação Argos","uid":"r3lvp-44k","version":5,"weekStart":""}
8	2	5	0	6	2022-11-10 22:35:37	1		{"annotations":{"list":[{"builtIn":1,"datasource":{"type":"grafana","uid":"-- Grafana --"},"enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","target":{"limit":100,"matchAny":false,"tags":[],"type":"dashboard"},"type":"dashboard"}]},"editable":true,"fiscalYearStartMonth":0,"graphTooltip":0,"id":2,"links":[],"liveNow":true,"panels":[{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":0},"id":6,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  diferenca\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Vazamento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"noValue":"0","thresholds":{"mode":"absolute","steps":[{"color":"yellow","value":null}]},"unit":"currencyBRL"},"overrides":[]},"gridPos":{"h":6,"w":6,"x":10,"y":0},"id":14,"options":{"colorMode":"value","graphMode":"area","justifyMode":"auto","orientation":"auto","reduceOptions":{"calcs":["lastNotNull"],"fields":"/.*/","values":false},"text":{"titleSize":700},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VALOR as \\"Preço\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Preço","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":6,"w":8,"x":16,"y":0},"id":12,"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["sum"],"fields":"","values":false},"textMode":"value"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  abastecimento_efetivo as \\"Abastecido\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Abastecido","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":6,"x":10,"y":6},"id":4,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VAZAMENTO as \\"Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Vazamento","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":7,"x":16,"y":6},"id":15,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^SEveridade Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  SEveridade_vazamento as \\"SEveridade Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Severidade do Vazamento","transparent":true,"type":"stat"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":9},"id":2,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  entrada_combustivel,\\n  saida_combustivel\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}],[{"params":["saida_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Abastecimento","transparent":true,"type":"timeseries"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"custom":{"align":"auto","displayMode":"auto","inspect":false},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":5,"w":14,"x":10,"y":11},"id":10,"options":{"footer":{"enablePagination":false,"fields":"","reducer":["sum"],"show":false},"showHeader":true},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"hide":false,"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  id as \\"Id Ordem\\",\\n  estado as \\"Estado Ordem\\",\\n  valor as \\"Preço\\"\\nFROM ordem_servico where sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["estado"],"type":"column"}]],"table":"ordem_servico","timeColumn":"id","timeColumnType":"int4","where":[{"name":"$__unixEpochFilter","params":[],"type":"macro"}]}],"title":"Estado Ordem","transparent":true,"type":"table"}],"refresh":"1s","schemaVersion":37,"style":"dark","tags":[],"templating":{"list":[]},"time":{"from":"now-24h","to":"now"},"timepicker":{"refresh_intervals":["30ms","1s","5s","10s","15s"]},"timezone":"","title":"Estação Argos","uid":"r3lvp-44k","version":6,"weekStart":""}
11	5	6	0	1	2022-11-11 21:57:11	1		{"annotations":{"list":[{"builtIn":1,"datasource":{"type":"grafana","uid":"-- Grafana --"},"enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","target":{"limit":100,"matchAny":false,"tags":[],"type":"dashboard"},"type":"dashboard"}]},"editable":true,"fiscalYearStartMonth":0,"graphTooltip":0,"id":null,"links":[],"liveNow":true,"panels":[{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":0},"id":6,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  diferenca\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Vazamento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"noValue":"0","thresholds":{"mode":"absolute","steps":[{"color":"yellow","value":null}]},"unit":"currencyBRL"},"overrides":[]},"gridPos":{"h":6,"w":6,"x":10,"y":0},"id":14,"options":{"colorMode":"value","graphMode":"area","justifyMode":"auto","orientation":"auto","reduceOptions":{"calcs":["lastNotNull"],"fields":"/.*/","values":false},"text":{"titleSize":700},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VALOR as \\"Preço\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Preço","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":6,"w":8,"x":16,"y":0},"id":12,"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["sum"],"fields":"","values":false},"textMode":"value"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  abastecimento_efetivo as \\"Abastecido\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Abastecido","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":6,"x":10,"y":6},"id":4,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VAZAMENTO as \\"Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Vazamento","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":7,"x":16,"y":6},"id":15,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^SEveridade Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"8-2W7fvVz"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  SEveridade_vazamento as \\"SEveridade Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Severidade do Vazamento","transparent":true,"type":"stat"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":9},"id":2,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  entrada_combustivel,\\n  saida_combustivel\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}],[{"params":["saida_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Abastecimento","transparent":true,"type":"timeseries"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"custom":{"align":"auto","displayMode":"auto","inspect":false},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":5,"w":14,"x":10,"y":11},"id":10,"options":{"footer":{"enablePagination":false,"fields":"","reducer":["sum"],"show":false},"showHeader":true},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"hide":false,"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  id as \\"Id Ordem\\",\\n  estado as \\"Estado Ordem\\",\\n  valor as \\"Preço\\"\\nFROM ordem_servico where sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["estado"],"type":"column"}]],"table":"ordem_servico","timeColumn":"id","timeColumnType":"int4","where":[{"name":"$__unixEpochFilter","params":[],"type":"macro"}]}],"title":"Estado Ordem","transparent":true,"type":"table"}],"refresh":"1s","schemaVersion":37,"style":"dark","tags":[],"templating":{"list":[]},"time":{"from":"now-24h","to":"now"},"timepicker":{"refresh_intervals":["30ms","1s","5s","10s","15s"]},"timezone":"","title":"Estação Argos","uid":"r3lvp-44k","version":1,"weekStart":""}
12	5	1	0	2	2022-11-11 21:58:16	1		{"annotations":{"list":[{"builtIn":1,"datasource":{"type":"grafana","uid":"-- Grafana --"},"enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","target":{"limit":100,"matchAny":false,"tags":[],"type":"dashboard"},"type":"dashboard"}]},"editable":true,"fiscalYearStartMonth":0,"graphTooltip":0,"id":5,"links":[],"liveNow":true,"panels":[{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":0},"id":6,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  diferenca\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Vazamento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"noValue":"0","thresholds":{"mode":"absolute","steps":[{"color":"yellow","value":null}]},"unit":"currencyBRL"},"overrides":[]},"gridPos":{"h":6,"w":6,"x":10,"y":0},"id":14,"options":{"colorMode":"value","graphMode":"area","justifyMode":"auto","orientation":"auto","reduceOptions":{"calcs":["lastNotNull"],"fields":"/.*/","values":false},"text":{"titleSize":700},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VALOR as \\"Preço\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Preço","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":6,"w":8,"x":16,"y":0},"id":12,"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["sum"],"fields":"","values":false},"textMode":"value"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  abastecimento_efetivo as \\"Abastecido\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Abastecido","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":6,"x":10,"y":6},"id":4,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VAZAMENTO as \\"Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Vazamento","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":7,"x":16,"y":6},"id":15,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^SEveridade Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  SEveridade_vazamento as \\"SEveridade Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Severidade do Vazamento","transparent":true,"type":"stat"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":9},"id":2,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  entrada_combustivel,\\n  saida_combustivel\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}],[{"params":["saida_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Abastecimento","transparent":true,"type":"timeseries"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"custom":{"align":"auto","displayMode":"auto","inspect":false},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":5,"w":14,"x":10,"y":11},"id":10,"options":{"footer":{"enablePagination":false,"fields":"","reducer":["sum"],"show":false},"showHeader":true},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"hide":false,"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  id as \\"Id Ordem\\",\\n  estado as \\"Estado Ordem\\",\\n  valor as \\"Preço\\"\\nFROM ordem_servico where sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["estado"],"type":"column"}]],"table":"ordem_servico","timeColumn":"id","timeColumnType":"int4","where":[{"name":"$__unixEpochFilter","params":[],"type":"macro"}]}],"title":"Estado Ordem","transparent":true,"type":"table"}],"refresh":"1s","schemaVersion":37,"style":"dark","tags":[],"templating":{"list":[]},"time":{"from":"now-24h","to":"now"},"timepicker":{"refresh_intervals":["30ms","1s","5s","10s","15s"]},"timezone":"","title":"Estação Argos","uid":"r3lvp-44k","version":2,"weekStart":""}
13	5	2	0	3	2022-11-11 22:06:58	1		{"annotations":{"list":[{"builtIn":1,"datasource":{"type":"grafana","uid":"-- Grafana --"},"enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","target":{"limit":100,"matchAny":false,"tags":[],"type":"dashboard"},"type":"dashboard"}]},"editable":true,"fiscalYearStartMonth":0,"graphTooltip":0,"id":5,"links":[],"liveNow":true,"panels":[{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":0},"id":6,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  diferenca\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Vazamento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"noValue":"0","thresholds":{"mode":"absolute","steps":[{"color":"yellow","value":null}]},"unit":"currencyBRL"},"overrides":[]},"gridPos":{"h":6,"w":6,"x":10,"y":0},"id":14,"options":{"colorMode":"value","graphMode":"area","justifyMode":"auto","orientation":"auto","reduceOptions":{"calcs":["lastNotNull"],"fields":"/.*/","values":false},"text":{"titleSize":700},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VALOR as \\"Preço\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Preço","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":6,"w":8,"x":16,"y":0},"id":12,"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["sum"],"fields":"","values":false},"textMode":"value"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  abastecimento_efetivo as \\"Abastecido\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Abastecido","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":6,"x":10,"y":6},"id":4,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VAZAMENTO as \\"Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Vazamento","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":7,"x":16,"y":6},"id":15,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^SEveridade Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  SEveridade_vazamento as \\"SEveridade Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Severidade do Vazamento","transparent":true,"type":"stat"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":9},"id":2,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  entrada_combustivel,\\n  saida_combustivel\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}],[{"params":["saida_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Abastecimento","transparent":true,"type":"timeseries"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"custom":{"align":"auto","displayMode":"auto","inspect":false},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":5,"w":14,"x":10,"y":11},"id":10,"options":{"footer":{"enablePagination":false,"fields":"","reducer":["sum"],"show":false},"showHeader":true},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"hide":false,"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  id as \\"Id Ordem\\",\\n  estado as \\"Estado Ordem\\",\\n  valor as \\"Preço\\"\\nFROM ordem_servico where sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["estado"],"type":"column"}]],"table":"ordem_servico","timeColumn":"id","timeColumnType":"int4","where":[{"name":"$__unixEpochFilter","params":[],"type":"macro"}]}],"title":"Estado Ordem","transparent":true,"type":"table"}],"refresh":"30ms","schemaVersion":37,"style":"dark","tags":[],"templating":{"list":[]},"time":{"from":"now-24h","to":"now"},"timepicker":{"refresh_intervals":["30ms","1s","5s","10s","15s"]},"timezone":"","title":"Estação Argos","uid":"r3lvp-44k","version":3,"weekStart":""}
14	5	3	0	4	2022-11-11 22:29:18	1		{"annotations":{"list":[{"builtIn":1,"datasource":{"type":"grafana","uid":"-- Grafana --"},"enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","target":{"limit":100,"matchAny":false,"tags":[],"type":"dashboard"},"type":"dashboard"}]},"editable":true,"fiscalYearStartMonth":0,"graphTooltip":0,"id":5,"links":[],"liveNow":true,"panels":[{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":0},"id":6,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  diferenca\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Vazamento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"noValue":"0","thresholds":{"mode":"absolute","steps":[{"color":"yellow","value":null}]},"unit":"currencyBRL"},"overrides":[]},"gridPos":{"h":6,"w":6,"x":10,"y":0},"id":14,"options":{"colorMode":"value","graphMode":"area","justifyMode":"auto","orientation":"auto","reduceOptions":{"calcs":["lastNotNull"],"fields":"/.*/","values":false},"text":{"titleSize":700},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VALOR as \\"Preço\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Preço","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":6,"w":8,"x":16,"y":0},"id":12,"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["sum"],"fields":"","values":false},"textMode":"value"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  abastecimento_efetivo as \\"Abastecido\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Abastecido","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":6,"x":10,"y":6},"id":4,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VAZAMENTO as \\"Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Vazamento","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":7,"x":16,"y":6},"id":15,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^SEveridade Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  SEveridade_vazamento as \\"SEveridade Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Severidade do Vazamento","transparent":true,"type":"stat"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":9,"w":10,"x":0,"y":9},"id":2,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  entrada_combustivel,\\n  saida_combustivel\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}],[{"params":["saida_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Abastecimento","transparent":true,"type":"timeseries"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"custom":{"align":"auto","displayMode":"auto","inspect":false},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":5,"w":14,"x":10,"y":11},"id":10,"options":{"footer":{"enablePagination":false,"fields":"","reducer":["sum"],"show":false},"showHeader":true},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"table","group":[],"hide":false,"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  id as \\"Id Ordem\\",\\n  estado as \\"Estado Ordem\\",\\n  valor as \\"Preço\\"\\nFROM ordem_servico where sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["estado"],"type":"column"}]],"table":"ordem_servico","timeColumn":"id","timeColumnType":"int4","where":[{"name":"$__unixEpochFilter","params":[],"type":"macro"}]}],"title":"Estado Ordem","transparent":true,"type":"table"}],"refresh":"1s","schemaVersion":37,"style":"dark","tags":[],"templating":{"list":[]},"time":{"from":"now-24h","to":"now"},"timepicker":{"refresh_intervals":["30ms","1s","5s","10s","15s"]},"timezone":"","title":"Estação Argos","uid":"r3lvp-44k","version":4,"weekStart":""}
15	5	4	0	5	2022-11-11 22:38:26	1		{"annotations":{"list":[{"builtIn":1,"datasource":{"type":"grafana","uid":"-- Grafana --"},"enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","target":{"limit":100,"matchAny":false,"tags":[],"type":"dashboard"},"type":"dashboard"}]},"editable":true,"fiscalYearStartMonth":0,"graphTooltip":0,"id":5,"links":[],"liveNow":true,"panels":[{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":6,"w":10,"x":0,"y":0},"id":6,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  diferenca\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Vazamento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"noValue":"0","thresholds":{"mode":"absolute","steps":[{"color":"yellow","value":null}]},"unit":"currencyBRL"},"overrides":[]},"gridPos":{"h":6,"w":6,"x":10,"y":0},"id":14,"options":{"colorMode":"value","graphMode":"area","justifyMode":"auto","orientation":"auto","reduceOptions":{"calcs":["lastNotNull"],"fields":"/.*/","values":false},"text":{"titleSize":700},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VALOR as \\"Preço\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Preço","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":6,"w":8,"x":16,"y":0},"id":12,"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["sum"],"fields":"","values":false},"textMode":"value"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  abastecimento_efetivo as \\"Abastecido\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Abastecido","transparent":true,"type":"stat"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":6,"w":10,"x":0,"y":6},"id":2,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  entrada_combustivel,\\n  saida_combustivel\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}],[{"params":["saida_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Abastecimento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":6,"x":10,"y":6},"id":4,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VAZAMENTO as \\"Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Vazamento","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[{"options":{"CRITICO":{"color":"dark-red","index":0}},"type":"value"}],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":7,"x":16,"y":6},"id":15,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^SEveridade Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  SEveridade_vazamento as \\"SEveridade Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Severidade do Vazamento","transparent":true,"type":"stat"}],"refresh":"1s","schemaVersion":37,"style":"dark","tags":[],"templating":{"list":[]},"time":{"from":"now-24h","to":"now"},"timepicker":{"refresh_intervals":["30ms","1s","5s","10s","15s"]},"timezone":"","title":"Estação Argos","uid":"r3lvp-44k","version":5,"weekStart":""}
16	5	5	0	6	2022-11-16 21:38:32	1		{"annotations":{"list":[{"builtIn":1,"datasource":{"type":"grafana","uid":"-- Grafana --"},"enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","target":{"limit":100,"matchAny":false,"tags":[],"type":"dashboard"},"type":"dashboard"}]},"editable":true,"fiscalYearStartMonth":0,"graphTooltip":0,"id":5,"links":[],"liveNow":true,"panels":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":6,"w":10,"x":0,"y":0},"id":6,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  diferenca\\nFROM dados_coletado\\nINNER JOIN ORDENS ON ORDENS.ID = dados_coletado.ID\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos' \\n    \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Vazamento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"noValue":"0","thresholds":{"mode":"absolute","steps":[{"color":"yellow","value":null}]},"unit":"currencyBRL"},"overrides":[]},"gridPos":{"h":6,"w":6,"x":10,"y":0},"id":14,"options":{"colorMode":"value","graphMode":"area","justifyMode":"auto","orientation":"auto","reduceOptions":{"calcs":["lastNotNull"],"fields":"/.*/","values":false},"text":{"titleSize":700},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VALOR as \\"Preço\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Preço","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":6,"w":8,"x":16,"y":0},"id":12,"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["sum"],"fields":"","values":false},"textMode":"value"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  abastecimento_efetivo as \\"Abastecido\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Abastecido","transparent":true,"type":"stat"},{"datasource":{},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":6,"w":10,"x":0,"y":6},"id":2,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  \\"timestamp\\" AS \\"time\\",\\n  entrada_combustivel,\\n  saida_combustivel\\nFROM dados_coletado\\nWHERE\\n  $__timeFilter(\\"timestamp\\") AND\\n  sensor = 'argos'\\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}],[{"params":["saida_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Abastecimento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":6,"x":10,"y":6},"id":4,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VAZAMENTO as \\"Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Vazamento","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[{"options":{"CRITICO":{"color":"dark-red","index":0}},"type":"value"}],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":7,"x":16,"y":6},"id":15,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^SEveridade Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  SEveridade_vazamento as \\"SEveridade Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Severidade do Vazamento","transparent":true,"type":"stat"}],"refresh":"1s","schemaVersion":37,"style":"dark","tags":[],"templating":{"list":[]},"time":{"from":"now-24h","to":"now"},"timepicker":{"refresh_intervals":["30ms","1s","5s","10s","15s"]},"timezone":"","title":"Estação Argos","uid":"r3lvp-44k","version":6,"weekStart":""}
17	5	6	0	7	2022-11-17 02:54:38	1		{"annotations":{"list":[{"builtIn":1,"datasource":{"type":"grafana","uid":"-- Grafana --"},"enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","target":{"limit":100,"matchAny":false,"tags":[],"type":"dashboard"},"type":"dashboard"}]},"editable":true,"fiscalYearStartMonth":0,"graphTooltip":0,"id":5,"links":[],"liveNow":true,"panels":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"smooth","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":6,"w":10,"x":0,"y":0},"id":6,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT data.timestamp as \\"time\\", data.diferenca\\nFROM dados_coletado as data INNER JOIN ORDEM_SERVICO AS ordem on data.id_ordem = ordem.id \\nWHERE ordem.estado = 'EM ANDAMENTO' \\nAND data.SENSOR = 'argos' \\nAND $__timeFilter(data.\\"timestamp\\")\\n","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Vazamento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"noValue":"0","thresholds":{"mode":"absolute","steps":[{"color":"yellow","value":null}]},"unit":"currencyBRL"},"overrides":[]},"gridPos":{"h":6,"w":6,"x":10,"y":0},"id":14,"options":{"colorMode":"value","graphMode":"area","justifyMode":"auto","orientation":"auto","reduceOptions":{"calcs":["lastNotNull"],"fields":"/.*/","values":false},"text":{"titleSize":700},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VALOR as \\"Preço\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Preço","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":6,"w":8,"x":16,"y":0},"id":12,"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["sum"],"fields":"","values":false},"textMode":"value"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  abastecimento_efetivo as \\"Abastecido\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Abastecido","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":6,"w":10,"x":0,"y":6},"id":2,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT data.timestamp as \\"time\\", \\n  data.entrada_combustivel,\\n  data.saida_combustivel\\nFROM dados_coletado as data \\nINNER JOIN ORDEM_SERVICO AS ordem on data.id_ordem = ordem.id \\nWHERE ordem.estado = 'EM ANDAMENTO' \\nAND data.SENSOR = 'argos' \\nAND $__timeFilter(data.timestamp)\\n","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}],[{"params":["saida_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Abastecimento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":6,"x":10,"y":6},"id":4,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VAZAMENTO as \\"Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Vazamento","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[{"options":{"CRITICO":{"color":"dark-red","index":0}},"type":"value"}],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":7,"x":16,"y":6},"id":15,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^SEveridade Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  SEveridade_vazamento as \\"SEveridade Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Severidade do Vazamento","transparent":true,"type":"stat"}],"refresh":"1s","schemaVersion":37,"style":"dark","tags":[],"templating":{"list":[]},"time":{"from":"now-24h","to":"now"},"timepicker":{"refresh_intervals":["30ms","1s","5s","10s","15s"]},"timezone":"","title":"Estação Argos","uid":"r3lvp-44k","version":7,"weekStart":""}
18	5	7	0	8	2022-11-17 02:59:57	1		{"annotations":{"list":[{"builtIn":1,"datasource":{"type":"grafana","uid":"-- Grafana --"},"enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","target":{"limit":100,"matchAny":false,"tags":[],"type":"dashboard"},"type":"dashboard"}]},"editable":true,"fiscalYearStartMonth":0,"graphTooltip":0,"id":5,"links":[],"liveNow":true,"panels":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"smooth","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":6,"w":10,"x":0,"y":0},"id":6,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT data.timestamp as \\"time\\", data.diferenca\\nFROM dados_coletado as data INNER JOIN ORDEM_SERVICO AS ordem on data.id_ordem = ordem.id \\nWHERE ordem.estado = 'EM ANDAMENTO' \\nAND data.SENSOR = 'argos' \\nAND $__timeFilter(data.\\"timestamp\\")\\n","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Vazamento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"noValue":"0","thresholds":{"mode":"absolute","steps":[{"color":"yellow","value":null}]},"unit":"currencyBRL"},"overrides":[]},"gridPos":{"h":6,"w":6,"x":10,"y":0},"id":14,"options":{"colorMode":"value","graphMode":"area","justifyMode":"auto","orientation":"auto","reduceOptions":{"calcs":["lastNotNull"],"fields":"/.*/","values":false},"text":{"titleSize":700},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VALOR as \\"Preço\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Preço","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":6,"w":8,"x":16,"y":0},"id":12,"options":{"colorMode":"value","graphMode":"none","justifyMode":"auto","orientation":"horizontal","reduceOptions":{"calcs":["sum"],"fields":"","values":false},"textMode":"value"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  abastecimento_efetivo as \\"Abastecido\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"title":"Abastecido","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"palette-classic"},"custom":{"axisCenteredZero":false,"axisColorMode":"text","axisLabel":"","axisPlacement":"auto","barAlignment":0,"drawStyle":"line","fillOpacity":0,"gradientMode":"none","hideFrom":{"legend":false,"tooltip":false,"viz":false},"lineInterpolation":"linear","lineWidth":1,"pointSize":5,"scaleDistribution":{"type":"linear"},"showPoints":"auto","spanNulls":false,"stacking":{"group":"A","mode":"none"},"thresholdsStyle":{"mode":"off"}},"mappings":[],"thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"red","value":80}]}},"overrides":[]},"gridPos":{"h":6,"w":10,"x":0,"y":6},"id":2,"options":{"legend":{"calcs":[],"displayMode":"list","placement":"bottom","showLegend":true},"tooltip":{"mode":"single","sort":"none"}},"targets":[{"datasource":{"type":"postgres","uid":"wXmWoll7k"},"format":"time_series","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT data.timestamp as \\"time\\", \\n  data.entrada_combustivel,\\n  data.saida_combustivel\\nFROM dados_coletado as data \\nINNER JOIN ORDEM_SERVICO AS ordem on data.id_ordem = ordem.id \\nWHERE ordem.estado = 'EM ANDAMENTO' \\nAND data.SENSOR = 'argos' \\nAND $__timeFilter(data.timestamp)\\n","refId":"A","select":[[{"params":["entrada_combustivel"],"type":"column"}],[{"params":["saida_combustivel"],"type":"column"}]],"table":"dados_coletado","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[{"name":"$__timeFilter","params":[],"type":"macro"},{"datatype":"varchar","name":"","params":["sensor","=","'argos'"],"type":"expression"}]}],"title":"Abastecimento","transparent":true,"type":"timeseries"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[],"min":0,"noValue":"0","thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"Nm3"},"overrides":[]},"gridPos":{"h":5,"w":6,"x":10,"y":6},"id":4,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  VAZAMENTO as \\"Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Vazamento","transparent":true,"type":"stat"},{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"fieldConfig":{"defaults":{"color":{"mode":"thresholds"},"mappings":[{"options":{"CRITICO":{"color":"dark-red","index":0}},"type":"value"}],"noValue":"NULO","thresholds":{"mode":"absolute","steps":[{"color":"green","value":null},{"color":"yellow","value":0.02},{"color":"orange","value":0.04},{"color":"red","value":0.06},{"color":"dark-red","value":0.08}]},"unit":"m3"},"overrides":[]},"gridPos":{"h":5,"w":7,"x":16,"y":6},"id":15,"options":{"colorMode":"value","graphMode":"area","justifyMode":"center","orientation":"vertical","reduceOptions":{"calcs":[],"fields":"/^SEveridade Vazamento$/","values":false},"text":{},"textMode":"auto"},"pluginVersion":"9.2.4","targets":[{"datasource":{"type":"postgres","uid":"x0UVWyD4k"},"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"SELECT\\n  SEveridade_vazamento as \\"SEveridade Vazamento\\"\\nFROM ordem_servico WHERE sensor = 'argos' and estado ='EM ANDAMENTO' \\nORDER BY 1","refId":"A","select":[[{"params":["diferenca"],"type":"column"}]],"table":"ordem_servico","timeColumn":"\\"timestamp\\"","timeColumnType":"timestamptz","where":[]}],"title":"Severidade do Vazamento","transparent":true,"type":"stat"}],"refresh":"1s","schemaVersion":37,"style":"dark","tags":[],"templating":{"list":[]},"time":{"from":"now-24h","to":"now"},"timepicker":{"refresh_intervals":["30ms","1s","5s","10s","15s"]},"timezone":"","title":"Estação Argos","uid":"r3lvp-44k","version":8,"weekStart":""}
\.


--
-- Data for Name: data_keys; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.data_keys (name, active, scope, provider, encrypted_data, created, updated, label) FROM stdin;
CbTK8xD4z	t	root	secretKey.v1	\\x2a5957567a4c574e6d59672a3147784d506f596c1f08e0a3c65e3b95d9d2a2d4416805ef242c9b4383a4624a458b1152dbf28b76	2022-11-10 05:27:08	2022-11-10 05:27:08	2022-11-10/root@secretKey.v1
Px84ZsvVz	t	root	secretKey.v1	\\x2a5957567a4c574e6d59672a4c6d4b6c7354666361fb959ba863597e574a4215463f6cc23b0c04e57d968327bf330c3df920b60c	2022-11-11 21:53:46	2022-11-11 21:53:46	2022-11-11/root@secretKey.v1
\.


--
-- Data for Name: data_source; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.data_source (id, org_id, version, type, name, access, url, password, "user", database, basic_auth, basic_auth_user, basic_auth_password, is_default, json_data, created, updated, with_credentials, secure_json_data, read_only, uid) FROM stdin;
2	1	2	postgres	PostgreSQL	proxy	db:5432		grafana	argos	f			t	{"postgresVersion":1200,"sslmode":"disable"}	2022-11-10 18:29:11	2022-11-10 18:38:19	f	{"password":"I1EySlVTemg0UkRSNiMqWVdWekxXTm1ZZyp4azhYYjNhbkMRwGcZYkWdVLJ61ZVECURixV0VhVPWUFp+uw=="}	f	8-2W7fvVz
3	3	4	postgres	PostgreSQL	proxy	db:5432		grafana	argos	f			t	{"postgresVersion":1200,"sslmode":"disable"}	2022-11-11 21:53:46	2022-11-11 21:54:20	f	{"password":"I1VIZzRORnB6ZGxaNiMqWVdWekxXTm1ZZyphWjBwN2JkMkWUAoux/BhY+3pNICRmkhPpnjCq2xXNEcNJkQ=="}	f	x0UVWyD4k
\.


--
-- Data for Name: data_source_acl; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.data_source_acl (id, org_id, data_source_id, team_id, user_id, permission, created, updated) FROM stdin;
\.


--
-- Data for Name: data_source_cache; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.data_source_cache (id, data_source_id, enabled, ttl_ms, created, updated, use_default_ttl, data_source_uid, ttl_resources_ms) FROM stdin;
\.


--
-- Data for Name: data_source_usage_by_day; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.data_source_usage_by_day (id, data_source_id, day, queries, errors, load_duration_ms) FROM stdin;
\.


--
-- Data for Name: entity_event; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.entity_event (id, entity_id, event_type, created) FROM stdin;
\.


--
-- Data for Name: file; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.file (path, path_hash, parent_folder_path_hash, contents, etag, cache_control, content_disposition, updated, created, size, mime_type) FROM stdin;
\.


--
-- Data for Name: file_meta; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.file_meta (path_hash, key, value) FROM stdin;
\.


--
-- Data for Name: kv_store; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.kv_store (id, org_id, namespace, key, value, created, updated) FROM stdin;
1	0	datasource	secretMigrationStatus	compatible	2022-11-10 04:43:09	2022-11-10 04:43:09
2	1	alertmanager	notifications		2022-11-10 04:58:08	2022-11-10 04:58:08
3	1	alertmanager	silences		2022-11-10 04:58:08	2022-11-10 04:58:08
8	3	alertmanager	notifications		2022-11-11 07:14:54	2022-11-11 07:14:54
9	3	alertmanager	silences		2022-11-11 07:14:54	2022-11-11 07:14:54
10	0	infra.usagestats	anonymous_id	26a19b75-3234-485a-92af-f0613fa43da1	2022-11-12 06:51:54	2022-11-12 06:51:54
11	0	infra.usagestats	last_sent	2022-11-16T06:51:54Z	2022-11-12 06:51:54	2022-11-16 06:51:54.410735
\.


--
-- Data for Name: library_element; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.library_element (id, org_id, folder_id, uid, name, kind, type, description, model, created, created_by, updated, updated_by, version) FROM stdin;
\.


--
-- Data for Name: library_element_connection; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.library_element_connection (id, element_id, kind, connection_id, created, created_by) FROM stdin;
\.


--
-- Data for Name: license_token; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.license_token (id, token, created, updated) FROM stdin;
\.


--
-- Data for Name: login_attempt; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.login_attempt (id, username, ip_address, created) FROM stdin;
\.


--
-- Data for Name: migration_log; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.migration_log (id, migration_id, sql, success, error, "timestamp") FROM stdin;
1	create migration_log table	CREATE TABLE IF NOT EXISTS "migration_log" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "migration_id" VARCHAR(255) NOT NULL\n, "sql" TEXT NOT NULL\n, "success" BOOL NOT NULL\n, "error" TEXT NOT NULL\n, "timestamp" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:34
2	create user table	CREATE TABLE IF NOT EXISTS "user" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" INTEGER NOT NULL\n, "login" VARCHAR(190) NOT NULL\n, "email" VARCHAR(190) NOT NULL\n, "name" VARCHAR(255) NULL\n, "password" VARCHAR(255) NULL\n, "salt" VARCHAR(50) NULL\n, "rands" VARCHAR(50) NULL\n, "company" VARCHAR(255) NULL\n, "account_id" BIGINT NOT NULL\n, "is_admin" BOOL NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:34
3	add unique index user.login	CREATE UNIQUE INDEX "UQE_user_login" ON "user" ("login");	t		2022-11-10 04:42:35
4	add unique index user.email	CREATE UNIQUE INDEX "UQE_user_email" ON "user" ("email");	t		2022-11-10 04:42:35
5	drop index UQE_user_login - v1	DROP INDEX "UQE_user_login" CASCADE	t		2022-11-10 04:42:35
6	drop index UQE_user_email - v1	DROP INDEX "UQE_user_email" CASCADE	t		2022-11-10 04:42:35
7	Rename table user to user_v1 - v1	ALTER TABLE "user" RENAME TO "user_v1"	t		2022-11-10 04:42:35
8	create user table v2	CREATE TABLE IF NOT EXISTS "user" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" INTEGER NOT NULL\n, "login" VARCHAR(190) NOT NULL\n, "email" VARCHAR(190) NOT NULL\n, "name" VARCHAR(255) NULL\n, "password" VARCHAR(255) NULL\n, "salt" VARCHAR(50) NULL\n, "rands" VARCHAR(50) NULL\n, "company" VARCHAR(255) NULL\n, "org_id" BIGINT NOT NULL\n, "is_admin" BOOL NOT NULL\n, "email_verified" BOOL NULL\n, "theme" VARCHAR(255) NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:35
9	create index UQE_user_login - v2	CREATE UNIQUE INDEX "UQE_user_login" ON "user" ("login");	t		2022-11-10 04:42:35
10	create index UQE_user_email - v2	CREATE UNIQUE INDEX "UQE_user_email" ON "user" ("email");	t		2022-11-10 04:42:35
11	copy data_source v1 to v2	INSERT INTO "user" ("created"\n, "login"\n, "email"\n, "password"\n, "org_id"\n, "rands"\n, "company"\n, "is_admin"\n, "updated"\n, "id"\n, "version"\n, "name"\n, "salt") SELECT "created"\n, "login"\n, "email"\n, "password"\n, "account_id"\n, "rands"\n, "company"\n, "is_admin"\n, "updated"\n, "id"\n, "version"\n, "name"\n, "salt" FROM "user_v1"	t		2022-11-10 04:42:35
12	Drop old table user_v1	DROP TABLE IF EXISTS "user_v1"	t		2022-11-10 04:42:35
13	Add column help_flags1 to user table	alter table "user" ADD COLUMN "help_flags1" BIGINT NOT NULL DEFAULT 0 	t		2022-11-10 04:42:35
14	Update user table charset	ALTER TABLE "user" ALTER "login" TYPE VARCHAR(190), ALTER "email" TYPE VARCHAR(190), ALTER "name" TYPE VARCHAR(255), ALTER "password" TYPE VARCHAR(255), ALTER "salt" TYPE VARCHAR(50), ALTER "rands" TYPE VARCHAR(50), ALTER "company" TYPE VARCHAR(255), ALTER "theme" TYPE VARCHAR(255);	t		2022-11-10 04:42:35
15	Add last_seen_at column to user	alter table "user" ADD COLUMN "last_seen_at" TIMESTAMP NULL 	t		2022-11-10 04:42:35
16	Add missing user data	code migration	t		2022-11-10 04:42:35
17	Add is_disabled column to user	alter table "user" ADD COLUMN "is_disabled" BOOL NOT NULL DEFAULT FALSE 	t		2022-11-10 04:42:35
18	Add index user.login/user.email	CREATE INDEX "IDX_user_login_email" ON "user" ("login","email");	t		2022-11-10 04:42:35
19	Add is_service_account column to user	alter table "user" ADD COLUMN "is_service_account" BOOL NOT NULL DEFAULT FALSE 	t		2022-11-10 04:42:36
20	Update is_service_account column to nullable	ALTER TABLE `user` ALTER COLUMN is_service_account DROP NOT NULL;	t		2022-11-10 04:42:36
21	create temp user table v1-7	CREATE TABLE IF NOT EXISTS "temp_user" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "version" INTEGER NOT NULL\n, "email" VARCHAR(190) NOT NULL\n, "name" VARCHAR(255) NULL\n, "role" VARCHAR(20) NULL\n, "code" VARCHAR(190) NOT NULL\n, "status" VARCHAR(20) NOT NULL\n, "invited_by_user_id" BIGINT NULL\n, "email_sent" BOOL NOT NULL\n, "email_sent_on" TIMESTAMP NULL\n, "remote_addr" VARCHAR(255) NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:36
22	create index IDX_temp_user_email - v1-7	CREATE INDEX "IDX_temp_user_email" ON "temp_user" ("email");	t		2022-11-10 04:42:36
23	create index IDX_temp_user_org_id - v1-7	CREATE INDEX "IDX_temp_user_org_id" ON "temp_user" ("org_id");	t		2022-11-10 04:42:36
24	create index IDX_temp_user_code - v1-7	CREATE INDEX "IDX_temp_user_code" ON "temp_user" ("code");	t		2022-11-10 04:42:36
25	create index IDX_temp_user_status - v1-7	CREATE INDEX "IDX_temp_user_status" ON "temp_user" ("status");	t		2022-11-10 04:42:36
26	Update temp_user table charset	ALTER TABLE "temp_user" ALTER "email" TYPE VARCHAR(190), ALTER "name" TYPE VARCHAR(255), ALTER "role" TYPE VARCHAR(20), ALTER "code" TYPE VARCHAR(190), ALTER "status" TYPE VARCHAR(20), ALTER "remote_addr" TYPE VARCHAR(255);	t		2022-11-10 04:42:36
27	drop index IDX_temp_user_email - v1	DROP INDEX "IDX_temp_user_email" CASCADE	t		2022-11-10 04:42:36
28	drop index IDX_temp_user_org_id - v1	DROP INDEX "IDX_temp_user_org_id" CASCADE	t		2022-11-10 04:42:36
29	drop index IDX_temp_user_code - v1	DROP INDEX "IDX_temp_user_code" CASCADE	t		2022-11-10 04:42:36
30	drop index IDX_temp_user_status - v1	DROP INDEX "IDX_temp_user_status" CASCADE	t		2022-11-10 04:42:36
31	Rename table temp_user to temp_user_tmp_qwerty - v1	ALTER TABLE "temp_user" RENAME TO "temp_user_tmp_qwerty"	t		2022-11-10 04:42:36
32	create temp_user v2	CREATE TABLE IF NOT EXISTS "temp_user" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "version" INTEGER NOT NULL\n, "email" VARCHAR(190) NOT NULL\n, "name" VARCHAR(255) NULL\n, "role" VARCHAR(20) NULL\n, "code" VARCHAR(190) NOT NULL\n, "status" VARCHAR(20) NOT NULL\n, "invited_by_user_id" BIGINT NULL\n, "email_sent" BOOL NOT NULL\n, "email_sent_on" TIMESTAMP NULL\n, "remote_addr" VARCHAR(255) NULL\n, "created" INTEGER NOT NULL DEFAULT 0\n, "updated" INTEGER NOT NULL DEFAULT 0\n);	t		2022-11-10 04:42:36
33	create index IDX_temp_user_email - v2	CREATE INDEX "IDX_temp_user_email" ON "temp_user" ("email");	t		2022-11-10 04:42:36
34	create index IDX_temp_user_org_id - v2	CREATE INDEX "IDX_temp_user_org_id" ON "temp_user" ("org_id");	t		2022-11-10 04:42:36
35	create index IDX_temp_user_code - v2	CREATE INDEX "IDX_temp_user_code" ON "temp_user" ("code");	t		2022-11-10 04:42:37
36	create index IDX_temp_user_status - v2	CREATE INDEX "IDX_temp_user_status" ON "temp_user" ("status");	t		2022-11-10 04:42:37
37	copy temp_user v1 to v2	INSERT INTO "temp_user" ("version"\n, "email"\n, "code"\n, "status"\n, "remote_addr"\n, "id"\n, "org_id"\n, "name"\n, "role"\n, "invited_by_user_id"\n, "email_sent"\n, "email_sent_on") SELECT "version"\n, "email"\n, "code"\n, "status"\n, "remote_addr"\n, "id"\n, "org_id"\n, "name"\n, "role"\n, "invited_by_user_id"\n, "email_sent"\n, "email_sent_on" FROM "temp_user_tmp_qwerty"	t		2022-11-10 04:42:37
38	drop temp_user_tmp_qwerty	DROP TABLE IF EXISTS "temp_user_tmp_qwerty"	t		2022-11-10 04:42:37
39	Set created for temp users that will otherwise prematurely expire	code migration	t		2022-11-10 04:42:37
165	Add column team_id in preferences	alter table "preferences" ADD COLUMN "team_id" BIGINT NULL 	t		2022-11-10 04:42:44
40	create star table	CREATE TABLE IF NOT EXISTS "star" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "user_id" BIGINT NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n);	t		2022-11-10 04:42:37
41	add unique index star.user_id_dashboard_id	CREATE UNIQUE INDEX "UQE_star_user_id_dashboard_id" ON "star" ("user_id","dashboard_id");	t		2022-11-10 04:42:37
42	create org table v1	CREATE TABLE IF NOT EXISTS "org" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" INTEGER NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "address1" VARCHAR(255) NULL\n, "address2" VARCHAR(255) NULL\n, "city" VARCHAR(255) NULL\n, "state" VARCHAR(255) NULL\n, "zip_code" VARCHAR(50) NULL\n, "country" VARCHAR(255) NULL\n, "billing_email" VARCHAR(255) NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:37
43	create index UQE_org_name - v1	CREATE UNIQUE INDEX "UQE_org_name" ON "org" ("name");	t		2022-11-10 04:42:37
44	create org_user table v1	CREATE TABLE IF NOT EXISTS "org_user" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "user_id" BIGINT NOT NULL\n, "role" VARCHAR(20) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:37
45	create index IDX_org_user_org_id - v1	CREATE INDEX "IDX_org_user_org_id" ON "org_user" ("org_id");	t		2022-11-10 04:42:37
46	create index UQE_org_user_org_id_user_id - v1	CREATE UNIQUE INDEX "UQE_org_user_org_id_user_id" ON "org_user" ("org_id","user_id");	t		2022-11-10 04:42:37
47	create index IDX_org_user_user_id - v1	CREATE INDEX "IDX_org_user_user_id" ON "org_user" ("user_id");	t		2022-11-10 04:42:37
48	Update org table charset	ALTER TABLE "org" ALTER "name" TYPE VARCHAR(190), ALTER "address1" TYPE VARCHAR(255), ALTER "address2" TYPE VARCHAR(255), ALTER "city" TYPE VARCHAR(255), ALTER "state" TYPE VARCHAR(255), ALTER "zip_code" TYPE VARCHAR(50), ALTER "country" TYPE VARCHAR(255), ALTER "billing_email" TYPE VARCHAR(255);	t		2022-11-10 04:42:38
49	Update org_user table charset	ALTER TABLE "org_user" ALTER "role" TYPE VARCHAR(20);	t		2022-11-10 04:42:38
50	Migrate all Read Only Viewers to Viewers	UPDATE org_user SET role = 'Viewer' WHERE role = 'Read Only Editor'	t		2022-11-10 04:42:38
51	create dashboard table	CREATE TABLE IF NOT EXISTS "dashboard" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" INTEGER NOT NULL\n, "slug" VARCHAR(189) NOT NULL\n, "title" VARCHAR(255) NOT NULL\n, "data" TEXT NOT NULL\n, "account_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:38
52	add index dashboard.account_id	CREATE INDEX "IDX_dashboard_account_id" ON "dashboard" ("account_id");	t		2022-11-10 04:42:38
53	add unique index dashboard_account_id_slug	CREATE UNIQUE INDEX "UQE_dashboard_account_id_slug" ON "dashboard" ("account_id","slug");	t		2022-11-10 04:42:38
54	create dashboard_tag table	CREATE TABLE IF NOT EXISTS "dashboard_tag" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n, "term" VARCHAR(50) NOT NULL\n);	t		2022-11-10 04:42:38
55	add unique index dashboard_tag.dasboard_id_term	CREATE UNIQUE INDEX "UQE_dashboard_tag_dashboard_id_term" ON "dashboard_tag" ("dashboard_id","term");	t		2022-11-10 04:42:38
56	drop index UQE_dashboard_tag_dashboard_id_term - v1	DROP INDEX "UQE_dashboard_tag_dashboard_id_term" CASCADE	t		2022-11-10 04:42:38
57	Rename table dashboard to dashboard_v1 - v1	ALTER TABLE "dashboard" RENAME TO "dashboard_v1"	t		2022-11-10 04:42:38
58	create dashboard v2	CREATE TABLE IF NOT EXISTS "dashboard" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" INTEGER NOT NULL\n, "slug" VARCHAR(189) NOT NULL\n, "title" VARCHAR(255) NOT NULL\n, "data" TEXT NOT NULL\n, "org_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:38
59	create index IDX_dashboard_org_id - v2	CREATE INDEX "IDX_dashboard_org_id" ON "dashboard" ("org_id");	t		2022-11-10 04:42:38
60	create index UQE_dashboard_org_id_slug - v2	CREATE UNIQUE INDEX "UQE_dashboard_org_id_slug" ON "dashboard" ("org_id","slug");	t		2022-11-10 04:42:39
61	copy dashboard v1 to v2	INSERT INTO "dashboard" ("data"\n, "org_id"\n, "created"\n, "updated"\n, "id"\n, "version"\n, "slug"\n, "title") SELECT "data"\n, "account_id"\n, "created"\n, "updated"\n, "id"\n, "version"\n, "slug"\n, "title" FROM "dashboard_v1"	t		2022-11-10 04:42:39
62	drop table dashboard_v1	DROP TABLE IF EXISTS "dashboard_v1"	t		2022-11-10 04:42:39
63	alter dashboard.data to mediumtext v1	SELECT 0;	t		2022-11-10 04:42:39
64	Add column updated_by in dashboard - v2	alter table "dashboard" ADD COLUMN "updated_by" INTEGER NULL 	t		2022-11-10 04:42:39
65	Add column created_by in dashboard - v2	alter table "dashboard" ADD COLUMN "created_by" INTEGER NULL 	t		2022-11-10 04:42:39
66	Add column gnetId in dashboard	alter table "dashboard" ADD COLUMN "gnet_id" BIGINT NULL 	t		2022-11-10 04:42:39
67	Add index for gnetId in dashboard	CREATE INDEX "IDX_dashboard_gnet_id" ON "dashboard" ("gnet_id");	t		2022-11-10 04:42:39
68	Add column plugin_id in dashboard	alter table "dashboard" ADD COLUMN "plugin_id" VARCHAR(189) NULL 	t		2022-11-10 04:42:39
69	Add index for plugin_id in dashboard	CREATE INDEX "IDX_dashboard_org_id_plugin_id" ON "dashboard" ("org_id","plugin_id");	t		2022-11-10 04:42:39
70	Add index for dashboard_id in dashboard_tag	CREATE INDEX "IDX_dashboard_tag_dashboard_id" ON "dashboard_tag" ("dashboard_id");	t		2022-11-10 04:42:39
71	Update dashboard table charset	ALTER TABLE "dashboard" ALTER "slug" TYPE VARCHAR(189), ALTER "title" TYPE VARCHAR(255), ALTER "plugin_id" TYPE VARCHAR(189), ALTER "data" TYPE TEXT;	t		2022-11-10 04:42:39
72	Update dashboard_tag table charset	ALTER TABLE "dashboard_tag" ALTER "term" TYPE VARCHAR(50);	t		2022-11-10 04:42:39
73	Add column folder_id in dashboard	alter table "dashboard" ADD COLUMN "folder_id" BIGINT NOT NULL DEFAULT 0 	t		2022-11-10 04:42:39
74	Add column isFolder in dashboard	alter table "dashboard" ADD COLUMN "is_folder" BOOL NOT NULL DEFAULT FALSE 	t		2022-11-10 04:42:39
75	Add column has_acl in dashboard	alter table "dashboard" ADD COLUMN "has_acl" BOOL NOT NULL DEFAULT FALSE 	t		2022-11-10 04:42:39
76	Add column uid in dashboard	alter table "dashboard" ADD COLUMN "uid" VARCHAR(40) NULL 	t		2022-11-10 04:42:39
77	Update uid column values in dashboard	UPDATE dashboard SET uid=lpad('' || id::text,9,'0') WHERE uid IS NULL;	t		2022-11-10 04:42:39
78	Add unique index dashboard_org_id_uid	CREATE UNIQUE INDEX "UQE_dashboard_org_id_uid" ON "dashboard" ("org_id","uid");	t		2022-11-10 04:42:39
79	Remove unique index org_id_slug	DROP INDEX "UQE_dashboard_org_id_slug" CASCADE	t		2022-11-10 04:42:39
80	Update dashboard title length	ALTER TABLE "dashboard" ALTER "title" TYPE VARCHAR(189);	t		2022-11-10 04:42:39
81	Add unique index for dashboard_org_id_title_folder_id	CREATE UNIQUE INDEX "UQE_dashboard_org_id_folder_id_title" ON "dashboard" ("org_id","folder_id","title");	t		2022-11-10 04:42:40
82	create dashboard_provisioning	CREATE TABLE IF NOT EXISTS "dashboard_provisioning" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "dashboard_id" BIGINT NULL\n, "name" VARCHAR(150) NOT NULL\n, "external_id" TEXT NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:40
83	Rename table dashboard_provisioning to dashboard_provisioning_tmp_qwerty - v1	ALTER TABLE "dashboard_provisioning" RENAME TO "dashboard_provisioning_tmp_qwerty"	t		2022-11-10 04:42:40
84	create dashboard_provisioning v2	CREATE TABLE IF NOT EXISTS "dashboard_provisioning" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "dashboard_id" BIGINT NULL\n, "name" VARCHAR(150) NOT NULL\n, "external_id" TEXT NOT NULL\n, "updated" INTEGER NOT NULL DEFAULT 0\n);	t		2022-11-10 04:42:40
85	create index IDX_dashboard_provisioning_dashboard_id - v2	CREATE INDEX "IDX_dashboard_provisioning_dashboard_id" ON "dashboard_provisioning" ("dashboard_id");	t		2022-11-10 04:42:40
86	create index IDX_dashboard_provisioning_dashboard_id_name - v2	CREATE INDEX "IDX_dashboard_provisioning_dashboard_id_name" ON "dashboard_provisioning" ("dashboard_id","name");	t		2022-11-10 04:42:40
87	copy dashboard_provisioning v1 to v2	INSERT INTO "dashboard_provisioning" ("external_id"\n, "id"\n, "dashboard_id"\n, "name") SELECT "external_id"\n, "id"\n, "dashboard_id"\n, "name" FROM "dashboard_provisioning_tmp_qwerty"	t		2022-11-10 04:42:40
88	drop dashboard_provisioning_tmp_qwerty	DROP TABLE IF EXISTS "dashboard_provisioning_tmp_qwerty"	t		2022-11-10 04:42:40
89	Add check_sum column	alter table "dashboard_provisioning" ADD COLUMN "check_sum" VARCHAR(32) NULL 	t		2022-11-10 04:42:40
90	Add index for dashboard_title	CREATE INDEX "IDX_dashboard_title" ON "dashboard" ("title");	t		2022-11-10 04:42:40
91	delete tags for deleted dashboards	DELETE FROM dashboard_tag WHERE dashboard_id NOT IN (SELECT id FROM dashboard)	t		2022-11-10 04:42:40
92	delete stars for deleted dashboards	DELETE FROM star WHERE dashboard_id NOT IN (SELECT id FROM dashboard)	t		2022-11-10 04:42:40
93	Add index for dashboard_is_folder	CREATE INDEX "IDX_dashboard_is_folder" ON "dashboard" ("is_folder");	t		2022-11-10 04:42:40
94	Add isPublic for dashboard	alter table "dashboard" ADD COLUMN "is_public" BOOL NOT NULL DEFAULT FALSE 	t		2022-11-10 04:42:40
95	create data_source table	CREATE TABLE IF NOT EXISTS "data_source" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "account_id" BIGINT NOT NULL\n, "version" INTEGER NOT NULL\n, "type" VARCHAR(255) NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "access" VARCHAR(255) NOT NULL\n, "url" VARCHAR(255) NOT NULL\n, "password" VARCHAR(255) NULL\n, "user" VARCHAR(255) NULL\n, "database" VARCHAR(255) NULL\n, "basic_auth" BOOL NOT NULL\n, "basic_auth_user" VARCHAR(255) NULL\n, "basic_auth_password" VARCHAR(255) NULL\n, "is_default" BOOL NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:40
96	add index data_source.account_id	CREATE INDEX "IDX_data_source_account_id" ON "data_source" ("account_id");	t		2022-11-10 04:42:41
97	add unique index data_source.account_id_name	CREATE UNIQUE INDEX "UQE_data_source_account_id_name" ON "data_source" ("account_id","name");	t		2022-11-10 04:42:41
98	drop index IDX_data_source_account_id - v1	DROP INDEX "IDX_data_source_account_id" CASCADE	t		2022-11-10 04:42:41
99	drop index UQE_data_source_account_id_name - v1	DROP INDEX "UQE_data_source_account_id_name" CASCADE	t		2022-11-10 04:42:41
100	Rename table data_source to data_source_v1 - v1	ALTER TABLE "data_source" RENAME TO "data_source_v1"	t		2022-11-10 04:42:41
101	create data_source table v2	CREATE TABLE IF NOT EXISTS "data_source" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "version" INTEGER NOT NULL\n, "type" VARCHAR(255) NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "access" VARCHAR(255) NOT NULL\n, "url" VARCHAR(255) NOT NULL\n, "password" VARCHAR(255) NULL\n, "user" VARCHAR(255) NULL\n, "database" VARCHAR(255) NULL\n, "basic_auth" BOOL NOT NULL\n, "basic_auth_user" VARCHAR(255) NULL\n, "basic_auth_password" VARCHAR(255) NULL\n, "is_default" BOOL NOT NULL\n, "json_data" TEXT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:41
102	create index IDX_data_source_org_id - v2	CREATE INDEX "IDX_data_source_org_id" ON "data_source" ("org_id");	t		2022-11-10 04:42:41
103	create index UQE_data_source_org_id_name - v2	CREATE UNIQUE INDEX "UQE_data_source_org_id_name" ON "data_source" ("org_id","name");	t		2022-11-10 04:42:41
104	Drop old table data_source_v1 #2	DROP TABLE IF EXISTS "data_source_v1"	t		2022-11-10 04:42:41
105	Add column with_credentials	alter table "data_source" ADD COLUMN "with_credentials" BOOL NOT NULL DEFAULT FALSE 	t		2022-11-10 04:42:41
106	Add secure json data column	alter table "data_source" ADD COLUMN "secure_json_data" TEXT NULL 	t		2022-11-10 04:42:41
107	Update data_source table charset	ALTER TABLE "data_source" ALTER "type" TYPE VARCHAR(255), ALTER "name" TYPE VARCHAR(190), ALTER "access" TYPE VARCHAR(255), ALTER "url" TYPE VARCHAR(255), ALTER "password" TYPE VARCHAR(255), ALTER "user" TYPE VARCHAR(255), ALTER "database" TYPE VARCHAR(255), ALTER "basic_auth_user" TYPE VARCHAR(255), ALTER "basic_auth_password" TYPE VARCHAR(255), ALTER "json_data" TYPE TEXT, ALTER "secure_json_data" TYPE TEXT;	t		2022-11-10 04:42:41
108	Update initial version to 1	UPDATE data_source SET version = 1 WHERE version = 0	t		2022-11-10 04:42:41
109	Add read_only data column	alter table "data_source" ADD COLUMN "read_only" BOOL NULL 	t		2022-11-10 04:42:41
110	Migrate logging ds to loki ds	UPDATE data_source SET type = 'loki' WHERE type = 'logging'	t		2022-11-10 04:42:41
111	Update json_data with nulls	UPDATE data_source SET json_data = '{}' WHERE json_data is null	t		2022-11-10 04:42:41
112	Add uid column	alter table "data_source" ADD COLUMN "uid" VARCHAR(40) NOT NULL DEFAULT 0 	t		2022-11-10 04:42:41
113	Update uid value	UPDATE data_source SET uid=lpad('' || id::text,9,'0');	t		2022-11-10 04:42:41
114	Add unique index datasource_org_id_uid	CREATE UNIQUE INDEX "UQE_data_source_org_id_uid" ON "data_source" ("org_id","uid");	t		2022-11-10 04:42:41
115	add unique index datasource_org_id_is_default	CREATE INDEX "IDX_data_source_org_id_is_default" ON "data_source" ("org_id","is_default");	t		2022-11-10 04:42:41
116	create api_key table	CREATE TABLE IF NOT EXISTS "api_key" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "account_id" BIGINT NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "key" VARCHAR(64) NOT NULL\n, "role" VARCHAR(255) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:41
117	add index api_key.account_id	CREATE INDEX "IDX_api_key_account_id" ON "api_key" ("account_id");	t		2022-11-10 04:42:42
118	add index api_key.key	CREATE UNIQUE INDEX "UQE_api_key_key" ON "api_key" ("key");	t		2022-11-10 04:42:42
119	add index api_key.account_id_name	CREATE UNIQUE INDEX "UQE_api_key_account_id_name" ON "api_key" ("account_id","name");	t		2022-11-10 04:42:42
120	drop index IDX_api_key_account_id - v1	DROP INDEX "IDX_api_key_account_id" CASCADE	t		2022-11-10 04:42:42
121	drop index UQE_api_key_key - v1	DROP INDEX "UQE_api_key_key" CASCADE	t		2022-11-10 04:42:42
122	drop index UQE_api_key_account_id_name - v1	DROP INDEX "UQE_api_key_account_id_name" CASCADE	t		2022-11-10 04:42:42
123	Rename table api_key to api_key_v1 - v1	ALTER TABLE "api_key" RENAME TO "api_key_v1"	t		2022-11-10 04:42:42
164	Update preferences table charset	ALTER TABLE "preferences" ALTER "timezone" TYPE VARCHAR(50), ALTER "theme" TYPE VARCHAR(20);	t		2022-11-10 04:42:44
124	create api_key table v2	CREATE TABLE IF NOT EXISTS "api_key" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "key" VARCHAR(190) NOT NULL\n, "role" VARCHAR(255) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:42
125	create index IDX_api_key_org_id - v2	CREATE INDEX "IDX_api_key_org_id" ON "api_key" ("org_id");	t		2022-11-10 04:42:42
126	create index UQE_api_key_key - v2	CREATE UNIQUE INDEX "UQE_api_key_key" ON "api_key" ("key");	t		2022-11-10 04:42:42
127	create index UQE_api_key_org_id_name - v2	CREATE UNIQUE INDEX "UQE_api_key_org_id_name" ON "api_key" ("org_id","name");	t		2022-11-10 04:42:42
128	copy api_key v1 to v2	INSERT INTO "api_key" ("updated"\n, "id"\n, "org_id"\n, "name"\n, "key"\n, "role"\n, "created") SELECT "updated"\n, "id"\n, "account_id"\n, "name"\n, "key"\n, "role"\n, "created" FROM "api_key_v1"	t		2022-11-10 04:42:42
129	Drop old table api_key_v1	DROP TABLE IF EXISTS "api_key_v1"	t		2022-11-10 04:42:42
130	Update api_key table charset	ALTER TABLE "api_key" ALTER "name" TYPE VARCHAR(190), ALTER "key" TYPE VARCHAR(190), ALTER "role" TYPE VARCHAR(255);	t		2022-11-10 04:42:42
131	Add expires to api_key table	alter table "api_key" ADD COLUMN "expires" BIGINT NULL 	t		2022-11-10 04:42:42
132	Add service account foreign key	alter table "api_key" ADD COLUMN "service_account_id" BIGINT NULL 	t		2022-11-10 04:42:42
133	set service account foreign key to nil if 0	UPDATE api_key SET service_account_id = NULL WHERE service_account_id = 0;	t		2022-11-10 04:42:42
134	Add last_used_at to api_key table	alter table "api_key" ADD COLUMN "last_used_at" TIMESTAMP NULL 	t		2022-11-10 04:42:42
135	Add is_revoked column to api_key table	alter table "api_key" ADD COLUMN "is_revoked" BOOL NULL DEFAULT FALSE 	t		2022-11-10 04:42:42
136	create dashboard_snapshot table v4	CREATE TABLE IF NOT EXISTS "dashboard_snapshot" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "name" VARCHAR(255) NOT NULL\n, "key" VARCHAR(190) NOT NULL\n, "dashboard" TEXT NOT NULL\n, "expires" TIMESTAMP NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:42
137	drop table dashboard_snapshot_v4 #1	DROP TABLE IF EXISTS "dashboard_snapshot"	t		2022-11-10 04:42:43
138	create dashboard_snapshot table v5 #2	CREATE TABLE IF NOT EXISTS "dashboard_snapshot" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "name" VARCHAR(255) NOT NULL\n, "key" VARCHAR(190) NOT NULL\n, "delete_key" VARCHAR(190) NOT NULL\n, "org_id" BIGINT NOT NULL\n, "user_id" BIGINT NOT NULL\n, "external" BOOL NOT NULL\n, "external_url" VARCHAR(255) NOT NULL\n, "dashboard" TEXT NOT NULL\n, "expires" TIMESTAMP NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:43
139	create index UQE_dashboard_snapshot_key - v5	CREATE UNIQUE INDEX "UQE_dashboard_snapshot_key" ON "dashboard_snapshot" ("key");	t		2022-11-10 04:42:43
140	create index UQE_dashboard_snapshot_delete_key - v5	CREATE UNIQUE INDEX "UQE_dashboard_snapshot_delete_key" ON "dashboard_snapshot" ("delete_key");	t		2022-11-10 04:42:43
141	create index IDX_dashboard_snapshot_user_id - v5	CREATE INDEX "IDX_dashboard_snapshot_user_id" ON "dashboard_snapshot" ("user_id");	t		2022-11-10 04:42:43
142	alter dashboard_snapshot to mediumtext v2	SELECT 0;	t		2022-11-10 04:42:43
143	Update dashboard_snapshot table charset	ALTER TABLE "dashboard_snapshot" ALTER "name" TYPE VARCHAR(255), ALTER "key" TYPE VARCHAR(190), ALTER "delete_key" TYPE VARCHAR(190), ALTER "external_url" TYPE VARCHAR(255), ALTER "dashboard" TYPE TEXT;	t		2022-11-10 04:42:43
144	Add column external_delete_url to dashboard_snapshots table	alter table "dashboard_snapshot" ADD COLUMN "external_delete_url" VARCHAR(255) NULL 	t		2022-11-10 04:42:43
145	Add encrypted dashboard json column	alter table "dashboard_snapshot" ADD COLUMN "dashboard_encrypted" BYTEA NULL 	t		2022-11-10 04:42:43
146	Change dashboard_encrypted column to MEDIUMBLOB	SELECT 0;	t		2022-11-10 04:42:43
147	create quota table v1	CREATE TABLE IF NOT EXISTS "quota" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NULL\n, "user_id" BIGINT NULL\n, "target" VARCHAR(190) NOT NULL\n, "limit" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:43
148	create index UQE_quota_org_id_user_id_target - v1	CREATE UNIQUE INDEX "UQE_quota_org_id_user_id_target" ON "quota" ("org_id","user_id","target");	t		2022-11-10 04:42:43
149	Update quota table charset	ALTER TABLE "quota" ALTER "target" TYPE VARCHAR(190);	t		2022-11-10 04:42:43
150	create plugin_setting table	CREATE TABLE IF NOT EXISTS "plugin_setting" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NULL\n, "plugin_id" VARCHAR(190) NOT NULL\n, "enabled" BOOL NOT NULL\n, "pinned" BOOL NOT NULL\n, "json_data" TEXT NULL\n, "secure_json_data" TEXT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:43
151	create index UQE_plugin_setting_org_id_plugin_id - v1	CREATE UNIQUE INDEX "UQE_plugin_setting_org_id_plugin_id" ON "plugin_setting" ("org_id","plugin_id");	t		2022-11-10 04:42:43
152	Add column plugin_version to plugin_settings	alter table "plugin_setting" ADD COLUMN "plugin_version" VARCHAR(50) NULL 	t		2022-11-10 04:42:44
153	Update plugin_setting table charset	ALTER TABLE "plugin_setting" ALTER "plugin_id" TYPE VARCHAR(190), ALTER "json_data" TYPE TEXT, ALTER "secure_json_data" TYPE TEXT, ALTER "plugin_version" TYPE VARCHAR(50);	t		2022-11-10 04:42:44
154	create session table	CREATE TABLE IF NOT EXISTS "session" (\n"key" CHAR(16) PRIMARY KEY NOT NULL\n, "data" BYTEA NOT NULL\n, "expiry" INTEGER NOT NULL\n);	t		2022-11-10 04:42:44
155	Drop old table playlist table	DROP TABLE IF EXISTS "playlist"	t		2022-11-10 04:42:44
156	Drop old table playlist_item table	DROP TABLE IF EXISTS "playlist_item"	t		2022-11-10 04:42:44
157	create playlist table v2	CREATE TABLE IF NOT EXISTS "playlist" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "name" VARCHAR(255) NOT NULL\n, "interval" VARCHAR(255) NOT NULL\n, "org_id" BIGINT NOT NULL\n);	t		2022-11-10 04:42:44
158	create playlist item table v2	CREATE TABLE IF NOT EXISTS "playlist_item" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "playlist_id" BIGINT NOT NULL\n, "type" VARCHAR(255) NOT NULL\n, "value" TEXT NOT NULL\n, "title" TEXT NOT NULL\n, "order" INTEGER NOT NULL\n);	t		2022-11-10 04:42:44
159	Update playlist table charset	ALTER TABLE "playlist" ALTER "name" TYPE VARCHAR(255), ALTER "interval" TYPE VARCHAR(255);	t		2022-11-10 04:42:44
160	Update playlist_item table charset	ALTER TABLE "playlist_item" ALTER "type" TYPE VARCHAR(255), ALTER "value" TYPE TEXT, ALTER "title" TYPE TEXT;	t		2022-11-10 04:42:44
161	drop preferences table v2	DROP TABLE IF EXISTS "preferences"	t		2022-11-10 04:42:44
162	drop preferences table v3	DROP TABLE IF EXISTS "preferences"	t		2022-11-10 04:42:44
163	create preferences table v3	CREATE TABLE IF NOT EXISTS "preferences" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "user_id" BIGINT NOT NULL\n, "version" INTEGER NOT NULL\n, "home_dashboard_id" BIGINT NOT NULL\n, "timezone" VARCHAR(50) NOT NULL\n, "theme" VARCHAR(20) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:44
246	alter dashboard_version.data to mediumtext v1	SELECT 0;	t		2022-11-10 04:42:48
166	Update team_id column values in preferences	UPDATE preferences SET team_id=0 WHERE team_id IS NULL;	t		2022-11-10 04:42:44
167	Add column week_start in preferences	alter table "preferences" ADD COLUMN "week_start" VARCHAR(10) NULL 	t		2022-11-10 04:42:44
168	Add column preferences.json_data	alter table "preferences" ADD COLUMN "json_data" TEXT NULL 	t		2022-11-10 04:42:44
169	alter preferences.json_data to mediumtext v1	SELECT 0;	t		2022-11-10 04:42:44
170	create alert table v1	CREATE TABLE IF NOT EXISTS "alert" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" BIGINT NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n, "panel_id" BIGINT NOT NULL\n, "org_id" BIGINT NOT NULL\n, "name" VARCHAR(255) NOT NULL\n, "message" TEXT NOT NULL\n, "state" VARCHAR(190) NOT NULL\n, "settings" TEXT NOT NULL\n, "frequency" BIGINT NOT NULL\n, "handler" BIGINT NOT NULL\n, "severity" TEXT NOT NULL\n, "silenced" BOOL NOT NULL\n, "execution_error" TEXT NOT NULL\n, "eval_data" TEXT NULL\n, "eval_date" TIMESTAMP NULL\n, "new_state_date" TIMESTAMP NOT NULL\n, "state_changes" INTEGER NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:44
171	add index alert org_id & id 	CREATE INDEX "IDX_alert_org_id_id" ON "alert" ("org_id","id");	t		2022-11-10 04:42:45
172	add index alert state	CREATE INDEX "IDX_alert_state" ON "alert" ("state");	t		2022-11-10 04:42:45
173	add index alert dashboard_id	CREATE INDEX "IDX_alert_dashboard_id" ON "alert" ("dashboard_id");	t		2022-11-10 04:42:45
174	Create alert_rule_tag table v1	CREATE TABLE IF NOT EXISTS "alert_rule_tag" (\n"alert_id" BIGINT NOT NULL\n, "tag_id" BIGINT NOT NULL\n);	t		2022-11-10 04:42:45
175	Add unique index alert_rule_tag.alert_id_tag_id	CREATE UNIQUE INDEX "UQE_alert_rule_tag_alert_id_tag_id" ON "alert_rule_tag" ("alert_id","tag_id");	t		2022-11-10 04:42:45
176	drop index UQE_alert_rule_tag_alert_id_tag_id - v1	DROP INDEX "UQE_alert_rule_tag_alert_id_tag_id" CASCADE	t		2022-11-10 04:42:45
177	Rename table alert_rule_tag to alert_rule_tag_v1 - v1	ALTER TABLE "alert_rule_tag" RENAME TO "alert_rule_tag_v1"	t		2022-11-10 04:42:45
178	Create alert_rule_tag table v2	CREATE TABLE IF NOT EXISTS "alert_rule_tag" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "alert_id" BIGINT NOT NULL\n, "tag_id" BIGINT NOT NULL\n);	t		2022-11-10 04:42:45
179	create index UQE_alert_rule_tag_alert_id_tag_id - Add unique index alert_rule_tag.alert_id_tag_id V2	CREATE UNIQUE INDEX "UQE_alert_rule_tag_alert_id_tag_id" ON "alert_rule_tag" ("alert_id","tag_id");	t		2022-11-10 04:42:45
180	copy alert_rule_tag v1 to v2	INSERT INTO "alert_rule_tag" ("alert_id"\n, "tag_id") SELECT "alert_id"\n, "tag_id" FROM "alert_rule_tag_v1"	t		2022-11-10 04:42:45
181	drop table alert_rule_tag_v1	DROP TABLE IF EXISTS "alert_rule_tag_v1"	t		2022-11-10 04:42:45
182	create alert_notification table v1	CREATE TABLE IF NOT EXISTS "alert_notification" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "type" VARCHAR(255) NOT NULL\n, "settings" TEXT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:45
183	Add column is_default	alter table "alert_notification" ADD COLUMN "is_default" BOOL NOT NULL DEFAULT FALSE 	t		2022-11-10 04:42:45
184	Add column frequency	alter table "alert_notification" ADD COLUMN "frequency" BIGINT NULL 	t		2022-11-10 04:42:45
185	Add column send_reminder	alter table "alert_notification" ADD COLUMN "send_reminder" BOOL NULL DEFAULT FALSE 	t		2022-11-10 04:42:45
186	Add column disable_resolve_message	alter table "alert_notification" ADD COLUMN "disable_resolve_message" BOOL NOT NULL DEFAULT FALSE 	t		2022-11-10 04:42:45
187	add index alert_notification org_id & name	CREATE UNIQUE INDEX "UQE_alert_notification_org_id_name" ON "alert_notification" ("org_id","name");	t		2022-11-10 04:42:45
188	Update alert table charset	ALTER TABLE "alert" ALTER "name" TYPE VARCHAR(255), ALTER "message" TYPE TEXT, ALTER "state" TYPE VARCHAR(190), ALTER "settings" TYPE TEXT, ALTER "severity" TYPE TEXT, ALTER "execution_error" TYPE TEXT, ALTER "eval_data" TYPE TEXT;	t		2022-11-10 04:42:45
189	Update alert_notification table charset	ALTER TABLE "alert_notification" ALTER "name" TYPE VARCHAR(190), ALTER "type" TYPE VARCHAR(255), ALTER "settings" TYPE TEXT;	t		2022-11-10 04:42:45
190	create notification_journal table v1	CREATE TABLE IF NOT EXISTS "alert_notification_journal" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "alert_id" BIGINT NOT NULL\n, "notifier_id" BIGINT NOT NULL\n, "sent_at" BIGINT NOT NULL\n, "success" BOOL NOT NULL\n);	t		2022-11-10 04:42:45
191	add index notification_journal org_id & alert_id & notifier_id	CREATE INDEX "IDX_alert_notification_journal_org_id_alert_id_notifier_id" ON "alert_notification_journal" ("org_id","alert_id","notifier_id");	t		2022-11-10 04:42:45
192	drop alert_notification_journal	DROP TABLE IF EXISTS "alert_notification_journal"	t		2022-11-10 04:42:45
193	create alert_notification_state table v1	CREATE TABLE IF NOT EXISTS "alert_notification_state" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "alert_id" BIGINT NOT NULL\n, "notifier_id" BIGINT NOT NULL\n, "state" VARCHAR(50) NOT NULL\n, "version" BIGINT NOT NULL\n, "updated_at" BIGINT NOT NULL\n, "alert_rule_state_updated_version" BIGINT NOT NULL\n);	t		2022-11-10 04:42:46
194	add index alert_notification_state org_id & alert_id & notifier_id	CREATE UNIQUE INDEX "UQE_alert_notification_state_org_id_alert_id_notifier_id" ON "alert_notification_state" ("org_id","alert_id","notifier_id");	t		2022-11-10 04:42:46
195	Add for to alert table	alter table "alert" ADD COLUMN "for" BIGINT NULL 	t		2022-11-10 04:42:46
196	Add column uid in alert_notification	alter table "alert_notification" ADD COLUMN "uid" VARCHAR(40) NULL 	t		2022-11-10 04:42:46
197	Update uid column values in alert_notification	UPDATE alert_notification SET uid=lpad('' || id::text,9,'0') WHERE uid IS NULL;	t		2022-11-10 04:42:46
198	Add unique index alert_notification_org_id_uid	CREATE UNIQUE INDEX "UQE_alert_notification_org_id_uid" ON "alert_notification" ("org_id","uid");	t		2022-11-10 04:42:46
199	Remove unique index org_id_name	DROP INDEX "UQE_alert_notification_org_id_name" CASCADE	t		2022-11-10 04:42:46
200	Add column secure_settings in alert_notification	alter table "alert_notification" ADD COLUMN "secure_settings" TEXT NULL 	t		2022-11-10 04:42:46
201	alter alert.settings to mediumtext	SELECT 0;	t		2022-11-10 04:42:46
202	Add non-unique index alert_notification_state_alert_id	CREATE INDEX "IDX_alert_notification_state_alert_id" ON "alert_notification_state" ("alert_id");	t		2022-11-10 04:42:46
203	Add non-unique index alert_rule_tag_alert_id	CREATE INDEX "IDX_alert_rule_tag_alert_id" ON "alert_rule_tag" ("alert_id");	t		2022-11-10 04:42:46
204	Drop old annotation table v4	DROP TABLE IF EXISTS "annotation"	t		2022-11-10 04:42:46
247	create team table	CREATE TABLE IF NOT EXISTS "team" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "org_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:48
248	add index team.org_id	CREATE INDEX "IDX_team_org_id" ON "team" ("org_id");	t		2022-11-10 04:42:48
488	drop recording_rules table v14	DROP TABLE IF EXISTS "recording_rules"	t		2022-11-10 04:43:04
205	create annotation table v5	CREATE TABLE IF NOT EXISTS "annotation" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "alert_id" BIGINT NULL\n, "user_id" BIGINT NULL\n, "dashboard_id" BIGINT NULL\n, "panel_id" BIGINT NULL\n, "category_id" BIGINT NULL\n, "type" VARCHAR(25) NOT NULL\n, "title" TEXT NOT NULL\n, "text" TEXT NOT NULL\n, "metric" VARCHAR(255) NULL\n, "prev_state" VARCHAR(25) NOT NULL\n, "new_state" VARCHAR(25) NOT NULL\n, "data" TEXT NOT NULL\n, "epoch" BIGINT NOT NULL\n);	t		2022-11-10 04:42:46
206	add index annotation 0 v3	CREATE INDEX "IDX_annotation_org_id_alert_id" ON "annotation" ("org_id","alert_id");	t		2022-11-10 04:42:46
207	add index annotation 1 v3	CREATE INDEX "IDX_annotation_org_id_type" ON "annotation" ("org_id","type");	t		2022-11-10 04:42:46
208	add index annotation 2 v3	CREATE INDEX "IDX_annotation_org_id_category_id" ON "annotation" ("org_id","category_id");	t		2022-11-10 04:42:46
209	add index annotation 3 v3	CREATE INDEX "IDX_annotation_org_id_dashboard_id_panel_id_epoch" ON "annotation" ("org_id","dashboard_id","panel_id","epoch");	t		2022-11-10 04:42:46
210	add index annotation 4 v3	CREATE INDEX "IDX_annotation_org_id_epoch" ON "annotation" ("org_id","epoch");	t		2022-11-10 04:42:47
211	Update annotation table charset	ALTER TABLE "annotation" ALTER "type" TYPE VARCHAR(25), ALTER "title" TYPE TEXT, ALTER "text" TYPE TEXT, ALTER "metric" TYPE VARCHAR(255), ALTER "prev_state" TYPE VARCHAR(25), ALTER "new_state" TYPE VARCHAR(25), ALTER "data" TYPE TEXT;	t		2022-11-10 04:42:47
212	Add column region_id to annotation table	alter table "annotation" ADD COLUMN "region_id" BIGINT NULL DEFAULT 0 	t		2022-11-10 04:42:47
213	Drop category_id index	DROP INDEX "IDX_annotation_org_id_category_id" CASCADE	t		2022-11-10 04:42:47
214	Add column tags to annotation table	alter table "annotation" ADD COLUMN "tags" VARCHAR(500) NULL 	t		2022-11-10 04:42:47
215	Create annotation_tag table v2	CREATE TABLE IF NOT EXISTS "annotation_tag" (\n"annotation_id" BIGINT NOT NULL\n, "tag_id" BIGINT NOT NULL\n);	t		2022-11-10 04:42:47
216	Add unique index annotation_tag.annotation_id_tag_id	CREATE UNIQUE INDEX "UQE_annotation_tag_annotation_id_tag_id" ON "annotation_tag" ("annotation_id","tag_id");	t		2022-11-10 04:42:47
217	drop index UQE_annotation_tag_annotation_id_tag_id - v2	DROP INDEX "UQE_annotation_tag_annotation_id_tag_id" CASCADE	t		2022-11-10 04:42:47
218	Rename table annotation_tag to annotation_tag_v2 - v2	ALTER TABLE "annotation_tag" RENAME TO "annotation_tag_v2"	t		2022-11-10 04:42:47
219	Create annotation_tag table v3	CREATE TABLE IF NOT EXISTS "annotation_tag" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "annotation_id" BIGINT NOT NULL\n, "tag_id" BIGINT NOT NULL\n);	t		2022-11-10 04:42:47
220	create index UQE_annotation_tag_annotation_id_tag_id - Add unique index annotation_tag.annotation_id_tag_id V3	CREATE UNIQUE INDEX "UQE_annotation_tag_annotation_id_tag_id" ON "annotation_tag" ("annotation_id","tag_id");	t		2022-11-10 04:42:47
221	copy annotation_tag v2 to v3	INSERT INTO "annotation_tag" ("annotation_id"\n, "tag_id") SELECT "annotation_id"\n, "tag_id" FROM "annotation_tag_v2"	t		2022-11-10 04:42:47
222	drop table annotation_tag_v2	DROP TABLE IF EXISTS "annotation_tag_v2"	t		2022-11-10 04:42:47
223	Update alert annotations and set TEXT to empty	UPDATE annotation SET TEXT = '' WHERE alert_id > 0	t		2022-11-10 04:42:47
224	Add created time to annotation table	alter table "annotation" ADD COLUMN "created" BIGINT NULL DEFAULT 0 	t		2022-11-10 04:42:47
225	Add updated time to annotation table	alter table "annotation" ADD COLUMN "updated" BIGINT NULL DEFAULT 0 	t		2022-11-10 04:42:47
226	Add index for created in annotation table	CREATE INDEX "IDX_annotation_org_id_created" ON "annotation" ("org_id","created");	t		2022-11-10 04:42:47
227	Add index for updated in annotation table	CREATE INDEX "IDX_annotation_org_id_updated" ON "annotation" ("org_id","updated");	t		2022-11-10 04:42:47
228	Convert existing annotations from seconds to milliseconds	UPDATE annotation SET epoch = (epoch*1000) where epoch < 9999999999	t		2022-11-10 04:42:47
229	Add epoch_end column	alter table "annotation" ADD COLUMN "epoch_end" BIGINT NOT NULL DEFAULT 0 	t		2022-11-10 04:42:47
230	Add index for epoch_end	CREATE INDEX "IDX_annotation_org_id_epoch_epoch_end" ON "annotation" ("org_id","epoch","epoch_end");	t		2022-11-10 04:42:47
231	Make epoch_end the same as epoch	UPDATE annotation SET epoch_end = epoch	t		2022-11-10 04:42:47
232	Move region to single row	code migration	t		2022-11-10 04:42:47
233	Remove index org_id_epoch from annotation table	DROP INDEX "IDX_annotation_org_id_epoch" CASCADE	t		2022-11-10 04:42:47
234	Remove index org_id_dashboard_id_panel_id_epoch from annotation table	DROP INDEX "IDX_annotation_org_id_dashboard_id_panel_id_epoch" CASCADE	t		2022-11-10 04:42:47
235	Add index for org_id_dashboard_id_epoch_end_epoch on annotation table	CREATE INDEX "IDX_annotation_org_id_dashboard_id_epoch_end_epoch" ON "annotation" ("org_id","dashboard_id","epoch_end","epoch");	t		2022-11-10 04:42:47
236	Add index for org_id_epoch_end_epoch on annotation table	CREATE INDEX "IDX_annotation_org_id_epoch_end_epoch" ON "annotation" ("org_id","epoch_end","epoch");	t		2022-11-10 04:42:47
237	Remove index org_id_epoch_epoch_end from annotation table	DROP INDEX "IDX_annotation_org_id_epoch_epoch_end" CASCADE	t		2022-11-10 04:42:47
238	Add index for alert_id on annotation table	CREATE INDEX "IDX_annotation_alert_id" ON "annotation" ("alert_id");	t		2022-11-10 04:42:47
239	Increase tags column to length 4096	ALTER TABLE annotation ALTER COLUMN tags TYPE VARCHAR(4096);	t		2022-11-10 04:42:48
240	create test_data table	CREATE TABLE IF NOT EXISTS "test_data" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "metric1" VARCHAR(20) NULL\n, "metric2" VARCHAR(150) NULL\n, "value_big_int" BIGINT NULL\n, "value_double" DOUBLE PRECISION NULL\n, "value_float" REAL NULL\n, "value_int" INTEGER NULL\n, "time_epoch" BIGINT NOT NULL\n, "time_date_time" TIMESTAMP NOT NULL\n, "time_time_stamp" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:48
241	create dashboard_version table v1	CREATE TABLE IF NOT EXISTS "dashboard_version" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n, "parent_version" INTEGER NOT NULL\n, "restored_from" INTEGER NOT NULL\n, "version" INTEGER NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "created_by" BIGINT NOT NULL\n, "message" TEXT NOT NULL\n, "data" TEXT NOT NULL\n);	t		2022-11-10 04:42:48
242	add index dashboard_version.dashboard_id	CREATE INDEX "IDX_dashboard_version_dashboard_id" ON "dashboard_version" ("dashboard_id");	t		2022-11-10 04:42:48
243	add unique index dashboard_version.dashboard_id and dashboard_version.version	CREATE UNIQUE INDEX "UQE_dashboard_version_dashboard_id_version" ON "dashboard_version" ("dashboard_id","version");	t		2022-11-10 04:42:48
244	Set dashboard version to 1 where 0	UPDATE dashboard SET version = 1 WHERE version = 0	t		2022-11-10 04:42:48
245	save existing dashboard data in dashboard_version table v1	INSERT INTO dashboard_version\n(\n\tdashboard_id,\n\tversion,\n\tparent_version,\n\trestored_from,\n\tcreated,\n\tcreated_by,\n\tmessage,\n\tdata\n)\nSELECT\n\tdashboard.id,\n\tdashboard.version,\n\tdashboard.version,\n\tdashboard.version,\n\tdashboard.updated,\n\tCOALESCE(dashboard.updated_by, -1),\n\t'',\n\tdashboard.data\nFROM dashboard;	t		2022-11-10 04:42:48
249	add unique index team_org_id_name	CREATE UNIQUE INDEX "UQE_team_org_id_name" ON "team" ("org_id","name");	t		2022-11-10 04:42:48
250	create team member table	CREATE TABLE IF NOT EXISTS "team_member" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "team_id" BIGINT NOT NULL\n, "user_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:48
251	add index team_member.org_id	CREATE INDEX "IDX_team_member_org_id" ON "team_member" ("org_id");	t		2022-11-10 04:42:48
252	add unique index team_member_org_id_team_id_user_id	CREATE UNIQUE INDEX "UQE_team_member_org_id_team_id_user_id" ON "team_member" ("org_id","team_id","user_id");	t		2022-11-10 04:42:48
253	add index team_member.team_id	CREATE INDEX "IDX_team_member_team_id" ON "team_member" ("team_id");	t		2022-11-10 04:42:48
254	Add column email to team table	alter table "team" ADD COLUMN "email" VARCHAR(190) NULL 	t		2022-11-10 04:42:49
255	Add column external to team_member table	alter table "team_member" ADD COLUMN "external" BOOL NULL 	t		2022-11-10 04:42:49
256	Add column permission to team_member table	alter table "team_member" ADD COLUMN "permission" SMALLINT NULL 	t		2022-11-10 04:42:49
257	create dashboard acl table	CREATE TABLE IF NOT EXISTS "dashboard_acl" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n, "user_id" BIGINT NULL\n, "team_id" BIGINT NULL\n, "permission" SMALLINT NOT NULL DEFAULT 4\n, "role" VARCHAR(20) NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:49
258	add index dashboard_acl_dashboard_id	CREATE INDEX "IDX_dashboard_acl_dashboard_id" ON "dashboard_acl" ("dashboard_id");	t		2022-11-10 04:42:49
259	add unique index dashboard_acl_dashboard_id_user_id	CREATE UNIQUE INDEX "UQE_dashboard_acl_dashboard_id_user_id" ON "dashboard_acl" ("dashboard_id","user_id");	t		2022-11-10 04:42:49
260	add unique index dashboard_acl_dashboard_id_team_id	CREATE UNIQUE INDEX "UQE_dashboard_acl_dashboard_id_team_id" ON "dashboard_acl" ("dashboard_id","team_id");	t		2022-11-10 04:42:49
261	add index dashboard_acl_user_id	CREATE INDEX "IDX_dashboard_acl_user_id" ON "dashboard_acl" ("user_id");	t		2022-11-10 04:42:49
262	add index dashboard_acl_team_id	CREATE INDEX "IDX_dashboard_acl_team_id" ON "dashboard_acl" ("team_id");	t		2022-11-10 04:42:49
263	add index dashboard_acl_org_id_role	CREATE INDEX "IDX_dashboard_acl_org_id_role" ON "dashboard_acl" ("org_id","role");	t		2022-11-10 04:42:49
264	add index dashboard_permission	CREATE INDEX "IDX_dashboard_acl_permission" ON "dashboard_acl" ("permission");	t		2022-11-10 04:42:49
265	save default acl rules in dashboard_acl table	\nINSERT INTO dashboard_acl\n\t(\n\t\torg_id,\n\t\tdashboard_id,\n\t\tpermission,\n\t\trole,\n\t\tcreated,\n\t\tupdated\n\t)\n\tVALUES\n\t\t(-1,-1, 1,'Viewer','2017-06-20','2017-06-20'),\n\t\t(-1,-1, 2,'Editor','2017-06-20','2017-06-20')\n\t	t		2022-11-10 04:42:49
266	delete acl rules for deleted dashboards and folders	DELETE FROM dashboard_acl WHERE dashboard_id NOT IN (SELECT id FROM dashboard) AND dashboard_id != -1	t		2022-11-10 04:42:49
267	create tag table	CREATE TABLE IF NOT EXISTS "tag" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "key" VARCHAR(100) NOT NULL\n, "value" VARCHAR(100) NOT NULL\n);	t		2022-11-10 04:42:49
268	add index tag.key_value	CREATE UNIQUE INDEX "UQE_tag_key_value" ON "tag" ("key","value");	t		2022-11-10 04:42:49
269	create login attempt table	CREATE TABLE IF NOT EXISTS "login_attempt" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "username" VARCHAR(190) NOT NULL\n, "ip_address" VARCHAR(30) NOT NULL\n, "created" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:50
270	add index login_attempt.username	CREATE INDEX "IDX_login_attempt_username" ON "login_attempt" ("username");	t		2022-11-10 04:42:50
271	drop index IDX_login_attempt_username - v1	DROP INDEX "IDX_login_attempt_username" CASCADE	t		2022-11-10 04:42:50
272	Rename table login_attempt to login_attempt_tmp_qwerty - v1	ALTER TABLE "login_attempt" RENAME TO "login_attempt_tmp_qwerty"	t		2022-11-10 04:42:50
273	create login_attempt v2	CREATE TABLE IF NOT EXISTS "login_attempt" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "username" VARCHAR(190) NOT NULL\n, "ip_address" VARCHAR(30) NOT NULL\n, "created" INTEGER NOT NULL DEFAULT 0\n);	t		2022-11-10 04:42:50
274	create index IDX_login_attempt_username - v2	CREATE INDEX "IDX_login_attempt_username" ON "login_attempt" ("username");	t		2022-11-10 04:42:50
275	copy login_attempt v1 to v2	INSERT INTO "login_attempt" ("id"\n, "username"\n, "ip_address") SELECT "id"\n, "username"\n, "ip_address" FROM "login_attempt_tmp_qwerty"	t		2022-11-10 04:42:50
276	drop login_attempt_tmp_qwerty	DROP TABLE IF EXISTS "login_attempt_tmp_qwerty"	t		2022-11-10 04:42:50
277	create user auth table	CREATE TABLE IF NOT EXISTS "user_auth" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "user_id" BIGINT NOT NULL\n, "auth_module" VARCHAR(190) NOT NULL\n, "auth_id" VARCHAR(100) NOT NULL\n, "created" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:50
278	create index IDX_user_auth_auth_module_auth_id - v1	CREATE INDEX "IDX_user_auth_auth_module_auth_id" ON "user_auth" ("auth_module","auth_id");	t		2022-11-10 04:42:50
279	alter user_auth.auth_id to length 190	ALTER TABLE user_auth ALTER COLUMN auth_id TYPE VARCHAR(190);	t		2022-11-10 04:42:50
280	Add OAuth access token to user_auth	alter table "user_auth" ADD COLUMN "o_auth_access_token" TEXT NULL 	t		2022-11-10 04:42:50
281	Add OAuth refresh token to user_auth	alter table "user_auth" ADD COLUMN "o_auth_refresh_token" TEXT NULL 	t		2022-11-10 04:42:50
282	Add OAuth token type to user_auth	alter table "user_auth" ADD COLUMN "o_auth_token_type" TEXT NULL 	t		2022-11-10 04:42:50
283	Add OAuth expiry to user_auth	alter table "user_auth" ADD COLUMN "o_auth_expiry" TIMESTAMP NULL 	t		2022-11-10 04:42:50
284	Add index to user_id column in user_auth	CREATE INDEX "IDX_user_auth_user_id" ON "user_auth" ("user_id");	t		2022-11-10 04:42:50
285	Add OAuth ID token to user_auth	alter table "user_auth" ADD COLUMN "o_auth_id_token" TEXT NULL 	t		2022-11-10 04:42:50
286	create server_lock table	CREATE TABLE IF NOT EXISTS "server_lock" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "operation_uid" VARCHAR(100) NOT NULL\n, "version" BIGINT NOT NULL\n, "last_execution" BIGINT NOT NULL\n);	t		2022-11-10 04:42:50
287	add index server_lock.operation_uid	CREATE UNIQUE INDEX "UQE_server_lock_operation_uid" ON "server_lock" ("operation_uid");	t		2022-11-10 04:42:50
288	create user auth token table	CREATE TABLE IF NOT EXISTS "user_auth_token" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "user_id" BIGINT NOT NULL\n, "auth_token" VARCHAR(100) NOT NULL\n, "prev_auth_token" VARCHAR(100) NOT NULL\n, "user_agent" VARCHAR(255) NOT NULL\n, "client_ip" VARCHAR(255) NOT NULL\n, "auth_token_seen" BOOL NOT NULL\n, "seen_at" INTEGER NULL\n, "rotated_at" INTEGER NOT NULL\n, "created_at" INTEGER NOT NULL\n, "updated_at" INTEGER NOT NULL\n);	t		2022-11-10 04:42:50
289	add unique index user_auth_token.auth_token	CREATE UNIQUE INDEX "UQE_user_auth_token_auth_token" ON "user_auth_token" ("auth_token");	t		2022-11-10 04:42:51
290	add unique index user_auth_token.prev_auth_token	CREATE UNIQUE INDEX "UQE_user_auth_token_prev_auth_token" ON "user_auth_token" ("prev_auth_token");	t		2022-11-10 04:42:51
291	add index user_auth_token.user_id	CREATE INDEX "IDX_user_auth_token_user_id" ON "user_auth_token" ("user_id");	t		2022-11-10 04:42:51
292	Add revoked_at to the user auth token	alter table "user_auth_token" ADD COLUMN "revoked_at" INTEGER NULL 	t		2022-11-10 04:42:51
293	create cache_data table	CREATE TABLE IF NOT EXISTS "cache_data" (\n"cache_key" VARCHAR(168) PRIMARY KEY NOT NULL\n, "data" BYTEA NOT NULL\n, "expires" INTEGER NOT NULL\n, "created_at" INTEGER NOT NULL\n);	t		2022-11-10 04:42:51
294	add unique index cache_data.cache_key	CREATE UNIQUE INDEX "UQE_cache_data_cache_key" ON "cache_data" ("cache_key");	t		2022-11-10 04:42:51
295	create short_url table v1	CREATE TABLE IF NOT EXISTS "short_url" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "uid" VARCHAR(40) NOT NULL\n, "path" TEXT NOT NULL\n, "created_by" INTEGER NOT NULL\n, "created_at" INTEGER NOT NULL\n, "last_seen_at" INTEGER NULL\n);	t		2022-11-10 04:42:51
296	add index short_url.org_id-uid	CREATE UNIQUE INDEX "UQE_short_url_org_id_uid" ON "short_url" ("org_id","uid");	t		2022-11-10 04:42:51
297	alter table short_url alter column created_by type to bigint	ALTER TABLE short_url ALTER COLUMN created_by TYPE BIGINT;	t		2022-11-10 04:42:51
298	delete alert_definition table	DROP TABLE IF EXISTS "alert_definition"	t		2022-11-10 04:42:52
299	recreate alert_definition table	CREATE TABLE IF NOT EXISTS "alert_definition" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "title" VARCHAR(190) NOT NULL\n, "condition" VARCHAR(190) NOT NULL\n, "data" TEXT NOT NULL\n, "updated" TIMESTAMP NOT NULL\n, "interval_seconds" BIGINT NOT NULL DEFAULT 60\n, "version" INTEGER NOT NULL DEFAULT 0\n, "uid" VARCHAR(40) NOT NULL DEFAULT 0\n);	t		2022-11-10 04:42:52
300	add index in alert_definition on org_id and title columns	CREATE INDEX "IDX_alert_definition_org_id_title" ON "alert_definition" ("org_id","title");	t		2022-11-10 04:42:52
301	add index in alert_definition on org_id and uid columns	CREATE INDEX "IDX_alert_definition_org_id_uid" ON "alert_definition" ("org_id","uid");	t		2022-11-10 04:42:52
302	alter alert_definition table data column to mediumtext in mysql	SELECT 0;	t		2022-11-10 04:42:52
303	drop index in alert_definition on org_id and title columns	DROP INDEX "IDX_alert_definition_org_id_title" CASCADE	t		2022-11-10 04:42:52
304	drop index in alert_definition on org_id and uid columns	DROP INDEX "IDX_alert_definition_org_id_uid" CASCADE	t		2022-11-10 04:42:52
305	add unique index in alert_definition on org_id and title columns	CREATE UNIQUE INDEX "UQE_alert_definition_org_id_title" ON "alert_definition" ("org_id","title");	t		2022-11-10 04:42:52
306	add unique index in alert_definition on org_id and uid columns	CREATE UNIQUE INDEX "UQE_alert_definition_org_id_uid" ON "alert_definition" ("org_id","uid");	t		2022-11-10 04:42:52
307	Add column paused in alert_definition	alter table "alert_definition" ADD COLUMN "paused" BOOL NOT NULL DEFAULT FALSE 	t		2022-11-10 04:42:52
308	drop alert_definition table	DROP TABLE IF EXISTS "alert_definition"	t		2022-11-10 04:42:52
309	delete alert_definition_version table	DROP TABLE IF EXISTS "alert_definition_version"	t		2022-11-10 04:42:52
310	recreate alert_definition_version table	CREATE TABLE IF NOT EXISTS "alert_definition_version" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "alert_definition_id" BIGINT NOT NULL\n, "alert_definition_uid" VARCHAR(40) NOT NULL DEFAULT 0\n, "parent_version" INTEGER NOT NULL\n, "restored_from" INTEGER NOT NULL\n, "version" INTEGER NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "title" VARCHAR(190) NOT NULL\n, "condition" VARCHAR(190) NOT NULL\n, "data" TEXT NOT NULL\n, "interval_seconds" BIGINT NOT NULL\n);	t		2022-11-10 04:42:52
311	add index in alert_definition_version table on alert_definition_id and version columns	CREATE UNIQUE INDEX "UQE_alert_definition_version_alert_definition_id_version" ON "alert_definition_version" ("alert_definition_id","version");	t		2022-11-10 04:42:52
312	add index in alert_definition_version table on alert_definition_uid and version columns	CREATE UNIQUE INDEX "UQE_alert_definition_version_alert_definition_uid_version" ON "alert_definition_version" ("alert_definition_uid","version");	t		2022-11-10 04:42:52
313	alter alert_definition_version table data column to mediumtext in mysql	SELECT 0;	t		2022-11-10 04:42:52
314	drop alert_definition_version table	DROP TABLE IF EXISTS "alert_definition_version"	t		2022-11-10 04:42:52
315	create alert_instance table	CREATE TABLE IF NOT EXISTS "alert_instance" (\n"def_org_id" BIGINT NOT NULL\n, "def_uid" VARCHAR(40) NOT NULL DEFAULT 0\n, "labels" TEXT NOT NULL\n, "labels_hash" VARCHAR(190) NOT NULL\n, "current_state" VARCHAR(190) NOT NULL\n, "current_state_since" BIGINT NOT NULL\n, "last_eval_time" BIGINT NOT NULL\n, PRIMARY KEY ( "def_org_id","def_uid","labels_hash" ));	t		2022-11-10 04:42:52
316	add index in alert_instance table on def_org_id, def_uid and current_state columns	CREATE INDEX "IDX_alert_instance_def_org_id_def_uid_current_state" ON "alert_instance" ("def_org_id","def_uid","current_state");	t		2022-11-10 04:42:53
317	add index in alert_instance table on def_org_id, current_state columns	CREATE INDEX "IDX_alert_instance_def_org_id_current_state" ON "alert_instance" ("def_org_id","current_state");	t		2022-11-10 04:42:53
318	add column current_state_end to alert_instance	alter table "alert_instance" ADD COLUMN "current_state_end" BIGINT NOT NULL DEFAULT 0 	t		2022-11-10 04:42:53
319	remove index def_org_id, def_uid, current_state on alert_instance	DROP INDEX "IDX_alert_instance_def_org_id_def_uid_current_state" CASCADE	t		2022-11-10 04:42:53
320	remove index def_org_id, current_state on alert_instance	DROP INDEX "IDX_alert_instance_def_org_id_current_state" CASCADE	t		2022-11-10 04:42:53
321	rename def_org_id to rule_org_id in alert_instance	ALTER TABLE alert_instance RENAME COLUMN def_org_id TO rule_org_id;	t		2022-11-10 04:42:53
322	rename def_uid to rule_uid in alert_instance	ALTER TABLE alert_instance RENAME COLUMN def_uid TO rule_uid;	t		2022-11-10 04:42:53
323	add index rule_org_id, rule_uid, current_state on alert_instance	CREATE INDEX "IDX_alert_instance_rule_org_id_rule_uid_current_state" ON "alert_instance" ("rule_org_id","rule_uid","current_state");	t		2022-11-10 04:42:53
324	add index rule_org_id, current_state on alert_instance	CREATE INDEX "IDX_alert_instance_rule_org_id_current_state" ON "alert_instance" ("rule_org_id","current_state");	t		2022-11-10 04:42:53
325	add current_reason column related to current_state	alter table "alert_instance" ADD COLUMN "current_reason" VARCHAR(190) NULL 	t		2022-11-10 04:42:53
326	create alert_rule table	CREATE TABLE IF NOT EXISTS "alert_rule" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "title" VARCHAR(190) NOT NULL\n, "condition" VARCHAR(190) NOT NULL\n, "data" TEXT NOT NULL\n, "updated" TIMESTAMP NOT NULL\n, "interval_seconds" BIGINT NOT NULL DEFAULT 60\n, "version" INTEGER NOT NULL DEFAULT 0\n, "uid" VARCHAR(40) NOT NULL DEFAULT 0\n, "namespace_uid" VARCHAR(40) NOT NULL\n, "rule_group" VARCHAR(190) NOT NULL\n, "no_data_state" VARCHAR(15) NOT NULL DEFAULT 'NoData'\n, "exec_err_state" VARCHAR(15) NOT NULL DEFAULT 'Alerting'\n);	t		2022-11-10 04:42:53
327	add index in alert_rule on org_id and title columns	CREATE UNIQUE INDEX "UQE_alert_rule_org_id_title" ON "alert_rule" ("org_id","title");	t		2022-11-10 04:42:53
328	add index in alert_rule on org_id and uid columns	CREATE UNIQUE INDEX "UQE_alert_rule_org_id_uid" ON "alert_rule" ("org_id","uid");	t		2022-11-10 04:42:53
329	add index in alert_rule on org_id, namespace_uid, group_uid columns	CREATE INDEX "IDX_alert_rule_org_id_namespace_uid_rule_group" ON "alert_rule" ("org_id","namespace_uid","rule_group");	t		2022-11-10 04:42:53
330	alter alert_rule table data column to mediumtext in mysql	SELECT 0;	t		2022-11-10 04:42:53
331	add column for to alert_rule	alter table "alert_rule" ADD COLUMN "for" BIGINT NOT NULL DEFAULT 0 	t		2022-11-10 04:42:53
332	add column annotations to alert_rule	alter table "alert_rule" ADD COLUMN "annotations" TEXT NULL 	t		2022-11-10 04:42:53
333	add column labels to alert_rule	alter table "alert_rule" ADD COLUMN "labels" TEXT NULL 	t		2022-11-10 04:42:53
334	remove unique index from alert_rule on org_id, title columns	DROP INDEX "UQE_alert_rule_org_id_title" CASCADE	t		2022-11-10 04:42:53
335	add index in alert_rule on org_id, namespase_uid and title columns	CREATE UNIQUE INDEX "UQE_alert_rule_org_id_namespace_uid_title" ON "alert_rule" ("org_id","namespace_uid","title");	t		2022-11-10 04:42:53
336	add dashboard_uid column to alert_rule	alter table "alert_rule" ADD COLUMN "dashboard_uid" VARCHAR(40) NULL 	t		2022-11-10 04:42:54
337	add panel_id column to alert_rule	alter table "alert_rule" ADD COLUMN "panel_id" BIGINT NULL 	t		2022-11-10 04:42:54
338	add index in alert_rule on org_id, dashboard_uid and panel_id columns	CREATE INDEX "IDX_alert_rule_org_id_dashboard_uid_panel_id" ON "alert_rule" ("org_id","dashboard_uid","panel_id");	t		2022-11-10 04:42:54
339	add rule_group_idx column to alert_rule	alter table "alert_rule" ADD COLUMN "rule_group_idx" INTEGER NOT NULL DEFAULT 1 	t		2022-11-10 04:42:54
340	create alert_rule_version table	CREATE TABLE IF NOT EXISTS "alert_rule_version" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "rule_org_id" BIGINT NOT NULL\n, "rule_uid" VARCHAR(40) NOT NULL DEFAULT 0\n, "rule_namespace_uid" VARCHAR(40) NOT NULL\n, "rule_group" VARCHAR(190) NOT NULL\n, "parent_version" INTEGER NOT NULL\n, "restored_from" INTEGER NOT NULL\n, "version" INTEGER NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "title" VARCHAR(190) NOT NULL\n, "condition" VARCHAR(190) NOT NULL\n, "data" TEXT NOT NULL\n, "interval_seconds" BIGINT NOT NULL\n, "no_data_state" VARCHAR(15) NOT NULL DEFAULT 'NoData'\n, "exec_err_state" VARCHAR(15) NOT NULL DEFAULT 'Alerting'\n);	t		2022-11-10 04:42:54
341	add index in alert_rule_version table on rule_org_id, rule_uid and version columns	CREATE UNIQUE INDEX "UQE_alert_rule_version_rule_org_id_rule_uid_version" ON "alert_rule_version" ("rule_org_id","rule_uid","version");	t		2022-11-10 04:42:54
342	add index in alert_rule_version table on rule_org_id, rule_namespace_uid and rule_group columns	CREATE INDEX "IDX_alert_rule_version_rule_org_id_rule_namespace_uid_rule_group" ON "alert_rule_version" ("rule_org_id","rule_namespace_uid","rule_group");	t		2022-11-10 04:42:54
343	alter alert_rule_version table data column to mediumtext in mysql	SELECT 0;	t		2022-11-10 04:42:54
344	add column for to alert_rule_version	alter table "alert_rule_version" ADD COLUMN "for" BIGINT NOT NULL DEFAULT 0 	t		2022-11-10 04:42:54
345	add column annotations to alert_rule_version	alter table "alert_rule_version" ADD COLUMN "annotations" TEXT NULL 	t		2022-11-10 04:42:54
346	add column labels to alert_rule_version	alter table "alert_rule_version" ADD COLUMN "labels" TEXT NULL 	t		2022-11-10 04:42:54
347	add rule_group_idx column to alert_rule_version	alter table "alert_rule_version" ADD COLUMN "rule_group_idx" INTEGER NOT NULL DEFAULT 1 	t		2022-11-10 04:42:54
348	create_alert_configuration_table	CREATE TABLE IF NOT EXISTS "alert_configuration" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "alertmanager_configuration" TEXT NOT NULL\n, "configuration_version" VARCHAR(3) NOT NULL\n, "created_at" INTEGER NOT NULL\n);	t		2022-11-10 04:42:54
349	Add column default in alert_configuration	alter table "alert_configuration" ADD COLUMN "default" BOOL NOT NULL DEFAULT FALSE 	t		2022-11-10 04:42:54
350	alert alert_configuration alertmanager_configuration column from TEXT to MEDIUMTEXT if mysql	SELECT 0;	t		2022-11-10 04:42:54
351	add column org_id in alert_configuration	alter table "alert_configuration" ADD COLUMN "org_id" BIGINT NOT NULL DEFAULT 0 	t		2022-11-10 04:42:54
352	add index in alert_configuration table on org_id column	CREATE INDEX "IDX_alert_configuration_org_id" ON "alert_configuration" ("org_id");	t		2022-11-10 04:42:54
353	add configuration_hash column to alert_configuration	alter table "alert_configuration" ADD COLUMN "configuration_hash" VARCHAR(32) NOT NULL DEFAULT 'not-yet-calculated' 	t		2022-11-10 04:42:54
354	create_ngalert_configuration_table	CREATE TABLE IF NOT EXISTS "ngalert_configuration" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "alertmanagers" TEXT NULL\n, "created_at" INTEGER NOT NULL\n, "updated_at" INTEGER NOT NULL\n);	t		2022-11-10 04:42:54
355	add index in ngalert_configuration on org_id column	CREATE UNIQUE INDEX "UQE_ngalert_configuration_org_id" ON "ngalert_configuration" ("org_id");	t		2022-11-10 04:42:54
356	add column send_alerts_to in ngalert_configuration	alter table "ngalert_configuration" ADD COLUMN "send_alerts_to" SMALLINT NOT NULL DEFAULT 0 	t		2022-11-10 04:42:55
357	create provenance_type table	CREATE TABLE IF NOT EXISTS "provenance_type" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "record_key" VARCHAR(190) NOT NULL\n, "record_type" VARCHAR(190) NOT NULL\n, "provenance" VARCHAR(190) NOT NULL\n);	t		2022-11-10 04:42:55
358	add index to uniquify (record_key, record_type, org_id) columns	CREATE UNIQUE INDEX "UQE_provenance_type_record_type_record_key_org_id" ON "provenance_type" ("record_type","record_key","org_id");	t		2022-11-10 04:42:55
359	create alert_image table	CREATE TABLE IF NOT EXISTS "alert_image" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "token" VARCHAR(190) NOT NULL\n, "path" VARCHAR(190) NOT NULL\n, "url" VARCHAR(190) NOT NULL\n, "created_at" TIMESTAMP NOT NULL\n, "expires_at" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:55
360	add unique index on token to alert_image table	CREATE UNIQUE INDEX "UQE_alert_image_token" ON "alert_image" ("token");	t		2022-11-10 04:42:55
361	support longer URLs in alert_image table	ALTER TABLE alert_image ALTER COLUMN url TYPE VARCHAR(2048);	t		2022-11-10 04:42:55
362	move dashboard alerts to unified alerting	code migration	t		2022-11-10 04:42:55
363	create library_element table v1	CREATE TABLE IF NOT EXISTS "library_element" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "folder_id" BIGINT NOT NULL\n, "uid" VARCHAR(40) NOT NULL\n, "name" VARCHAR(150) NOT NULL\n, "kind" BIGINT NOT NULL\n, "type" VARCHAR(40) NOT NULL\n, "description" VARCHAR(255) NOT NULL\n, "model" TEXT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "created_by" BIGINT NOT NULL\n, "updated" TIMESTAMP NOT NULL\n, "updated_by" BIGINT NOT NULL\n, "version" BIGINT NOT NULL\n);	t		2022-11-10 04:42:55
364	add index library_element org_id-folder_id-name-kind	CREATE UNIQUE INDEX "UQE_library_element_org_id_folder_id_name_kind" ON "library_element" ("org_id","folder_id","name","kind");	t		2022-11-10 04:42:55
450	Update uid column values in playlist	UPDATE playlist SET uid=id::text;	t		2022-11-10 04:43:02
531	rename orgs roles	code migration	t		2022-11-10 04:43:07
365	create library_element_connection table v1	CREATE TABLE IF NOT EXISTS "library_element_connection" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "element_id" BIGINT NOT NULL\n, "kind" BIGINT NOT NULL\n, "connection_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "created_by" BIGINT NOT NULL\n);	t		2022-11-10 04:42:55
366	add index library_element_connection element_id-kind-connection_id	CREATE UNIQUE INDEX "UQE_library_element_connection_element_id_kind_connection_id" ON "library_element_connection" ("element_id","kind","connection_id");	t		2022-11-10 04:42:55
367	add unique index library_element org_id_uid	CREATE UNIQUE INDEX "UQE_library_element_org_id_uid" ON "library_element" ("org_id","uid");	t		2022-11-10 04:42:55
368	increase max description length to 2048	ALTER TABLE "library_element" ALTER "description" TYPE VARCHAR(2048);	t		2022-11-10 04:42:56
369	clone move dashboard alerts to unified alerting	code migration	t		2022-11-10 04:42:56
370	create data_keys table	CREATE TABLE IF NOT EXISTS "data_keys" (\n"name" VARCHAR(100) PRIMARY KEY NOT NULL\n, "active" BOOL NOT NULL\n, "scope" VARCHAR(30) NOT NULL\n, "provider" VARCHAR(50) NOT NULL\n, "encrypted_data" BYTEA NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:56
371	create secrets table	CREATE TABLE IF NOT EXISTS "secrets" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "namespace" VARCHAR(255) NOT NULL\n, "type" VARCHAR(255) NOT NULL\n, "value" TEXT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:56
372	rename data_keys name column to id	ALTER TABLE "data_keys" RENAME COLUMN "name" TO "id"	t		2022-11-10 04:42:56
373	add name column into data_keys	alter table "data_keys" ADD COLUMN "name" VARCHAR(100) NOT NULL DEFAULT '' 	t		2022-11-10 04:42:56
374	copy data_keys id column values into name	UPDATE data_keys SET name = id	t		2022-11-10 04:42:56
375	rename data_keys name column to label	ALTER TABLE "data_keys" RENAME COLUMN "name" TO "label"	t		2022-11-10 04:42:56
376	rename data_keys id column back to name	ALTER TABLE "data_keys" RENAME COLUMN "id" TO "name"	t		2022-11-10 04:42:56
377	create kv_store table v1	CREATE TABLE IF NOT EXISTS "kv_store" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "namespace" VARCHAR(190) NOT NULL\n, "key" VARCHAR(190) NOT NULL\n, "value" TEXT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:56
378	add index kv_store.org_id-namespace-key	CREATE UNIQUE INDEX "UQE_kv_store_org_id_namespace_key" ON "kv_store" ("org_id","namespace","key");	t		2022-11-10 04:42:56
379	update dashboard_uid and panel_id from existing annotations	set dashboard_uid and panel_id migration	t		2022-11-10 04:42:56
380	create permission table	CREATE TABLE IF NOT EXISTS "permission" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "role_id" BIGINT NOT NULL\n, "action" VARCHAR(190) NOT NULL\n, "scope" VARCHAR(190) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:56
381	add unique index permission.role_id	CREATE INDEX "IDX_permission_role_id" ON "permission" ("role_id");	t		2022-11-10 04:42:56
382	add unique index role_id_action_scope	CREATE UNIQUE INDEX "UQE_permission_role_id_action_scope" ON "permission" ("role_id","action","scope");	t		2022-11-10 04:42:56
383	create role table	CREATE TABLE IF NOT EXISTS "role" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "description" TEXT NULL\n, "version" BIGINT NOT NULL\n, "org_id" BIGINT NOT NULL\n, "uid" VARCHAR(40) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:56
384	add column display_name	alter table "role" ADD COLUMN "display_name" VARCHAR(190) NULL 	t		2022-11-10 04:42:57
385	add column group_name	alter table "role" ADD COLUMN "group_name" VARCHAR(190) NULL 	t		2022-11-10 04:42:57
386	add index role.org_id	CREATE INDEX "IDX_role_org_id" ON "role" ("org_id");	t		2022-11-10 04:42:57
387	add unique index role_org_id_name	CREATE UNIQUE INDEX "UQE_role_org_id_name" ON "role" ("org_id","name");	t		2022-11-10 04:42:57
388	add index role_org_id_uid	CREATE UNIQUE INDEX "UQE_role_org_id_uid" ON "role" ("org_id","uid");	t		2022-11-10 04:42:57
389	create team role table	CREATE TABLE IF NOT EXISTS "team_role" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "team_id" BIGINT NOT NULL\n, "role_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:57
390	add index team_role.org_id	CREATE INDEX "IDX_team_role_org_id" ON "team_role" ("org_id");	t		2022-11-10 04:42:57
391	add unique index team_role_org_id_team_id_role_id	CREATE UNIQUE INDEX "UQE_team_role_org_id_team_id_role_id" ON "team_role" ("org_id","team_id","role_id");	t		2022-11-10 04:42:57
392	add index team_role.team_id	CREATE INDEX "IDX_team_role_team_id" ON "team_role" ("team_id");	t		2022-11-10 04:42:57
393	create user role table	CREATE TABLE IF NOT EXISTS "user_role" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "user_id" BIGINT NOT NULL\n, "role_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:58
394	add index user_role.org_id	CREATE INDEX "IDX_user_role_org_id" ON "user_role" ("org_id");	t		2022-11-10 04:42:58
395	add unique index user_role_org_id_user_id_role_id	CREATE UNIQUE INDEX "UQE_user_role_org_id_user_id_role_id" ON "user_role" ("org_id","user_id","role_id");	t		2022-11-10 04:42:58
396	add index user_role.user_id	CREATE INDEX "IDX_user_role_user_id" ON "user_role" ("user_id");	t		2022-11-10 04:42:58
397	create builtin role table	CREATE TABLE IF NOT EXISTS "builtin_role" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "role" VARCHAR(190) NOT NULL\n, "role_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:42:58
398	add index builtin_role.role_id	CREATE INDEX "IDX_builtin_role_role_id" ON "builtin_role" ("role_id");	t		2022-11-10 04:42:58
399	add index builtin_role.name	CREATE INDEX "IDX_builtin_role_role" ON "builtin_role" ("role");	t		2022-11-10 04:42:59
400	Add column org_id to builtin_role table	alter table "builtin_role" ADD COLUMN "org_id" BIGINT NOT NULL DEFAULT 0 	t		2022-11-10 04:42:59
401	add index builtin_role.org_id	CREATE INDEX "IDX_builtin_role_org_id" ON "builtin_role" ("org_id");	t		2022-11-10 04:42:59
402	add unique index builtin_role_org_id_role_id_role	CREATE UNIQUE INDEX "UQE_builtin_role_org_id_role_id_role" ON "builtin_role" ("org_id","role_id","role");	t		2022-11-10 04:42:59
403	Remove unique index role_org_id_uid	DROP INDEX "UQE_role_org_id_uid" CASCADE	t		2022-11-10 04:42:59
404	add unique index role.uid	CREATE UNIQUE INDEX "UQE_role_uid" ON "role" ("uid");	t		2022-11-10 04:42:59
405	create seed assignment table	CREATE TABLE IF NOT EXISTS "seed_assignment" (\n"builtin_role" VARCHAR(190) NOT NULL\n, "role_name" VARCHAR(190) NOT NULL\n);	t		2022-11-10 04:42:59
406	add unique index builtin_role_role_name	CREATE UNIQUE INDEX "UQE_seed_assignment_builtin_role_role_name" ON "seed_assignment" ("builtin_role","role_name");	t		2022-11-10 04:42:59
407	add column hidden to role table	alter table "role" ADD COLUMN "hidden" BOOL NOT NULL DEFAULT FALSE 	t		2022-11-10 04:42:59
408	create query_history table v1	CREATE TABLE IF NOT EXISTS "query_history" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "uid" VARCHAR(40) NOT NULL\n, "org_id" BIGINT NOT NULL\n, "datasource_uid" VARCHAR(40) NOT NULL\n, "created_by" INTEGER NOT NULL\n, "created_at" INTEGER NOT NULL\n, "comment" TEXT NOT NULL\n, "queries" TEXT NOT NULL\n);	t		2022-11-10 04:42:59
409	add index query_history.org_id-created_by-datasource_uid	CREATE INDEX "IDX_query_history_org_id_created_by_datasource_uid" ON "query_history" ("org_id","created_by","datasource_uid");	t		2022-11-10 04:42:59
410	alter table query_history alter column created_by type to bigint	ALTER TABLE query_history ALTER COLUMN created_by TYPE BIGINT;	t		2022-11-10 04:42:59
411	teams permissions migration	code migration	t		2022-11-10 04:43:00
412	dashboard permissions	code migration	t		2022-11-10 04:43:00
413	dashboard permissions uid scopes	code migration	t		2022-11-10 04:43:00
414	drop managed folder create actions	code migration	t		2022-11-10 04:43:00
415	alerting notification permissions	code migration	t		2022-11-10 04:43:00
416	create query_history_star table v1	CREATE TABLE IF NOT EXISTS "query_history_star" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "query_uid" VARCHAR(40) NOT NULL\n, "user_id" INTEGER NOT NULL\n);	t		2022-11-10 04:43:00
417	add index query_history.user_id-query_uid	CREATE UNIQUE INDEX "UQE_query_history_star_user_id_query_uid" ON "query_history_star" ("user_id","query_uid");	t		2022-11-10 04:43:00
418	add column org_id in query_history_star	alter table "query_history_star" ADD COLUMN "org_id" BIGINT NOT NULL DEFAULT 1 	t		2022-11-10 04:43:00
419	alter table query_history_star_mig column user_id type to bigint	ALTER TABLE query_history_star ALTER COLUMN user_id TYPE BIGINT;	t		2022-11-10 04:43:00
420	create correlation table v1	CREATE TABLE IF NOT EXISTS "correlation" (\n"uid" VARCHAR(40) NOT NULL\n, "source_uid" VARCHAR(40) NOT NULL\n, "target_uid" VARCHAR(40) NULL\n, "label" TEXT NOT NULL\n, "description" TEXT NOT NULL\n, PRIMARY KEY ( "uid","source_uid" ));	t		2022-11-10 04:43:00
421	add index correlations.uid	CREATE INDEX "IDX_correlation_uid" ON "correlation" ("uid");	t		2022-11-10 04:43:00
422	add index correlations.source_uid	CREATE INDEX "IDX_correlation_source_uid" ON "correlation" ("source_uid");	t		2022-11-10 04:43:00
423	create entity_events table	CREATE TABLE IF NOT EXISTS "entity_event" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "entity_id" VARCHAR(1024) NOT NULL\n, "event_type" VARCHAR(8) NOT NULL\n, "created" BIGINT NOT NULL\n);	t		2022-11-10 04:43:00
424	create dashboard public config v1	CREATE TABLE IF NOT EXISTS "dashboard_public_config" (\n"uid" VARCHAR(40) PRIMARY KEY NOT NULL\n, "dashboard_uid" VARCHAR(40) NOT NULL\n, "org_id" BIGINT NOT NULL\n, "time_settings" TEXT NOT NULL\n, "refresh_rate" INTEGER NOT NULL DEFAULT 30\n, "template_variables" TEXT NULL\n);	t		2022-11-10 04:43:00
425	drop index UQE_dashboard_public_config_uid - v1	DROP INDEX "UQE_dashboard_public_config_uid" CASCADE	t		2022-11-10 04:43:01
426	drop index IDX_dashboard_public_config_org_id_dashboard_uid - v1	DROP INDEX "IDX_dashboard_public_config_org_id_dashboard_uid" CASCADE	t		2022-11-10 04:43:01
427	Drop old dashboard public config table	DROP TABLE IF EXISTS "dashboard_public_config"	t		2022-11-10 04:43:01
428	recreate dashboard public config v1	CREATE TABLE IF NOT EXISTS "dashboard_public_config" (\n"uid" VARCHAR(40) PRIMARY KEY NOT NULL\n, "dashboard_uid" VARCHAR(40) NOT NULL\n, "org_id" BIGINT NOT NULL\n, "time_settings" TEXT NOT NULL\n, "refresh_rate" INTEGER NOT NULL DEFAULT 30\n, "template_variables" TEXT NULL\n);	t		2022-11-10 04:43:01
429	create index UQE_dashboard_public_config_uid - v1	CREATE UNIQUE INDEX "UQE_dashboard_public_config_uid" ON "dashboard_public_config" ("uid");	t		2022-11-10 04:43:01
430	create index IDX_dashboard_public_config_org_id_dashboard_uid - v1	CREATE INDEX "IDX_dashboard_public_config_org_id_dashboard_uid" ON "dashboard_public_config" ("org_id","dashboard_uid");	t		2022-11-10 04:43:01
431	drop index UQE_dashboard_public_config_uid - v2	DROP INDEX "UQE_dashboard_public_config_uid" CASCADE	t		2022-11-10 04:43:01
432	drop index IDX_dashboard_public_config_org_id_dashboard_uid - v2	DROP INDEX "IDX_dashboard_public_config_org_id_dashboard_uid" CASCADE	t		2022-11-10 04:43:01
433	Drop public config table	DROP TABLE IF EXISTS "dashboard_public_config"	t		2022-11-10 04:43:01
434	Recreate dashboard public config v2	CREATE TABLE IF NOT EXISTS "dashboard_public_config" (\n"uid" VARCHAR(40) PRIMARY KEY NOT NULL\n, "dashboard_uid" VARCHAR(40) NOT NULL\n, "org_id" BIGINT NOT NULL\n, "time_settings" TEXT NULL\n, "template_variables" TEXT NULL\n, "access_token" VARCHAR(32) NOT NULL\n, "created_by" INTEGER NOT NULL\n, "updated_by" INTEGER NULL\n, "created_at" TIMESTAMP NOT NULL\n, "updated_at" TIMESTAMP NULL\n, "is_enabled" BOOL NOT NULL DEFAULT FALSE\n);	t		2022-11-10 04:43:01
435	create index UQE_dashboard_public_config_uid - v2	CREATE UNIQUE INDEX "UQE_dashboard_public_config_uid" ON "dashboard_public_config" ("uid");	t		2022-11-10 04:43:01
436	create index IDX_dashboard_public_config_org_id_dashboard_uid - v2	CREATE INDEX "IDX_dashboard_public_config_org_id_dashboard_uid" ON "dashboard_public_config" ("org_id","dashboard_uid");	t		2022-11-10 04:43:01
437	create index UQE_dashboard_public_config_access_token - v2	CREATE UNIQUE INDEX "UQE_dashboard_public_config_access_token" ON "dashboard_public_config" ("access_token");	t		2022-11-10 04:43:01
438	Rename table dashboard_public_config to dashboard_public - v2	ALTER TABLE "dashboard_public_config" RENAME TO "dashboard_public"	t		2022-11-10 04:43:01
439	create default alerting folders	code migration	t		2022-11-10 04:43:01
440	create file table	CREATE TABLE IF NOT EXISTS "file" (\n"path" VARCHAR(1024) NOT NULL\n, "path_hash" VARCHAR(64) NOT NULL\n, "parent_folder_path_hash" VARCHAR(64) NOT NULL\n, "contents" BYTEA NOT NULL\n, "etag" VARCHAR(32) NOT NULL\n, "cache_control" VARCHAR(128) NOT NULL\n, "content_disposition" VARCHAR(128) NOT NULL\n, "updated" TIMESTAMP NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "size" BIGINT NOT NULL\n, "mime_type" VARCHAR(255) NOT NULL\n);	t		2022-11-10 04:43:01
441	file table idx: path natural pk	CREATE UNIQUE INDEX "UQE_file_path_hash" ON "file" ("path_hash");	t		2022-11-10 04:43:02
442	file table idx: parent_folder_path_hash fast folder retrieval	CREATE INDEX "IDX_file_parent_folder_path_hash" ON "file" ("parent_folder_path_hash");	t		2022-11-10 04:43:02
443	create file_meta table	CREATE TABLE IF NOT EXISTS "file_meta" (\n"path_hash" VARCHAR(64) NOT NULL\n, "key" VARCHAR(191) NOT NULL\n, "value" VARCHAR(1024) NOT NULL\n);	t		2022-11-10 04:43:02
444	file table idx: path key	CREATE UNIQUE INDEX "UQE_file_meta_path_hash_key" ON "file_meta" ("path_hash","key");	t		2022-11-10 04:43:02
445	set path collation in file table	ALTER TABLE file ALTER COLUMN path TYPE VARCHAR(1024) COLLATE "C";	t		2022-11-10 04:43:02
446	managed permissions migration	code migration	t		2022-11-10 04:43:02
447	managed folder permissions alert actions migration	code migration	t		2022-11-10 04:43:02
448	RBAC action name migrator	code migration	t		2022-11-10 04:43:02
449	Add UID column to playlist	alter table "playlist" ADD COLUMN "uid" VARCHAR(80) NOT NULL DEFAULT 0 	t		2022-11-10 04:43:02
451	Add index for uid in playlist	CREATE UNIQUE INDEX "UQE_playlist_org_id_uid" ON "playlist" ("org_id","uid");	t		2022-11-10 04:43:02
452	update group index for alert rules	code migration	t		2022-11-10 04:43:02
453	managed folder permissions alert actions repeated migration	code migration	t		2022-11-10 04:43:02
454	admin only folder/dashboard permission	code migration	t		2022-11-10 04:43:02
455	managed folder permissions alert actions repeated fixed migration	code migration	t		2022-11-10 04:43:02
456	create data_source_usage_by_day table	CREATE TABLE IF NOT EXISTS "data_source_usage_by_day" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "data_source_id" BIGINT NOT NULL\n, "day" VARCHAR(40) NOT NULL\n, "queries" BIGINT NOT NULL\n, "errors" BIGINT NOT NULL\n, "load_duration_ms" BIGINT NOT NULL\n);	t		2022-11-10 04:43:02
457	create data_source_usage_by_day(data_source_id) index	CREATE INDEX "IDX_data_source_usage_by_day_data_source_id" ON "data_source_usage_by_day" ("data_source_id");	t		2022-11-10 04:43:02
458	create data_source_usage_by_day(data_source_id, day) unique index	CREATE UNIQUE INDEX "UQE_data_source_usage_by_day_data_source_id_day" ON "data_source_usage_by_day" ("data_source_id","day");	t		2022-11-10 04:43:02
459	create dashboard_usage_by_day table	CREATE TABLE IF NOT EXISTS "dashboard_usage_by_day" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n, "day" VARCHAR(40) NOT NULL\n, "views" BIGINT NOT NULL\n, "queries" BIGINT NOT NULL\n, "errors" BIGINT NOT NULL\n, "load_duration" REAL NOT NULL\n);	t		2022-11-10 04:43:02
460	create dashboard_usage_sums table	CREATE TABLE IF NOT EXISTS "dashboard_usage_sums" (\n"dashboard_id" BIGINT PRIMARY KEY NOT NULL\n, "updated" TIMESTAMP NOT NULL\n, "views_last_1_days" BIGINT NOT NULL\n, "views_last_7_days" BIGINT NOT NULL\n, "views_last_30_days" BIGINT NOT NULL\n, "views_total" BIGINT NOT NULL\n, "queries_last_1_days" BIGINT NOT NULL\n, "queries_last_7_days" BIGINT NOT NULL\n, "queries_last_30_days" BIGINT NOT NULL\n, "queries_total" BIGINT NOT NULL\n);	t		2022-11-10 04:43:02
461	create dashboard_usage_by_day(dashboard_id) index	CREATE INDEX "IDX_dashboard_usage_by_day_dashboard_id" ON "dashboard_usage_by_day" ("dashboard_id");	t		2022-11-10 04:43:02
462	create dashboard_usage_by_day(dashboard_id, day) index	CREATE UNIQUE INDEX "UQE_dashboard_usage_by_day_dashboard_id_day" ON "dashboard_usage_by_day" ("dashboard_id","day");	t		2022-11-10 04:43:02
463	add column errors_last_1_days to dashboard_usage_sums	alter table "dashboard_usage_sums" ADD COLUMN "errors_last_1_days" BIGINT NOT NULL DEFAULT 0 	t		2022-11-10 04:43:03
464	add column errors_last_7_days to dashboard_usage_sums	alter table "dashboard_usage_sums" ADD COLUMN "errors_last_7_days" BIGINT NOT NULL DEFAULT 0 	t		2022-11-10 04:43:03
465	add column errors_last_30_days to dashboard_usage_sums	alter table "dashboard_usage_sums" ADD COLUMN "errors_last_30_days" BIGINT NOT NULL DEFAULT 0 	t		2022-11-10 04:43:03
466	add column errors_total to dashboard_usage_sums	alter table "dashboard_usage_sums" ADD COLUMN "errors_total" BIGINT NOT NULL DEFAULT 0 	t		2022-11-10 04:43:03
467	create dashboard_public_usage_by_day table	CREATE TABLE IF NOT EXISTS "dashboard_public_usage_by_day" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "public_dashboard_uid" VARCHAR(255) NOT NULL\n, "day" VARCHAR(40) NOT NULL\n, "views" BIGINT NOT NULL\n, "queries" BIGINT NOT NULL\n, "errors" BIGINT NOT NULL\n, "load_duration" REAL NOT NULL\n);	t		2022-11-10 04:43:03
468	create user_dashboard_views table	CREATE TABLE IF NOT EXISTS "user_dashboard_views" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "user_id" BIGINT NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n, "viewed" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:43:03
469	add index user_dashboard_views.user_id	CREATE INDEX "IDX_user_dashboard_views_user_id" ON "user_dashboard_views" ("user_id");	t		2022-11-10 04:43:03
470	add index user_dashboard_views.dashboard_id	CREATE INDEX "IDX_user_dashboard_views_dashboard_id" ON "user_dashboard_views" ("dashboard_id");	t		2022-11-10 04:43:03
471	add unique index user_dashboard_views_user_id_dashboard_id	CREATE UNIQUE INDEX "UQE_user_dashboard_views_user_id_dashboard_id" ON "user_dashboard_views" ("user_id","dashboard_id");	t		2022-11-10 04:43:03
472	create user_stats table	CREATE TABLE IF NOT EXISTS "user_stats" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "user_id" BIGINT NOT NULL\n, "billing_role" VARCHAR(40) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:43:03
473	add unique index user_stats(user_id)	CREATE UNIQUE INDEX "UQE_user_stats_user_id" ON "user_stats" ("user_id");	t		2022-11-10 04:43:03
474	create data_source_cache table	CREATE TABLE IF NOT EXISTS "data_source_cache" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "data_source_id" BIGINT NOT NULL\n, "enabled" BOOL NOT NULL\n, "ttl_ms" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:43:03
475	add index data_source_cache.data_source_id	CREATE INDEX "IDX_data_source_cache_data_source_id" ON "data_source_cache" ("data_source_id");	t		2022-11-10 04:43:03
476	add use_default_ttl column	alter table "data_source_cache" ADD COLUMN "use_default_ttl" BOOL NOT NULL DEFAULT TRUE 	t		2022-11-10 04:43:03
477	add data_source_cache.data_source_uid column	alter table "data_source_cache" ADD COLUMN "data_source_uid" VARCHAR(40) NOT NULL DEFAULT 0 	t		2022-11-10 04:43:03
478	remove abandoned data_source_cache records	DELETE FROM data_source_cache WHERE NOT EXISTS (SELECT 1 FROM data_source WHERE id = data_source_cache.data_source_id);	t		2022-11-10 04:43:03
479	update data_source_cache.data_source_uid value	UPDATE data_source_cache SET data_source_uid = data_source.uid FROM data_source WHERE data_source.id = data_source_cache.data_source_id;	t		2022-11-10 04:43:03
480	add index data_source_cache.data_source_uid	CREATE INDEX "IDX_data_source_cache_data_source_uid" ON "data_source_cache" ("data_source_uid");	t		2022-11-10 04:43:03
481	add data_source_cache.ttl_resources_ms column	alter table "data_source_cache" ADD COLUMN "ttl_resources_ms" BIGINT NOT NULL DEFAULT 300000 	t		2022-11-10 04:43:03
482	update data_source_cache.ttl_resources_ms to have the same value as ttl_ms	UPDATE data_source_cache SET ttl_resources_ms = ttl_ms;	t		2022-11-10 04:43:03
483	create data_source_acl table	CREATE TABLE IF NOT EXISTS "data_source_acl" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "data_source_id" BIGINT NOT NULL\n, "team_id" BIGINT NOT NULL\n, "user_id" BIGINT NOT NULL\n, "permission" SMALLINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:43:03
484	add index data_source_acl.data_source_id	CREATE INDEX "IDX_data_source_acl_data_source_id" ON "data_source_acl" ("data_source_id");	t		2022-11-10 04:43:04
485	add unique index datasource_acl.unique	CREATE UNIQUE INDEX "UQE_data_source_acl_data_source_id_team_id_user_id" ON "data_source_acl" ("data_source_id","team_id","user_id");	t		2022-11-10 04:43:04
486	create license_token table	CREATE TABLE IF NOT EXISTS "license_token" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "token" TEXT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:43:04
487	drop recorded_queries table v14	DROP TABLE IF EXISTS "recorded_queries"	t		2022-11-10 04:43:04
489	create recording_rules table v14	CREATE TABLE IF NOT EXISTS "recording_rules" (\n"id" VARCHAR(128) NOT NULL\n, "target_ref_id" VARCHAR(128) NOT NULL\n, "name" VARCHAR(128) NOT NULL\n, "description" TEXT NOT NULL\n, "org_id" BIGINT NOT NULL\n, "interval" BIGINT NOT NULL\n, "range" BIGINT NOT NULL\n, "active" BOOL NOT NULL DEFAULT TRUE\n, "count" BOOL NOT NULL DEFAULT TRUE\n, "queries" BYTEA NOT NULL\n, "created_at" TIMESTAMP NOT NULL\n, PRIMARY KEY ( "id","target_ref_id" ));	t		2022-11-10 04:43:04
490	create remote_write_targets table v1	CREATE TABLE IF NOT EXISTS "remote_write_targets" (\n"id" VARCHAR(128) NOT NULL\n, "data_source_uid" VARCHAR(128) NOT NULL\n, "write_path" VARCHAR(128) NOT NULL\n, "org_id" INTEGER NOT NULL\n, PRIMARY KEY ( "id","data_source_uid","write_path" ));	t		2022-11-10 04:43:04
491	Add prom_name to recording_rules table	alter table "recording_rules" ADD COLUMN "prom_name" VARCHAR(128) NULL 	t		2022-11-10 04:43:04
492	ensure remote_write_targets table	CREATE TABLE IF NOT EXISTS "remote_write_targets" (\n"id" VARCHAR(128) NOT NULL\n, "data_source_uid" VARCHAR(128) NOT NULL\n, "write_path" VARCHAR(128) NOT NULL\n, "org_id" INTEGER NOT NULL\n, PRIMARY KEY ( "id","data_source_uid","write_path" ));	t		2022-11-10 04:43:04
493	create report config table v1	CREATE TABLE IF NOT EXISTS "report" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "user_id" BIGINT NOT NULL\n, "org_id" BIGINT NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n, "name" TEXT NOT NULL\n, "recipients" TEXT NOT NULL\n, "reply_to" TEXT NULL\n, "message" TEXT NULL\n, "schedule_frequency" VARCHAR(32) NOT NULL\n, "schedule_day" VARCHAR(32) NOT NULL\n, "schedule_hour" BIGINT NOT NULL\n, "schedule_minute" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:43:04
494	Add index report.user_id	CREATE INDEX "IDX_report_user_id" ON "report" ("user_id");	t		2022-11-10 04:43:04
495	add index to dashboard_id	CREATE INDEX "IDX_report_dashboard_id" ON "report" ("dashboard_id");	t		2022-11-10 04:43:04
496	add index to org_id	CREATE INDEX "IDX_report_org_id" ON "report" ("org_id");	t		2022-11-10 04:43:04
497	Add timezone to the report	alter table "report" ADD COLUMN "schedule_timezone" VARCHAR(50) NOT NULL DEFAULT 'Europe/Stockholm' 	t		2022-11-10 04:43:05
498	Add time_from to the report	alter table "report" ADD COLUMN "time_from" VARCHAR(255) NULL 	t		2022-11-10 04:43:05
499	Add time_to to the report	alter table "report" ADD COLUMN "time_to" VARCHAR(255) NULL 	t		2022-11-10 04:43:05
500	Add PDF landscape option to the report	alter table "report" ADD COLUMN "pdf_landscape" BOOL NULL 	t		2022-11-10 04:43:05
501	Add monthly day scheduling option to the report	alter table "report" ADD COLUMN "schedule_day_of_month" VARCHAR(32) NULL 	t		2022-11-10 04:43:05
502	Add PDF layout option to the report	alter table "report" ADD COLUMN "pdf_layout" VARCHAR(255) NULL 	t		2022-11-10 04:43:05
503	Add PDF orientation option to the report	alter table "report" ADD COLUMN "pdf_orientation" VARCHAR(32) NULL 	t		2022-11-10 04:43:05
504	Update report pdf_orientation from pdf_landscape	UPDATE report SET pdf_orientation = 'landscape' WHERE pdf_landscape = true	t		2022-11-10 04:43:05
505	create report settings table	CREATE TABLE IF NOT EXISTS "report_settings" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "user_id" BIGINT NOT NULL\n, "org_id" BIGINT NOT NULL\n, "branding_report_logo_url" TEXT NULL\n, "branding_email_logo_url" TEXT NULL\n, "branding_email_footer_link" TEXT NULL\n, "branding_email_footer_text" TEXT NULL\n, "branding_email_footer_mode" VARCHAR(50) NULL\n);	t		2022-11-10 04:43:06
506	Add dashboard_uid field to the report	alter table "report" ADD COLUMN "dashboard_uid" VARCHAR(40) NULL 	t		2022-11-10 04:43:06
507	Add template_vars field to the report	alter table "report" ADD COLUMN "template_vars" TEXT NULL 	t		2022-11-10 04:43:06
508	Add option to include dashboard url in the report	alter table "report" ADD COLUMN "enable_dashboard_url" BOOL NULL 	t		2022-11-10 04:43:06
509	Add state field to the report	alter table "report" ADD COLUMN "state" VARCHAR(32) NULL 	t		2022-11-10 04:43:07
510	Add option to add CSV files to the report	alter table "report" ADD COLUMN "enable_csv" BOOL NULL 	t		2022-11-10 04:43:07
511	Add scheduling start date	alter table "report" ADD COLUMN "schedule_start" INTEGER NULL 	t		2022-11-10 04:43:07
512	Add missing schedule_start date for old reports	code migration	t		2022-11-10 04:43:07
513	Add scheduling end date	alter table "report" ADD COLUMN "schedule_end" INTEGER NULL 	t		2022-11-10 04:43:07
514	Add schedulinng custom interval frequency	alter table "report" ADD COLUMN "schedule_interval_frequency" VARCHAR(32) NULL 	t		2022-11-10 04:43:07
515	Add scheduling custom interval amount	alter table "report" ADD COLUMN "schedule_interval_amount" BIGINT NULL 	t		2022-11-10 04:43:07
516	Add workdays only flag to report	alter table "report" ADD COLUMN "schedule_workdays_only" BOOL NULL 	t		2022-11-10 04:43:07
517	create report dashboards table	CREATE TABLE IF NOT EXISTS "report_dashboards" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "report_id" BIGINT NOT NULL\n, "dashboard_uid" VARCHAR(40) NOT NULL DEFAULT ''\n, "report_variables" TEXT NULL\n, "time_to" VARCHAR(255) NULL\n, "time_from" VARCHAR(255) NULL\n);	t		2022-11-10 04:43:07
518	Add index report_dashboards.report_id	CREATE INDEX "IDX_report_dashboards_report_id" ON "report_dashboards" ("report_id");	t		2022-11-10 04:43:07
519	Migrate report fields into report_dashboards	INSERT INTO report_dashboards (report_id, dashboard_uid, report_variables, time_to, time_from) SELECT id, CASE WHEN dashboard_uid IS NULL THEN '' ELSE dashboard_uid END, template_vars, time_to, time_from FROM report	t		2022-11-10 04:43:07
520	Add formats option to the report	alter table "report" ADD COLUMN "formats" VARCHAR(190) NOT NULL DEFAULT '["pdf"]' 	t		2022-11-10 04:43:07
521	Migrate reports with csv enabled	UPDATE report SET formats='["pdf","csv"]' WHERE enable_csv IS TRUE;	t		2022-11-10 04:43:07
522	Migrate ancient reports	code migration	t		2022-11-10 04:43:07
523	Add created column in report_dashboards	alter table "report_dashboards" ADD COLUMN "created" TIMESTAMP NULL 	t		2022-11-10 04:43:07
524	create team group table	CREATE TABLE IF NOT EXISTS "team_group" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "team_id" BIGINT NOT NULL\n, "group_id" VARCHAR(190) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2022-11-10 04:43:07
525	add index team_group.org_id	CREATE INDEX "IDX_team_group_org_id" ON "team_group" ("org_id");	t		2022-11-10 04:43:07
526	add unique index team_group.org_id_team_id_group_id	CREATE UNIQUE INDEX "UQE_team_group_org_id_team_id_group_id" ON "team_group" ("org_id","team_id","group_id");	t		2022-11-10 04:43:07
527	add index team_group.group_id	CREATE INDEX "IDX_team_group_group_id" ON "team_group" ("group_id");	t		2022-11-10 04:43:07
528	create settings table	CREATE TABLE IF NOT EXISTS "setting" (\n"section" VARCHAR(100) NOT NULL\n, "key" VARCHAR(100) NOT NULL\n, "value" TEXT NOT NULL\n);	t		2022-11-10 04:43:07
529	add unique index settings.section_key	CREATE UNIQUE INDEX "UQE_setting_section_key" ON "setting" ("section","key");	t		2022-11-10 04:43:07
530	migrate role names	code migration	t		2022-11-10 04:43:07
532	remove duplicated org role	code migration	t		2022-11-10 04:43:08
533	migrate alerting role names	code migration	t		2022-11-10 04:43:08
534	data source permissions	code migration	t		2022-11-10 04:43:08
535	data source uid permissions	code migration	t		2022-11-10 04:43:08
536	rename permissions:delegate scope	UPDATE permission SET scope = 'permissions:type:delegate' WHERE scope = 'permissions:delegate'	t		2022-11-10 04:43:08
537	builtin role migration	code migration	t		2022-11-10 04:43:08
538	add action column to seed_assignment	alter table "seed_assignment" ADD COLUMN "action" VARCHAR(190) NULL 	t		2022-11-10 04:43:08
539	add scope column to seed_assignment	alter table "seed_assignment" ADD COLUMN "scope" VARCHAR(190) NULL 	t		2022-11-10 04:43:08
540	remove unique index builtin_role_role_name before nullable update	DROP INDEX "UQE_seed_assignment_builtin_role_role_name" CASCADE	t		2022-11-10 04:43:08
541	update seed_assignment role_name column to nullable	ALTER TABLE `seed_assignment` ALTER COLUMN role_name DROP NOT NULL;	t		2022-11-10 04:43:08
542	add unique index builtin_role_name back	CREATE UNIQUE INDEX "UQE_seed_assignment_builtin_role_role_name" ON "seed_assignment" ("builtin_role","role_name");	t		2022-11-10 04:43:08
543	add unique index builtin_role_action_scope	CREATE UNIQUE INDEX "UQE_seed_assignment_builtin_role_action_scope" ON "seed_assignment" ("builtin_role","action","scope");	t		2022-11-10 04:43:08
544	seed permissions migration	code migration	t		2022-11-10 04:43:08
545	managed permissions migration enterprise	code migration	t		2022-11-10 04:43:08
\.


--
-- Data for Name: ngalert_configuration; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.ngalert_configuration (id, org_id, alertmanagers, created_at, updated_at, send_alerts_to) FROM stdin;
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.org (id, version, name, address1, address2, city, state, zip_code, country, billing_email, created, updated) FROM stdin;
1	0	Main Org.							\N	2022-11-10 04:43:08	2022-11-10 04:43:08
3	0	cliente							\N	2022-11-11 06:59:08	2022-11-11 06:59:08
\.


--
-- Data for Name: org_user; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.org_user (id, org_id, user_id, role, created, updated) FROM stdin;
2	1	2	Viewer	2022-11-10 22:09:48	2022-11-10 22:10:20
3	1	3	Viewer	2022-11-10 22:34:58	2022-11-10 22:34:58
5	3	1	Admin	2022-11-11 06:59:08	2022-11-11 06:59:08
1	1	1	Admin	2022-11-10 04:43:08	2022-11-11 07:06:30
\.


--
-- Data for Name: permission; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.permission (id, role_id, action, scope, created, updated) FROM stdin;
42	8	dashboards:read	dashboards:uid:r3lvp-44k	2022-11-11 21:57:11	2022-11-11 21:57:11
43	8	dashboards:write	dashboards:uid:r3lvp-44k	2022-11-11 21:57:11	2022-11-11 21:57:11
44	8	dashboards:delete	dashboards:uid:r3lvp-44k	2022-11-11 21:57:11	2022-11-11 21:57:11
45	8	dashboards.permissions:read	dashboards:uid:r3lvp-44k	2022-11-11 21:57:11	2022-11-11 21:57:11
46	8	dashboards.permissions:write	dashboards:uid:r3lvp-44k	2022-11-11 21:57:11	2022-11-11 21:57:11
47	9	dashboards:read	dashboards:uid:r3lvp-44k	2022-11-11 21:57:11	2022-11-11 21:57:11
48	9	dashboards:write	dashboards:uid:r3lvp-44k	2022-11-11 21:57:11	2022-11-11 21:57:11
49	9	dashboards:delete	dashboards:uid:r3lvp-44k	2022-11-11 21:57:11	2022-11-11 21:57:11
50	10	dashboards:read	dashboards:uid:r3lvp-44k	2022-11-11 21:57:11	2022-11-11 21:57:11
\.


--
-- Data for Name: playlist; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.playlist (id, name, "interval", org_id, uid) FROM stdin;
\.


--
-- Data for Name: playlist_item; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.playlist_item (id, playlist_id, type, value, title, "order") FROM stdin;
\.


--
-- Data for Name: plugin_setting; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.plugin_setting (id, org_id, plugin_id, enabled, pinned, json_data, secure_json_data, created, updated, plugin_version) FROM stdin;
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.preferences (id, org_id, user_id, version, home_dashboard_id, timezone, theme, created, updated, team_id, week_start, json_data) FROM stdin;
1	1	1	0	2			2022-11-10 05:33:19	2022-11-10 05:33:19	0		{"locale":"","navbar":{"savedItems":null},"queryHistory":{"homeTab":""}}
2	3	0	1	5		dark	2022-11-11 06:59:24	2022-11-11 22:08:38	0		{"locale":"","navbar":{"savedItems":null},"queryHistory":{"homeTab":""}}
\.


--
-- Data for Name: provenance_type; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.provenance_type (id, org_id, record_key, record_type, provenance) FROM stdin;
\.


--
-- Data for Name: query_history; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.query_history (id, uid, org_id, datasource_uid, created_by, created_at, comment, queries) FROM stdin;
\.


--
-- Data for Name: query_history_star; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.query_history_star (id, query_uid, user_id, org_id) FROM stdin;
\.


--
-- Data for Name: quota; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.quota (id, org_id, user_id, target, "limit", created, updated) FROM stdin;
\.


--
-- Data for Name: recording_rules; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.recording_rules (id, target_ref_id, name, description, org_id, "interval", range, active, count, queries, created_at, prom_name) FROM stdin;
\.


--
-- Data for Name: remote_write_targets; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.remote_write_targets (id, data_source_uid, write_path, org_id) FROM stdin;
\.


--
-- Data for Name: report; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.report (id, user_id, org_id, dashboard_id, name, recipients, reply_to, message, schedule_frequency, schedule_day, schedule_hour, schedule_minute, created, updated, schedule_timezone, time_from, time_to, pdf_landscape, schedule_day_of_month, pdf_layout, pdf_orientation, dashboard_uid, template_vars, enable_dashboard_url, state, enable_csv, schedule_start, schedule_end, schedule_interval_frequency, schedule_interval_amount, schedule_workdays_only, formats) FROM stdin;
\.


--
-- Data for Name: report_dashboards; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.report_dashboards (id, report_id, dashboard_uid, report_variables, time_to, time_from, created) FROM stdin;
\.


--
-- Data for Name: report_settings; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.report_settings (id, user_id, org_id, branding_report_logo_url, branding_email_logo_url, branding_email_footer_link, branding_email_footer_text, branding_email_footer_mode) FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.role (id, name, description, version, org_id, uid, created, updated, display_name, group_name, hidden) FROM stdin;
1	basic:grafana_admin	Grafana Admin role	1	0	basic_grafana_admin	2022-11-10 04:43:08.084477	2022-11-10 04:43:08.084477	Grafana Admin	Basic	t
2	basic:admin	Admin role	1	0	basic_admin	2022-11-10 04:43:08.084477	2022-11-10 04:43:08.084477	Admin	Basic	t
3	basic:editor	Editor role	1	0	basic_editor	2022-11-10 04:43:08.084477	2022-11-10 04:43:08.084477	Editor	Basic	t
4	basic:viewer	Viewer role	1	0	basic_viewer	2022-11-10 04:43:08.084477	2022-11-10 04:43:08.084477	Viewer	Basic	t
5	managed:users:1:permissions		0	1	9tXtUbD4z	2022-11-10 05:28:26	2022-11-10 05:28:26			f
6	managed:builtins:editor:permissions		0	1	22XpUbvVk	2022-11-10 05:28:26	2022-11-10 05:28:26			f
7	managed:builtins:viewer:permissions		0	1	XhXp8xvVz	2022-11-10 05:28:26	2022-11-10 05:28:26			f
8	managed:users:1:permissions		0	3	f_Z50YD4k	2022-11-11 07:05:24	2022-11-11 07:05:24			f
9	managed:builtins:editor:permissions		0	3	ECWc0LD4k	2022-11-11 07:05:24	2022-11-11 07:05:24			f
10	managed:builtins:viewer:permissions		0	3	G3WcAYD4k	2022-11-11 07:05:24	2022-11-11 07:05:24			f
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.secrets (id, org_id, namespace, type, value, created, updated) FROM stdin;
2	1	PostgreSQL	datasource	I1EySlVTemg0UkRSNiMqWVdWekxXTm1ZZypBMVVybWpGTPj5j9LA3fweeyZnjjlOoobvgCkInhW1ZovyySNmAn9SS2FrGezqJFFBEg	2022-11-10 18:29:11	2022-11-10 18:38:19
3	3	PostgreSQL	datasource	I1VIZzRORnB6ZGxaNiMqWVdWekxXTm1ZZypRRzA5Um9vdtwwY9/Vf2DC3jG39G7I/l3SQOjUI1UucpTw2jWAhvZo0VKmXlywqLdbaA	2022-11-11 21:53:46	2022-11-11 21:54:20
\.


--
-- Data for Name: seed_assignment; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.seed_assignment (builtin_role, role_name, action, scope) FROM stdin;
\.


--
-- Data for Name: server_lock; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.server_lock (id, operation_uid, version, last_execution) FROM stdin;
1	metaanalytics-daily-rollup	6	1668129924
2	cleanup expired auth tokens	14	1668624714
4	delete old login attempts	968	1668653895
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.session (key, data, expiry) FROM stdin;
\.


--
-- Data for Name: setting; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.setting (section, key, value) FROM stdin;
\.


--
-- Data for Name: short_url; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.short_url (id, org_id, uid, path, created_by, created_at, last_seen_at) FROM stdin;
\.


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.star (id, user_id, dashboard_id) FROM stdin;
1	1	2
3	1	5
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.tag (id, key, value) FROM stdin;
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.team (id, name, org_id, created, updated, email) FROM stdin;
1	m	1	2022-11-11 07:13:11	2022-11-11 07:13:11	
\.


--
-- Data for Name: team_group; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.team_group (id, org_id, team_id, group_id, created, updated) FROM stdin;
\.


--
-- Data for Name: team_member; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.team_member (id, org_id, team_id, user_id, created, updated, external, permission) FROM stdin;
\.


--
-- Data for Name: team_role; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.team_role (id, org_id, team_id, role_id, created) FROM stdin;
\.


--
-- Data for Name: temp_user; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.temp_user (id, org_id, version, email, name, role, code, status, invited_by_user_id, email_sent, email_sent_on, remote_addr, created, updated) FROM stdin;
\.


--
-- Data for Name: test_data; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.test_data (id, metric1, metric2, value_big_int, value_double, value_float, value_int, time_epoch, time_date_time, time_time_stamp) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public."user" (id, version, login, email, name, password, salt, rands, company, org_id, is_admin, email_verified, theme, created, updated, help_flags1, last_seen_at, is_disabled, is_service_account) FROM stdin;
3	0	funcionario	funcionario	funcionário	921680859bb53dc5ab716fc77f03fe43b7a2afeb0d6910c12cd6d9f81bc830c15ac91ee127f9937462a1c816da6f2d4b9a65	gQuJjl08pA	vTzkQlZEEd		1	f	f		2022-11-10 22:34:58	2022-11-10 22:34:58	0	2012-11-10 22:34:58	f	f
2	0	cliente	cliente1234	cliente	b3b0f916e259ac8573f5e87aafc6d0ff784c515a2ef9571dbdbf8b83e304443b2716afd08fabde33477a5ef0ddbf0f29d3d7	1PLV3J9bRx	Badl5ew5jl		1	f	f		2022-11-10 22:09:47	2022-11-10 22:10:56	0	2022-11-10 22:35:58	f	f
1	0	argosAdmin	admin@localhost		478a619afe657caafb47d12a1923194b9b09e5138b6766b84b927102c0b999cef66696ac738635b632a6522aa1ac25c2f496	xwNryDNK3W	gNinq17U7b		3	t	f		2022-11-10 04:43:08	2022-11-10 04:43:08	0	2022-11-17 02:55:17	f	f
\.


--
-- Data for Name: user_auth; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.user_auth (id, user_id, auth_module, auth_id, created, o_auth_access_token, o_auth_refresh_token, o_auth_token_type, o_auth_expiry, o_auth_id_token) FROM stdin;
\.


--
-- Data for Name: user_auth_token; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.user_auth_token (id, user_id, auth_token, prev_auth_token, user_agent, client_ip, auth_token_seen, seen_at, rotated_at, created_at, updated_at, revoked_at) FROM stdin;
5	2	5434bf0287dad1c61faf675787d1c1d4bef56d9f283d45e6c47de8db5c2d6a6a	5434bf0287dad1c61faf675787d1c1d4bef56d9f283d45e6c47de8db5c2d6a6a	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36	192.168.0.22	t	1668119758	1668119758	1668119758	1668119758	0
1	1	373299038e0256f9049175076f99528f38243889c96d1d778bae9781cce5ab45	283a78908d080784f4da649174fa8c46e09d55d183dfad62ff617135e95aec26	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36	172.24.0.6	t	1668057595	1668057593	1668055527	1668055527	0
7	1	41d233255e4075cbd57de0aae394eaa89ac9f9bcfa4bf8161045248b413ee878	e4b2f3ce50fb3b29ddfab146e6e7a84c3ae234bc3937e40aa56cb0c36a166ee7	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36	201.4.35.80	t	1668204481	1668204475	1668150046	1668150046	0
9	1	48e8dfe7bf5dd4e4cc8dd90233b45c1c230caa65cbaf9be69fbc183be56881c4	48e8dfe7bf5dd4e4cc8dd90233b45c1c230caa65cbaf9be69fbc183be56881c4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36	201.4.35.80	t	1668203196	1668203196	1668203196	1668203196	0
11	1	98299efb351fb24380d767d0b45df28147ddd0e246541d686b395a861c6f78bf	ff20f5de3d3e22d761268444e8a8ba1c089ddd54c3d9065882cc57715ce3efa5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36	192.168.0.12	t	1668634706	1668634493	1668207817	1668207817	0
4	2	7d032ed9a8e84ce875ab6924d855457013e23a92bfd42192cf39775ae9e3d167	7d032ed9a8e84ce875ab6924d855457013e23a92bfd42192cf39775ae9e3d167	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36	192.168.0.22	t	1668118259	1668118259	1668118259	1668118259	0
3	1	0e88353d7c0e8259f4140a86b7d97165dafa8c0a60e7da8d00c3e9dfee2cee4c	bd7b9fc84fd85d6fe3816d613e5d9c1af6932fd276a9da0fc087154be4ea64d9	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36	192.168.0.12	t	1668641990	1668641990	1668104671	1668104671	0
12	1	38d16f9ec9ca49767adb303d5b2f946a7f2e3d2a7f6984acf63178b076419631	dd498d5c7d28096d17c89b740cc4549db82ea2a30f7428f40c634c26b0f84144	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36	192.168.0.12	t	1668653401	1668653400	1668652800	1668652800	0
\.


--
-- Data for Name: user_dashboard_views; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.user_dashboard_views (id, user_id, dashboard_id, viewed) FROM stdin;
\.


--
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.user_role (id, org_id, user_id, role_id, created) FROM stdin;
1	1	1	5	2022-11-10 05:28:26
2	3	1	8	2022-11-11 07:05:24
\.


--
-- Data for Name: user_stats; Type: TABLE DATA; Schema: public; Owner: grafana_user
--

COPY public.user_stats (id, user_id, billing_role, created, updated) FROM stdin;
1	1	server_admin	2022-11-10 04:45:27.83999	2022-11-10 18:24:32.011718
2	2	viewer	2022-11-10 22:10:59.364561	2022-11-10 22:35:58.777524
\.


--
-- Name: alert_configuration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.alert_configuration_id_seq', 3, true);


--
-- Name: alert_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.alert_id_seq', 1, false);


--
-- Name: alert_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.alert_image_id_seq', 1, false);


--
-- Name: alert_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.alert_notification_id_seq', 1, false);


--
-- Name: alert_notification_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.alert_notification_state_id_seq', 1, false);


--
-- Name: alert_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.alert_rule_id_seq', 1, false);


--
-- Name: alert_rule_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.alert_rule_tag_id_seq', 1, false);


--
-- Name: alert_rule_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.alert_rule_version_id_seq', 1, false);


--
-- Name: annotation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.annotation_id_seq', 1, false);


--
-- Name: annotation_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.annotation_tag_id_seq', 1, false);


--
-- Name: api_key_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.api_key_id_seq1', 1, false);


--
-- Name: builtin_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.builtin_role_id_seq', 8, true);


--
-- Name: dashboard_acl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.dashboard_acl_id_seq', 2, true);


--
-- Name: dashboard_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.dashboard_id_seq1', 5, true);


--
-- Name: dashboard_provisioning_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.dashboard_provisioning_id_seq1', 1, false);


--
-- Name: dashboard_public_usage_by_day_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.dashboard_public_usage_by_day_id_seq', 1, false);


--
-- Name: dashboard_snapshot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.dashboard_snapshot_id_seq', 1, false);


--
-- Name: dashboard_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.dashboard_tag_id_seq', 1, false);


--
-- Name: dashboard_usage_by_day_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.dashboard_usage_by_day_id_seq', 1, false);


--
-- Name: dashboard_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.dashboard_version_id_seq', 18, true);


--
-- Name: data_source_acl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.data_source_acl_id_seq', 1, false);


--
-- Name: data_source_cache_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.data_source_cache_id_seq', 1, false);


--
-- Name: data_source_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.data_source_id_seq1', 3, true);


--
-- Name: data_source_usage_by_day_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.data_source_usage_by_day_id_seq', 1, false);


--
-- Name: entity_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.entity_event_id_seq', 1, false);


--
-- Name: kv_store_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.kv_store_id_seq', 11, true);


--
-- Name: library_element_connection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.library_element_connection_id_seq', 1, false);


--
-- Name: library_element_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.library_element_id_seq', 1, false);


--
-- Name: license_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.license_token_id_seq', 1, false);


--
-- Name: login_attempt_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.login_attempt_id_seq1', 1, false);


--
-- Name: migration_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.migration_log_id_seq', 545, true);


--
-- Name: ngalert_configuration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.ngalert_configuration_id_seq', 1, false);


--
-- Name: org_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.org_id_seq', 3, true);


--
-- Name: org_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.org_user_id_seq', 6, true);


--
-- Name: permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.permission_id_seq', 50, true);


--
-- Name: playlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.playlist_id_seq', 1, false);


--
-- Name: playlist_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.playlist_item_id_seq', 1, false);


--
-- Name: plugin_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.plugin_setting_id_seq', 1, false);


--
-- Name: preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.preferences_id_seq', 2, true);


--
-- Name: provenance_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.provenance_type_id_seq', 1, false);


--
-- Name: query_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.query_history_id_seq', 1, false);


--
-- Name: query_history_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.query_history_star_id_seq', 1, false);


--
-- Name: quota_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.quota_id_seq', 1, false);


--
-- Name: report_dashboards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.report_dashboards_id_seq', 1, false);


--
-- Name: report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.report_id_seq', 1, false);


--
-- Name: report_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.report_settings_id_seq', 1, false);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.role_id_seq', 10, true);


--
-- Name: secrets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.secrets_id_seq', 3, true);


--
-- Name: server_lock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.server_lock_id_seq', 74, true);


--
-- Name: short_url_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.short_url_id_seq', 1, false);


--
-- Name: star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.star_id_seq', 3, true);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.tag_id_seq', 1, false);


--
-- Name: team_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.team_group_id_seq', 1, false);


--
-- Name: team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.team_id_seq', 1, true);


--
-- Name: team_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.team_member_id_seq', 1, true);


--
-- Name: team_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.team_role_id_seq', 1, false);


--
-- Name: temp_user_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.temp_user_id_seq1', 1, false);


--
-- Name: test_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.test_data_id_seq', 1, false);


--
-- Name: user_auth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.user_auth_id_seq', 1, false);


--
-- Name: user_auth_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.user_auth_token_id_seq', 12, true);


--
-- Name: user_dashboard_views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.user_dashboard_views_id_seq', 1, false);


--
-- Name: user_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.user_id_seq1', 4, true);


--
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.user_role_id_seq', 2, true);


--
-- Name: user_stats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: grafana_user
--

SELECT pg_catalog.setval('public.user_stats_id_seq', 2, true);


--
-- Name: alert_configuration alert_configuration_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert_configuration
    ADD CONSTRAINT alert_configuration_pkey PRIMARY KEY (id);


--
-- Name: alert_image alert_image_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert_image
    ADD CONSTRAINT alert_image_pkey PRIMARY KEY (id);


--
-- Name: alert_instance alert_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert_instance
    ADD CONSTRAINT alert_instance_pkey PRIMARY KEY (rule_org_id, rule_uid, labels_hash);


--
-- Name: alert_notification alert_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert_notification
    ADD CONSTRAINT alert_notification_pkey PRIMARY KEY (id);


--
-- Name: alert_notification_state alert_notification_state_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert_notification_state
    ADD CONSTRAINT alert_notification_state_pkey PRIMARY KEY (id);


--
-- Name: alert alert_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert
    ADD CONSTRAINT alert_pkey PRIMARY KEY (id);


--
-- Name: alert_rule alert_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert_rule
    ADD CONSTRAINT alert_rule_pkey PRIMARY KEY (id);


--
-- Name: alert_rule_tag alert_rule_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert_rule_tag
    ADD CONSTRAINT alert_rule_tag_pkey PRIMARY KEY (id);


--
-- Name: alert_rule_version alert_rule_version_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.alert_rule_version
    ADD CONSTRAINT alert_rule_version_pkey PRIMARY KEY (id);


--
-- Name: annotation annotation_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.annotation
    ADD CONSTRAINT annotation_pkey PRIMARY KEY (id);


--
-- Name: annotation_tag annotation_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.annotation_tag
    ADD CONSTRAINT annotation_tag_pkey PRIMARY KEY (id);


--
-- Name: api_key api_key_pkey1; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.api_key
    ADD CONSTRAINT api_key_pkey1 PRIMARY KEY (id);


--
-- Name: builtin_role builtin_role_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.builtin_role
    ADD CONSTRAINT builtin_role_pkey PRIMARY KEY (id);


--
-- Name: cache_data cache_data_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.cache_data
    ADD CONSTRAINT cache_data_pkey PRIMARY KEY (cache_key);


--
-- Name: correlation correlation_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.correlation
    ADD CONSTRAINT correlation_pkey PRIMARY KEY (uid, source_uid);


--
-- Name: dashboard_acl dashboard_acl_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard_acl
    ADD CONSTRAINT dashboard_acl_pkey PRIMARY KEY (id);


--
-- Name: dashboard dashboard_pkey1; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT dashboard_pkey1 PRIMARY KEY (id);


--
-- Name: dashboard_provisioning dashboard_provisioning_pkey1; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard_provisioning
    ADD CONSTRAINT dashboard_provisioning_pkey1 PRIMARY KEY (id);


--
-- Name: dashboard_public dashboard_public_config_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard_public
    ADD CONSTRAINT dashboard_public_config_pkey PRIMARY KEY (uid);


--
-- Name: dashboard_public_usage_by_day dashboard_public_usage_by_day_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard_public_usage_by_day
    ADD CONSTRAINT dashboard_public_usage_by_day_pkey PRIMARY KEY (id);


--
-- Name: dashboard_snapshot dashboard_snapshot_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard_snapshot
    ADD CONSTRAINT dashboard_snapshot_pkey PRIMARY KEY (id);


--
-- Name: dashboard_tag dashboard_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard_tag
    ADD CONSTRAINT dashboard_tag_pkey PRIMARY KEY (id);


--
-- Name: dashboard_usage_by_day dashboard_usage_by_day_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard_usage_by_day
    ADD CONSTRAINT dashboard_usage_by_day_pkey PRIMARY KEY (id);


--
-- Name: dashboard_usage_sums dashboard_usage_sums_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard_usage_sums
    ADD CONSTRAINT dashboard_usage_sums_pkey PRIMARY KEY (dashboard_id);


--
-- Name: dashboard_version dashboard_version_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.dashboard_version
    ADD CONSTRAINT dashboard_version_pkey PRIMARY KEY (id);


--
-- Name: data_keys data_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.data_keys
    ADD CONSTRAINT data_keys_pkey PRIMARY KEY (name);


--
-- Name: data_source_acl data_source_acl_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.data_source_acl
    ADD CONSTRAINT data_source_acl_pkey PRIMARY KEY (id);


--
-- Name: data_source_cache data_source_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.data_source_cache
    ADD CONSTRAINT data_source_cache_pkey PRIMARY KEY (id);


--
-- Name: data_source data_source_pkey1; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.data_source
    ADD CONSTRAINT data_source_pkey1 PRIMARY KEY (id);


--
-- Name: data_source_usage_by_day data_source_usage_by_day_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.data_source_usage_by_day
    ADD CONSTRAINT data_source_usage_by_day_pkey PRIMARY KEY (id);


--
-- Name: entity_event entity_event_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.entity_event
    ADD CONSTRAINT entity_event_pkey PRIMARY KEY (id);


--
-- Name: kv_store kv_store_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.kv_store
    ADD CONSTRAINT kv_store_pkey PRIMARY KEY (id);


--
-- Name: library_element_connection library_element_connection_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.library_element_connection
    ADD CONSTRAINT library_element_connection_pkey PRIMARY KEY (id);


--
-- Name: library_element library_element_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.library_element
    ADD CONSTRAINT library_element_pkey PRIMARY KEY (id);


--
-- Name: license_token license_token_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.license_token
    ADD CONSTRAINT license_token_pkey PRIMARY KEY (id);


--
-- Name: login_attempt login_attempt_pkey1; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.login_attempt
    ADD CONSTRAINT login_attempt_pkey1 PRIMARY KEY (id);


--
-- Name: migration_log migration_log_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.migration_log
    ADD CONSTRAINT migration_log_pkey PRIMARY KEY (id);


--
-- Name: ngalert_configuration ngalert_configuration_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.ngalert_configuration
    ADD CONSTRAINT ngalert_configuration_pkey PRIMARY KEY (id);


--
-- Name: org org_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT org_pkey PRIMARY KEY (id);


--
-- Name: org_user org_user_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.org_user
    ADD CONSTRAINT org_user_pkey PRIMARY KEY (id);


--
-- Name: permission permission_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (id);


--
-- Name: playlist_item playlist_item_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.playlist_item
    ADD CONSTRAINT playlist_item_pkey PRIMARY KEY (id);


--
-- Name: playlist playlist_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.playlist
    ADD CONSTRAINT playlist_pkey PRIMARY KEY (id);


--
-- Name: plugin_setting plugin_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.plugin_setting
    ADD CONSTRAINT plugin_setting_pkey PRIMARY KEY (id);


--
-- Name: preferences preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.preferences
    ADD CONSTRAINT preferences_pkey PRIMARY KEY (id);


--
-- Name: provenance_type provenance_type_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.provenance_type
    ADD CONSTRAINT provenance_type_pkey PRIMARY KEY (id);


--
-- Name: query_history query_history_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.query_history
    ADD CONSTRAINT query_history_pkey PRIMARY KEY (id);


--
-- Name: query_history_star query_history_star_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.query_history_star
    ADD CONSTRAINT query_history_star_pkey PRIMARY KEY (id);


--
-- Name: quota quota_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.quota
    ADD CONSTRAINT quota_pkey PRIMARY KEY (id);


--
-- Name: recording_rules recording_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.recording_rules
    ADD CONSTRAINT recording_rules_pkey PRIMARY KEY (id, target_ref_id);


--
-- Name: remote_write_targets remote_write_targets_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.remote_write_targets
    ADD CONSTRAINT remote_write_targets_pkey PRIMARY KEY (id, data_source_uid, write_path);


--
-- Name: report_dashboards report_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.report_dashboards
    ADD CONSTRAINT report_dashboards_pkey PRIMARY KEY (id);


--
-- Name: report report_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT report_pkey PRIMARY KEY (id);


--
-- Name: report_settings report_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.report_settings
    ADD CONSTRAINT report_settings_pkey PRIMARY KEY (id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: secrets secrets_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.secrets
    ADD CONSTRAINT secrets_pkey PRIMARY KEY (id);


--
-- Name: server_lock server_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.server_lock
    ADD CONSTRAINT server_lock_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (key);


--
-- Name: short_url short_url_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.short_url
    ADD CONSTRAINT short_url_pkey PRIMARY KEY (id);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: team_group team_group_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.team_group
    ADD CONSTRAINT team_group_pkey PRIMARY KEY (id);


--
-- Name: team_member team_member_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.team_member
    ADD CONSTRAINT team_member_pkey PRIMARY KEY (id);


--
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (id);


--
-- Name: team_role team_role_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.team_role
    ADD CONSTRAINT team_role_pkey PRIMARY KEY (id);


--
-- Name: temp_user temp_user_pkey1; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.temp_user
    ADD CONSTRAINT temp_user_pkey1 PRIMARY KEY (id);


--
-- Name: test_data test_data_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.test_data
    ADD CONSTRAINT test_data_pkey PRIMARY KEY (id);


--
-- Name: user_auth user_auth_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.user_auth
    ADD CONSTRAINT user_auth_pkey PRIMARY KEY (id);


--
-- Name: user_auth_token user_auth_token_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.user_auth_token
    ADD CONSTRAINT user_auth_token_pkey PRIMARY KEY (id);


--
-- Name: user_dashboard_views user_dashboard_views_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.user_dashboard_views
    ADD CONSTRAINT user_dashboard_views_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey1; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey1 PRIMARY KEY (id);


--
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);


--
-- Name: user_stats user_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: grafana_user
--

ALTER TABLE ONLY public.user_stats
    ADD CONSTRAINT user_stats_pkey PRIMARY KEY (id);


--
-- Name: IDX_alert_configuration_org_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_alert_configuration_org_id" ON public.alert_configuration USING btree (org_id);


--
-- Name: IDX_alert_dashboard_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_alert_dashboard_id" ON public.alert USING btree (dashboard_id);


--
-- Name: IDX_alert_instance_rule_org_id_current_state; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_alert_instance_rule_org_id_current_state" ON public.alert_instance USING btree (rule_org_id, current_state);


--
-- Name: IDX_alert_instance_rule_org_id_rule_uid_current_state; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_alert_instance_rule_org_id_rule_uid_current_state" ON public.alert_instance USING btree (rule_org_id, rule_uid, current_state);


--
-- Name: IDX_alert_notification_state_alert_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_alert_notification_state_alert_id" ON public.alert_notification_state USING btree (alert_id);


--
-- Name: IDX_alert_org_id_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_alert_org_id_id" ON public.alert USING btree (org_id, id);


--
-- Name: IDX_alert_rule_org_id_dashboard_uid_panel_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_alert_rule_org_id_dashboard_uid_panel_id" ON public.alert_rule USING btree (org_id, dashboard_uid, panel_id);


--
-- Name: IDX_alert_rule_org_id_namespace_uid_rule_group; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_alert_rule_org_id_namespace_uid_rule_group" ON public.alert_rule USING btree (org_id, namespace_uid, rule_group);


--
-- Name: IDX_alert_rule_tag_alert_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_alert_rule_tag_alert_id" ON public.alert_rule_tag USING btree (alert_id);


--
-- Name: IDX_alert_rule_version_rule_org_id_rule_namespace_uid_rule_grou; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_alert_rule_version_rule_org_id_rule_namespace_uid_rule_grou" ON public.alert_rule_version USING btree (rule_org_id, rule_namespace_uid, rule_group);


--
-- Name: IDX_alert_state; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_alert_state" ON public.alert USING btree (state);


--
-- Name: IDX_annotation_alert_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_annotation_alert_id" ON public.annotation USING btree (alert_id);


--
-- Name: IDX_annotation_org_id_alert_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_annotation_org_id_alert_id" ON public.annotation USING btree (org_id, alert_id);


--
-- Name: IDX_annotation_org_id_created; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_annotation_org_id_created" ON public.annotation USING btree (org_id, created);


--
-- Name: IDX_annotation_org_id_dashboard_id_epoch_end_epoch; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_annotation_org_id_dashboard_id_epoch_end_epoch" ON public.annotation USING btree (org_id, dashboard_id, epoch_end, epoch);


--
-- Name: IDX_annotation_org_id_epoch_end_epoch; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_annotation_org_id_epoch_end_epoch" ON public.annotation USING btree (org_id, epoch_end, epoch);


--
-- Name: IDX_annotation_org_id_type; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_annotation_org_id_type" ON public.annotation USING btree (org_id, type);


--
-- Name: IDX_annotation_org_id_updated; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_annotation_org_id_updated" ON public.annotation USING btree (org_id, updated);


--
-- Name: IDX_api_key_org_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_api_key_org_id" ON public.api_key USING btree (org_id);


--
-- Name: IDX_builtin_role_org_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_builtin_role_org_id" ON public.builtin_role USING btree (org_id);


--
-- Name: IDX_builtin_role_role; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_builtin_role_role" ON public.builtin_role USING btree (role);


--
-- Name: IDX_builtin_role_role_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_builtin_role_role_id" ON public.builtin_role USING btree (role_id);


--
-- Name: IDX_correlation_source_uid; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_correlation_source_uid" ON public.correlation USING btree (source_uid);


--
-- Name: IDX_correlation_uid; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_correlation_uid" ON public.correlation USING btree (uid);


--
-- Name: IDX_dashboard_acl_dashboard_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_acl_dashboard_id" ON public.dashboard_acl USING btree (dashboard_id);


--
-- Name: IDX_dashboard_acl_org_id_role; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_acl_org_id_role" ON public.dashboard_acl USING btree (org_id, role);


--
-- Name: IDX_dashboard_acl_permission; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_acl_permission" ON public.dashboard_acl USING btree (permission);


--
-- Name: IDX_dashboard_acl_team_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_acl_team_id" ON public.dashboard_acl USING btree (team_id);


--
-- Name: IDX_dashboard_acl_user_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_acl_user_id" ON public.dashboard_acl USING btree (user_id);


--
-- Name: IDX_dashboard_gnet_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_gnet_id" ON public.dashboard USING btree (gnet_id);


--
-- Name: IDX_dashboard_is_folder; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_is_folder" ON public.dashboard USING btree (is_folder);


--
-- Name: IDX_dashboard_org_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_org_id" ON public.dashboard USING btree (org_id);


--
-- Name: IDX_dashboard_org_id_plugin_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_org_id_plugin_id" ON public.dashboard USING btree (org_id, plugin_id);


--
-- Name: IDX_dashboard_provisioning_dashboard_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_provisioning_dashboard_id" ON public.dashboard_provisioning USING btree (dashboard_id);


--
-- Name: IDX_dashboard_provisioning_dashboard_id_name; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_provisioning_dashboard_id_name" ON public.dashboard_provisioning USING btree (dashboard_id, name);


--
-- Name: IDX_dashboard_public_config_org_id_dashboard_uid; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_public_config_org_id_dashboard_uid" ON public.dashboard_public USING btree (org_id, dashboard_uid);


--
-- Name: IDX_dashboard_snapshot_user_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_snapshot_user_id" ON public.dashboard_snapshot USING btree (user_id);


--
-- Name: IDX_dashboard_tag_dashboard_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_tag_dashboard_id" ON public.dashboard_tag USING btree (dashboard_id);


--
-- Name: IDX_dashboard_title; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_title" ON public.dashboard USING btree (title);


--
-- Name: IDX_dashboard_usage_by_day_dashboard_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_usage_by_day_dashboard_id" ON public.dashboard_usage_by_day USING btree (dashboard_id);


--
-- Name: IDX_dashboard_version_dashboard_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_dashboard_version_dashboard_id" ON public.dashboard_version USING btree (dashboard_id);


--
-- Name: IDX_data_source_acl_data_source_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_data_source_acl_data_source_id" ON public.data_source_acl USING btree (data_source_id);


--
-- Name: IDX_data_source_cache_data_source_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_data_source_cache_data_source_id" ON public.data_source_cache USING btree (data_source_id);


--
-- Name: IDX_data_source_cache_data_source_uid; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_data_source_cache_data_source_uid" ON public.data_source_cache USING btree (data_source_uid);


--
-- Name: IDX_data_source_org_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_data_source_org_id" ON public.data_source USING btree (org_id);


--
-- Name: IDX_data_source_org_id_is_default; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_data_source_org_id_is_default" ON public.data_source USING btree (org_id, is_default);


--
-- Name: IDX_data_source_usage_by_day_data_source_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_data_source_usage_by_day_data_source_id" ON public.data_source_usage_by_day USING btree (data_source_id);


--
-- Name: IDX_file_parent_folder_path_hash; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_file_parent_folder_path_hash" ON public.file USING btree (parent_folder_path_hash);


--
-- Name: IDX_login_attempt_username; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_login_attempt_username" ON public.login_attempt USING btree (username);


--
-- Name: IDX_org_user_org_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_org_user_org_id" ON public.org_user USING btree (org_id);


--
-- Name: IDX_org_user_user_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_org_user_user_id" ON public.org_user USING btree (user_id);


--
-- Name: IDX_permission_role_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_permission_role_id" ON public.permission USING btree (role_id);


--
-- Name: IDX_query_history_org_id_created_by_datasource_uid; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_query_history_org_id_created_by_datasource_uid" ON public.query_history USING btree (org_id, created_by, datasource_uid);


--
-- Name: IDX_report_dashboard_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_report_dashboard_id" ON public.report USING btree (dashboard_id);


--
-- Name: IDX_report_dashboards_report_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_report_dashboards_report_id" ON public.report_dashboards USING btree (report_id);


--
-- Name: IDX_report_org_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_report_org_id" ON public.report USING btree (org_id);


--
-- Name: IDX_report_user_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_report_user_id" ON public.report USING btree (user_id);


--
-- Name: IDX_role_org_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_role_org_id" ON public.role USING btree (org_id);


--
-- Name: IDX_team_group_group_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_team_group_group_id" ON public.team_group USING btree (group_id);


--
-- Name: IDX_team_group_org_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_team_group_org_id" ON public.team_group USING btree (org_id);


--
-- Name: IDX_team_member_org_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_team_member_org_id" ON public.team_member USING btree (org_id);


--
-- Name: IDX_team_member_team_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_team_member_team_id" ON public.team_member USING btree (team_id);


--
-- Name: IDX_team_org_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_team_org_id" ON public.team USING btree (org_id);


--
-- Name: IDX_team_role_org_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_team_role_org_id" ON public.team_role USING btree (org_id);


--
-- Name: IDX_team_role_team_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_team_role_team_id" ON public.team_role USING btree (team_id);


--
-- Name: IDX_temp_user_code; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_temp_user_code" ON public.temp_user USING btree (code);


--
-- Name: IDX_temp_user_email; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_temp_user_email" ON public.temp_user USING btree (email);


--
-- Name: IDX_temp_user_org_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_temp_user_org_id" ON public.temp_user USING btree (org_id);


--
-- Name: IDX_temp_user_status; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_temp_user_status" ON public.temp_user USING btree (status);


--
-- Name: IDX_user_auth_auth_module_auth_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_user_auth_auth_module_auth_id" ON public.user_auth USING btree (auth_module, auth_id);


--
-- Name: IDX_user_auth_token_user_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_user_auth_token_user_id" ON public.user_auth_token USING btree (user_id);


--
-- Name: IDX_user_auth_user_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_user_auth_user_id" ON public.user_auth USING btree (user_id);


--
-- Name: IDX_user_dashboard_views_dashboard_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_user_dashboard_views_dashboard_id" ON public.user_dashboard_views USING btree (dashboard_id);


--
-- Name: IDX_user_dashboard_views_user_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_user_dashboard_views_user_id" ON public.user_dashboard_views USING btree (user_id);


--
-- Name: IDX_user_login_email; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_user_login_email" ON public."user" USING btree (login, email);


--
-- Name: IDX_user_role_org_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_user_role_org_id" ON public.user_role USING btree (org_id);


--
-- Name: IDX_user_role_user_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE INDEX "IDX_user_role_user_id" ON public.user_role USING btree (user_id);


--
-- Name: UQE_alert_image_token; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_alert_image_token" ON public.alert_image USING btree (token);


--
-- Name: UQE_alert_notification_org_id_uid; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_alert_notification_org_id_uid" ON public.alert_notification USING btree (org_id, uid);


--
-- Name: UQE_alert_notification_state_org_id_alert_id_notifier_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_alert_notification_state_org_id_alert_id_notifier_id" ON public.alert_notification_state USING btree (org_id, alert_id, notifier_id);


--
-- Name: UQE_alert_rule_org_id_namespace_uid_title; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_alert_rule_org_id_namespace_uid_title" ON public.alert_rule USING btree (org_id, namespace_uid, title);


--
-- Name: UQE_alert_rule_org_id_uid; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_alert_rule_org_id_uid" ON public.alert_rule USING btree (org_id, uid);


--
-- Name: UQE_alert_rule_tag_alert_id_tag_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_alert_rule_tag_alert_id_tag_id" ON public.alert_rule_tag USING btree (alert_id, tag_id);


--
-- Name: UQE_alert_rule_version_rule_org_id_rule_uid_version; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_alert_rule_version_rule_org_id_rule_uid_version" ON public.alert_rule_version USING btree (rule_org_id, rule_uid, version);


--
-- Name: UQE_annotation_tag_annotation_id_tag_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_annotation_tag_annotation_id_tag_id" ON public.annotation_tag USING btree (annotation_id, tag_id);


--
-- Name: UQE_api_key_key; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_api_key_key" ON public.api_key USING btree (key);


--
-- Name: UQE_api_key_org_id_name; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_api_key_org_id_name" ON public.api_key USING btree (org_id, name);


--
-- Name: UQE_builtin_role_org_id_role_id_role; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_builtin_role_org_id_role_id_role" ON public.builtin_role USING btree (org_id, role_id, role);


--
-- Name: UQE_cache_data_cache_key; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_cache_data_cache_key" ON public.cache_data USING btree (cache_key);


--
-- Name: UQE_dashboard_acl_dashboard_id_team_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_dashboard_acl_dashboard_id_team_id" ON public.dashboard_acl USING btree (dashboard_id, team_id);


--
-- Name: UQE_dashboard_acl_dashboard_id_user_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_dashboard_acl_dashboard_id_user_id" ON public.dashboard_acl USING btree (dashboard_id, user_id);


--
-- Name: UQE_dashboard_org_id_folder_id_title; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_dashboard_org_id_folder_id_title" ON public.dashboard USING btree (org_id, folder_id, title);


--
-- Name: UQE_dashboard_org_id_uid; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_dashboard_org_id_uid" ON public.dashboard USING btree (org_id, uid);


--
-- Name: UQE_dashboard_public_config_access_token; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_dashboard_public_config_access_token" ON public.dashboard_public USING btree (access_token);


--
-- Name: UQE_dashboard_public_config_uid; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_dashboard_public_config_uid" ON public.dashboard_public USING btree (uid);


--
-- Name: UQE_dashboard_snapshot_delete_key; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_dashboard_snapshot_delete_key" ON public.dashboard_snapshot USING btree (delete_key);


--
-- Name: UQE_dashboard_snapshot_key; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_dashboard_snapshot_key" ON public.dashboard_snapshot USING btree (key);


--
-- Name: UQE_dashboard_usage_by_day_dashboard_id_day; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_dashboard_usage_by_day_dashboard_id_day" ON public.dashboard_usage_by_day USING btree (dashboard_id, day);


--
-- Name: UQE_dashboard_version_dashboard_id_version; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_dashboard_version_dashboard_id_version" ON public.dashboard_version USING btree (dashboard_id, version);


--
-- Name: UQE_data_source_acl_data_source_id_team_id_user_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_data_source_acl_data_source_id_team_id_user_id" ON public.data_source_acl USING btree (data_source_id, team_id, user_id);


--
-- Name: UQE_data_source_org_id_name; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_data_source_org_id_name" ON public.data_source USING btree (org_id, name);


--
-- Name: UQE_data_source_org_id_uid; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_data_source_org_id_uid" ON public.data_source USING btree (org_id, uid);


--
-- Name: UQE_data_source_usage_by_day_data_source_id_day; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_data_source_usage_by_day_data_source_id_day" ON public.data_source_usage_by_day USING btree (data_source_id, day);


--
-- Name: UQE_file_meta_path_hash_key; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_file_meta_path_hash_key" ON public.file_meta USING btree (path_hash, key);


--
-- Name: UQE_file_path_hash; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_file_path_hash" ON public.file USING btree (path_hash);


--
-- Name: UQE_kv_store_org_id_namespace_key; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_kv_store_org_id_namespace_key" ON public.kv_store USING btree (org_id, namespace, key);


--
-- Name: UQE_library_element_connection_element_id_kind_connection_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_library_element_connection_element_id_kind_connection_id" ON public.library_element_connection USING btree (element_id, kind, connection_id);


--
-- Name: UQE_library_element_org_id_folder_id_name_kind; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_library_element_org_id_folder_id_name_kind" ON public.library_element USING btree (org_id, folder_id, name, kind);


--
-- Name: UQE_library_element_org_id_uid; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_library_element_org_id_uid" ON public.library_element USING btree (org_id, uid);


--
-- Name: UQE_ngalert_configuration_org_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_ngalert_configuration_org_id" ON public.ngalert_configuration USING btree (org_id);


--
-- Name: UQE_org_name; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_org_name" ON public.org USING btree (name);


--
-- Name: UQE_org_user_org_id_user_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_org_user_org_id_user_id" ON public.org_user USING btree (org_id, user_id);


--
-- Name: UQE_permission_role_id_action_scope; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_permission_role_id_action_scope" ON public.permission USING btree (role_id, action, scope);


--
-- Name: UQE_playlist_org_id_uid; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_playlist_org_id_uid" ON public.playlist USING btree (org_id, uid);


--
-- Name: UQE_plugin_setting_org_id_plugin_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_plugin_setting_org_id_plugin_id" ON public.plugin_setting USING btree (org_id, plugin_id);


--
-- Name: UQE_provenance_type_record_type_record_key_org_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_provenance_type_record_type_record_key_org_id" ON public.provenance_type USING btree (record_type, record_key, org_id);


--
-- Name: UQE_query_history_star_user_id_query_uid; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_query_history_star_user_id_query_uid" ON public.query_history_star USING btree (user_id, query_uid);


--
-- Name: UQE_quota_org_id_user_id_target; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_quota_org_id_user_id_target" ON public.quota USING btree (org_id, user_id, target);


--
-- Name: UQE_role_org_id_name; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_role_org_id_name" ON public.role USING btree (org_id, name);


--
-- Name: UQE_role_uid; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_role_uid" ON public.role USING btree (uid);


--
-- Name: UQE_seed_assignment_builtin_role_action_scope; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_seed_assignment_builtin_role_action_scope" ON public.seed_assignment USING btree (builtin_role, action, scope);


--
-- Name: UQE_seed_assignment_builtin_role_role_name; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_seed_assignment_builtin_role_role_name" ON public.seed_assignment USING btree (builtin_role, role_name);


--
-- Name: UQE_server_lock_operation_uid; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_server_lock_operation_uid" ON public.server_lock USING btree (operation_uid);


--
-- Name: UQE_setting_section_key; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_setting_section_key" ON public.setting USING btree (section, key);


--
-- Name: UQE_short_url_org_id_uid; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_short_url_org_id_uid" ON public.short_url USING btree (org_id, uid);


--
-- Name: UQE_star_user_id_dashboard_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_star_user_id_dashboard_id" ON public.star USING btree (user_id, dashboard_id);


--
-- Name: UQE_tag_key_value; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_tag_key_value" ON public.tag USING btree (key, value);


--
-- Name: UQE_team_group_org_id_team_id_group_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_team_group_org_id_team_id_group_id" ON public.team_group USING btree (org_id, team_id, group_id);


--
-- Name: UQE_team_member_org_id_team_id_user_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_team_member_org_id_team_id_user_id" ON public.team_member USING btree (org_id, team_id, user_id);


--
-- Name: UQE_team_org_id_name; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_team_org_id_name" ON public.team USING btree (org_id, name);


--
-- Name: UQE_team_role_org_id_team_id_role_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_team_role_org_id_team_id_role_id" ON public.team_role USING btree (org_id, team_id, role_id);


--
-- Name: UQE_user_auth_token_auth_token; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_user_auth_token_auth_token" ON public.user_auth_token USING btree (auth_token);


--
-- Name: UQE_user_auth_token_prev_auth_token; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_user_auth_token_prev_auth_token" ON public.user_auth_token USING btree (prev_auth_token);


--
-- Name: UQE_user_dashboard_views_user_id_dashboard_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_user_dashboard_views_user_id_dashboard_id" ON public.user_dashboard_views USING btree (user_id, dashboard_id);


--
-- Name: UQE_user_email; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_user_email" ON public."user" USING btree (email);


--
-- Name: UQE_user_login; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_user_login" ON public."user" USING btree (login);


--
-- Name: UQE_user_role_org_id_user_id_role_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_user_role_org_id_user_id_role_id" ON public.user_role USING btree (org_id, user_id, role_id);


--
-- Name: UQE_user_stats_user_id; Type: INDEX; Schema: public; Owner: grafana_user
--

CREATE UNIQUE INDEX "UQE_user_stats_user_id" ON public.user_stats USING btree (user_id);


--
-- PostgreSQL database dump complete
--

