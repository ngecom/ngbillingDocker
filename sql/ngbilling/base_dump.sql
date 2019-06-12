--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.20
-- Dumped by pg_dump version 9.3.20
-- Started on 2018-10-29 14:58:58

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1 (class 3079 OID 11750)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 4033 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 171 (class 1259 OID 264482)
-- Name: account_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE account_type (
    id integer NOT NULL,
    credit_limit numeric(22,10),
    invoice_design character varying(100),
    invoice_delivery_method_id integer,
    date_created timestamp without time zone,
    credit_notification_limit1 numeric(22,10),
    credit_notification_limit2 numeric(22,10),
    language_id integer,
    entity_id integer,
    currency_id integer,
    optlock integer NOT NULL,
    main_subscript_order_period_id integer NOT NULL,
    next_invoice_day_of_period integer NOT NULL,
    notification_ait_id integer
);


ALTER TABLE public.account_type OWNER TO openbrm_demo;

--
-- TOC entry 172 (class 1259 OID 264485)
-- Name: account_type_price; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE account_type_price (
    account_type_id integer NOT NULL,
    create_datetime timestamp without time zone NOT NULL,
    price_expiry_date date
);


ALTER TABLE public.account_type_price OWNER TO openbrm_demo;

--
-- TOC entry 173 (class 1259 OID 264488)
-- Name: ach; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE ach (
    id integer NOT NULL,
    user_id integer,
    aba_routing character varying(40) NOT NULL,
    bank_account character varying(60) NOT NULL,
    account_type integer NOT NULL,
    bank_name character varying(50) NOT NULL,
    account_name character varying(100) NOT NULL,
    optlock integer NOT NULL,
    gateway_key character varying(100)
);


ALTER TABLE public.ach OWNER TO openbrm_demo;

--
-- TOC entry 174 (class 1259 OID 264491)
-- Name: advance_rated_cdr_record; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE advance_rated_cdr_record (
    id integer DEFAULT 0 NOT NULL,
    process_id integer NOT NULL,
    record_id character varying(100) DEFAULT NULL::character varying,
    order_id integer NOT NULL,
    user_id integer NOT NULL,
    invoice_id integer,
    calling_number character varying(40) DEFAULT NULL::character varying,
    destination_number character varying(40) DEFAULT NULL::character varying,
    call_start_date timestamp without time zone,
    call_end_date timestamp without time zone,
    duration integer,
    cost numeric(22,10) DEFAULT NULL::numeric,
    product_id integer,
    destination_descr character varying(256) DEFAULT NULL::character varying,
    rate_id integer,
    call_type character varying(20) DEFAULT NULL::character varying,
    device_id character varying(20) DEFAULT NULL::character varying,
    cdr_source character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.advance_rated_cdr_record OWNER TO openbrm_demo;

--
-- TOC entry 175 (class 1259 OID 264506)
-- Name: ageing_entity_step; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE ageing_entity_step (
    id integer NOT NULL,
    entity_id integer,
    status_id integer,
    days integer NOT NULL,
    optlock integer NOT NULL,
    retry_payment smallint DEFAULT 0 NOT NULL,
    suspend smallint DEFAULT 0 NOT NULL,
    send_notification smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.ageing_entity_step OWNER TO openbrm_demo;

--
-- TOC entry 176 (class 1259 OID 264512)
-- Name: asset; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE asset (
    id integer NOT NULL,
    identifier character varying(200) NOT NULL,
    create_datetime timestamp without time zone NOT NULL,
    status_id integer NOT NULL,
    entity_id integer,
    deleted integer NOT NULL,
    item_id integer NOT NULL,
    notes character varying(1000),
    optlock integer NOT NULL,
    group_id integer,
    order_line_id integer,
    global boolean DEFAULT false NOT NULL
);


ALTER TABLE public.asset OWNER TO openbrm_demo;

--
-- TOC entry 177 (class 1259 OID 264519)
-- Name: asset_assignment; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE asset_assignment (
    id integer NOT NULL,
    asset_id integer NOT NULL,
    order_line_id integer NOT NULL,
    start_datetime timestamp without time zone NOT NULL,
    end_datetime timestamp without time zone
);


ALTER TABLE public.asset_assignment OWNER TO openbrm_demo;

--
-- TOC entry 178 (class 1259 OID 264522)
-- Name: asset_entity_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE asset_entity_map (
    asset_id integer NOT NULL,
    entity_id integer NOT NULL
);


ALTER TABLE public.asset_entity_map OWNER TO openbrm_demo;

--
-- TOC entry 179 (class 1259 OID 264525)
-- Name: asset_meta_field_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE asset_meta_field_map (
    asset_id integer NOT NULL,
    meta_field_value_id integer NOT NULL
);


ALTER TABLE public.asset_meta_field_map OWNER TO openbrm_demo;

--
-- TOC entry 180 (class 1259 OID 264528)
-- Name: asset_reservation; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE asset_reservation (
    id integer NOT NULL,
    user_id integer NOT NULL,
    creator_user_id integer NOT NULL,
    asset_id integer NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.asset_reservation OWNER TO openbrm_demo;

--
-- TOC entry 181 (class 1259 OID 264531)
-- Name: asset_status; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE asset_status (
    id integer NOT NULL,
    item_type_id integer,
    is_default integer NOT NULL,
    is_order_saved integer NOT NULL,
    is_available integer NOT NULL,
    deleted integer NOT NULL,
    optlock integer NOT NULL,
    is_internal integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.asset_status OWNER TO openbrm_demo;

--
-- TOC entry 182 (class 1259 OID 264535)
-- Name: asset_transition; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE asset_transition (
    id integer NOT NULL,
    create_datetime timestamp without time zone NOT NULL,
    previous_status_id integer,
    new_status_id integer NOT NULL,
    asset_id integer NOT NULL,
    user_id integer,
    assigned_to_id integer
);


ALTER TABLE public.asset_transition OWNER TO openbrm_demo;

--
-- TOC entry 183 (class 1259 OID 264538)
-- Name: base_user; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE base_user (
    id integer NOT NULL,
    entity_id integer,
    password character varying(1024),
    deleted integer DEFAULT 0 NOT NULL,
    language_id integer,
    status_id integer,
    subscriber_status integer DEFAULT 1,
    currency_id integer,
    create_datetime timestamp without time zone NOT NULL,
    last_status_change timestamp without time zone,
    last_login timestamp without time zone,
    user_name character varying(50),
    failed_attempts integer DEFAULT 0 NOT NULL,
    optlock integer NOT NULL,
    change_password_date date,
    encryption_scheme integer NOT NULL,
    account_locked_time timestamp without time zone,
    account_disabled_date date
);


ALTER TABLE public.base_user OWNER TO openbrm_demo;

--
-- TOC entry 184 (class 1259 OID 264547)
-- Name: batch_job_execution; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE batch_job_execution (
    job_execution_id integer NOT NULL,
    version integer,
    job_instance_id integer NOT NULL,
    create_time timestamp without time zone NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    status character varying(10),
    exit_code character varying(100),
    exit_message character varying(2500),
    last_updated timestamp without time zone,
    job_configuration_location character varying(2500)
);


ALTER TABLE public.batch_job_execution OWNER TO openbrm_demo;

--
-- TOC entry 185 (class 1259 OID 264553)
-- Name: batch_job_execution_context; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE batch_job_execution_context (
    job_execution_id bigint NOT NULL,
    short_context character varying(2500) NOT NULL,
    serialized_context text
);


ALTER TABLE public.batch_job_execution_context OWNER TO openbrm_demo;

--
-- TOC entry 186 (class 1259 OID 264559)
-- Name: batch_job_execution_params; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE batch_job_execution_params (
    job_execution_id integer NOT NULL,
    type_cd character varying(6) NOT NULL,
    key_name character varying(100) NOT NULL,
    string_val character varying(250),
    date_val timestamp without time zone,
    long_val integer,
    double_val numeric(17,0),
    identifying character(1)
);


ALTER TABLE public.batch_job_execution_params OWNER TO openbrm_demo;

--
-- TOC entry 187 (class 1259 OID 264562)
-- Name: batch_job_execution_seq; Type: SEQUENCE; Schema: public; Owner: openbrm_demo
--

CREATE SEQUENCE batch_job_execution_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.batch_job_execution_seq OWNER TO openbrm_demo;

--
-- TOC entry 188 (class 1259 OID 264564)
-- Name: batch_job_instance; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE batch_job_instance (
    job_instance_id integer NOT NULL,
    version integer,
    job_name character varying(100) NOT NULL,
    job_key character varying(32) NOT NULL
);


ALTER TABLE public.batch_job_instance OWNER TO openbrm_demo;

--
-- TOC entry 189 (class 1259 OID 264567)
-- Name: batch_job_seq; Type: SEQUENCE; Schema: public; Owner: openbrm_demo
--

CREATE SEQUENCE batch_job_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.batch_job_seq OWNER TO openbrm_demo;

--
-- TOC entry 190 (class 1259 OID 264569)
-- Name: batch_process_info; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE batch_process_info (
    id integer NOT NULL,
    process_id integer NOT NULL,
    job_execution_id integer NOT NULL,
    total_failed_users integer NOT NULL,
    total_successful_users integer NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.batch_process_info OWNER TO openbrm_demo;

--
-- TOC entry 191 (class 1259 OID 264572)
-- Name: batch_step_execution; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE batch_step_execution (
    step_execution_id integer NOT NULL,
    version integer NOT NULL,
    step_name character varying(100) NOT NULL,
    job_execution_id integer NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone,
    status character varying(10),
    commit_count integer,
    read_count integer,
    filter_count integer,
    write_count integer,
    read_skip_count integer,
    write_skip_count integer,
    process_skip_count integer,
    rollback_count integer,
    exit_code character varying(100),
    exit_message character varying(2500),
    last_updated timestamp without time zone
);


ALTER TABLE public.batch_step_execution OWNER TO openbrm_demo;

--
-- TOC entry 192 (class 1259 OID 264578)
-- Name: batch_step_execution_context; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE batch_step_execution_context (
    step_execution_id integer NOT NULL,
    short_context character varying(2500) NOT NULL,
    serialized_context text
);


ALTER TABLE public.batch_step_execution_context OWNER TO openbrm_demo;

--
-- TOC entry 193 (class 1259 OID 264584)
-- Name: batch_step_execution_seq; Type: SEQUENCE; Schema: public; Owner: openbrm_demo
--

CREATE SEQUENCE batch_step_execution_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.batch_step_execution_seq OWNER TO openbrm_demo;

--
-- TOC entry 194 (class 1259 OID 264586)
-- Name: billing_process; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE billing_process (
    id integer NOT NULL,
    entity_id integer NOT NULL,
    billing_date date NOT NULL,
    period_unit_id integer NOT NULL,
    period_value integer NOT NULL,
    is_review integer NOT NULL,
    paper_invoice_batch_id integer,
    retries_to_do integer DEFAULT 0 NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.billing_process OWNER TO openbrm_demo;

--
-- TOC entry 195 (class 1259 OID 264590)
-- Name: billing_process_configuration; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE billing_process_configuration (
    id integer NOT NULL,
    entity_id integer,
    next_run_date date NOT NULL,
    generate_report integer NOT NULL,
    retries integer,
    days_for_retry integer,
    days_for_report integer,
    review_status integer NOT NULL,
    due_date_unit_id integer NOT NULL,
    due_date_value integer NOT NULL,
    df_fm integer,
    only_recurring integer DEFAULT 1 NOT NULL,
    invoice_date_process integer NOT NULL,
    optlock integer NOT NULL,
    maximum_periods integer DEFAULT 1 NOT NULL,
    auto_payment_application integer DEFAULT 0 NOT NULL,
    period_unit_id integer DEFAULT 1 NOT NULL,
    last_day_of_month boolean DEFAULT false NOT NULL,
    prorating_type character varying(50) DEFAULT 'PRORATING_AUTO_OFF'::character varying
);


ALTER TABLE public.billing_process_configuration OWNER TO openbrm_demo;

--
-- TOC entry 196 (class 1259 OID 264599)
-- Name: billing_process_failed_user; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE billing_process_failed_user (
    id integer NOT NULL,
    batch_process_id integer NOT NULL,
    user_id integer NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.billing_process_failed_user OWNER TO openbrm_demo;

--
-- TOC entry 197 (class 1259 OID 264602)
-- Name: blacklist; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE blacklist (
    id integer NOT NULL,
    entity_id integer NOT NULL,
    create_datetime timestamp without time zone NOT NULL,
    type integer NOT NULL,
    source integer NOT NULL,
    credit_card integer,
    credit_card_id integer,
    contact_id integer,
    user_id integer,
    optlock integer NOT NULL,
    meta_field_value_id integer
);


ALTER TABLE public.blacklist OWNER TO openbrm_demo;

--
-- TOC entry 198 (class 1259 OID 264605)
-- Name: breadcrumb; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE breadcrumb (
    id integer NOT NULL,
    user_id integer NOT NULL,
    controller character varying(255) NOT NULL,
    action character varying(255),
    name character varying(255),
    object_id integer,
    version integer NOT NULL,
    description character varying(255)
);


ALTER TABLE public.breadcrumb OWNER TO openbrm_demo;

--
-- TOC entry 199 (class 1259 OID 264611)
-- Name: bulk_notification_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE bulk_notification_type (
    id integer NOT NULL,
    type character varying(50) NOT NULL
);


ALTER TABLE public.bulk_notification_type OWNER TO openbrm_demo;

--
-- TOC entry 200 (class 1259 OID 264614)
-- Name: bundle_meta_field_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE bundle_meta_field_map (
    bundle_id integer NOT NULL,
    meta_field_value_id integer NOT NULL
);


ALTER TABLE public.bundle_meta_field_map OWNER TO openbrm_demo;

--
-- TOC entry 201 (class 1259 OID 264617)
-- Name: c_rate; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE c_rate (
    id integer NOT NULL,
    prefix character varying(45) NOT NULL,
    destination character varying(45) NOT NULL,
    version smallint DEFAULT 1 NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    flat_rate numeric(10,2),
    conn_charge numeric(10,2),
    scaled_rate numeric(10,2),
    rate_plan integer,
    call_type character varying(45) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    valid_from date NOT NULL,
    valid_to date,
    last_updated_date date NOT NULL,
    rate_type character varying(100),
    entity_id integer NOT NULL
);


ALTER TABLE public.c_rate OWNER TO openbrm_demo;

--
-- TOC entry 202 (class 1259 OID 264622)
-- Name: cdrentries; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE cdrentries (
    id integer NOT NULL,
    accountcode character varying(20),
    src character varying(20),
    dst character varying(20),
    dcontext character varying(20),
    clid character varying(20),
    channel character varying(20),
    dstchannel character varying(20),
    lastapp character varying(20),
    lastdatat character varying(20),
    start_time timestamp without time zone,
    answer timestamp without time zone,
    end_time timestamp without time zone,
    duration integer,
    billsec integer,
    disposition character varying(20),
    amaflags character varying(20),
    userfield character varying(100),
    ts timestamp without time zone
);


ALTER TABLE public.cdrentries OWNER TO openbrm_demo;

--
-- TOC entry 203 (class 1259 OID 264625)
-- Name: charge_sessions; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE charge_sessions (
    id integer NOT NULL,
    user_id integer,
    session_token character varying(150),
    ts_started timestamp without time zone,
    ts_last_access timestamp without time zone,
    carried_units numeric(22,10)
);


ALTER TABLE public.charge_sessions OWNER TO openbrm_demo;

--
-- TOC entry 204 (class 1259 OID 264628)
-- Name: charge_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE charge_type (
    id integer NOT NULL,
    type character varying(50) NOT NULL
);


ALTER TABLE public.charge_type OWNER TO openbrm_demo;

--
-- TOC entry 205 (class 1259 OID 264631)
-- Name: contact; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE contact (
    id integer NOT NULL,
    organization_name character varying(200),
    street_addres1 character varying(100),
    street_addres2 character varying(100),
    city character varying(50),
    state_province character varying(30),
    postal_code character varying(15),
    country_code character varying(2),
    last_name character varying(30),
    first_name character varying(30),
    person_initial character varying(5),
    person_title character varying(40),
    phone_country_code integer,
    phone_area_code integer,
    phone_phone_number character varying(20),
    fax_country_code integer,
    fax_area_code integer,
    fax_phone_number character varying(20),
    email character varying(200),
    create_datetime timestamp without time zone NOT NULL,
    deleted integer DEFAULT 0 NOT NULL,
    notification_include integer DEFAULT 1,
    user_id integer,
    optlock integer NOT NULL
);


ALTER TABLE public.contact OWNER TO openbrm_demo;

--
-- TOC entry 206 (class 1259 OID 264639)
-- Name: contact_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE contact_map (
    id integer NOT NULL,
    contact_id integer,
    type_id integer,
    table_id integer NOT NULL,
    foreign_id integer NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.contact_map OWNER TO openbrm_demo;

--
-- TOC entry 207 (class 1259 OID 264642)
-- Name: contact_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE contact_type (
    id integer NOT NULL,
    entity_id integer,
    is_primary integer,
    optlock integer NOT NULL
);


ALTER TABLE public.contact_type OWNER TO openbrm_demo;

--
-- TOC entry 208 (class 1259 OID 264645)
-- Name: country; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE country (
    id integer NOT NULL,
    code character varying(2) NOT NULL
);


ALTER TABLE public.country OWNER TO openbrm_demo;

--
-- TOC entry 209 (class 1259 OID 264648)
-- Name: credit_card; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE credit_card (
    id integer NOT NULL,
    cc_number character varying(100) NOT NULL,
    cc_number_plain character varying(20),
    cc_expiry date NOT NULL,
    name character varying(150),
    cc_type integer NOT NULL,
    deleted integer DEFAULT 0 NOT NULL,
    gateway_key character varying(100),
    optlock integer NOT NULL
);


ALTER TABLE public.credit_card OWNER TO openbrm_demo;

--
-- TOC entry 210 (class 1259 OID 264652)
-- Name: currency; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE currency (
    id integer NOT NULL,
    symbol character varying(10) NOT NULL,
    code character varying(3) NOT NULL,
    country_code character varying(2) NOT NULL,
    optlock integer
);


ALTER TABLE public.currency OWNER TO openbrm_demo;

--
-- TOC entry 211 (class 1259 OID 264655)
-- Name: currency_entity_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE currency_entity_map (
    currency_id integer NOT NULL,
    entity_id integer NOT NULL
);


ALTER TABLE public.currency_entity_map OWNER TO openbrm_demo;

--
-- TOC entry 212 (class 1259 OID 264658)
-- Name: currency_exchange; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE currency_exchange (
    id integer NOT NULL,
    entity_id integer,
    currency_id integer,
    rate numeric(22,10) NOT NULL,
    create_datetime timestamp without time zone NOT NULL,
    optlock integer NOT NULL,
    valid_since date DEFAULT '1970-01-01'::date NOT NULL
);


ALTER TABLE public.currency_exchange OWNER TO openbrm_demo;

--
-- TOC entry 213 (class 1259 OID 264662)
-- Name: customer; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE customer (
    id integer NOT NULL,
    user_id integer,
    partner_id integer,
    referral_fee_paid integer,
    invoice_delivery_method_id integer NOT NULL,
    auto_payment_type integer,
    due_date_unit_id integer,
    due_date_value integer,
    df_fm integer,
    parent_id integer,
    is_parent integer,
    exclude_aging integer DEFAULT 0 NOT NULL,
    invoice_child integer,
    optlock integer NOT NULL,
    dynamic_balance numeric(22,10),
    credit_limit numeric(22,10),
    auto_recharge numeric(22,10),
    use_parent_pricing boolean NOT NULL,
    main_subscript_order_period_id integer,
    next_invoice_day_of_period integer,
    next_inovice_date date,
    account_type_id integer,
    invoice_design character varying(100),
    credit_notification_limit1 numeric(22,10),
    credit_notification_limit2 numeric(22,10),
    recharge_threshold numeric(22,10),
    monthly_limit numeric(22,10),
    current_monthly_amount numeric(22,10),
    current_month timestamp without time zone
);


ALTER TABLE public.customer OWNER TO openbrm_demo;

--
-- TOC entry 214 (class 1259 OID 264666)
-- Name: customer_account_info_type_timeline; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE customer_account_info_type_timeline (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    account_info_type_id integer NOT NULL,
    meta_field_value_id integer NOT NULL,
    effective_date date NOT NULL
);


ALTER TABLE public.customer_account_info_type_timeline OWNER TO openbrm_demo;

--
-- TOC entry 215 (class 1259 OID 264669)
-- Name: customer_docs; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE customer_docs (
    id integer NOT NULL,
    user_id integer,
    document_name character varying(35) DEFAULT NULL::character varying,
    file_name character varying(60) DEFAULT NULL::character varying,
    content_type character varying(10) NOT NULL,
    doc_data bytea,
    created_datetime timestamp without time zone,
    mod_date timestamp without time zone,
    deleted smallint NOT NULL
);


ALTER TABLE public.customer_docs OWNER TO openbrm_demo;

--
-- TOC entry 216 (class 1259 OID 264677)
-- Name: customer_meta_field_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE customer_meta_field_map (
    customer_id integer NOT NULL,
    meta_field_value_id integer NOT NULL
);


ALTER TABLE public.customer_meta_field_map OWNER TO openbrm_demo;

--
-- TOC entry 217 (class 1259 OID 264680)
-- Name: customer_notes; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE customer_notes (
    id integer NOT NULL,
    note_title character varying(50),
    note_content character varying(1000),
    creation_time timestamp without time zone,
    entity_id integer,
    user_id integer,
    customer_id integer
);


ALTER TABLE public.customer_notes OWNER TO openbrm_demo;

--
-- TOC entry 218 (class 1259 OID 264686)
-- Name: data_table_query; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE data_table_query (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    route_id integer NOT NULL,
    global integer NOT NULL,
    root_entry_id integer NOT NULL,
    user_id integer NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.data_table_query OWNER TO openbrm_demo;

--
-- TOC entry 219 (class 1259 OID 264689)
-- Name: data_table_query_entry; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE data_table_query_entry (
    id integer NOT NULL,
    route_id integer NOT NULL,
    columns character varying(250) NOT NULL,
    next_entry_id integer,
    optlock integer NOT NULL
);


ALTER TABLE public.data_table_query_entry OWNER TO openbrm_demo;

--
-- TOC entry 220 (class 1259 OID 264692)
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20)
);


ALTER TABLE public.databasechangelog OWNER TO openbrm_demo;

--
-- TOC entry 221 (class 1259 OID 264698)
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO openbrm_demo;

--
-- TOC entry 222 (class 1259 OID 264701)
-- Name: destination_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE destination_map (
    id integer NOT NULL,
    map_group character varying(24) NOT NULL,
    prefix character varying(24) NOT NULL,
    tier_code character varying(24) NOT NULL,
    description character varying(100) NOT NULL,
    category character varying(50) NOT NULL,
    rank integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.destination_map OWNER TO openbrm_demo;

--
-- TOC entry 223 (class 1259 OID 264705)
-- Name: device; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE device (
    id integer NOT NULL,
    type_id integer NOT NULL,
    serial_num character varying(100),
    device_code character varying(100),
    vendor_code character varying(100),
    status_id integer NOT NULL,
    created_date timestamp without time zone NOT NULL,
    last_updated_date timestamp without time zone,
    deleted integer DEFAULT 0 NOT NULL,
    optlock integer NOT NULL,
    entity_id integer NOT NULL,
    icc character varying(100),
    imsi character varying(100),
    puk1 integer,
    puk2 integer,
    pin1 character varying(20),
    pin2 character varying(20)
);


ALTER TABLE public.device OWNER TO openbrm_demo;

--
-- TOC entry 224 (class 1259 OID 264712)
-- Name: device_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE device_type (
    id integer NOT NULL
);


ALTER TABLE public.device_type OWNER TO openbrm_demo;

--
-- TOC entry 225 (class 1259 OID 264715)
-- Name: discount; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE discount (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    discount_type character varying(25) NOT NULL,
    rate numeric(22,10),
    start_date date,
    end_date date,
    entity_id integer,
    last_update_datetime timestamp without time zone
);


ALTER TABLE public.discount OWNER TO openbrm_demo;

--
-- TOC entry 226 (class 1259 OID 264718)
-- Name: discount_attribute; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE discount_attribute (
    discount_id integer NOT NULL,
    attribute_name character varying(255) NOT NULL,
    attribute_value character varying(255)
);


ALTER TABLE public.discount_attribute OWNER TO openbrm_demo;

--
-- TOC entry 227 (class 1259 OID 264724)
-- Name: discount_line; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE discount_line (
    id integer NOT NULL,
    discount_id integer NOT NULL,
    item_id integer,
    order_id integer NOT NULL,
    discount_order_line_id integer,
    order_line_amount numeric(22,10),
    description character varying(1000) NOT NULL
);


ALTER TABLE public.discount_line OWNER TO openbrm_demo;

--
-- TOC entry 228 (class 1259 OID 264730)
-- Name: entity; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE entity (
    id integer NOT NULL,
    external_id character varying(20),
    description character varying(100) NOT NULL,
    create_datetime timestamp without time zone NOT NULL,
    language_id integer NOT NULL,
    currency_id integer NOT NULL,
    optlock integer NOT NULL,
    deleted integer DEFAULT 0 NOT NULL,
    invoice_as_reseller boolean DEFAULT false NOT NULL,
    parent_id integer
);


ALTER TABLE public.entity OWNER TO openbrm_demo;

--
-- TOC entry 229 (class 1259 OID 264735)
-- Name: entity_delivery_method_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE entity_delivery_method_map (
    method_id integer NOT NULL,
    entity_id integer NOT NULL
);


ALTER TABLE public.entity_delivery_method_map OWNER TO openbrm_demo;

--
-- TOC entry 230 (class 1259 OID 264738)
-- Name: entity_payment_method_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE entity_payment_method_map (
    entity_id integer NOT NULL,
    payment_method_id integer NOT NULL
);


ALTER TABLE public.entity_payment_method_map OWNER TO openbrm_demo;

--
-- TOC entry 231 (class 1259 OID 264741)
-- Name: entity_report_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE entity_report_map (
    report_id integer NOT NULL,
    entity_id integer NOT NULL
);


ALTER TABLE public.entity_report_map OWNER TO openbrm_demo;

--
-- TOC entry 232 (class 1259 OID 264744)
-- Name: enumeration; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE enumeration (
    id integer NOT NULL,
    entity_id integer NOT NULL,
    name character varying(50) NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.enumeration OWNER TO openbrm_demo;

--
-- TOC entry 233 (class 1259 OID 264747)
-- Name: enumeration_values; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE enumeration_values (
    id integer NOT NULL,
    enumeration_id integer NOT NULL,
    value character varying(50) NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.enumeration_values OWNER TO openbrm_demo;

--
-- TOC entry 234 (class 1259 OID 264750)
-- Name: event_log; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE event_log (
    id integer NOT NULL,
    entity_id integer,
    user_id integer,
    table_id integer,
    foreign_id integer NOT NULL,
    create_datetime timestamp without time zone NOT NULL,
    level_field integer NOT NULL,
    module_id integer NOT NULL,
    message_id integer NOT NULL,
    old_num integer,
    old_str character varying(1000),
    old_date timestamp without time zone,
    optlock integer NOT NULL,
    affected_user_id integer
);


ALTER TABLE public.event_log OWNER TO openbrm_demo;

--
-- TOC entry 235 (class 1259 OID 264756)
-- Name: event_log_message; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE event_log_message (
    id integer NOT NULL
);


ALTER TABLE public.event_log_message OWNER TO openbrm_demo;

--
-- TOC entry 236 (class 1259 OID 264759)
-- Name: event_log_module; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE event_log_module (
    id integer NOT NULL
);


ALTER TABLE public.event_log_module OWNER TO openbrm_demo;

--
-- TOC entry 237 (class 1259 OID 264762)
-- Name: event_type_rate_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE event_type_rate_map (
    id integer NOT NULL,
    charge_rate_id integer,
    event_type_id integer,
    data_type character varying(10) NOT NULL,
    customer_readonly smallint,
    optlock integer NOT NULL
);


ALTER TABLE public.event_type_rate_map OWNER TO openbrm_demo;

--
-- TOC entry 238 (class 1259 OID 264765)
-- Name: ex_rate; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE ex_rate (
    id integer NOT NULL,
    prefix character varying(45) NOT NULL,
    destination character varying(45) NOT NULL,
    field1 character varying(45) NOT NULL,
    field2 character varying(45) NOT NULL,
    version smallint DEFAULT 1 NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    rate_plan integer,
    created_date timestamp without time zone NOT NULL,
    valid_from date NOT NULL,
    valid_to date,
    last_updated_date date NOT NULL,
    entity_id integer NOT NULL
);


ALTER TABLE public.ex_rate OWNER TO openbrm_demo;

--
-- TOC entry 239 (class 1259 OID 264770)
-- Name: filter; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE filter (
    id integer NOT NULL,
    filter_set_id integer NOT NULL,
    type character varying(255) NOT NULL,
    constraint_type character varying(255) NOT NULL,
    field character varying(255) NOT NULL,
    template character varying(255) NOT NULL,
    visible boolean NOT NULL,
    integer_value integer,
    string_value character varying(255),
    start_date_value timestamp without time zone,
    end_date_value timestamp without time zone,
    version integer NOT NULL,
    boolean_value boolean,
    decimal_value numeric(22,10),
    decimal_high_value numeric(22,10),
    field_key_data character varying(255)
);


ALTER TABLE public.filter OWNER TO openbrm_demo;

--
-- TOC entry 240 (class 1259 OID 264776)
-- Name: filter_set; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE filter_set (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    user_id integer NOT NULL,
    version integer NOT NULL
);


ALTER TABLE public.filter_set OWNER TO openbrm_demo;

--
-- TOC entry 241 (class 1259 OID 264779)
-- Name: filter_set_filter_id_seq; Type: SEQUENCE; Schema: public; Owner: openbrm_demo
--

CREATE SEQUENCE filter_set_filter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.filter_set_filter_id_seq OWNER TO openbrm_demo;

--
-- TOC entry 242 (class 1259 OID 264781)
-- Name: filter_set_filter; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE filter_set_filter (
    filter_set_filters_id integer,
    filter_id integer,
    id integer DEFAULT nextval('filter_set_filter_id_seq'::regclass)
);


ALTER TABLE public.filter_set_filter OWNER TO openbrm_demo;

--
-- TOC entry 243 (class 1259 OID 264785)
-- Name: generic_status; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE generic_status (
    id integer NOT NULL,
    dtype character varying(50) NOT NULL,
    status_value integer NOT NULL,
    can_login integer,
    ordr integer,
    attribute1 character varying(20),
    entity_id integer,
    deleted integer
);


ALTER TABLE public.generic_status OWNER TO openbrm_demo;

--
-- TOC entry 244 (class 1259 OID 264788)
-- Name: generic_status_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE generic_status_type (
    id character varying(50) NOT NULL
);


ALTER TABLE public.generic_status_type OWNER TO openbrm_demo;

--
-- TOC entry 245 (class 1259 OID 264791)
-- Name: international_description; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE international_description (
    table_id integer NOT NULL,
    foreign_id integer NOT NULL,
    psudo_column character varying(20) NOT NULL,
    language_id integer NOT NULL,
    content character varying(4000) NOT NULL
);


ALTER TABLE public.international_description OWNER TO openbrm_demo;

--
-- TOC entry 246 (class 1259 OID 264797)
-- Name: invoice; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE invoice (
    id integer NOT NULL,
    create_datetime timestamp without time zone NOT NULL,
    billing_process_id integer,
    user_id integer,
    delegated_invoice_id integer,
    due_date date NOT NULL,
    total numeric(22,10) NOT NULL,
    payment_attempts integer DEFAULT 0 NOT NULL,
    status_id integer DEFAULT 1 NOT NULL,
    balance numeric(22,10),
    carried_balance numeric(22,10) NOT NULL,
    in_process_payment integer DEFAULT 1 NOT NULL,
    is_review integer NOT NULL,
    currency_id integer NOT NULL,
    deleted integer DEFAULT 0 NOT NULL,
    paper_invoice_batch_id integer,
    customer_notes character varying(1000),
    public_number character varying(40),
    last_reminder date,
    overdue_step integer,
    create_timestamp timestamp without time zone NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.invoice OWNER TO openbrm_demo;

--
-- TOC entry 247 (class 1259 OID 264807)
-- Name: invoice_commission; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE invoice_commission (
    id integer NOT NULL,
    partner_id integer,
    referral_partner_id integer,
    commission_process_run_id integer,
    invoice_id integer,
    standard_amount numeric(22,10),
    master_amount numeric(22,10),
    exception_amount numeric(22,10),
    referral_amount numeric(22,10),
    commission_id integer
);


ALTER TABLE public.invoice_commission OWNER TO openbrm_demo;

--
-- TOC entry 248 (class 1259 OID 264810)
-- Name: invoice_delivery_method; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE invoice_delivery_method (
    id integer NOT NULL
);


ALTER TABLE public.invoice_delivery_method OWNER TO openbrm_demo;

--
-- TOC entry 249 (class 1259 OID 264813)
-- Name: invoice_line; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE invoice_line (
    id integer NOT NULL,
    invoice_id integer,
    type_id integer,
    amount numeric(22,10) NOT NULL,
    quantity numeric(22,10),
    price numeric(22,10),
    deleted integer DEFAULT 0 NOT NULL,
    item_id integer,
    description character varying(1000),
    source_user_id integer,
    is_percentage integer DEFAULT 0 NOT NULL,
    optlock integer NOT NULL,
    order_id integer
);


ALTER TABLE public.invoice_line OWNER TO openbrm_demo;

--
-- TOC entry 250 (class 1259 OID 264821)
-- Name: invoice_line_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE invoice_line_type (
    id integer NOT NULL,
    description character varying(50) NOT NULL,
    order_position integer NOT NULL
);


ALTER TABLE public.invoice_line_type OWNER TO openbrm_demo;

--
-- TOC entry 251 (class 1259 OID 264824)
-- Name: invoice_meta_field_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE invoice_meta_field_map (
    invoice_id integer NOT NULL,
    meta_field_value_id integer NOT NULL
);


ALTER TABLE public.invoice_meta_field_map OWNER TO openbrm_demo;

--
-- TOC entry 252 (class 1259 OID 264827)
-- Name: item; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE item (
    id integer NOT NULL,
    internal_number character varying(50),
    entity_id integer,
    deleted integer DEFAULT 0 NOT NULL,
    has_decimals integer DEFAULT 0 NOT NULL,
    optlock integer NOT NULL,
    gl_code character varying(50),
    price_manual integer,
    asset_management_enabled integer DEFAULT 0 NOT NULL,
    standard_availability boolean DEFAULT true NOT NULL,
    global boolean DEFAULT false NOT NULL,
    standard_partner_percentage numeric(22,10),
    master_partner_percentage numeric(22,10),
    active_since date,
    active_until date,
    reservation_duration integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.item OWNER TO openbrm_demo;

--
-- TOC entry 253 (class 1259 OID 264836)
-- Name: item_account_type_availability; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE item_account_type_availability (
    item_id integer,
    account_type_id integer
);


ALTER TABLE public.item_account_type_availability OWNER TO openbrm_demo;

--
-- TOC entry 254 (class 1259 OID 264839)
-- Name: item_dependency; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE item_dependency (
    id integer NOT NULL,
    dtype character varying(10) NOT NULL,
    item_id integer NOT NULL,
    min integer NOT NULL,
    max integer,
    dependent_item_id integer,
    dependent_item_type_id integer
);


ALTER TABLE public.item_dependency OWNER TO openbrm_demo;

--
-- TOC entry 255 (class 1259 OID 264842)
-- Name: item_entity_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE item_entity_map (
    item_id integer NOT NULL,
    entity_id integer NOT NULL
);


ALTER TABLE public.item_entity_map OWNER TO openbrm_demo;

--
-- TOC entry 256 (class 1259 OID 264845)
-- Name: item_meta_field_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE item_meta_field_map (
    item_id integer NOT NULL,
    meta_field_value_id integer NOT NULL
);


ALTER TABLE public.item_meta_field_map OWNER TO openbrm_demo;

--
-- TOC entry 257 (class 1259 OID 264848)
-- Name: item_price; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE item_price (
    id integer NOT NULL,
    item_id integer,
    currency_id integer,
    price numeric(22,10) NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.item_price OWNER TO openbrm_demo;

--
-- TOC entry 258 (class 1259 OID 264851)
-- Name: item_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE item_type (
    id integer NOT NULL,
    entity_id integer NOT NULL,
    description character varying(100),
    order_line_type_id integer NOT NULL,
    optlock integer NOT NULL,
    internal boolean NOT NULL,
    parent_id integer,
    allow_asset_management integer DEFAULT 0 NOT NULL,
    asset_identifier_label character varying(50),
    global boolean DEFAULT false NOT NULL,
    one_per_order boolean DEFAULT false NOT NULL,
    one_per_customer boolean DEFAULT false NOT NULL
);


ALTER TABLE public.item_type OWNER TO openbrm_demo;

--
-- TOC entry 259 (class 1259 OID 264858)
-- Name: item_type_entity_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE item_type_entity_map (
    item_type_id integer NOT NULL,
    entity_id integer NOT NULL
);


ALTER TABLE public.item_type_entity_map OWNER TO openbrm_demo;

--
-- TOC entry 260 (class 1259 OID 264861)
-- Name: item_type_exclude_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE item_type_exclude_map (
    item_id integer NOT NULL,
    type_id integer NOT NULL
);


ALTER TABLE public.item_type_exclude_map OWNER TO openbrm_demo;

--
-- TOC entry 261 (class 1259 OID 264864)
-- Name: item_type_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE item_type_map (
    item_id integer NOT NULL,
    type_id integer NOT NULL
);


ALTER TABLE public.item_type_map OWNER TO openbrm_demo;

--
-- TOC entry 262 (class 1259 OID 264867)
-- Name: item_type_meta_field_def_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE item_type_meta_field_def_map (
    item_type_id integer NOT NULL,
    meta_field_id integer NOT NULL
);


ALTER TABLE public.item_type_meta_field_def_map OWNER TO openbrm_demo;

--
-- TOC entry 263 (class 1259 OID 264870)
-- Name: item_type_meta_field_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE item_type_meta_field_map (
    item_type_id integer NOT NULL,
    meta_field_value_id integer NOT NULL
);


ALTER TABLE public.item_type_meta_field_map OWNER TO openbrm_demo;

--
-- TOC entry 264 (class 1259 OID 264873)
-- Name: jbilling_seqs; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE jbilling_seqs (
    name character varying(255) NOT NULL,
    next_id integer
);


ALTER TABLE public.jbilling_seqs OWNER TO openbrm_demo;

--
-- TOC entry 265 (class 1259 OID 264876)
-- Name: jbilling_table; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE jbilling_table (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.jbilling_table OWNER TO openbrm_demo;

--
-- TOC entry 266 (class 1259 OID 264879)
-- Name: language; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE language (
    id integer NOT NULL,
    code character varying(2) NOT NULL,
    description character varying(50) NOT NULL
);


ALTER TABLE public.language OWNER TO openbrm_demo;

--
-- TOC entry 267 (class 1259 OID 264882)
-- Name: list_meta_field_values_id_seq; Type: SEQUENCE; Schema: public; Owner: openbrm_demo
--

CREATE SEQUENCE list_meta_field_values_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.list_meta_field_values_id_seq OWNER TO openbrm_demo;

--
-- TOC entry 268 (class 1259 OID 264884)
-- Name: list_meta_field_values; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE list_meta_field_values (
    meta_field_value_id integer NOT NULL,
    list_value character varying(255),
    id integer DEFAULT nextval('list_meta_field_values_id_seq'::regclass)
);


ALTER TABLE public.list_meta_field_values OWNER TO openbrm_demo;

--
-- TOC entry 269 (class 1259 OID 264888)
-- Name: matching_field; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE matching_field (
    id integer NOT NULL,
    description character varying(255) NOT NULL,
    required boolean NOT NULL,
    route_id integer,
    matching_field character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    order_sequence integer NOT NULL,
    optlock integer NOT NULL,
    longest_value integer NOT NULL,
    smallest_value integer NOT NULL,
    mandatory_fields_query character varying(1000) NOT NULL
);


ALTER TABLE public.matching_field OWNER TO openbrm_demo;

--
-- TOC entry 270 (class 1259 OID 264894)
-- Name: mediation_cfg; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE mediation_cfg (
    id integer NOT NULL,
    entity_id integer NOT NULL,
    create_datetime timestamp without time zone DEFAULT now() NOT NULL,
    name character varying(50) NOT NULL,
    order_value integer NOT NULL,
    pluggable_task_id integer NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.mediation_cfg OWNER TO openbrm_demo;

--
-- TOC entry 271 (class 1259 OID 264898)
-- Name: mediation_errors; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE mediation_errors (
    accountcode character varying(50) NOT NULL,
    src character varying(50) DEFAULT NULL::character varying,
    dst character varying(50) DEFAULT NULL::character varying,
    dcontext character varying(50) DEFAULT NULL::character varying,
    clid character varying(50) DEFAULT NULL::character varying,
    channel character varying(50) DEFAULT NULL::character varying,
    dstchannel character varying(50) DEFAULT NULL::character varying,
    lastapp character varying(50) DEFAULT NULL::character varying,
    lastdata character varying(50) DEFAULT NULL::character varying,
    start_to timestamp without time zone DEFAULT now() NOT NULL,
    answer timestamp without time zone,
    end_to timestamp without time zone,
    duration integer,
    billsec integer,
    disposition character varying(50) DEFAULT NULL::character varying,
    amaflags character varying(50) DEFAULT NULL::character varying,
    userfield character varying(50) DEFAULT NULL::character varying,
    error_message character varying(50) DEFAULT NULL::character varying,
    should_retry smallint
);


ALTER TABLE public.mediation_errors OWNER TO openbrm_demo;

--
-- TOC entry 272 (class 1259 OID 264917)
-- Name: mediation_order_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE mediation_order_map (
    mediation_process_id integer NOT NULL,
    order_id integer NOT NULL
);


ALTER TABLE public.mediation_order_map OWNER TO openbrm_demo;

--
-- TOC entry 273 (class 1259 OID 264920)
-- Name: mediation_process; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE mediation_process (
    id integer NOT NULL,
    configuration_id integer NOT NULL,
    start_datetime timestamp without time zone DEFAULT now() NOT NULL,
    end_datetime timestamp without time zone,
    orders_affected integer NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.mediation_process OWNER TO openbrm_demo;

--
-- TOC entry 274 (class 1259 OID 264924)
-- Name: mediation_record; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE mediation_record (
    id_key character varying(100) NOT NULL,
    start_datetime timestamp without time zone DEFAULT now() NOT NULL,
    mediation_process_id integer,
    optlock integer NOT NULL,
    status_id integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.mediation_record OWNER TO openbrm_demo;

--
-- TOC entry 275 (class 1259 OID 264928)
-- Name: mediation_record_line; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE mediation_record_line (
    id integer NOT NULL,
    order_line_id integer NOT NULL,
    event_date timestamp without time zone DEFAULT now() NOT NULL,
    amount numeric(22,10) NOT NULL,
    quantity numeric(22,10) NOT NULL,
    description character varying(200) DEFAULT NULL::character varying,
    optlock integer NOT NULL,
    mediation_record_id integer NOT NULL
);


ALTER TABLE public.mediation_record_line OWNER TO openbrm_demo;

--
-- TOC entry 276 (class 1259 OID 264933)
-- Name: meta_field_group; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE meta_field_group (
    id integer NOT NULL,
    date_created date,
    date_updated date,
    entity_id integer NOT NULL,
    display_order integer,
    optlock integer,
    entity_type character varying(32) NOT NULL,
    discriminator character varying(30) NOT NULL,
    name character varying(32),
    account_type_id integer
);


ALTER TABLE public.meta_field_group OWNER TO openbrm_demo;

--
-- TOC entry 277 (class 1259 OID 264936)
-- Name: meta_field_name; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE meta_field_name (
    id integer NOT NULL,
    name character varying(100),
    entity_type character varying(25) NOT NULL,
    data_type character varying(25) NOT NULL,
    is_disabled boolean,
    is_mandatory boolean,
    display_order integer,
    default_value_id integer,
    optlock integer NOT NULL,
    entity_id integer DEFAULT 1,
    error_message character varying(256),
    is_primary boolean DEFAULT true,
    validation_rule_id integer,
    filename character varying(100),
    field_usage character varying(50)
);


ALTER TABLE public.meta_field_name OWNER TO openbrm_demo;

--
-- TOC entry 278 (class 1259 OID 264944)
-- Name: meta_field_value; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE meta_field_value (
    id integer NOT NULL,
    meta_field_name_id integer NOT NULL,
    dtype character varying(10) NOT NULL,
    boolean_value boolean,
    date_value timestamp without time zone,
    decimal_value numeric(22,10),
    integer_value integer,
    string_value character varying(1000)
);


ALTER TABLE public.meta_field_value OWNER TO openbrm_demo;

--
-- TOC entry 279 (class 1259 OID 264950)
-- Name: metafield_group_meta_field_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE metafield_group_meta_field_map (
    metafield_group_id integer NOT NULL,
    meta_field_value_id integer NOT NULL
);


ALTER TABLE public.metafield_group_meta_field_map OWNER TO openbrm_demo;

--
-- TOC entry 280 (class 1259 OID 264953)
-- Name: notification_category; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE notification_category (
    id integer NOT NULL
);


ALTER TABLE public.notification_category OWNER TO openbrm_demo;

--
-- TOC entry 281 (class 1259 OID 264956)
-- Name: notification_config; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE notification_config (
    id integer NOT NULL,
    event_id integer NOT NULL,
    created_datetime timestamp without time zone NOT NULL,
    message_id integer NOT NULL,
    notify_type integer NOT NULL,
    deleted smallint,
    optlock integer
);


ALTER TABLE public.notification_config OWNER TO openbrm_demo;

--
-- TOC entry 282 (class 1259 OID 264959)
-- Name: notification_event; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE notification_event (
    id integer NOT NULL,
    subject character varying(255) DEFAULT NULL::character varying,
    created_datetime timestamp without time zone NOT NULL
);


ALTER TABLE public.notification_event OWNER TO openbrm_demo;

--
-- TOC entry 283 (class 1259 OID 264963)
-- Name: notification_medium_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE notification_medium_type (
    notification_id integer NOT NULL,
    medium_type character varying(255) NOT NULL
);


ALTER TABLE public.notification_medium_type OWNER TO openbrm_demo;

--
-- TOC entry 284 (class 1259 OID 264966)
-- Name: notification_message; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE notification_message (
    id integer NOT NULL,
    type_id integer,
    entity_id integer NOT NULL,
    language_id integer NOT NULL,
    use_flag integer DEFAULT 1 NOT NULL,
    optlock integer NOT NULL,
    attachment_type character varying(20),
    include_attachment integer,
    attachment_design character varying(100),
    notify_admin integer,
    notify_partner integer,
    notify_parent integer,
    notify_all_parents integer
);


ALTER TABLE public.notification_message OWNER TO openbrm_demo;

--
-- TOC entry 285 (class 1259 OID 264970)
-- Name: notification_message_arch; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE notification_message_arch (
    id integer NOT NULL,
    type_id integer,
    create_datetime timestamp without time zone NOT NULL,
    user_id integer,
    result_message character varying(200),
    optlock integer NOT NULL
);


ALTER TABLE public.notification_message_arch OWNER TO openbrm_demo;

--
-- TOC entry 286 (class 1259 OID 264973)
-- Name: notification_message_arch_line; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE notification_message_arch_line (
    content character varying(1000) NOT NULL,
    message_archive_id integer,
    section integer NOT NULL,
    optlock integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.notification_message_arch_line OWNER TO openbrm_demo;

--
-- TOC entry 287 (class 1259 OID 264979)
-- Name: notification_message_line; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE notification_message_line (
    id integer NOT NULL,
    message_section_id integer,
    content character varying(1000) NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.notification_message_line OWNER TO openbrm_demo;

--
-- TOC entry 288 (class 1259 OID 264985)
-- Name: notification_message_section; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE notification_message_section (
    id integer NOT NULL,
    message_id integer,
    section integer,
    optlock integer NOT NULL
);


ALTER TABLE public.notification_message_section OWNER TO openbrm_demo;

--
-- TOC entry 289 (class 1259 OID 264988)
-- Name: notification_message_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE notification_message_type (
    id integer NOT NULL,
    optlock integer NOT NULL,
    category_id integer
);


ALTER TABLE public.notification_message_type OWNER TO openbrm_demo;

--
-- TOC entry 290 (class 1259 OID 264991)
-- Name: notification_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE notification_type (
    id integer NOT NULL
);


ALTER TABLE public.notification_type OWNER TO openbrm_demo;

--
-- TOC entry 291 (class 1259 OID 264994)
-- Name: ob_rated_cdr_record; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE ob_rated_cdr_record (
    id integer DEFAULT 0 NOT NULL,
    process_id integer NOT NULL,
    record_id character varying(100) DEFAULT NULL::character varying,
    order_id integer NOT NULL,
    user_id integer NOT NULL,
    invoice_id integer,
    calling_number character varying(40) DEFAULT NULL::character varying,
    destination_number character varying(40) DEFAULT NULL::character varying,
    call_start_date timestamp without time zone,
    call_end_date timestamp without time zone,
    duration integer,
    cost numeric(22,10) DEFAULT NULL::numeric,
    product_id integer,
    destination_descr character varying(256) DEFAULT NULL::character varying,
    rate_id integer,
    call_type character varying(20) DEFAULT NULL::character varying,
    cdr_source character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.ob_rated_cdr_record OWNER TO openbrm_demo;

--
-- TOC entry 292 (class 1259 OID 265008)
-- Name: order_billing_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE order_billing_type (
    id integer NOT NULL
);


ALTER TABLE public.order_billing_type OWNER TO openbrm_demo;

--
-- TOC entry 293 (class 1259 OID 265011)
-- Name: order_change; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE order_change (
    id integer NOT NULL,
    parent_order_change_id integer,
    parent_order_line_id integer,
    order_id integer NOT NULL,
    item_id integer NOT NULL,
    quantity numeric(22,10),
    price numeric(22,10),
    description character varying(1000),
    use_item integer,
    user_id integer NOT NULL,
    create_datetime timestamp without time zone NOT NULL,
    start_date date NOT NULL,
    application_date timestamp without time zone,
    status_id integer NOT NULL,
    user_assigned_status_id integer NOT NULL,
    order_line_id integer,
    optlock integer NOT NULL,
    error_message character varying(500),
    error_codes character varying(200),
    applied_manually integer,
    removal integer,
    next_billable_date date,
    end_date date,
    order_change_type_id integer NOT NULL,
    order_status_id integer,
    is_percentage boolean DEFAULT false NOT NULL
);


ALTER TABLE public.order_change OWNER TO openbrm_demo;

--
-- TOC entry 294 (class 1259 OID 265018)
-- Name: order_change_asset_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE order_change_asset_map (
    order_change_id integer NOT NULL,
    asset_id integer NOT NULL
);


ALTER TABLE public.order_change_asset_map OWNER TO openbrm_demo;

--
-- TOC entry 295 (class 1259 OID 265021)
-- Name: order_change_meta_field_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE order_change_meta_field_map (
    order_change_id integer NOT NULL,
    meta_field_value_id integer NOT NULL
);


ALTER TABLE public.order_change_meta_field_map OWNER TO openbrm_demo;

--
-- TOC entry 296 (class 1259 OID 265024)
-- Name: order_change_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE order_change_type (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    entity_id integer,
    default_type boolean DEFAULT false NOT NULL,
    allow_order_status_change boolean DEFAULT false NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.order_change_type OWNER TO openbrm_demo;

--
-- TOC entry 297 (class 1259 OID 265029)
-- Name: order_change_type_item_type_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE order_change_type_item_type_map (
    order_change_type_id integer NOT NULL,
    item_type_id integer NOT NULL
);


ALTER TABLE public.order_change_type_item_type_map OWNER TO openbrm_demo;

--
-- TOC entry 298 (class 1259 OID 265032)
-- Name: order_change_type_meta_field_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE order_change_type_meta_field_map (
    order_change_type_id integer NOT NULL,
    meta_field_id integer NOT NULL
);


ALTER TABLE public.order_change_type_meta_field_map OWNER TO openbrm_demo;

--
-- TOC entry 299 (class 1259 OID 265035)
-- Name: order_line; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE order_line (
    id integer NOT NULL,
    order_id integer,
    item_id integer,
    type_id integer,
    amount numeric(22,10) NOT NULL,
    quantity numeric(22,10),
    price numeric(22,10),
    item_price integer,
    create_datetime timestamp without time zone NOT NULL,
    deleted integer DEFAULT 0 NOT NULL,
    description character varying(1000),
    optlock integer NOT NULL,
    use_item boolean NOT NULL,
    parent_line_id integer,
    start_date date,
    end_date date,
    sip_uri character varying(255),
    is_percentage boolean DEFAULT false NOT NULL
);


ALTER TABLE public.order_line OWNER TO openbrm_demo;

--
-- TOC entry 300 (class 1259 OID 265043)
-- Name: order_line_meta_field_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE order_line_meta_field_map (
    order_line_id integer NOT NULL,
    meta_field_value_id integer NOT NULL
);


ALTER TABLE public.order_line_meta_field_map OWNER TO openbrm_demo;

--
-- TOC entry 301 (class 1259 OID 265046)
-- Name: order_line_meta_fields_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE order_line_meta_fields_map (
    item_id integer NOT NULL,
    meta_field_id integer NOT NULL
);


ALTER TABLE public.order_line_meta_fields_map OWNER TO openbrm_demo;

--
-- TOC entry 302 (class 1259 OID 265049)
-- Name: order_line_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE order_line_type (
    id integer NOT NULL,
    editable integer NOT NULL
);


ALTER TABLE public.order_line_type OWNER TO openbrm_demo;

--
-- TOC entry 303 (class 1259 OID 265052)
-- Name: order_meta_field_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE order_meta_field_map (
    order_id integer NOT NULL,
    meta_field_value_id integer NOT NULL
);


ALTER TABLE public.order_meta_field_map OWNER TO openbrm_demo;

--
-- TOC entry 304 (class 1259 OID 265055)
-- Name: order_period; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE order_period (
    id integer NOT NULL,
    entity_id integer,
    value integer,
    unit_id integer,
    optlock integer NOT NULL
);


ALTER TABLE public.order_period OWNER TO openbrm_demo;

--
-- TOC entry 305 (class 1259 OID 265058)
-- Name: order_process; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE order_process (
    id integer NOT NULL,
    order_id integer,
    invoice_id integer,
    billing_process_id integer,
    periods_included integer,
    period_start date,
    period_end date,
    is_review integer NOT NULL,
    origin integer,
    optlock integer NOT NULL
);


ALTER TABLE public.order_process OWNER TO openbrm_demo;

--
-- TOC entry 306 (class 1259 OID 265061)
-- Name: order_status; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE order_status (
    id integer NOT NULL,
    order_status_flag integer,
    entity_id integer
);


ALTER TABLE public.order_status OWNER TO openbrm_demo;

--
-- TOC entry 307 (class 1259 OID 265064)
-- Name: package_price; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE package_price (
    id integer NOT NULL,
    pkg_prod_id integer,
    type_id integer,
    amount numeric(10,2),
    discount numeric(10,2),
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    start_offset integer,
    start_offset_unit integer,
    end_offset integer,
    end_offset_unit integer,
    optlock integer NOT NULL,
    deleted integer DEFAULT 0 NOT NULL,
    period_id integer,
    billing_type_id integer
);


ALTER TABLE public.package_price OWNER TO openbrm_demo;

--
-- TOC entry 308 (class 1259 OID 265068)
-- Name: package_price_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE package_price_type (
    id integer NOT NULL,
    type character varying(50) NOT NULL
);


ALTER TABLE public.package_price_type OWNER TO openbrm_demo;

--
-- TOC entry 309 (class 1259 OID 265071)
-- Name: package_product; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE package_product (
    id integer NOT NULL,
    package_id integer NOT NULL,
    quantity integer NOT NULL,
    product_id integer NOT NULL,
    deleted integer DEFAULT 0 NOT NULL,
    optlock integer,
    create_datetime timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.package_product OWNER TO openbrm_demo;

--
-- TOC entry 310 (class 1259 OID 265076)
-- Name: paper_invoice_batch; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE paper_invoice_batch (
    id integer NOT NULL,
    total_invoices integer NOT NULL,
    delivery_date date,
    is_self_managed integer NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.paper_invoice_batch OWNER TO openbrm_demo;

--
-- TOC entry 311 (class 1259 OID 265079)
-- Name: partner; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE partner (
    id integer NOT NULL,
    user_id integer,
    total_payments numeric(22,10) NOT NULL,
    total_refunds numeric(22,10) NOT NULL,
    total_payouts numeric(22,10) NOT NULL,
    due_payout numeric(22,10),
    optlock integer NOT NULL,
    type character varying(250),
    parent_id integer,
    commission_type character varying(255)
);


ALTER TABLE public.partner OWNER TO openbrm_demo;

--
-- TOC entry 312 (class 1259 OID 265085)
-- Name: partner_commission; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE partner_commission (
    id integer NOT NULL,
    amount numeric(22,10),
    type character varying(255),
    partner_id integer,
    commission_process_run_id integer,
    currency_id integer
);


ALTER TABLE public.partner_commission OWNER TO openbrm_demo;

--
-- TOC entry 313 (class 1259 OID 265088)
-- Name: partner_commission_exception; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE partner_commission_exception (
    id integer NOT NULL,
    partner_id integer,
    start_date date,
    end_date date,
    percentage numeric(22,10),
    item_id integer
);


ALTER TABLE public.partner_commission_exception OWNER TO openbrm_demo;

--
-- TOC entry 314 (class 1259 OID 265091)
-- Name: partner_commission_proc_config; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE partner_commission_proc_config (
    id integer NOT NULL,
    entity_id integer,
    next_run_date date,
    period_unit_id integer,
    period_value integer
);


ALTER TABLE public.partner_commission_proc_config OWNER TO openbrm_demo;

--
-- TOC entry 315 (class 1259 OID 265094)
-- Name: partner_commission_process_run; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE partner_commission_process_run (
    id integer NOT NULL,
    run_date date,
    period_start date,
    period_end date,
    entity_id integer
);


ALTER TABLE public.partner_commission_process_run OWNER TO openbrm_demo;

--
-- TOC entry 316 (class 1259 OID 265097)
-- Name: partner_meta_field_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE partner_meta_field_map (
    partner_id integer NOT NULL,
    meta_field_value_id integer NOT NULL
);


ALTER TABLE public.partner_meta_field_map OWNER TO openbrm_demo;

--
-- TOC entry 317 (class 1259 OID 265100)
-- Name: partner_payout; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE partner_payout (
    id integer NOT NULL,
    starting_date date NOT NULL,
    ending_date date NOT NULL,
    payments_amount numeric(22,10) NOT NULL,
    refunds_amount numeric(22,10) NOT NULL,
    balance_left numeric(22,10) NOT NULL,
    payment_id integer,
    partner_id integer,
    optlock integer NOT NULL
);


ALTER TABLE public.partner_payout OWNER TO openbrm_demo;

--
-- TOC entry 318 (class 1259 OID 265103)
-- Name: partner_referral_commission; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE partner_referral_commission (
    id integer NOT NULL,
    referral_id integer,
    referrer_id integer,
    start_date date,
    end_date date,
    percentage numeric(22,10)
);


ALTER TABLE public.partner_referral_commission OWNER TO openbrm_demo;

--
-- TOC entry 319 (class 1259 OID 265106)
-- Name: payment; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE payment (
    id integer NOT NULL,
    user_id integer,
    attempt integer,
    result_id integer,
    amount numeric(22,10) NOT NULL,
    create_datetime timestamp without time zone NOT NULL,
    update_datetime timestamp without time zone,
    payment_date date,
    method_id integer,
    credit_card_id integer,
    deleted integer DEFAULT 0 NOT NULL,
    is_refund integer DEFAULT 0 NOT NULL,
    is_preauth integer DEFAULT 0 NOT NULL,
    payment_id integer,
    currency_id integer NOT NULL,
    payout_id integer,
    ach_id integer,
    balance numeric(22,10),
    optlock integer NOT NULL,
    payment_period integer,
    payment_notes character varying(500)
);


ALTER TABLE public.payment OWNER TO openbrm_demo;

--
-- TOC entry 320 (class 1259 OID 265115)
-- Name: payment_authorization; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE payment_authorization (
    id integer NOT NULL,
    payment_id integer,
    processor character varying(40) NOT NULL,
    code1 character varying(40) NOT NULL,
    code2 character varying(40),
    code3 character varying(40),
    approval_code character varying(20),
    avs character varying(20),
    transaction_id character varying(40),
    md5 character varying(100),
    card_code character varying(100),
    create_datetime date NOT NULL,
    response_message character varying(200),
    optlock integer NOT NULL
);


ALTER TABLE public.payment_authorization OWNER TO openbrm_demo;

--
-- TOC entry 321 (class 1259 OID 265121)
-- Name: payment_commission; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE payment_commission (
    id integer NOT NULL,
    invoice_id integer,
    payment_amount numeric(22,10)
);


ALTER TABLE public.payment_commission OWNER TO openbrm_demo;

--
-- TOC entry 322 (class 1259 OID 265124)
-- Name: payment_info_cheque; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE payment_info_cheque (
    id integer NOT NULL,
    payment_id integer,
    bank character varying(50),
    cheque_number character varying(50),
    cheque_date date,
    optlock integer NOT NULL
);


ALTER TABLE public.payment_info_cheque OWNER TO openbrm_demo;

--
-- TOC entry 323 (class 1259 OID 265127)
-- Name: payment_information; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE payment_information (
    id integer NOT NULL,
    user_id integer,
    payment_method_id integer NOT NULL,
    processing_order integer,
    deleted integer NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.payment_information OWNER TO openbrm_demo;

--
-- TOC entry 324 (class 1259 OID 265130)
-- Name: payment_information_meta_fields_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE payment_information_meta_fields_map (
    payment_information_id integer NOT NULL,
    meta_field_value_id integer NOT NULL
);


ALTER TABLE public.payment_information_meta_fields_map OWNER TO openbrm_demo;

--
-- TOC entry 325 (class 1259 OID 265133)
-- Name: payment_instrument_info; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE payment_instrument_info (
    id integer NOT NULL,
    result_id integer NOT NULL,
    method_id integer NOT NULL,
    instrument_id integer NOT NULL,
    payment_id integer NOT NULL
);


ALTER TABLE public.payment_instrument_info OWNER TO openbrm_demo;

--
-- TOC entry 326 (class 1259 OID 265136)
-- Name: payment_invoice; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE payment_invoice (
    id integer NOT NULL,
    payment_id integer,
    invoice_id integer,
    amount numeric(22,10),
    create_datetime timestamp without time zone NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.payment_invoice OWNER TO openbrm_demo;

--
-- TOC entry 327 (class 1259 OID 265139)
-- Name: payment_meta_field_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE payment_meta_field_map (
    payment_id integer NOT NULL,
    meta_field_value_id integer NOT NULL
);


ALTER TABLE public.payment_meta_field_map OWNER TO openbrm_demo;

--
-- TOC entry 328 (class 1259 OID 265142)
-- Name: payment_method; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE payment_method (
    id integer NOT NULL
);


ALTER TABLE public.payment_method OWNER TO openbrm_demo;

--
-- TOC entry 329 (class 1259 OID 265145)
-- Name: payment_method_account_type_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE payment_method_account_type_map (
    payment_method_id integer NOT NULL,
    account_type_id integer NOT NULL
);


ALTER TABLE public.payment_method_account_type_map OWNER TO openbrm_demo;

--
-- TOC entry 330 (class 1259 OID 265148)
-- Name: payment_method_meta_fields_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE payment_method_meta_fields_map (
    payment_method_id integer NOT NULL,
    meta_field_id integer NOT NULL
);


ALTER TABLE public.payment_method_meta_fields_map OWNER TO openbrm_demo;

--
-- TOC entry 331 (class 1259 OID 265151)
-- Name: payment_method_template; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE payment_method_template (
    id integer NOT NULL,
    template_name character varying(20) NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.payment_method_template OWNER TO openbrm_demo;

--
-- TOC entry 332 (class 1259 OID 265154)
-- Name: payment_method_template_meta_fields_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE payment_method_template_meta_fields_map (
    method_template_id integer NOT NULL,
    meta_field_id integer NOT NULL
);


ALTER TABLE public.payment_method_template_meta_fields_map OWNER TO openbrm_demo;

--
-- TOC entry 333 (class 1259 OID 265157)
-- Name: payment_method_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE payment_method_type (
    id integer NOT NULL,
    method_name character varying(20) NOT NULL,
    is_recurring boolean DEFAULT false NOT NULL,
    entity_id integer NOT NULL,
    template_id integer NOT NULL,
    optlock integer NOT NULL,
    all_account_type boolean DEFAULT false NOT NULL
);


ALTER TABLE public.payment_method_type OWNER TO openbrm_demo;

--
-- TOC entry 334 (class 1259 OID 265162)
-- Name: payment_result; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE payment_result (
    id integer NOT NULL
);


ALTER TABLE public.payment_result OWNER TO openbrm_demo;

--
-- TOC entry 335 (class 1259 OID 265165)
-- Name: period_unit; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE period_unit (
    id integer NOT NULL
);


ALTER TABLE public.period_unit OWNER TO openbrm_demo;

--
-- TOC entry 336 (class 1259 OID 265168)
-- Name: permission; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE permission (
    id integer NOT NULL,
    type_id integer NOT NULL,
    foreign_id integer
);


ALTER TABLE public.permission OWNER TO openbrm_demo;

--
-- TOC entry 337 (class 1259 OID 265171)
-- Name: permission_role_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE permission_role_map (
    permission_id integer,
    role_id integer
);


ALTER TABLE public.permission_role_map OWNER TO openbrm_demo;

--
-- TOC entry 338 (class 1259 OID 265174)
-- Name: permission_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE permission_type (
    id integer NOT NULL,
    description character varying(30) NOT NULL
);


ALTER TABLE public.permission_type OWNER TO openbrm_demo;

--
-- TOC entry 339 (class 1259 OID 265177)
-- Name: permission_user; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE permission_user (
    permission_id integer,
    user_id integer,
    is_grant integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.permission_user OWNER TO openbrm_demo;

--
-- TOC entry 340 (class 1259 OID 265180)
-- Name: pluggable_task; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE pluggable_task (
    id integer NOT NULL,
    entity_id integer NOT NULL,
    type_id integer,
    processing_order integer NOT NULL,
    optlock integer NOT NULL,
    notes character varying(1000)
);


ALTER TABLE public.pluggable_task OWNER TO openbrm_demo;

--
-- TOC entry 341 (class 1259 OID 265186)
-- Name: pluggable_task_parameter; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE pluggable_task_parameter (
    id integer NOT NULL,
    task_id integer,
    name character varying(50) NOT NULL,
    int_value integer,
    str_value character varying(500),
    float_value numeric(22,10),
    optlock integer NOT NULL
);


ALTER TABLE public.pluggable_task_parameter OWNER TO openbrm_demo;

--
-- TOC entry 342 (class 1259 OID 265192)
-- Name: pluggable_task_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE pluggable_task_type (
    id integer NOT NULL,
    category_id integer NOT NULL,
    class_name character varying(200) NOT NULL,
    min_parameters integer NOT NULL
);


ALTER TABLE public.pluggable_task_type OWNER TO openbrm_demo;

--
-- TOC entry 343 (class 1259 OID 265195)
-- Name: pluggable_task_type_category; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE pluggable_task_type_category (
    id integer NOT NULL,
    interface_name character varying(200) NOT NULL
);


ALTER TABLE public.pluggable_task_type_category OWNER TO openbrm_demo;

--
-- TOC entry 344 (class 1259 OID 265198)
-- Name: preference; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE preference (
    id integer NOT NULL,
    type_id integer,
    table_id integer NOT NULL,
    foreign_id integer NOT NULL,
    value character varying(200)
);


ALTER TABLE public.preference OWNER TO openbrm_demo;

--
-- TOC entry 345 (class 1259 OID 265201)
-- Name: preference_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE preference_type (
    id integer NOT NULL,
    def_value character varying(200),
    validation_rule_id integer
);


ALTER TABLE public.preference_type OWNER TO openbrm_demo;

--
-- TOC entry 346 (class 1259 OID 265204)
-- Name: price_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE price_map (
    id integer NOT NULL,
    map_group character varying(24) NOT NULL,
    origin_zone character varying(10) NOT NULL,
    dest_zone character varying(10) NOT NULL,
    zone_result character varying(64) NOT NULL,
    time_result character varying(24) NOT NULL,
    price_group character varying(64) NOT NULL,
    description character varying(64) NOT NULL,
    rate_price numeric(22,10) DEFAULT NULL::numeric,
    setup_price numeric(22,10) DEFAULT NULL::numeric,
    deleted integer DEFAULT 0 NOT NULL,
    rating_type character varying(64) NOT NULL,
    price_map_plan integer NOT NULL,
    created_date timestamp without time zone NOT NULL,
    start_date date NOT NULL,
    end_date date,
    last_updated_date date NOT NULL,
    entity_id integer
);


ALTER TABLE public.price_map OWNER TO openbrm_demo;

--
-- TOC entry 347 (class 1259 OID 265210)
-- Name: price_model; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE price_model (
    id integer NOT NULL,
    price_model character varying(45) NOT NULL,
    qty_step integer NOT NULL,
    tier_from integer NOT NULL,
    tier_to integer NOT NULL,
    beat numeric(22,10) DEFAULT NULL::numeric,
    factor numeric(22,10) DEFAULT NULL::numeric,
    charge_base integer NOT NULL,
    deleted integer DEFAULT 0 NOT NULL,
    price_plan integer NOT NULL,
    created_date timestamp without time zone NOT NULL,
    last_updated_date date NOT NULL,
    entity_id integer
);


ALTER TABLE public.price_model OWNER TO openbrm_demo;

--
-- TOC entry 348 (class 1259 OID 265216)
-- Name: price_package; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE price_package (
    id integer NOT NULL,
    package_code character varying(60),
    description character varying(100),
    created_date timestamp without time zone,
    active_until timestamp without time zone,
    category integer,
    entity_id integer,
    optlock integer NOT NULL,
    deleted integer,
    active_since timestamp without time zone,
    mbg_days integer
);


ALTER TABLE public.price_package OWNER TO openbrm_demo;

--
-- TOC entry 349 (class 1259 OID 265219)
-- Name: process_run; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE process_run (
    id integer NOT NULL,
    process_id integer,
    run_date date NOT NULL,
    started timestamp without time zone NOT NULL,
    finished timestamp without time zone,
    payment_finished timestamp without time zone,
    invoices_generated integer,
    optlock integer NOT NULL,
    status_id integer NOT NULL
);


ALTER TABLE public.process_run OWNER TO openbrm_demo;

--
-- TOC entry 350 (class 1259 OID 265222)
-- Name: process_run_total; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE process_run_total (
    id integer NOT NULL,
    process_run_id integer,
    currency_id integer NOT NULL,
    total_invoiced numeric(22,10),
    total_paid numeric(22,10),
    total_not_paid numeric(22,10),
    optlock integer NOT NULL
);


ALTER TABLE public.process_run_total OWNER TO openbrm_demo;

--
-- TOC entry 351 (class 1259 OID 265225)
-- Name: process_run_total_pm; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE process_run_total_pm (
    id integer NOT NULL,
    process_run_total_id integer,
    payment_method_id integer,
    total numeric(22,10) NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.process_run_total_pm OWNER TO openbrm_demo;

--
-- TOC entry 352 (class 1259 OID 265228)
-- Name: process_run_user; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE process_run_user (
    id integer NOT NULL,
    process_run_id integer NOT NULL,
    user_id integer NOT NULL,
    status integer NOT NULL,
    created timestamp without time zone NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.process_run_user OWNER TO openbrm_demo;

--
-- TOC entry 353 (class 1259 OID 265231)
-- Name: product_charge; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE product_charge (
    id integer NOT NULL,
    item_id integer NOT NULL,
    created_date timestamp without time zone NOT NULL,
    charge_type integer NOT NULL,
    deleted integer DEFAULT 0 NOT NULL,
    tax_code integer
);


ALTER TABLE public.product_charge OWNER TO openbrm_demo;

--
-- TOC entry 354 (class 1259 OID 265235)
-- Name: product_charge_rate; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE product_charge_rate (
    id integer NOT NULL,
    charge_id integer NOT NULL,
    currency_id integer NOT NULL,
    fixed_amount numeric(22,2) NOT NULL,
    scaled_amount numeric(22,2) NOT NULL,
    unit_id integer NOT NULL,
    dependee_id integer,
    rum_id integer,
    last_modified timestamp without time zone,
    optlock integer NOT NULL,
    deleted integer,
    salience integer NOT NULL,
    destination_map_id integer
);


ALTER TABLE public.product_charge_rate OWNER TO openbrm_demo;

--
-- TOC entry 355 (class 1259 OID 265238)
-- Name: promotion; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE promotion (
    id integer NOT NULL,
    item_id integer,
    code character varying(50) NOT NULL,
    notes character varying(200),
    once integer NOT NULL,
    since date,
    until date
);


ALTER TABLE public.promotion OWNER TO openbrm_demo;

--
-- TOC entry 356 (class 1259 OID 265241)
-- Name: promotion_user_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE promotion_user_map (
    user_id integer NOT NULL,
    promotion_id integer NOT NULL
);


ALTER TABLE public.promotion_user_map OWNER TO openbrm_demo;

--
-- TOC entry 357 (class 1259 OID 265244)
-- Name: provisioning_tag; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE provisioning_tag (
    id integer NOT NULL,
    code character varying(255),
    level integer NOT NULL,
    parent_id integer,
    deleted integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.provisioning_tag OWNER TO openbrm_demo;

--
-- TOC entry 358 (class 1259 OID 265248)
-- Name: provisioning_tag_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE provisioning_tag_map (
    id integer NOT NULL,
    item_id integer NOT NULL,
    tag_id integer,
    level integer DEFAULT 0 NOT NULL,
    parent_id integer,
    deleted integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.provisioning_tag_map OWNER TO openbrm_demo;

--
-- TOC entry 359 (class 1259 OID 265253)
-- Name: provisioning_tag_map_info; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE provisioning_tag_map_info (
    id integer NOT NULL,
    map_id integer NOT NULL,
    parameter character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.provisioning_tag_map_info OWNER TO openbrm_demo;

--
-- TOC entry 360 (class 1259 OID 265257)
-- Name: purchase_order; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE purchase_order (
    id integer NOT NULL,
    user_id integer,
    period_id integer,
    billing_type_id integer NOT NULL,
    active_since date,
    active_until date,
    cycle_start date,
    create_datetime timestamp without time zone NOT NULL,
    next_billable_day date,
    created_by integer,
    status_id integer NOT NULL,
    currency_id integer NOT NULL,
    deleted integer DEFAULT 0 NOT NULL,
    notify integer,
    last_notified timestamp without time zone,
    notification_step integer,
    due_date_unit_id integer,
    due_date_value integer,
    df_fm integer,
    anticipate_periods integer,
    own_invoice integer,
    notes character varying(200),
    notes_in_invoice integer,
    optlock integer NOT NULL,
    primary_order_id integer,
    prorate_flag boolean DEFAULT false NOT NULL,
    parent_order_id integer,
    cancellation_fee_type character varying(50),
    cancellation_fee integer,
    cancellation_fee_percentage integer,
    cancellation_maximum_fee integer,
    cancellation_minimum_period integer,
    reseller_order integer,
    free_usage_quantity numeric(22,10),
    deleted_date date
);


ALTER TABLE public.purchase_order OWNER TO openbrm_demo;

--
-- TOC entry 361 (class 1259 OID 265262)
-- Name: purchased_bundle; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE purchased_bundle (
    id integer NOT NULL,
    bundle_id integer NOT NULL,
    status_id integer NOT NULL,
    valid_from date NOT NULL,
    valid_to date,
    update_datetime timestamp without time zone,
    created_datetime timestamp without time zone,
    user_id integer NOT NULL
);


ALTER TABLE public.purchased_bundle OWNER TO openbrm_demo;

--
-- TOC entry 362 (class 1259 OID 265265)
-- Name: purchased_bundle_product; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE purchased_bundle_product (
    id integer NOT NULL,
    pb_id integer NOT NULL,
    product_id integer NOT NULL,
    recurring_charge numeric(10,2),
    recurring_discount numeric(10,2),
    recurring_start_time timestamp without time zone,
    recurring_end_time timestamp without time zone,
    oneoff_charge numeric(10,2),
    oneoff_discount numeric(10,2),
    oneoff_start_time timestamp without time zone,
    oneoff_end_time timestamp without time zone,
    usage_charge numeric(10,2),
    usage_discount numeric(10,2),
    usage_start_time timestamp without time zone,
    usage_end_time timestamp without time zone,
    cancel_charge numeric(10,2),
    cancel_discount numeric(10,2),
    cancel_start_time timestamp without time zone,
    cancel_end_time timestamp without time zone,
    oneoff_order_id integer,
    recurring_order_id integer,
    cancel_order_id integer
);


ALTER TABLE public.purchased_bundle_product OWNER TO openbrm_demo;

--
-- TOC entry 363 (class 1259 OID 265268)
-- Name: rate; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE rate (
    id integer NOT NULL,
    prefix character varying(45) NOT NULL,
    destination character varying(45) NOT NULL,
    version integer DEFAULT 1 NOT NULL,
    deleted integer DEFAULT 0 NOT NULL,
    flat_rate numeric(22,10),
    conn_charge numeric(22,10),
    scaled_rate numeric(22,10),
    rate_plan integer,
    created_date timestamp without time zone NOT NULL,
    valid_from date NOT NULL,
    valid_to date,
    last_updated_date date NOT NULL,
    rate_type character varying(100),
    entity_id integer
);


ALTER TABLE public.rate OWNER TO openbrm_demo;

--
-- TOC entry 364 (class 1259 OID 265273)
-- Name: rate_dependee; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE rate_dependee (
    id integer NOT NULL,
    currency_id integer,
    min_balance numeric(10,2),
    max_balance numeric(10,2),
    dependency_type smallint,
    optlock integer NOT NULL
);


ALTER TABLE public.rate_dependee OWNER TO openbrm_demo;

--
-- TOC entry 365 (class 1259 OID 265276)
-- Name: rate_dependency_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE rate_dependency_type (
    id integer NOT NULL,
    type character varying(50) NOT NULL
);


ALTER TABLE public.rate_dependency_type OWNER TO openbrm_demo;

--
-- TOC entry 366 (class 1259 OID 265279)
-- Name: rating_event_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE rating_event_type (
    id integer NOT NULL,
    entity_id integer NOT NULL,
    event_name character varying(60) DEFAULT NULL::character varying,
    optlock integer NOT NULL
);


ALTER TABLE public.rating_event_type OWNER TO openbrm_demo;

--
-- TOC entry 367 (class 1259 OID 265283)
-- Name: rating_unit; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE rating_unit (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    entity_id integer NOT NULL,
    price_unit_name character varying(50),
    increment_unit_name character varying(50),
    increment_unit_quantity numeric(22,10),
    can_be_deleted boolean DEFAULT true,
    optlock integer NOT NULL
);


ALTER TABLE public.rating_unit OWNER TO openbrm_demo;

--
-- TOC entry 368 (class 1259 OID 265287)
-- Name: recent_item; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE recent_item (
    id integer NOT NULL,
    type character varying(255) NOT NULL,
    object_id integer NOT NULL,
    user_id integer NOT NULL,
    version integer NOT NULL
);


ALTER TABLE public.recent_item OWNER TO openbrm_demo;

--
-- TOC entry 369 (class 1259 OID 265290)
-- Name: report; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE report (
    id integer NOT NULL,
    type_id integer NOT NULL,
    name character varying(255) NOT NULL,
    file_name character varying(500) NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.report OWNER TO openbrm_demo;

--
-- TOC entry 370 (class 1259 OID 265296)
-- Name: report_parameter; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE report_parameter (
    id integer NOT NULL,
    report_id integer NOT NULL,
    dtype character varying(10) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.report_parameter OWNER TO openbrm_demo;

--
-- TOC entry 371 (class 1259 OID 265299)
-- Name: report_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE report_type (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.report_type OWNER TO openbrm_demo;

--
-- TOC entry 372 (class 1259 OID 265302)
-- Name: reseller_entityid_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE reseller_entityid_map (
    entity_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.reseller_entityid_map OWNER TO openbrm_demo;

--
-- TOC entry 373 (class 1259 OID 265305)
-- Name: reserved_amounts; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE reserved_amounts (
    id integer NOT NULL,
    session_id integer,
    ts_created timestamp without time zone,
    currency_id integer,
    reserved_amount numeric(22,10),
    item_id integer,
    data text,
    quantity numeric(22,10)
);


ALTER TABLE public.reserved_amounts OWNER TO openbrm_demo;

--
-- TOC entry 374 (class 1259 OID 265311)
-- Name: reset_password_code; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE reset_password_code (
    base_user_id integer NOT NULL,
    date_created timestamp without time zone,
    token character varying(32) NOT NULL,
    new_password character varying(40)
);


ALTER TABLE public.reset_password_code OWNER TO openbrm_demo;

--
-- TOC entry 375 (class 1259 OID 265314)
-- Name: role; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE role (
    id integer NOT NULL,
    entity_id integer,
    role_type_id integer
);


ALTER TABLE public.role OWNER TO openbrm_demo;

--
-- TOC entry 376 (class 1259 OID 265317)
-- Name: route; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE route (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    table_name character varying(50) NOT NULL,
    entity_id integer NOT NULL,
    optlock integer NOT NULL,
    root_table boolean DEFAULT false,
    output_field_name character varying(150),
    default_route character varying(255),
    route_table boolean DEFAULT false
);


ALTER TABLE public.route OWNER TO openbrm_demo;

--
-- TOC entry 377 (class 1259 OID 265325)
-- Name: rum_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE rum_map (
    id integer NOT NULL,
    price_group character varying(45) NOT NULL,
    step integer NOT NULL,
    price_model character varying(45) NOT NULL,
    rum character varying(45) NOT NULL,
    resource character varying(45) NOT NULL,
    resource_id integer NOT NULL,
    rum_type character varying(45) NOT NULL,
    consume_flag integer NOT NULL,
    deleted integer DEFAULT 0 NOT NULL,
    rummap_plan integer NOT NULL,
    created_date timestamp without time zone NOT NULL,
    last_updated_date date NOT NULL,
    entity_id integer
);


ALTER TABLE public.rum_map OWNER TO openbrm_demo;

--
-- TOC entry 378 (class 1259 OID 265329)
-- Name: rum_type; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE rum_type (
    id integer NOT NULL,
    type character varying(50) NOT NULL
);


ALTER TABLE public.rum_type OWNER TO openbrm_demo;

--
-- TOC entry 379 (class 1259 OID 265332)
-- Name: schedule; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE schedule (
    id integer NOT NULL,
    subject character varying(255) NOT NULL,
    period_id smallint NOT NULL,
    user_id integer,
    status_id smallint NOT NULL,
    created_datetime timestamp without time zone NOT NULL,
    active_since date NOT NULL,
    active_until date NOT NULL,
    date_of_event date,
    last_update_time integer,
    entity_id integer,
    user_name character varying(45) NOT NULL
);


ALTER TABLE public.schedule OWNER TO openbrm_demo;

--
-- TOC entry 380 (class 1259 OID 265335)
-- Name: schedule_action; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE schedule_action (
    id integer NOT NULL,
    schedule_id integer NOT NULL,
    status_id smallint,
    type_id integer,
    plugin_id integer,
    action_period_id smallint
);


ALTER TABLE public.schedule_action OWNER TO openbrm_demo;

--
-- TOC entry 381 (class 1259 OID 265338)
-- Name: schedule_action_param; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE schedule_action_param (
    id integer NOT NULL,
    schedule_action_id integer,
    name character varying(255) DEFAULT NULL::character varying,
    value character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.schedule_action_param OWNER TO openbrm_demo;

--
-- TOC entry 382 (class 1259 OID 265346)
-- Name: scheduler_status; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE scheduler_status (
    id integer NOT NULL,
    type character varying(50) NOT NULL
);


ALTER TABLE public.scheduler_status OWNER TO openbrm_demo;

--
-- TOC entry 383 (class 1259 OID 265349)
-- Name: service; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE service (
    id integer NOT NULL,
    user_id integer NOT NULL,
    login character varying(45) NOT NULL,
    password character varying(100) NOT NULL,
    status_id integer NOT NULL,
    create_datetime timestamp without time zone DEFAULT now() NOT NULL,
    order_id integer NOT NULL,
    order_line_id integer NOT NULL,
    name character varying(45) DEFAULT NULL::character varying,
    service_type character varying(70) DEFAULT NULL::character varying,
    deleted integer DEFAULT 0 NOT NULL,
    optlock integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.service OWNER TO openbrm_demo;

--
-- TOC entry 384 (class 1259 OID 265357)
-- Name: service_alias; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE service_alias (
    id integer NOT NULL,
    service_id integer NOT NULL,
    alias_name character varying(255),
    created_date timestamp without time zone NOT NULL,
    last_updated_date timestamp without time zone,
    deleted integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.service_alias OWNER TO openbrm_demo;

--
-- TOC entry 385 (class 1259 OID 265361)
-- Name: service_feature; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE service_feature (
    id integer NOT NULL,
    service_id integer NOT NULL,
    prov_tag_map_id integer NOT NULL,
    deleted integer,
    parent_id integer NOT NULL,
    level integer NOT NULL,
    status_id integer NOT NULL
);


ALTER TABLE public.service_feature OWNER TO openbrm_demo;

--
-- TOC entry 386 (class 1259 OID 265364)
-- Name: service_feature_info; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE service_feature_info (
    id integer NOT NULL,
    service_feature_id integer NOT NULL,
    parameter character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.service_feature_info OWNER TO openbrm_demo;

--
-- TOC entry 387 (class 1259 OID 265368)
-- Name: service_site; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE service_site (
    id integer NOT NULL,
    service_id integer NOT NULL,
    site_addr text NOT NULL,
    created_date timestamp without time zone NOT NULL,
    last_updated_date timestamp without time zone NOT NULL,
    deleted integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.service_site OWNER TO openbrm_demo;

--
-- TOC entry 388 (class 1259 OID 265375)
-- Name: shortcut; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE shortcut (
    id integer NOT NULL,
    user_id integer NOT NULL,
    controller character varying(255) NOT NULL,
    action character varying(255),
    name character varying(255),
    object_id integer,
    version integer NOT NULL
);


ALTER TABLE public.shortcut OWNER TO openbrm_demo;

--
-- TOC entry 389 (class 1259 OID 265381)
-- Name: support_ticket; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE support_ticket (
    id integer NOT NULL,
    subject character varying(255),
    user_id integer NOT NULL,
    assigned_user_id integer NOT NULL,
    status_id integer NOT NULL,
    created_datetime timestamp without time zone NOT NULL,
    last_modified date NOT NULL
);


ALTER TABLE public.support_ticket OWNER TO openbrm_demo;

--
-- TOC entry 390 (class 1259 OID 265384)
-- Name: sure_tax_txn_log; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE sure_tax_txn_log (
    id integer NOT NULL,
    txn_id character varying(20) NOT NULL,
    txn_type character varying(10) NOT NULL,
    txn_data text NOT NULL,
    txn_date timestamp without time zone NOT NULL,
    resp_trans_id integer,
    request_type character varying(10)
);


ALTER TABLE public.sure_tax_txn_log OWNER TO openbrm_demo;

--
-- TOC entry 391 (class 1259 OID 265390)
-- Name: tab; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE tab (
    id integer NOT NULL,
    message_code character varying(50),
    controller_name character varying(50),
    access_url character varying(50),
    required_role character varying(50),
    version integer NOT NULL,
    default_order integer
);


ALTER TABLE public.tab OWNER TO openbrm_demo;

--
-- TOC entry 392 (class 1259 OID 265393)
-- Name: tab_configuration; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE tab_configuration (
    id integer NOT NULL,
    user_id integer,
    version integer NOT NULL
);


ALTER TABLE public.tab_configuration OWNER TO openbrm_demo;

--
-- TOC entry 393 (class 1259 OID 265396)
-- Name: tab_configuration_tab; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE tab_configuration_tab (
    id integer NOT NULL,
    tab_id integer,
    tab_configuration_id integer,
    display_order integer,
    visible boolean,
    version integer NOT NULL
);


ALTER TABLE public.tab_configuration_tab OWNER TO openbrm_demo;

--
-- TOC entry 394 (class 1259 OID 265399)
-- Name: tax_code; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE tax_code (
    id integer,
    tax_code character varying(60) DEFAULT NULL::character varying,
    country character varying(60) DEFAULT NULL::character varying,
    rate numeric(10,2) DEFAULT NULL::numeric
);


ALTER TABLE public.tax_code OWNER TO openbrm_demo;

--
-- TOC entry 395 (class 1259 OID 265405)
-- Name: ticket_details; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE ticket_details (
    created_datetime timestamp without time zone NOT NULL,
    ticket_id integer NOT NULL,
    ticket_body character varying(255),
    id integer NOT NULL
);


ALTER TABLE public.ticket_details OWNER TO openbrm_demo;

--
-- TOC entry 396 (class 1259 OID 265408)
-- Name: ticket_status; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE ticket_status (
    id integer NOT NULL,
    type character varying(50) NOT NULL
);


ALTER TABLE public.ticket_status OWNER TO openbrm_demo;

--
-- TOC entry 397 (class 1259 OID 265411)
-- Name: uploadcdr; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE uploadcdr (
    name character varying(50),
    date timestamp without time zone NOT NULL,
    status character varying(50),
    type character varying(50),
    id integer NOT NULL
);


ALTER TABLE public.uploadcdr OWNER TO openbrm_demo;

--
-- TOC entry 398 (class 1259 OID 265414)
-- Name: usage_bals; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE usage_bals (
    user_id integer NOT NULL,
    currency_id integer NOT NULL,
    plan_id integer NOT NULL,
    valid_from integer NOT NULL,
    valid_to integer NOT NULL,
    balance double precision
);


ALTER TABLE public.usage_bals OWNER TO openbrm_demo;

--
-- TOC entry 399 (class 1259 OID 265417)
-- Name: usage_monitor; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE usage_monitor (
    id integer NOT NULL,
    resource_id integer NOT NULL,
    thershold smallint NOT NULL,
    entity_id integer NOT NULL
);


ALTER TABLE public.usage_monitor OWNER TO openbrm_demo;

--
-- TOC entry 400 (class 1259 OID 265420)
-- Name: usage_monitor_filter; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE usage_monitor_filter (
    id integer NOT NULL,
    "user" integer,
    used numeric(22,10) DEFAULT NULL::numeric,
    resource_id integer
);


ALTER TABLE public.usage_monitor_filter OWNER TO openbrm_demo;

--
-- TOC entry 401 (class 1259 OID 265424)
-- Name: user_balance; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE user_balance (
    id integer NOT NULL,
    user_id integer,
    active_since date NOT NULL,
    active_until date,
    create_datetime date NOT NULL,
    currency_id integer NOT NULL,
    deleted integer NOT NULL,
    optlock integer NOT NULL,
    balance numeric(10,2),
    order_id integer NOT NULL,
    order_line_id integer NOT NULL
);


ALTER TABLE public.user_balance OWNER TO openbrm_demo;

--
-- TOC entry 402 (class 1259 OID 265427)
-- Name: user_code; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE user_code (
    id integer NOT NULL,
    user_id integer NOT NULL,
    identifier character varying(55) NOT NULL,
    external_ref character varying(50),
    type character varying(50),
    type_desc character varying(250),
    valid_from date,
    valid_to date
);


ALTER TABLE public.user_code OWNER TO openbrm_demo;

--
-- TOC entry 403 (class 1259 OID 265430)
-- Name: user_code_link; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE user_code_link (
    id integer NOT NULL,
    user_code_id integer NOT NULL,
    object_type character varying(50) NOT NULL,
    object_id integer
);


ALTER TABLE public.user_code_link OWNER TO openbrm_demo;

--
-- TOC entry 404 (class 1259 OID 265433)
-- Name: user_credit_card_map_id_seq; Type: SEQUENCE; Schema: public; Owner: openbrm_demo
--

CREATE SEQUENCE user_credit_card_map_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_credit_card_map_id_seq OWNER TO openbrm_demo;

--
-- TOC entry 405 (class 1259 OID 265435)
-- Name: user_credit_card_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE user_credit_card_map (
    user_id integer,
    credit_card_id integer,
    id integer DEFAULT nextval('user_credit_card_map_id_seq'::regclass)
);


ALTER TABLE public.user_credit_card_map OWNER TO openbrm_demo;

--
-- TOC entry 406 (class 1259 OID 265439)
-- Name: user_device; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE user_device (
    id integer NOT NULL,
    user_id integer NOT NULL,
    device_id integer NOT NULL,
    created_date timestamp without time zone NOT NULL,
    last_updated_date timestamp without time zone,
    order_id integer,
    order_line_id integer,
    telephone_number character varying(60),
    ip character varying(60),
    deleted integer DEFAULT 0 NOT NULL,
    optlock integer NOT NULL,
    ext_id1 character varying(60),
    status_id integer NOT NULL
);


ALTER TABLE public.user_device OWNER TO openbrm_demo;

--
-- TOC entry 407 (class 1259 OID 265443)
-- Name: user_password_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE user_password_map (
    id integer NOT NULL,
    base_user_id integer NOT NULL,
    date_created timestamp without time zone NOT NULL,
    new_password character varying(1024) NOT NULL
);


ALTER TABLE public.user_password_map OWNER TO openbrm_demo;

--
-- TOC entry 408 (class 1259 OID 265449)
-- Name: user_role_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE user_role_map (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.user_role_map OWNER TO openbrm_demo;

--
-- TOC entry 409 (class 1259 OID 265452)
-- Name: user_status; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE user_status (
    id integer NOT NULL,
    can_login smallint
);


ALTER TABLE public.user_status OWNER TO openbrm_demo;

--
-- TOC entry 410 (class 1259 OID 265455)
-- Name: validation_rule; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE validation_rule (
    id integer NOT NULL,
    rule_type character varying(25) NOT NULL,
    enabled boolean,
    optlock integer NOT NULL
);


ALTER TABLE public.validation_rule OWNER TO openbrm_demo;

--
-- TOC entry 411 (class 1259 OID 265458)
-- Name: validation_rule_attributes; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE validation_rule_attributes (
    validation_rule_id integer NOT NULL,
    attribute_name character varying(255) NOT NULL,
    attribute_value character varying(255)
);


ALTER TABLE public.validation_rule_attributes OWNER TO openbrm_demo;

--
-- TOC entry 412 (class 1259 OID 265464)
-- Name: voucher; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE voucher (
    id integer NOT NULL,
    created_datetime timestamp without time zone NOT NULL,
    last_modified timestamp without time zone,
    status_id integer NOT NULL,
    entity_id integer NOT NULL,
    serial_no integer NOT NULL,
    pin_code character varying(60) NOT NULL,
    batch_id character varying(60) NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.voucher OWNER TO openbrm_demo;

--
-- TOC entry 413 (class 1259 OID 265467)
-- Name: world_zone_map; Type: TABLE; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE TABLE world_zone_map (
    map_group character varying(10) DEFAULT NULL::character varying,
    tier_code character varying(10) DEFAULT NULL::character varying,
    world_zone character varying(10) DEFAULT NULL::character varying,
    id integer
);


ALTER TABLE public.world_zone_map OWNER TO openbrm_demo;

--
-- TOC entry 3783 (class 0 OID 264482)
-- Dependencies: 171
-- Data for Name: account_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY account_type (id, credit_limit, invoice_design, invoice_delivery_method_id, date_created, credit_notification_limit1, credit_notification_limit2, language_id, entity_id, currency_id, optlock, main_subscript_order_period_id, next_invoice_day_of_period, notification_ait_id) FROM stdin;
100	0.0000000000	\N	\N	2018-10-25 17:20:54.325	\N	\N	\N	10	\N	0	200	1	\N
101	20000.0000000000		1	2018-10-25 17:28:26.657	18000.0000000000	20000.0000000000	1	10	1	1	200	1	10
\.


--
-- TOC entry 3784 (class 0 OID 264485)
-- Dependencies: 172
-- Data for Name: account_type_price; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY account_type_price (account_type_id, create_datetime, price_expiry_date) FROM stdin;
\.


--
-- TOC entry 3785 (class 0 OID 264488)
-- Dependencies: 173
-- Data for Name: ach; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY ach (id, user_id, aba_routing, bank_account, account_type, bank_name, account_name, optlock, gateway_key) FROM stdin;
\.


--
-- TOC entry 3786 (class 0 OID 264491)
-- Dependencies: 174
-- Data for Name: advance_rated_cdr_record; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY advance_rated_cdr_record (id, process_id, record_id, order_id, user_id, invoice_id, calling_number, destination_number, call_start_date, call_end_date, duration, cost, product_id, destination_descr, rate_id, call_type, device_id, cdr_source) FROM stdin;
\.


--
-- TOC entry 3787 (class 0 OID 264506)
-- Dependencies: 175
-- Data for Name: ageing_entity_step; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY ageing_entity_step (id, entity_id, status_id, days, optlock, retry_payment, suspend, send_notification) FROM stdin;
\.


--
-- TOC entry 3788 (class 0 OID 264512)
-- Dependencies: 176
-- Data for Name: asset; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY asset (id, identifier, create_datetime, status_id, entity_id, deleted, item_id, notes, optlock, group_id, order_line_id, global) FROM stdin;
\.


--
-- TOC entry 3789 (class 0 OID 264519)
-- Dependencies: 177
-- Data for Name: asset_assignment; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY asset_assignment (id, asset_id, order_line_id, start_datetime, end_datetime) FROM stdin;
\.


--
-- TOC entry 3790 (class 0 OID 264522)
-- Dependencies: 178
-- Data for Name: asset_entity_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY asset_entity_map (asset_id, entity_id) FROM stdin;
\.


--
-- TOC entry 3791 (class 0 OID 264525)
-- Dependencies: 179
-- Data for Name: asset_meta_field_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY asset_meta_field_map (asset_id, meta_field_value_id) FROM stdin;
\.


--
-- TOC entry 3792 (class 0 OID 264528)
-- Dependencies: 180
-- Data for Name: asset_reservation; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY asset_reservation (id, user_id, creator_user_id, asset_id, start_date, end_date, optlock) FROM stdin;
\.


--
-- TOC entry 3793 (class 0 OID 264531)
-- Dependencies: 181
-- Data for Name: asset_status; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY asset_status (id, item_type_id, is_default, is_order_saved, is_available, deleted, optlock, is_internal) FROM stdin;
1	\N	0	0	0	0	1	1
\.


--
-- TOC entry 3794 (class 0 OID 264535)
-- Dependencies: 182
-- Data for Name: asset_transition; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY asset_transition (id, create_datetime, previous_status_id, new_status_id, asset_id, user_id, assigned_to_id) FROM stdin;
\.


--
-- TOC entry 3795 (class 0 OID 264538)
-- Dependencies: 183
-- Data for Name: base_user; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY base_user (id, entity_id, password, deleted, language_id, status_id, subscriber_status, currency_id, create_datetime, last_status_change, last_login, user_name, failed_attempts, optlock, change_password_date, encryption_scheme, account_locked_time, account_disabled_date) FROM stdin;
10	10	$2a$10$gNwEehQuLk2dw5Sao.uIfeJ06HJSsG0aDvr63fpwKGEm4Di5neE1y	0	1	1	9	1	2018-10-25 17:20:53.559	\N	2018-10-29 14:57:28.489	admin	0	4	\N	6	\N	\N
\.


--
-- TOC entry 3796 (class 0 OID 264547)
-- Dependencies: 184
-- Data for Name: batch_job_execution; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY batch_job_execution (job_execution_id, version, job_instance_id, create_time, start_time, end_time, status, exit_code, exit_message, last_updated, job_configuration_location) FROM stdin;
\.


--
-- TOC entry 3797 (class 0 OID 264553)
-- Dependencies: 185
-- Data for Name: batch_job_execution_context; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY batch_job_execution_context (job_execution_id, short_context, serialized_context) FROM stdin;
\.


--
-- TOC entry 3798 (class 0 OID 264559)
-- Dependencies: 186
-- Data for Name: batch_job_execution_params; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY batch_job_execution_params (job_execution_id, type_cd, key_name, string_val, date_val, long_val, double_val, identifying) FROM stdin;
\.


--
-- TOC entry 4034 (class 0 OID 0)
-- Dependencies: 187
-- Name: batch_job_execution_seq; Type: SEQUENCE SET; Schema: public; Owner: openbrm_demo
--

SELECT pg_catalog.setval('batch_job_execution_seq', 1, false);


--
-- TOC entry 3800 (class 0 OID 264564)
-- Dependencies: 188
-- Data for Name: batch_job_instance; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY batch_job_instance (job_instance_id, version, job_name, job_key) FROM stdin;
\.


--
-- TOC entry 4035 (class 0 OID 0)
-- Dependencies: 189
-- Name: batch_job_seq; Type: SEQUENCE SET; Schema: public; Owner: openbrm_demo
--

SELECT pg_catalog.setval('batch_job_seq', 1, false);


--
-- TOC entry 3802 (class 0 OID 264569)
-- Dependencies: 190
-- Data for Name: batch_process_info; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY batch_process_info (id, process_id, job_execution_id, total_failed_users, total_successful_users, optlock) FROM stdin;
\.


--
-- TOC entry 3803 (class 0 OID 264572)
-- Dependencies: 191
-- Data for Name: batch_step_execution; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY batch_step_execution (step_execution_id, version, step_name, job_execution_id, start_time, end_time, status, commit_count, read_count, filter_count, write_count, read_skip_count, write_skip_count, process_skip_count, rollback_count, exit_code, exit_message, last_updated) FROM stdin;
\.


--
-- TOC entry 3804 (class 0 OID 264578)
-- Dependencies: 192
-- Data for Name: batch_step_execution_context; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY batch_step_execution_context (step_execution_id, short_context, serialized_context) FROM stdin;
\.


--
-- TOC entry 4036 (class 0 OID 0)
-- Dependencies: 193
-- Name: batch_step_execution_seq; Type: SEQUENCE SET; Schema: public; Owner: openbrm_demo
--

SELECT pg_catalog.setval('batch_step_execution_seq', 1, false);


--
-- TOC entry 3806 (class 0 OID 264586)
-- Dependencies: 194
-- Data for Name: billing_process; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY billing_process (id, entity_id, billing_date, period_unit_id, period_value, is_review, paper_invoice_batch_id, retries_to_do, optlock) FROM stdin;
\.


--
-- TOC entry 3807 (class 0 OID 264590)
-- Dependencies: 195
-- Data for Name: billing_process_configuration; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY billing_process_configuration (id, entity_id, next_run_date, generate_report, retries, days_for_retry, days_for_report, review_status, due_date_unit_id, due_date_value, df_fm, only_recurring, invoice_date_process, optlock, maximum_periods, auto_payment_application, period_unit_id, last_day_of_month, prorating_type) FROM stdin;
100	10	2018-09-01	0	0	\N	3	2	1	1	\N	1	0	1	99	1	1	f	PRORATING_AUTO_OFF
\.


--
-- TOC entry 3808 (class 0 OID 264599)
-- Dependencies: 196
-- Data for Name: billing_process_failed_user; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY billing_process_failed_user (id, batch_process_id, user_id, optlock) FROM stdin;
\.


--
-- TOC entry 3809 (class 0 OID 264602)
-- Dependencies: 197
-- Data for Name: blacklist; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY blacklist (id, entity_id, create_datetime, type, source, credit_card, credit_card_id, contact_id, user_id, optlock, meta_field_value_id) FROM stdin;
\.


--
-- TOC entry 3810 (class 0 OID 264605)
-- Dependencies: 198
-- Data for Name: breadcrumb; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY breadcrumb (id, user_id, controller, action, name, object_id, version, description) FROM stdin;
76	10	product	list	\N	102	0	\N
77	10	config	index	\N	\N	0	\N
78	10	plugin	show	\N	33	0	\N
79	10	plugin	list	\N	\N	0	\N
80	10	plugin	plugins	\N	16	0	\N
81	10	plugin	show	\N	34	0	\N
82	10	plugin	edit	\N	34	0	\N
83	10	plugin	show	\N	34	0	\N
84	10	customer	list	\N	\N	0	\N
\.


--
-- TOC entry 3811 (class 0 OID 264611)
-- Dependencies: 199
-- Data for Name: bulk_notification_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY bulk_notification_type (id, type) FROM stdin;
1	SMS
2	Email
\.


--
-- TOC entry 3812 (class 0 OID 264614)
-- Dependencies: 200
-- Data for Name: bundle_meta_field_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY bundle_meta_field_map (bundle_id, meta_field_value_id) FROM stdin;
\.


--
-- TOC entry 3813 (class 0 OID 264617)
-- Dependencies: 201
-- Data for Name: c_rate; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY c_rate (id, prefix, destination, version, deleted, flat_rate, conn_charge, scaled_rate, rate_plan, call_type, created_date, valid_from, valid_to, last_updated_date, rate_type, entity_id) FROM stdin;
\.


--
-- TOC entry 3814 (class 0 OID 264622)
-- Dependencies: 202
-- Data for Name: cdrentries; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY cdrentries (id, accountcode, src, dst, dcontext, clid, channel, dstchannel, lastapp, lastdatat, start_time, answer, end_time, duration, billsec, disposition, amaflags, userfield, ts) FROM stdin;
\.


--
-- TOC entry 3815 (class 0 OID 264625)
-- Dependencies: 203
-- Data for Name: charge_sessions; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY charge_sessions (id, user_id, session_token, ts_started, ts_last_access, carried_units) FROM stdin;
\.


--
-- TOC entry 3816 (class 0 OID 264628)
-- Dependencies: 204
-- Data for Name: charge_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY charge_type (id, type) FROM stdin;
\.


--
-- TOC entry 3817 (class 0 OID 264631)
-- Dependencies: 205
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY contact (id, organization_name, street_addres1, street_addres2, city, state_province, postal_code, country_code, last_name, first_name, person_initial, person_title, phone_country_code, phone_area_code, phone_phone_number, fax_country_code, fax_area_code, fax_phone_number, email, create_datetime, deleted, notification_include, user_id, optlock) FROM stdin;
100	openbrm	panama		Hyderabad	telangana	500079	IN	admin	admin	\N	\N	155	67678	88	\N	\N	\N	admin@gmail.com	2018-10-25 17:20:53.309	0	\N	\N	0
101	openbrm	panama		Hyderabad	telangana	500079	IN	admin	admin	\N	\N	155	67678	88	\N	\N	\N	admin@gmail.com	2018-10-25 17:20:53.809	0	1	10	0
\.


--
-- TOC entry 3818 (class 0 OID 264639)
-- Dependencies: 206
-- Data for Name: contact_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY contact_map (id, contact_id, type_id, table_id, foreign_id, optlock) FROM stdin;
678000	100	\N	5	10	0
678001	101	\N	10	10	0
\.


--
-- TOC entry 3819 (class 0 OID 264642)
-- Dependencies: 207
-- Data for Name: contact_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY contact_type (id, entity_id, is_primary, optlock) FROM stdin;
1	\N	\N	0
\.


--
-- TOC entry 3820 (class 0 OID 264645)
-- Dependencies: 208
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY country (id, code) FROM stdin;
1	AF
2	AL
3	DZ
4	AS
5	AD
6	AO
7	AI
8	AQ
9	AG
10	AR
11	AM
12	AW
13	AU
14	AT
15	AZ
16	BS
17	BH
18	BD
19	BB
20	BY
21	BE
22	BZ
23	BJ
24	BM
25	BT
26	BO
27	BA
28	BW
29	BV
30	BR
31	IO
32	BN
33	BG
34	BF
35	BI
36	KH
37	CM
38	CA
39	CV
40	KY
41	CF
42	TD
43	CL
44	CN
45	CX
46	CC
47	CO
48	KM
49	CG
50	CK
51	CR
52	CI
53	HR
54	CU
55	CY
56	CZ
57	CD
58	DK
59	DJ
60	DM
61	DO
62	TP
63	EC
64	EG
65	SV
66	GQ
67	ER
68	EE
69	ET
70	FK
71	FO
72	FJ
73	FI
74	FR
75	GF
76	PF
77	TF
78	GA
79	GM
80	GE
81	DE
82	GH
83	GI
84	GR
85	GL
86	GD
87	GP
88	GU
89	GT
90	GN
91	GW
92	GY
93	HT
94	HM
95	HN
96	HK
97	HU
98	IS
99	IN
100	ID
101	IR
102	IQ
103	IE
104	IL
105	IT
106	JM
107	JP
108	JO
109	KZ
110	KE
111	KI
112	KR
113	KW
114	KG
115	LA
116	LV
117	LB
118	LS
119	LR
120	LY
121	LI
122	LT
123	LU
124	MO
125	MK
126	MG
127	MW
128	MY
129	MV
130	ML
131	MT
132	MH
133	MQ
134	MR
135	MU
136	YT
137	MX
138	FM
139	MD
140	MC
141	MN
142	MS
143	MA
144	MZ
145	MM
146	NA
147	NR
148	NP
149	NL
150	AN
151	NC
152	NZ
153	NI
154	NE
155	NG
156	NU
157	NF
158	KP
159	MP
160	NO
161	OM
162	PK
163	PW
164	PA
165	PG
166	PY
167	PE
168	PH
169	PN
170	PL
171	PT
172	PR
173	QA
174	RE
175	RO
176	RU
177	RW
178	WS
179	SM
180	ST
181	SA
182	SN
183	YU
184	SC
185	SL
186	SG
187	SK
188	SI
189	SB
190	SO
191	ZA
192	GS
193	ES
194	LK
195	SH
196	KN
197	LC
198	PM
199	VC
200	SD
201	SR
202	SJ
203	SZ
204	SE
205	CH
206	SY
207	TW
208	TJ
209	TZ
210	TH
211	TG
212	TK
213	TO
214	TT
215	TN
216	TR
217	TM
218	TC
219	TV
220	UG
221	UA
222	AE
223	UK
224	US
225	UM
226	UY
227	UZ
228	VU
229	VA
230	VE
231	VN
232	VG
233	VI
234	WF
235	YE
236	ZM
237	ZW
\.


--
-- TOC entry 3821 (class 0 OID 264648)
-- Dependencies: 209
-- Data for Name: credit_card; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY credit_card (id, cc_number, cc_number_plain, cc_expiry, name, cc_type, deleted, gateway_key, optlock) FROM stdin;
\.


--
-- TOC entry 3822 (class 0 OID 264652)
-- Dependencies: 210
-- Data for Name: currency; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY currency (id, symbol, code, country_code, optlock) FROM stdin;
2	C$	CAD	CA	0
3	&#8364;	EUR	EU	0
4	&#165;	JPY	JP	0
5	&#163;	GBP	UK	0
6	&#8361;	KRW	KR	0
7	Sf	CHF	CH	0
8	SeK	SEK	SE	0
9	S$	SGD	SG	0
10	M$	MYR	MY	0
11	$	AUD	AU	0
10000	IDR	IDR	IN	0
10001	ITR	ITR	IN	0
10002	ISR	ISR	IN	0
1	US$	USD	US	1
\.


--
-- TOC entry 3823 (class 0 OID 264655)
-- Dependencies: 211
-- Data for Name: currency_entity_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY currency_entity_map (currency_id, entity_id) FROM stdin;
1	10
\.


--
-- TOC entry 3824 (class 0 OID 264658)
-- Dependencies: 212
-- Data for Name: currency_exchange; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY currency_exchange (id, entity_id, currency_id, rate, create_datetime, optlock, valid_since) FROM stdin;
1	0	2	1.3250000000	2004-03-09 00:00:00	1	1970-01-01
2	0	3	0.8118000000	2004-03-09 00:00:00	1	1970-01-01
3	0	4	111.4000000000	2004-03-09 00:00:00	1	1970-01-01
4	0	5	0.5479000000	2004-03-09 00:00:00	1	1970-01-01
5	0	6	1171.0000000000	2004-03-09 00:00:00	1	1970-01-01
6	0	7	1.2300000000	2004-07-06 00:00:00	1	1970-01-01
7	0	8	7.4700000000	2004-07-06 00:00:00	1	1970-01-01
10	0	9	1.6800000000	2004-10-12 00:00:00	1	1970-01-01
11	0	10	3.8000000000	2004-10-12 00:00:00	1	1970-01-01
12	0	11	1.2880000000	2007-01-25 00:00:00	1	1970-01-01
13	10	10000	1.0000000000	2012-10-31 16:14:59	0	1970-01-01
14	0	10000	1.0000000000	2012-10-31 16:14:59	0	1970-01-01
15	1	10001	1.0000000000	2012-10-23 06:37:43	0	1970-01-01
16	0	10001	1.0000000000	2012-10-23 06:37:43	0	1970-01-01
17	1	10002	1.0000000000	2012-10-23 06:37:43	0	1970-01-01
18	0	10002	1.0000000000	2012-10-23 06:37:43	0	1970-01-01
\.


--
-- TOC entry 3825 (class 0 OID 264662)
-- Dependencies: 213
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY customer (id, user_id, partner_id, referral_fee_paid, invoice_delivery_method_id, auto_payment_type, due_date_unit_id, due_date_value, df_fm, parent_id, is_parent, exclude_aging, invoice_child, optlock, dynamic_balance, credit_limit, auto_recharge, use_parent_pricing, main_subscript_order_period_id, next_invoice_day_of_period, next_inovice_date, account_type_id, invoice_design, credit_notification_limit1, credit_notification_limit2, recharge_threshold, monthly_limit, current_monthly_amount, current_month) FROM stdin;
\.


--
-- TOC entry 3826 (class 0 OID 264666)
-- Dependencies: 214
-- Data for Name: customer_account_info_type_timeline; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY customer_account_info_type_timeline (id, customer_id, account_info_type_id, meta_field_value_id, effective_date) FROM stdin;
\.


--
-- TOC entry 3827 (class 0 OID 264669)
-- Dependencies: 215
-- Data for Name: customer_docs; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY customer_docs (id, user_id, document_name, file_name, content_type, doc_data, created_datetime, mod_date, deleted) FROM stdin;
\.


--
-- TOC entry 3828 (class 0 OID 264677)
-- Dependencies: 216
-- Data for Name: customer_meta_field_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY customer_meta_field_map (customer_id, meta_field_value_id) FROM stdin;
\.


--
-- TOC entry 3829 (class 0 OID 264680)
-- Dependencies: 217
-- Data for Name: customer_notes; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY customer_notes (id, note_title, note_content, creation_time, entity_id, user_id, customer_id) FROM stdin;
\.


--
-- TOC entry 3830 (class 0 OID 264686)
-- Dependencies: 218
-- Data for Name: data_table_query; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY data_table_query (id, name, route_id, global, root_entry_id, user_id, optlock) FROM stdin;
\.


--
-- TOC entry 3831 (class 0 OID 264689)
-- Dependencies: 219
-- Data for Name: data_table_query_entry; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY data_table_query_entry (id, route_id, columns, next_entry_id, optlock) FROM stdin;
\.


--
-- TOC entry 3832 (class 0 OID 264692)
-- Dependencies: 220
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase) FROM stdin;
1337623084753-1	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:48.573	1	EXECUTED	7:8922bfebfc70cb70fd4684f82e90ecc0	createTable		\N	3.2.2
1337623084753-2	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:48.636	2	EXECUTED	7:4543e51971682f746629b64f60f25424	createTable		\N	3.2.2
1337623084753-3	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:48.683	3	EXECUTED	7:58002b5f2f43d673944e6db319c95e25	createTable		\N	3.2.2
1337623084753-4	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:48.745	4	EXECUTED	7:65e4f1f41f33afa3af2aaf9f11fe894a	createTable		\N	3.2.2
1337623084753-5	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:48.823	5	EXECUTED	7:f5069e51fd697b6062afaf2f78e5ecbb	createTable		\N	3.2.2
1337623084753-6	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:48.886	6	EXECUTED	7:76ea4196cc9ae7f5e4b05d5b2e905b45	createTable		\N	3.2.2
1337623084753-7	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:48.98	7	EXECUTED	7:1c468637211181df1494d3c2fffde1df	createTable		\N	3.2.2
1337623084753-8	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.042	8	EXECUTED	7:cead7dc80be6db8de4b92d14ed7b512b	createTable		\N	3.2.2
1337623084753-9	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.183	9	EXECUTED	7:485c707222e5a3a59e85a58dc72deaa8	createTable		\N	3.2.2
1337623084753-10	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.261	10	EXECUTED	7:2475e48c7730001b948dc413a3673707	createTable		\N	3.2.2
1337623084753-11	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.323	11	EXECUTED	7:0714008a0e79b913249812348bd92812	createTable		\N	3.2.2
1337623084753-12	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.355	12	EXECUTED	7:a22dc68a8e1cc035fc8e6b98c243afa2	createTable		\N	3.2.2
1337623084753-13	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.402	13	EXECUTED	7:91dad5ca3c80ba7f0c86cd403ad1f5a1	createTable		\N	3.2.2
1337623084753-14	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.464	14	EXECUTED	7:bb023c716e85f3e5a6ecc18addf74c93	createTable		\N	3.2.2
1337623084753-15	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.48	15	EXECUTED	7:b3dc34c78a6d99215bd55e3cf9f024a5	createTable		\N	3.2.2
1337623084753-16	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.558	16	EXECUTED	7:ccbc91b77accf90af85fe7a7f1e8eb50	createTable		\N	3.2.2
1337623084753-17	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.667	17	EXECUTED	7:eeaa643a00b54017268d1f7d2d685561	createTable		\N	3.2.2
1337623084753-18	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.683	18	EXECUTED	7:b86cc87b63206be74e0bf0810603b4b9	createTable		\N	3.2.2
1337623084753-20	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.73	19	EXECUTED	7:875167c97cb7a74f69518cce3669b6bf	createTable		\N	3.2.2
1337623084753-21	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.73	20	EXECUTED	7:e3a0537c1e4c52573487d9a174ea5868	createTable		\N	3.2.2
1337623084753-22	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.745	21	EXECUTED	7:ad866e4480035e2d3611d758b1aae457	createTable		\N	3.2.2
1337623084753-23	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.745	22	EXECUTED	7:4a31d34d4f9622f1d949707fd6f5af9a	createTable		\N	3.2.2
1337623084753-24	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.792	23	EXECUTED	7:841d8cd76ebe7329c4a5eb65f1b75215	createTable		\N	3.2.2
1337623084753-25	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.839	24	EXECUTED	7:d069497f8f0f4d5633a95960dae1c927	createTable		\N	3.2.2
1337623084753-26	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.933	25	EXECUTED	7:b72e670cb94ade1967424839e713c7a6	createTable		\N	3.2.2
1337623084753-27	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:49.98	26	EXECUTED	7:f0321e258497e2fcbf1837269cf57697	createTable		\N	3.2.2
1337623084753-28	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.027	27	EXECUTED	7:9ac47f41854098201d8e3327bab3aaa9	createTable		\N	3.2.2
1337623084753-29	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.136	28	EXECUTED	7:9a6a68eac5722813ddb11fb3f5b5c7cf	createTable		\N	3.2.2
1337623084753-30	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.23	29	EXECUTED	7:c5ff89ba8a44fa1d04755fbe4d9aaba0	createTable		\N	3.2.2
1337623084753-31	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.245	30	EXECUTED	7:f08d28a18f9bd6f14e882e433112d7c8	createTable		\N	3.2.2
1337623084753-32	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.308	31	EXECUTED	7:df80d416e3a998ec1c9367b6a150e910	createTable		\N	3.2.2
1337623084753-33	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.386	32	EXECUTED	7:3e5399c547a512022ed5924ab230808c	createTable		\N	3.2.2
1337623084753-34	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.433	33	EXECUTED	7:4de2c4d22bbb5f42b88b5c865fab7eb6	createTable		\N	3.2.2
1337623084753-35	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.605	34	EXECUTED	7:07262c39b56be415cf7c37fe63d42a69	createTable		\N	3.2.2
1337623084753-36	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.683	35	EXECUTED	7:3b091de78f648afe18f9e9ad3e66413d	createTable		\N	3.2.2
1337623084753-37	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.824	36	EXECUTED	7:ed8dd86cf5fbfb408f6181aedc2cfca8	createTable		\N	3.2.2
1337623084753-38	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.871	37	EXECUTED	7:0fcd69c5133c7417e57410ad49c90c14	createTable		\N	3.2.2
1337623084753-39	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.871	38	EXECUTED	7:0cf8dfbe640acc6dbc3bc62c3a90561b	createTable		\N	3.2.2
1337623084753-40	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.933	39	EXECUTED	7:1caca3a71ad2afbd8ccd8f830215c6a9	createTable		\N	3.2.2
1337623084753-41	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.933	40	EXECUTED	7:aefc2c13166967dbade6e629788be8f8	createTable		\N	3.2.2
1337623084753-43	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.98	41	EXECUTED	7:78fa99c7075e71184d35caa2a64e1323	createTable		\N	3.2.2
1337623084753-44	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.98	42	EXECUTED	7:e71d4833b5fd6f8c33fb4afdac2f6602	createTable		\N	3.2.2
1337623084753-45	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.996	43	EXECUTED	7:dd8d274a4d158e81346dd07dbae9e4dc	createTable		\N	3.2.2
1337623084753-46	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:50.996	44	EXECUTED	7:b27b564b5e45ff66688f7b59be7da0ae	createTable		\N	3.2.2
1337623084753-47	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:51.043	45	EXECUTED	7:fd1da3e1a613390da6c9c50de7ec8dd1	createTable		\N	3.2.2
1337623084753-48	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:51.105	46	EXECUTED	7:28e24c30a1fcf81bd315d1cc66162b5b	createTable		\N	3.2.2
1337623084753-49	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:51.105	47	EXECUTED	7:dff7780f47c39c01843ce852439b56b2	createTable		\N	3.2.2
1337623084753-56	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:51.185	48	EXECUTED	7:cfeb764e680a99849337a34ac178dbc7	createTable		\N	3.2.2
1337623084753-57	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:51.233	49	EXECUTED	7:c3c22ccb5d4b12a2fea500373e60d062	createTable		\N	3.2.2
1337623084753-58	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:51.288	50	EXECUTED	7:13d5847e8c5ad95b0fc5726d373c88fb	createTable		\N	3.2.2
1337623084753-59	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:51.354	51	EXECUTED	7:4198e76fefd9fa386fb430303d822a67	createTable		\N	3.2.2
1337623084753-60	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:51.41	52	EXECUTED	7:fc642db573ffdc1e618a3c8687842080	createTable		\N	3.2.2
1337623084753-61	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:51.508	53	EXECUTED	7:2f03831363dde29a1d2ff07013c59977	createTable		\N	3.2.2
1337623084753-62	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:51.6	54	EXECUTED	7:73cbcc198f3501f7806a785f3d209bbc	createTable		\N	3.2.2
1337623084753-63	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:51.662	55	EXECUTED	7:d74efc0344146b6b79f3b7a2c1fd379f	createTable		\N	3.2.2
1337623084753-64	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:51.725	56	EXECUTED	7:a7df71b28261768069a3b4b85f9c8eee	createTable		\N	3.2.2
1337623084753-65	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:51.772	57	EXECUTED	7:cf70309e8abd8b593c5de9baf45167fa	createTable		\N	3.2.2
1337623084753-66	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:51.912	58	EXECUTED	7:bd24286b5bd6410a6e61920a11d9864b	createTable		\N	3.2.2
1337623084753-67	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:51.959	59	EXECUTED	7:25caddd42f70cd1fb8578934ce32151a	createTable		\N	3.2.2
1337623084753-68	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:51.959	60	EXECUTED	7:ba7faa6025e643508a1356a016a5441a	createTable		\N	3.2.2
1337623084753-69	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.022	61	EXECUTED	7:4f304ef3ad2349533a4bf8dcccdf81c4	createTable		\N	3.2.2
1337623084753-70	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.069	62	EXECUTED	7:e9a90e7c10705101a981030ce0a5d182	createTable		\N	3.2.2
1337623084753-71	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.131	63	EXECUTED	7:d6f47d891ec3566bf5fa9d0781164aaf	createTable		\N	3.2.2
1337623084753-72	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.209	64	EXECUTED	7:8bb31b2fcc7078088b1d9549003c7542	createTable		\N	3.2.2
1337623084753-73	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.225	65	EXECUTED	7:d9572ef7e927f18157afd29cd88599f4	createTable		\N	3.2.2
1337623084753-74	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.272	66	EXECUTED	7:d3b6218392df92ad908a3c93b13d283f	createTable		\N	3.2.2
1337623084753-75	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.334	67	EXECUTED	7:53b048b2daaae2527524683fa9370126	createTable		\N	3.2.2
1337623084753-76	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.428	68	EXECUTED	7:1dcd25aebd541861664bb25e6a95aeb5	createTable		\N	3.2.2
1337623084753-77	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.522	69	EXECUTED	7:8cc0b8eb3dc4c57bca43fb74fe8ba9f6	createTable		\N	3.2.2
1337623084753-78	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.569	70	EXECUTED	7:faf64042497651dbe58fca13b595121c	createTable		\N	3.2.2
1337623084753-79	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.616	71	EXECUTED	7:8d8395b59d4135177e3e97152321c39d	createTable		\N	3.2.2
1337623084753-80	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.631	72	EXECUTED	7:9c176496b9d4502ce7931395f35bc44a	createTable		\N	3.2.2
1337623084753-81	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.678	73	EXECUTED	7:f8806b3d1ca780622b4dfec350732459	createTable		\N	3.2.2
1337623084753-82	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.741	74	EXECUTED	7:5a5559ed5e9105e545520f786702ba41	createTable		\N	3.2.2
1337623084753-83	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.788	75	EXECUTED	7:48f296de8c91d93c6051f5aee0cccf03	createTable		\N	3.2.2
1337623084753-92	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.881	76	EXECUTED	7:7a0fe4fd689496a88bec4d08ea2d14ee	createTable		\N	3.2.2
1337623084753-93	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:52.959	77	EXECUTED	7:c730a0ddbcc43ae41d0d171037197776	createTable		\N	3.2.2
1337623084753-94	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:53.022	78	EXECUTED	7:eb876cba9f2fec2d625d99cce58529a9	createTable		\N	3.2.2
1337623084753-95	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:53.069	79	EXECUTED	7:cc69581564adc173b25c8c4e03690842	createTable		\N	3.2.2
1337623084753-96	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:53.116	80	EXECUTED	7:35f4c7e4a908c1ef59be622b6c33ace8	createTable		\N	3.2.2
1337623084753-97	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:53.163	81	EXECUTED	7:37490816ce942e643a637c26331286fa	createTable		\N	3.2.2
1337623084753-100	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:53.225	82	EXECUTED	7:9205df323f2c15c685ed06f9f4491eab	createTable		\N	3.2.2
1337623084753-101	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:53.272	83	EXECUTED	7:0c5a94d1f3378394d68b44396f4d1e43	createTable		\N	3.2.2
1337623084753-102	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:53.35	84	EXECUTED	7:42bdcdfcead0d065149cad55681524c0	createTable		\N	3.2.2
1337623084753-103	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:53.397	85	EXECUTED	7:c08d47ebd7356606e269e4a327170596	createTable		\N	3.2.2
1337623084753-104	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:53.475	86	EXECUTED	7:b461b8cf0707edf2c94478c7c2d794e0	createTable		\N	3.2.2
1337623084753-105	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:53.491	87	EXECUTED	7:ace973ecfbf315e6d3f82bd53dc0b477	createTable		\N	3.2.2
1337623084753-106	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:53.538	88	EXECUTED	7:e3de9bcdddb0cc988d7610d2a1a00b32	createTable		\N	3.2.2
1337623084753-108	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:53.584	89	EXECUTED	7:a68dac8b48dc6f65ff2dea5770001986	createTable		\N	3.2.2
1337623084753-109	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:53.678	90	EXECUTED	7:af705ddba5368bd508b083effb1cfb82	createTable		\N	3.2.2
1337623084753-110	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:53.741	91	EXECUTED	7:826d2988bdefbd37d26bbb65d9fc1108	createTable		\N	3.2.2
1337623084753-111	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:53.803	92	EXECUTED	7:50d7aa6e39cc87396f27d68615c8d50c	createTable		\N	3.2.2
1337623084753-112	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:53.866	93	EXECUTED	7:1f7885410869f4615dac1e1d07cff696	createTable		\N	3.2.2
1337623084753-113	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.022	94	EXECUTED	7:d2a95b4dfdcbd8b9a73ca63ff5e345d0	createTable		\N	3.2.2
1337623084753-114	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.053	95	EXECUTED	7:5f78d6ae3f31a54c849af6522260a069	createTable		\N	3.2.2
1337623084753-115	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.053	96	EXECUTED	7:07c7b1f6224b8988f6f3e8ad0e8c047e	createTable		\N	3.2.2
1337623084753-319	Mahesh Shivarkar	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.147	97	EXECUTED	7:8d8f703ad7dacac3ebcbd47e68eedec0	createTable		\N	3.2.2
1337623084753-117	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.209	98	EXECUTED	7:87e9550f859e966dec9d281cdfc1dd48	addPrimaryKey		\N	3.2.2
1337623084753-119	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.256	99	EXECUTED	7:f1c2782ad773845b19553e79f3dc5391	addPrimaryKey		\N	3.2.2
1337623084753-123	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.319	100	EXECUTED	7:52309a419b3950177c73af5949f47005	addUniqueConstraint		\N	3.2.2
1337623084753-275	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.428	101	EXECUTED	7:c2686f9acf46dd4643804f0a81082846	createIndex		\N	3.2.2
1337623084753-276	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.475	102	EXECUTED	7:d7c7866adc8d375251789a69edb20467	createIndex		\N	3.2.2
1337623084753-277	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.552	103	EXECUTED	7:cc67f9419e6ef2dcc2bbe073d6b6b9de	createIndex		\N	3.2.2
1337623084753-278	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.603	104	EXECUTED	7:1727b1798178b0ffffff18a67f5a6867	createIndex		\N	3.2.2
1337623084753-279	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.656	105	EXECUTED	7:f0f3154cbeec62c6ccb10d1a8343e62d	createIndex		\N	3.2.2
1337623084753-280	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.725	106	EXECUTED	7:13a830711e5f414436fb33a1ad519e42	createIndex		\N	3.2.2
1337623084753-281	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.777	107	EXECUTED	7:d987b9fbc745b67acc8e9a32e96aea70	createIndex		\N	3.2.2
1337623084753-282	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.846	108	EXECUTED	7:3d28edff13be5e4423c26486379c6f31	createIndex		\N	3.2.2
1337623084753-283	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.904	109	EXECUTED	7:6372c28e52eed7014b5bde10a28cf251	createIndex		\N	3.2.2
1337623084753-284	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:54.955	110	EXECUTED	7:01c0d61a65dc8b722bd648b6dc482e0a	createIndex		\N	3.2.2
1337623084753-285	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.002	111	EXECUTED	7:0596149a2dc329fb8b9b4f98ae54ac49	createIndex		\N	3.2.2
1337623084753-286	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.064	112	EXECUTED	7:011eb535742a8d00970f215048f2e125	createIndex		\N	3.2.2
1337623084753-287	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.111	113	EXECUTED	7:a6b890a6877ebeda60c8f84a60b4a89f	createIndex		\N	3.2.2
1337623084753-288	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.158	114	EXECUTED	7:433d0a908a559a67d282e419687a1e4d	createIndex		\N	3.2.2
1337623084753-289	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.221	115	EXECUTED	7:579e254c79923e01621b59846f089e29	createIndex		\N	3.2.2
1337623084753-290	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.299	116	EXECUTED	7:379c46ff8b1b0fac4db10022e6ca8f33	createIndex		\N	3.2.2
1337623084753-291	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.33	117	EXECUTED	7:dff786eb144e47a9499fba98377131e4	createIndex		\N	3.2.2
1337623084753-292	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.393	118	EXECUTED	7:31f0f76bd0a1c9473d28095b3658667d	createIndex		\N	3.2.2
1337623084753-293	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.439	119	EXECUTED	7:055ef896d9761d0d49de010db685c5a6	createIndex		\N	3.2.2
1337623084753-294	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.486	120	EXECUTED	7:a32d1fd84eb1c7b88823b5c7cab181c6	createIndex		\N	3.2.2
1337623084753-295	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.533	121	EXECUTED	7:11975e32cbfcd912b4b1bf2dbd8c779b	createIndex		\N	3.2.2
1337623084753-296	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.58	122	EXECUTED	7:424bd03aa3aa1646b793f863fe253558	createIndex		\N	3.2.2
1337623084753-298	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.643	123	EXECUTED	7:b4212acd1e65f02d3087997ca0330c10	createIndex		\N	3.2.2
1337623084753-299	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.705	124	EXECUTED	7:20828164f60f1229ca1505ece7c2fc85	createIndex		\N	3.2.2
1337623084753-300	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.752	125	EXECUTED	7:d6728c6bf7bb9dd186588af165a2dbaf	createIndex		\N	3.2.2
1337623084753-301	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.799	126	EXECUTED	7:e69e0236869430e4fbb47d9588f13541	createIndex		\N	3.2.2
1337623084753-302	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.861	127	EXECUTED	7:69ff6e381675605c0c160f3099e7bb87	createIndex		\N	3.2.2
1337623084753-303	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.908	128	EXECUTED	7:e537aeb410d8893d88eb5510e2fe0075	createIndex		\N	3.2.2
1337623084753-304	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:55.955	129	EXECUTED	7:2e5779c6ca114f02133ea1e248061cdd	createIndex		\N	3.2.2
1337623084753-305	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:56.002	130	EXECUTED	7:b0f88448f336a132cc2d4ba0da17b797	createIndex		\N	3.2.2
1337623084753-306	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:56.049	131	EXECUTED	7:2f8061b9e79a61c46232286ebf3acd81	createIndex		\N	3.2.2
1337623084753-310	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:56.111	132	EXECUTED	7:3bbb241087ab9de6bea8468c2690e9c8	createIndex		\N	3.2.2
1337623084753-311	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:56.158	133	EXECUTED	7:3f79c343ef2321709d4918093a2e00b4	createIndex		\N	3.2.2
1337623084753-312	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:56.221	134	EXECUTED	7:06085b0f16fc1e534a141f5df2ccbf50	createIndex		\N	3.2.2
1337623084753-313	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:56.268	135	EXECUTED	7:051124011bcc345dfd247fe6f1bb0b98	createIndex		\N	3.2.2
1337623084753-314	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:56.33	136	EXECUTED	7:872164576f404bd25d2e1aacac05048b	createIndex		\N	3.2.2
1337623084753-315	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:56.393	137	EXECUTED	7:dcf50778ee2fc38371c76339adf703a4	createIndex		\N	3.2.2
1337623084753-316	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:56.439	138	EXECUTED	7:77a38d8be0387955425076e143f63cb2	createIndex		\N	3.2.2
1337623084753-317	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:56.502	139	EXECUTED	7:dbc868040f1429f41108777e8f88a6cb	createIndex		\N	3.2.2
20120530-#2825-Fix-percentage-products-in-Plans	Juan Vidal	descriptors/database/jbilling-schema.xml	2018-10-25 17:10:56.549	140	EXECUTED	7:59fa33cc692b00665d419b4848aaf91c	insert (x2)		\N	3.2.2
1337972683141-1	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.208	141	EXECUTED	7:892b03dadc233acca2db7ec13f101c85	insert (x3)		\N	3.2.2
1337972683141-2	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.238	142	EXECUTED	7:fa9c382ea1b19e50f152621cb197c200	insert (x4)		\N	3.2.2
1337972683141-3	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.248	143	EXECUTED	7:f886238981f23b68d125e8b28549baec	insert		\N	3.2.2
1337972683141-4	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.357	144	EXECUTED	7:b7cb42e9f8fa3780248317d351060a98	insert (x95)		\N	3.2.2
1337972683141-5	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.4	145	EXECUTED	7:143fed48a07ca57c1daceb6153602a88	insert (x4)		\N	3.2.2
1337972683141-8	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.417	146	EXECUTED	7:a0b212d7616fd99cb7e9fc86cbe92cf6	insert (x9)		\N	3.2.2
1337972683141-9	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.442	147	EXECUTED	7:23aa1cf86bec54afe2202bdd3e5a8335	insert (x23)		\N	3.2.2
1337972683141-10	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.46	148	EXECUTED	7:b80f83026687ae7d0d1375e6c26a20f1	insert (x4)		\N	3.2.2
1337972683141-11	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.54	149	EXECUTED	7:c1f26f3f90f2f887e9ebe7296c6ab44a	insert (x108)		\N	3.2.2
1337972683141-12	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.577	150	EXECUTED	7:b903c29c915d7d299113ad0d4e61d824	insert (x2)		\N	3.2.2
1337972683141-13	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.593	151	EXECUTED	7:f7a782164e04f7b3f15d629567ce768d	insert (x2)		\N	3.2.2
1337972683141-14	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.765	152	EXECUTED	7:4a46f7ce9e8137ec22ed274f4ecfebfa	insert (x237)		\N	3.2.2
1337972683141-15	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.811	153	EXECUTED	7:87037e224619b9533ce9439b6f1a1a06	insert (x4)		\N	3.2.2
1337972683141-16	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.843	154	EXECUTED	7:75ed7c524f745f840b92fb7ce037b76c	insert (x14)		\N	3.2.2
1337972683141-18	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.858	155	EXECUTED	7:fe0ae9a150a7d52b241b3c985f08fe87	insert (x11)		\N	3.2.2
1337972683141-19	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.89	156	EXECUTED	7:c8c6f8a9710886e7afc788b605cb9334	insert (x6)		\N	3.2.2
1337972683141-20	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.905	157	EXECUTED	7:82e0c8279a94a8a793dbd80504fd1926	insert (x34)		\N	3.2.2
1337972683141-21	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:21.968	158	EXECUTED	7:954f44e51752b1ec00cdf5f7ed1433b7	insert (x87)		\N	3.2.2
1337972683141-22	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:22.015	159	EXECUTED	7:1109e20657343a92a7125e944a3fc388	insert (x9)		\N	3.2.2
1337972683141-23	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:22.03	160	EXECUTED	7:164fb555c85034315a8989521b5f5b12	insert (x3)		\N	3.2.2
1337972683141-24	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:22.046	161	EXECUTED	7:79edf8a3a5506853f064eb79bd1bb30a	insert		\N	3.2.2
1337972683141-25	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:22.046	162	EXECUTED	7:6681820783c4b007b05a8a91bcec3da3	insert (x4)		\N	3.2.2
1337972683141-26	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:22.077	163	EXECUTED	7:587d53226acce3a9ddddd2471e6b4492	insert (x18)		\N	3.2.2
1337972683141-27	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:22.108	164	EXECUTED	7:289e035c8f1e23c982cfab688581c87e	insert (x45)		\N	3.2.2
1337972683141-28	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:22.155	165	EXECUTED	7:e60013b2da9542a8d89a5c038626e1e3	insert (x16)		\N	3.2.2
1337972683141-29	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:22.186	166	EXECUTED	7:21c89970a65dd49d28d95da673e6e328	insert (x15)		\N	3.2.2
1337972683141-30	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:22.202	167	EXECUTED	7:466725d303d2465d862b3a7d6a440c51	insert (x18)		\N	3.2.2
1337972683141-31	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:22.249	168	EXECUTED	7:ce3597406cf9f78a94ec3502b9058110	insert (x39)		\N	3.2.2
1337972683141-32	aristokrates (generated)	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:22.874	169	EXECUTED	7:0f34c53953c75cd6cf804b122971129d	insert (x1072)		\N	3.2.2
#14049-French and German Translation Texts	Manisha Gupta	descriptors/database/jbilling-init_data.xml	2018-10-25 17:11:23.452	170	EXECUTED	7:bc56a1d674bfaad04798e774ff5ad052	insert (x2), sql		\N	3.2.2
1337623084753-126	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:37.869	171	EXECUTED	7:75a4458852605f08e980823b5f9006ab	addForeignKeyConstraint		\N	3.2.2
1337623084753-127	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:37.9	172	EXECUTED	7:5f2ce32f0fb8497611f789eac19f99f1	addForeignKeyConstraint		\N	3.2.2
1337623084753-128	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:37.9	173	EXECUTED	7:e673d72b62e0b22b635bee51da2289d9	addForeignKeyConstraint		\N	3.2.2
1337623084753-129	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:37.916	174	EXECUTED	7:b97de99f9ba546281e8562bd7e21cff6	addForeignKeyConstraint		\N	3.2.2
1337623084753-130	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:37.916	175	EXECUTED	7:d2aee44b966453cd7b6c53627329350e	addForeignKeyConstraint		\N	3.2.2
1337623084753-131	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:37.932	176	EXECUTED	7:1cd30f95824988b0117aa5bf311e5356	addForeignKeyConstraint		\N	3.2.2
1337623084753-132	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:37.947	177	EXECUTED	7:74305f78440d940e59ad1c67ceed861e	addForeignKeyConstraint		\N	3.2.2
1337623084753-133	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:37.947	178	EXECUTED	7:814576f082018486e8363af201bab961	addForeignKeyConstraint		\N	3.2.2
1337623084753-134	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:37.963	179	EXECUTED	7:3f1504236ed54fe5131c6177c970fa0c	addForeignKeyConstraint		\N	3.2.2
1337623084753-135	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:37.963	180	EXECUTED	7:4c23adfc033faf802947f6592ea77891	addForeignKeyConstraint		\N	3.2.2
1337623084753-136	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:37.978	181	EXECUTED	7:c5df405e06b4187a05748d0b4f59630d	addForeignKeyConstraint		\N	3.2.2
1337623084753-137	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:37.978	182	EXECUTED	7:60be39df8fdbb0ddc081fbebe8c54b64	addForeignKeyConstraint		\N	3.2.2
1337623084753-138	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:37.994	183	EXECUTED	7:8806a5a1135003ff02aa0eb2d69a704b	addForeignKeyConstraint		\N	3.2.2
1337623084753-139	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:37.994	184	EXECUTED	7:70b7422a6eff32b27fb9fe08e9e45217	addForeignKeyConstraint		\N	3.2.2
1337623084753-140	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.01	185	EXECUTED	7:0ea2224088b851ccf69dafb3afee7e40	addForeignKeyConstraint		\N	3.2.2
1337623084753-141	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.01	186	EXECUTED	7:76ba18fb2bebb05f411d0531bd7e6c8e	addForeignKeyConstraint		\N	3.2.2
1337623084753-142	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.025	187	EXECUTED	7:1ed5930e3268ad94fba96e21fdea1249	addForeignKeyConstraint		\N	3.2.2
1337623084753-143	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.025	188	EXECUTED	7:04d4799989743cd5704499e274368b2b	addForeignKeyConstraint		\N	3.2.2
1337623084753-144	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.025	189	EXECUTED	7:4c73be0bc45aaf334bcf63c573e938cb	addForeignKeyConstraint		\N	3.2.2
1337623084753-145	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.025	190	EXECUTED	7:e6b0f05a91612c4b440b5f99a8c0ea50	addForeignKeyConstraint		\N	3.2.2
1337623084753-146	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.041	191	EXECUTED	7:7b3dcbcd8269799b4b0c8fa9bd09bec4	addForeignKeyConstraint		\N	3.2.2
1337623084753-147	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.041	192	EXECUTED	7:d558528ecd03f62b1e9e338f59bf5d56	addForeignKeyConstraint		\N	3.2.2
1337623084753-148	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.057	193	EXECUTED	7:6f46f0b755b98fde27e472d096d40a2a	addForeignKeyConstraint		\N	3.2.2
1337623084753-149	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.057	194	EXECUTED	7:33fa4ce421c443142f0287ef168f0fbb	addForeignKeyConstraint		\N	3.2.2
1337623084753-150	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.057	195	EXECUTED	7:0da342a911166e62660c407d77c3bd5a	addForeignKeyConstraint		\N	3.2.2
1337623084753-153	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.072	196	EXECUTED	7:b827b4302366b9c807f81366a68e0de4	addForeignKeyConstraint		\N	3.2.2
1337623084753-154	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.072	197	EXECUTED	7:b7ad5cb6690e13eb64461b5a98dbdf53	addForeignKeyConstraint		\N	3.2.2
1337623084753-155	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.072	198	EXECUTED	7:05fbf423084f303b0d367b0737430e6c	addForeignKeyConstraint		\N	3.2.2
1337623084753-156	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.088	199	EXECUTED	7:bf67b3134da20eb6268a3e97d1d9081c	addForeignKeyConstraint		\N	3.2.2
1337623084753-157	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.088	200	EXECUTED	7:a27db18ae366812b1e64968d629573c3	addForeignKeyConstraint		\N	3.2.2
1337623084753-158	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.103	201	EXECUTED	7:c94b05a44d2d7df27e2ac602046c7887	addForeignKeyConstraint		\N	3.2.2
1337623084753-159	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.103	202	EXECUTED	7:368aee5dd0f38f4a77f2542debc79054	addForeignKeyConstraint		\N	3.2.2
1337623084753-160	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.103	203	EXECUTED	7:f8b376c9402563d5e4bbea8e8f8ba9c4	addForeignKeyConstraint		\N	3.2.2
22	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:59.931	506	EXECUTED	7:97ebaba8537f01b2dbcc9dbd1957ff96	createTable		\N	3.2.2
1337623084753-161	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.119	204	EXECUTED	7:7e0038d684ebf592939a347817ab97da	addForeignKeyConstraint		\N	3.2.2
1337623084753-162	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.119	205	EXECUTED	7:1acb6f8b10f87a06b38717d675d9a6b9	addForeignKeyConstraint		\N	3.2.2
1337623084753-163	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.135	206	EXECUTED	7:4d42cbc89214b0789261d5b38054d506	addForeignKeyConstraint		\N	3.2.2
1337623084753-164	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.135	207	EXECUTED	7:40a8bb1b37873c28120d3dd4aa282157	addForeignKeyConstraint		\N	3.2.2
1337623084753-165	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.135	208	EXECUTED	7:9ac531852fc3f7cd0837aa589faa582e	addForeignKeyConstraint		\N	3.2.2
1337623084753-166	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.15	209	EXECUTED	7:3004d4c9e496d94c854f76ea48c0076d	addForeignKeyConstraint		\N	3.2.2
1337623084753-167	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.15	210	EXECUTED	7:63a2ef8480517cbdb4087901ced6188d	addForeignKeyConstraint		\N	3.2.2
1337623084753-168	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.166	211	EXECUTED	7:aba5c2cf49fee6f01873e796c6105418	addForeignKeyConstraint		\N	3.2.2
1337623084753-169	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.166	212	EXECUTED	7:79f8a3d295ad88ab7b517cb8ee83c692	addForeignKeyConstraint		\N	3.2.2
1337623084753-170	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.182	213	EXECUTED	7:c1310382bb7ec369d5f26c0eb1fbb667	addForeignKeyConstraint		\N	3.2.2
1337623084753-171	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.182	214	EXECUTED	7:cf1dcec7874b07a0ad7e15f99b027a0b	addForeignKeyConstraint		\N	3.2.2
1337623084753-172	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.197	215	EXECUTED	7:a369d57ca2662da122f75b8da071d19b	addForeignKeyConstraint		\N	3.2.2
1337623084753-173	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.197	216	EXECUTED	7:ad42dcd59467e0f28e6996bb5d3c0fa4	addForeignKeyConstraint		\N	3.2.2
1337623084753-174	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.213	217	EXECUTED	7:5f7d0419cbe31f8b8ee7df86b1937270	addForeignKeyConstraint		\N	3.2.2
1337623084753-175	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.213	218	EXECUTED	7:3c483115556a8b38cdc15ad39c3b3492	addForeignKeyConstraint		\N	3.2.2
1337623084753-176	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.213	219	EXECUTED	7:148ee59fc185fa10a75ccf2f2b7bbf1f	addForeignKeyConstraint		\N	3.2.2
1337623084753-177	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.228	220	EXECUTED	7:325d811db324fa6318d992f3982290c5	addForeignKeyConstraint		\N	3.2.2
1337623084753-178	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.228	221	EXECUTED	7:a985100c3fafe73b9457178f9295a3be	addForeignKeyConstraint		\N	3.2.2
1337623084753-179	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.228	222	EXECUTED	7:9a6ab972e31b150963fdd2356beb9c7c	addForeignKeyConstraint		\N	3.2.2
1337623084753-180	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.244	223	EXECUTED	7:c53734d21ae9b060abeaafc155f83145	addForeignKeyConstraint		\N	3.2.2
1337623084753-181	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.244	224	EXECUTED	7:2e163eefd39c2db61858c16001014541	addForeignKeyConstraint		\N	3.2.2
1337623084753-184	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.26	225	EXECUTED	7:f55ae3b446a476dc9fb9411591bb2543	addForeignKeyConstraint		\N	3.2.2
1337623084753-185	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.26	226	EXECUTED	7:4f3177adff776b02f07504d2ef55b2d8	addForeignKeyConstraint		\N	3.2.2
1337623084753-186	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.275	227	EXECUTED	7:80107e941ca59227c531c848985c3bf9	addForeignKeyConstraint		\N	3.2.2
1337623084753-187	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.275	228	EXECUTED	7:f7361473b2cd5d91a6a28a0154a2e095	addForeignKeyConstraint		\N	3.2.2
1337623084753-188	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.275	229	EXECUTED	7:dcb2e6763c0d385509fb5515068667ab	addForeignKeyConstraint		\N	3.2.2
1337623084753-197	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.291	230	EXECUTED	7:9b1b8c900ce348daae8ef8f47fdcaad0	addForeignKeyConstraint		\N	3.2.2
1337623084753-198	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.291	231	EXECUTED	7:61387e4e43008981acc9f7b66c24c8a2	addForeignKeyConstraint		\N	3.2.2
1337623084753-199	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.291	232	EXECUTED	7:4c6e3731514d76c12d13fae3e4fa3d23	addForeignKeyConstraint		\N	3.2.2
1337623084753-200	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.307	233	EXECUTED	7:6859fa8993edd74e0f8a609871de66bf	addForeignKeyConstraint		\N	3.2.2
1337623084753-201	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.307	234	EXECUTED	7:acb4a155eea2c455856a8de38cdfdd88	addForeignKeyConstraint		\N	3.2.2
1337623084753-202	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.307	235	EXECUTED	7:3ec857f24a27a75824df0cb2f90f6344	addForeignKeyConstraint		\N	3.2.2
1337623084753-203	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.322	236	EXECUTED	7:b2b4130291b13a57a3810adb4a47ce94	addForeignKeyConstraint		\N	3.2.2
1337623084753-204	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.322	237	EXECUTED	7:ead685db40b963c35fc1c19741dfd38f	addForeignKeyConstraint		\N	3.2.2
1337623084753-205	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.322	238	EXECUTED	7:25fa80b9806b625b5afd37bf3c5ba704	addForeignKeyConstraint		\N	3.2.2
1337623084753-206	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.338	239	EXECUTED	7:cfc81314a958f756a9369c8a87eab006	addForeignKeyConstraint		\N	3.2.2
1337623084753-207	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.338	240	EXECUTED	7:dec079d2acc7ffdde9f0d46e92ac1115	addForeignKeyConstraint		\N	3.2.2
1337623084753-208	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.338	241	EXECUTED	7:5e484ec21018d0b9da7b1b9da5b7d03a	addForeignKeyConstraint		\N	3.2.2
1337623084753-209	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.353	242	EXECUTED	7:0a30b63874b23a3d00dd0d08c74cc41c	addForeignKeyConstraint		\N	3.2.2
1337623084753-210	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.353	243	EXECUTED	7:57e8ee891eaf66558ec183a69efbc64f	addForeignKeyConstraint		\N	3.2.2
1337623084753-211	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.353	244	EXECUTED	7:b2b7afe0b718b46aa02588f9cd5dc90e	addForeignKeyConstraint		\N	3.2.2
1337623084753-212	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.353	245	EXECUTED	7:be1220080dbe423f7f720d9df7179d2c	addForeignKeyConstraint		\N	3.2.2
1337623084753-213	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.385	246	EXECUTED	7:72551c40edbab7f01d0e65f219bc5d97	addForeignKeyConstraint		\N	3.2.2
1337623084753-214	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.4	247	EXECUTED	7:23b4bc660215da2c1b87563a29de3cbb	addForeignKeyConstraint		\N	3.2.2
1337623084753-215	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.416	248	EXECUTED	7:cdaeac3fed333286507b082a79c96e0f	addForeignKeyConstraint		\N	3.2.2
1337623084753-216	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.416	249	EXECUTED	7:6491850a4fe692c81fdbb217280bbe64	addForeignKeyConstraint		\N	3.2.2
1337623084753-217	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.416	250	EXECUTED	7:f9ac90aa76552717f6b8dd874d917b41	addForeignKeyConstraint		\N	3.2.2
1337623084753-218	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.432	251	EXECUTED	7:a42b948787df60198c9004274072a675	addForeignKeyConstraint		\N	3.2.2
1337623084753-219	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.432	252	EXECUTED	7:49e038365abfb81b94e85c2c25d7d70d	addForeignKeyConstraint		\N	3.2.2
1337623084753-220	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.432	253	EXECUTED	7:1500f6f47029683281bc7b2e8292f726	addForeignKeyConstraint		\N	3.2.2
1337623084753-221	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.447	254	EXECUTED	7:129c344be312e649bf894e350d95b3e1	addForeignKeyConstraint		\N	3.2.2
1337623084753-222	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.447	255	EXECUTED	7:42359f8afd2b6db651722cf404c60b2d	addForeignKeyConstraint		\N	3.2.2
1337623084753-223	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.447	256	EXECUTED	7:52bb8c9f7f1ad2d08f80a47f20702e9b	addForeignKeyConstraint		\N	3.2.2
1337623084753-224	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.463	257	EXECUTED	7:6849ea30a8540c1be986fcdfc03e17f3	addForeignKeyConstraint		\N	3.2.2
1337623084753-225	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.463	258	EXECUTED	7:010da80e97cf08a7495a8bab95b6f65e	addForeignKeyConstraint		\N	3.2.2
1337623084753-226	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.463	259	EXECUTED	7:42c7e285e08d764c551e2ddbcbd926e2	addForeignKeyConstraint		\N	3.2.2
1337623084753-227	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.478	260	EXECUTED	7:b44fdcf89b27873fd93714b547314afa	addForeignKeyConstraint		\N	3.2.2
1337623084753-228	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.478	261	EXECUTED	7:c71d08ed6e2235b7c6ae6b2594ca42ca	addForeignKeyConstraint		\N	3.2.2
1337623084753-229	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.478	262	EXECUTED	7:75fc3797d3a4ba34b7625484fae3e0f7	addForeignKeyConstraint		\N	3.2.2
1337623084753-230	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.494	263	EXECUTED	7:4d29bc601d3c8c90dc3641dd9f1845c4	addForeignKeyConstraint		\N	3.2.2
1337623084753-231	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.494	264	EXECUTED	7:b2fe4aa6cee8ce8e0e6f3c5467a2c87d	addForeignKeyConstraint		\N	3.2.2
1337623084753-232	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.494	265	EXECUTED	7:57d343b6a41f159d61cba9795c4d70ae	addForeignKeyConstraint		\N	3.2.2
1337623084753-233	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.51	266	EXECUTED	7:17ac0584178afafd9831a8c810d9c3ee	addForeignKeyConstraint		\N	3.2.2
1337623084753-247	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.51	267	EXECUTED	7:8de30a7a3d4fad9c4c9b534d9a32a3d9	addForeignKeyConstraint		\N	3.2.2
1337623084753-249	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.525	268	EXECUTED	7:95a7ab19c2e772287a661a19e7c62b32	addForeignKeyConstraint		\N	3.2.2
1337623084753-250	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.525	269	EXECUTED	7:0ef59f7c632a6c8b6f7e3e0b88534353	addForeignKeyConstraint		\N	3.2.2
1337623084753-251	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.541	270	EXECUTED	7:e2d8293585bf55ef1030a5bbc0c41504	addForeignKeyConstraint		\N	3.2.2
1337623084753-252	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.541	271	EXECUTED	7:3e40b2c12f93d4bb17992e6d5d01ec8d	addForeignKeyConstraint		\N	3.2.2
1337623084753-256	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.557	272	EXECUTED	7:7744c9a47a2e8c3ff7fffd49a94010fb	addForeignKeyConstraint		\N	3.2.2
1337623084753-257	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.557	273	EXECUTED	7:bfc0510a2ee7d38ad7ab2d75a9972d2e	addForeignKeyConstraint		\N	3.2.2
1337623084753-258	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.572	274	EXECUTED	7:15bbd9ad1be11b4a9dcec7ed34679947	addForeignKeyConstraint		\N	3.2.2
1337623084753-259	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.577	275	EXECUTED	7:b304182d1e2c2cdf5e7b49bd35bb80c1	addForeignKeyConstraint		\N	3.2.2
1337623084753-260	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.58	276	EXECUTED	7:dd1ed1cac11d56dfd406defa182b6824	addForeignKeyConstraint		\N	3.2.2
1337623084753-261	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.58	277	EXECUTED	7:968f5c629f6c1903a38ebecc8533eeef	addForeignKeyConstraint		\N	3.2.2
1337623084753-262	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.58	278	EXECUTED	7:79156e7a592a64e23527208e5e675897	addForeignKeyConstraint		\N	3.2.2
1337623084753-263	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.596	279	EXECUTED	7:e6db865fb6d446b2197012876fa7da21	addForeignKeyConstraint		\N	3.2.2
1337623084753-264	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.596	280	EXECUTED	7:ea5ce4eaffe78b9c3e22df6d2b993ef4	addForeignKeyConstraint		\N	3.2.2
1337623084753-265	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.596	281	EXECUTED	7:b31723792215e0944355c4c9e88ee4c5	addForeignKeyConstraint		\N	3.2.2
1337623084753-266	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.596	282	EXECUTED	7:10fab1f295c37475c84fff8d5216621a	addForeignKeyConstraint		\N	3.2.2
1337623084753-267	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.611	283	EXECUTED	7:4c19e257741ff1192e15ef611b3756d3	addForeignKeyConstraint		\N	3.2.2
1337623084753-268	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.611	284	EXECUTED	7:f1825551f57751ddb85cdb205ece5348	addForeignKeyConstraint		\N	3.2.2
1337623084753-269	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.611	285	EXECUTED	7:934a52ce8b78df006eb498b925c56919	addForeignKeyConstraint		\N	3.2.2
1337623084753-270	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.627	286	EXECUTED	7:d4374eaf5120aa300a92d3c5bde3e54b	addForeignKeyConstraint		\N	3.2.2
1337623084753-272	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.627	287	EXECUTED	7:9c64ee7a22c79f65096967374724864b	addForeignKeyConstraint		\N	3.2.2
1337623084753-273	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.627	288	EXECUTED	7:ac2b6866e164e675a7fa39d9ebea125f	addForeignKeyConstraint		\N	3.2.2
1337623084753-274	Emiliano Conde	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.643	289	EXECUTED	7:fdf5cb55c7696fcc46c1957aa70455c8	addForeignKeyConstraint		\N	3.2.2
1337623084753-320	Mahesh Shivarkar	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.643	290	EXECUTED	7:692ad199923acbe9dbe6bd36ef9601e2	addForeignKeyConstraint		\N	3.2.2
1337623084753-321	Mahesh Shivarkar	descriptors/database/jbilling-schema.xml	2018-10-25 17:11:38.658	291	EXECUTED	7:dce9f5277aff5d62f2665f00f3bf2159	addForeignKeyConstraint		\N	3.2.2
min-balance-to-ignore-ageing	Panche Isajeski	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:20.866	292	EXECUTED	7:2c3823a513867c4974079fccc4787df3	insert (x3)	March 27, 2012 Redmine #2486 New Preference - Min Balance to ignore Ageing/Overdue Notifications	\N	3.2.2
eliminate-main-order_alter-columns	Emiliano Conde	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:20.928	293	EXECUTED	7:98130990a159fe3de10953b0c4c53e8a	addColumn, update (x2), addForeignKeyConstraint, dropForeignKeyConstraint, dropColumn (x2)	April 23, 2012 - Redmine #922 - Eliminate Main Order	\N	3.2.2
eliminate-main-order_update-data-psql	Emiliano Conde	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:20.944	294	EXECUTED	7:bd17e924a4b0dbf9d818efef7914cb75	update (x2), dropColumn (x2)	April 23, 2012 - Redmine #922 - Eliminate Main Order	\N	3.2.2
fix-min_params_SimpleTaxCompositionTask	Emiliano Conde	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:20.944	295	EXECUTED	7:fe9e061efc641247abdd965f5ab02e5b	update	April 24, 2012 - Fix to SimpleTaxCompositionTask	\N	3.2.2
clear-empty-meta_fields	Emiliano Conde	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:20.944	296	EXECUTED	7:c03db8bd29d2054324c086e03f30c4d3	delete (x2)	May 22, 2012 - Remove empty string metafields	\N	3.2.2
notification-message	Panche Isajeski	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:20.959	297	EXECUTED	7:8b28a3fb0056977c21990000adeefab4	addColumn (x3), insert (x2)	May 28, 2012 - Adding notification messages	\N	3.2.2
attach-overdue-invoices-to-notifications	Panche Isajeski	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:20.975	298	EXECUTED	7:e7e15513c4239eb838787f550dcd5d06	insert (x3)	May 31, 2012 Redmine #2718 Attach Invoices to all Overdue Notifications	\N	3.2.2
20120608-#2725-notification-category	Vikas Bodani	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:20.991	299	EXECUTED	7:90397ac5f5c6af71ceb30284faa51ede	insert	June 15, Redmine #2725 - Custom Notification Category	\N	3.2.2
custom-notification-feature	Shweta Gupta	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:21.006	300	EXECUTED	7:696537b57591f8cbf39624fefbb60676	addColumn (x4), update (x4)	June 20, 2012 Redmine #2725 Custom Notification Feature	\N	3.2.2
20120606-2718-overdue-invoice-penalty-order-task	Vikas Bodani	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:21.022	301	EXECUTED	7:85ff1cd4b3f3b3e21b2a84d55ba4383a	insert (x3), update	Overdue Invoice penalties plug-in - new feature	\N	3.2.2
remove-rules-generator-task	Brian Cowdery	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:21.022	302	EXECUTED	7:24c6b80505bf3a623c3189f300e5805f	delete (x3)	July 8, 2012 Redmine # 3023 Remove rules generator API	\N	3.2.2
add-event-based-custom-notification-task	Panche Isajeski	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:21.037	303	EXECUTED	7:c912f82eb7120badbcbb45504d2cadc4	insert (x3)	Jul 12, 2012 - #2725 - Custom notifications	\N	3.2.2
3990 - Made order_id persistent to invoiceLineDTO	Vikas Bodani	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:21.053	304	EXECUTED	7:37fb18bd6a347d0468c08992bf68a934	addColumn, addForeignKeyConstraint	Requirement 3990 - Added order_id to the Invoice_Line table.	\N	3.2.2
2006 - Force Unique Emails Preference	Vladimir Carevski	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:21.053	305	EXECUTED	7:f4c6c02953c9021414768dad5dfc73c7	insert (x3)	Bugs #2006 - Option to force unique emails in the company	\N	3.2.2
4474 - Entity to be deletable.	Amol Gadre	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:21.149	306	EXECUTED	7:9bfe1c0e1bcb165d49966db06c6543e3	addColumn	Requirement #4474 - Added deleted column in entity to allow for soft deletion.	\N	3.2.2
change-category-for-penalty-task	Panche Isajeski	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:21.159	307	EXECUTED	7:34f5913c5a3f26d196cb99777fe7e376	update		\N	3.2.2
add-new-suretax-engine-base	Amol Gadre	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:21.3	308	EXECUTED	7:b537cd361acb0cf41e6f617f4e4525ab	insert, createTable, insert (x4)	Jun 24, 2013 - Add Suretax Processing	\N	3.2.2
20121120 #3304 Jbilling Core Changes for Discounts	Amol Gadre	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:21.595	309	EXECUTED	7:df9c63a9e4d4462edc9bff8e759d0d74	createTable (x2), addPrimaryKey, addForeignKeyConstraint (x2), createTable, addForeignKeyConstraint (x4), insert (x5)	20121120 #3304 Jbilling Core Changes for Discounts: Added new tables related to discounts functionality.	\N	3.2.2
20121213 #3452 Last Updated date time added on Discount	Amol Gadre	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:21.611	310	EXECUTED	7:8b8068ba80ae36348ad0be3e89da803b	addColumn	20121213 #3452 Last Updated date time added on Discount.	\N	3.2.2
20121031 #3530 Merchant Account Relationships	Amol Gadre	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:21.611	311	EXECUTED	7:438e0417fcb7e10e5bfe5972dbfcff60	addColumn, addForeignKeyConstraint	#3530 - Added new column to purchase order called primary order id to link the orders while creating a plan order.	\N	3.2.2
4933 - Invoice Date and Invoice Due Date are Incorrect	Maruthi	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:21.626	312	EXECUTED	7:3681aa0a29b8bdec4aa7ef5ca86cb256	update (x2)		\N	3.2.2
fix-column-name-length	Juan Vidal	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:21.72	313	EXECUTED	7:66ba15060609eee70a014cc0849cdd52	dropForeignKeyConstraint, renameColumn, addForeignKeyConstraint	Fix to rename the column name to less than 30 characters to avoid errors in Oracle.	\N	3.2.2
Requirement-5461	Rahul Asthana	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:21.72	314	EXECUTED	7:d0deb14443f14c174b966b7f11391ae6	update	Fix Unable to create new enumerations.	\N	3.2.2
#6076-add-notification-for-refunds	Juan Vidal	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:21.736	315	EXECUTED	7:46495a67401a323908715262572724ba	insert (x2)		\N	3.2.2
#6250-Tables-without-primary-keys	maruthi	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:22.533	316	EXECUTED	7:8f1d3152721f2838206cde44ff8707d6	sql (x3), delete, insert, addPrimaryKey, createSequence, addColumn, createSequence, addColumn, createSequence, addColumn, addPrimaryKey (x13)		\N	3.2.2
#6183-credit-card-transaction-report-renamed-cc	Juan Vidal	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:22.548	317	EXECUTED	7:fa8164800bdcd87f01715f68281a6aad	update		\N	3.2.2
#6250-Tables-without-primary-keys - correction - 3	Vikas Bodani	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:22.564	318	EXECUTED	7:c908088e56120afca458636804c41bc1	update		\N	3.2.2
#7339 - Added to fix the null value in category Type dropdown	Vishwajeet Borade	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:22.579	319	EXECUTED	7:a4f7eff5e35244954275ae4f40bc23ee	insert	Added to fix the null value in category Type dropdown	\N	3.2.2
#8469-billing-process-invoice-date-simplified	Ashok Kale	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:22.658	320	EXECUTED	7:f31c45d9cd97b60b26ee578660caf3d3	addColumn (x2), addForeignKeyConstraint	Requirement Add Customer level Next Invoice date	\N	3.2.2
#8469-Log-next-invoice-date-update.	Ashok Kale	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:22.674	321	EXECUTED	7:96b6f6b6610bbf7d3125ccd46d4b7b80	insert		\N	3.2.2
#8469-billing-process-semi-monthly-period-unit	Amol Gadre	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:22.689	322	EXECUTED	7:51e84dff9db24846b0d6d27f9cc8ca14	insert (x2)	Requirement Add new semi-monthly period for billing process	\N	3.2.2
#8469-Add-New-flag-last-day-of-invoice	Ashok Kale	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:22.799	323	EXECUTED	7:6c6d5a3e7496441006daff7a3ab18534	addColumn, insert		\N	3.2.2
#8469-Add-prorating-options	Ashok Kale	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:23.049	324	EXECUTED	7:1958a9aa62c52aad9c7338da0836efd1	addColumn (x2)		\N	3.2.2
#8469-remove-pro-rate-tasks	Ashok Kale	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:23.064	325	EXECUTED	7:b5de1ee40993b77c87eb2ef6adbb55f4	delete (x4)	June 10, 2014 Redmine # 8469 Remove ProRateOrderPeriodTask Plugin\nJune 10, 2014 Redmine # 8469 Remove DailyProRateCompositionTask Plugin	\N	3.2.2
#10005-Last Day of Month not Behaving as Expected	Manish Bansod	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:23.08	326	EXECUTED	7:16383077db84e9d6f56752447c661cb9	delete	# 10005 Delete Use Prorating preference	\N	3.2.2
20141211 - correcting next_ids	Rohit Gupta	descriptors/database/jbilling-upgrade-3.2.xml	2018-10-25 17:12:23.08	327	EXECUTED	7:75d374236ddd2a1db3a6dc078729e93b	update		\N	3.2.2
#3173 - Create a New Payment Method 'Credit'	Oscar Bidabehere	descriptors/database/jbilling-upgrade-3.3.xml	2018-10-25 17:12:56.578	328	EXECUTED	7:d4c0e5904753ca7ba863f5791c6fdd3b	insert (x5), update, sql, update		\N	3.2.2
#4781 - Dynamic tab configuration	Gerhard Maree	descriptors/database/jbilling-upgrade-3.3.xml	2018-10-25 17:12:56.735	329	EXECUTED	7:d2d074354d2d0d976cfec554f645d59b	createTable (x2), addForeignKeyConstraint, createTable, addForeignKeyConstraint (x2), insert (x9)		\N	3.2.2
#4781 - Dynamic tab configuration - Discounts menu item	Gerhard Maree	descriptors/database/jbilling-upgrade-3.3.xml	2018-10-25 17:12:56.75	330	EXECUTED	7:491a8a91b812e15cdc356ec9e6d6f794	addColumn, update (x2), insert		\N	3.2.2
#1905 - Reset password	Oscar Bidabehere	descriptors/database/jbilling-upgrade-3.3.xml	2018-10-25 17:12:56.875	331	EXECUTED	7:97686600f147d2bf90e3cf499aaefa00	createTable, sql, update, sql (x3), update, sql (x3), update	Default configuration\nid = maxMessageId + count\nmessage_id = maxMessageId - count\nmessage_id = maxMessageId - count\nmessage_id = maxMessageId - count\nmessage_section_id = (maxSectionId + 1 - (3 * entityCant)) + count\nmessage_section_id = (maxSecti...	\N	3.2.2
20121231-#2488,BalanceBelowThresholdNotificationTask-1	Shweta Gupta	descriptors/database/jbilling-upgrade-3.3.xml	2018-10-25 17:12:56.922	332	EXECUTED	7:6fadc677d51171b6542fb9f68b67ce3f	insert (x7), update (x2)		\N	3.2.2
#3374-Ageing improvements	Panche Isajeski	descriptors/database/jbilling-upgrade-3.3.xml	2018-10-25 17:12:57.36	333	EXECUTED	7:a79d27b91e4028ce1e817ad4061a47cf	createTable, insert, addColumn, sql, update, addForeignKeyConstraint, sql (x7), delete, update (x2), delete, addUniqueConstraint, insert (x3), update	#3374-Separate auto payment retry from the billing process\nMigration scripts\nNew UserAgeingNotificationTask for mapping between notifications and user statuses	\N	3.2.2
20130305 - #3307	Shweta Gupta 	descriptors/database/jbilling-upgrade-3.3.xml	2018-10-25 17:12:57.375	334	EXECUTED	7:ee1b60bd538330b881d7754ca296756a	insert (x3)	Add New Preference - Unique Product Code	\N	3.2.2
20121207-#4042-add-parent-item-type-column	Vladimir Carevski	descriptors/database/jbilling-upgrade-3.3.xml	2018-10-25 17:12:57.375	335	EXECUTED	7:f8ef413e9a2c9bb407408497d5abbb86	addColumn, addForeignKeyConstraint	Dec 07, 2012 - #4042, Adds column for parent item type id	\N	3.2.2
#7623, Configure password rules	Rohit	descriptors/database/jbilling-upgrade-3.3.xml	2018-10-25 17:12:57.391	336	EXECUTED	7:7530bbe34c559ca4d74ef84b11b6217c	addColumn		\N	3.2.2
#8043, add column in item table	Rohit	descriptors/database/jbilling-upgrade-3.3.xml	2018-10-25 17:12:57.391	337	EXECUTED	7:408ea8eb15a4583cf2fa2e0d2f881992	addColumn		\N	3.2.2
20141112-correcting sequences	Manisha Gupta	descriptors/database/jbilling-upgrade-3.3.xml	2018-10-25 17:12:57.391	338	EXECUTED	7:633a3f89bd3692aeb80f99645cc3e5c8	update		\N	3.2.2
#4938 - Asset Management - Entites	Gerhard Maree	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:25.91	339	EXECUTED	7:d2fdd52f6735f83b8e5f6b04460b54a5	createTable, addForeignKeyConstraint, insert (x2), addColumn, createTable, addForeignKeyConstraint (x2), addColumn (x2), createTable, addForeignKeyConstraint (x4), insert (x2), createTable, addForeignKeyConstraint (x2), createTable, addForeignKeyC...	Asset Status related changes\nItem related changes\nItemType related changes\nAsset related changes\nAsset Transition related changes	\N	3.2.2
#4938 - Asset Management - Pluggable Tasks	Gerhard Maree	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:26.004	340	EXECUTED	7:a30c26ed09010e0ef0bfd85459179416	insert (x3), sql, insert (x3), sql, insert (x3), update, sql, update	Register 3 new tasks:\n            FileCleanupTask - This task will delete files older than a certain time. The task is only\n                scheduled for the first entity since it will look at the same folder for all entities.\n            AssetUpd...	\N	3.2.2
20130719 #5729: - Asset Groups - Entites	Gerhard Maree	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:26.176	341	EXECUTED	7:0794a98449f5c2e12f9bed3b52bc3b1a	sql, update (x4), delete, update, addColumn (x2), insert (x2)	Asset Groups related changes	\N	3.2.2
requirement # 5292 - 09	Khobab Chaudhary	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.02	373	EXECUTED	7:299292a3b10a69946707299c7aa4529e	addForeignKeyConstraint		\N	3.2.2
spring-batch-tables	Emiliano Conde	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:26.645	342	EXECUTED	7:171c3c92d345411b881249972ed15ce1	createTable (x6)	These are the tables and sequences needed by Spring Batch to work.\n            Note that this will not work on MySQL, since it does not have sequences\n            Yet S Batch does support MySQL so there has to be some alternative	\N	3.2.2
spring-batch-key-gen-openbrm_demo	Gerhard Maree	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:26.691	343	EXECUTED	7:91b6b0a184cb3e71fc18dca5a73405f2	createSequence (x3)	These are the tables and sequences needed by Spring Batch to work on openbrm_demo.	\N	3.2.2
Customer Account Type	Rahul Asthana	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:26.77	344	EXECUTED	7:9f5503ac5a2c53c02ec46203641f4838	createTable, addForeignKeyConstraint (x5)		\N	3.2.2
add-account-type-in-jbilling_table	Rahul Asthana	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:26.785	345	EXECUTED	7:cf0e47a00053bd4f99942c4ce646b197	insert		\N	3.2.2
5015-remove-auto-payment	Gurdev Parmar	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:26.785	346	EXECUTED	7:a8840e138fbc85667758c15a348a4f1d	dropColumn		\N	3.2.2
20130514-#4987-account-type-management	Vladimir Carevski	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:26.785	347	EXECUTED	7:44dda31d011da48e31cf24dd75f36b59	insert, addColumn, addForeignKeyConstraint		\N	3.2.2
20130516-#4988-account-type-pricing	Panche Isajeski	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:26.801	348	EXECUTED	7:a3561ad5969bb383639dbbfd40165abd	createTable (x2)		\N	3.2.2
20130516-#4988-account-type-pricing-item-std-avail	Gerhard Maree	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:26.91	349	EXECUTED	7:118755081f859e1201bd197f44fbd0ba	addColumn	The follow 2 change sets are required until https://liquibase.jira.com/browse/CORE-1260 is fixed.\n            The default value for mysql should be 0 or 1 of type tinyint	\N	3.2.2
20130429-#4920	Oleg Baskakov	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.004	350	EXECUTED	7:d8cd8ca4d3f3f1cc4f3e25c049ee2a71	createTable (x2), addColumn, insert (x3)	Requirement #4920 - Create MetaField Groups.	\N	3.2.2
20130429-#4920-bool-fix	Gerhard Maree	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.129	351	EXECUTED	7:8b80ccaff04a22b6df35c6b875c8f5f3	addColumn	The follow 2 change sets are required until https://liquibase.jira.com/browse/CORE-1260 is fixed.\n            The default value for mysql should be 0 or 1 of type tinyint	\N	3.2.2
20130506-#4921	Oleg Baskakov	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.145	352	EXECUTED	7:a65ad49096481e8b5f8e32abf20ccc85	createTable	Requirement #4921 - MetaField validation rules.	\N	3.2.2
20130513-#4922	Oleg Baskakov	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.16	353	EXECUTED	7:1970e21215fc78e9db1c896c99bb0c35	addColumn, addForeignKeyConstraint	Requirements #4922 - Create Account Information Types (AIT)	\N	3.2.2
#5388-Java based Metafield validation	Panche Isajeski	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.316	354	EXECUTED	7:1387a5fbc16e5986b74c3fe3c5c49ad4	createTable, dropColumn, addColumn, addForeignKeyConstraint, createTable, insert (x2)	Metafields - Custom Java validators	\N	3.2.2
#5137-remove-contact-type-constraints-on-contact-map	Vladimir Carevski	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.348	355	EXECUTED	7:881e8c84288d3af8cffdc4d0667417ce	dropNotNullConstraint, dropForeignKeyConstraint, dropIndex, addForeignKeyConstraint		\N	3.2.2
20130531-#5237-product-dependencies	Shweta Gupta	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.629	356	EXECUTED	7:ec8bd52646e88556a9e0b14df38d0b04	createTable, addPrimaryKey, addForeignKeyConstraint (x2), createTable, addPrimaryKey, addForeignKeyConstraint (x2), createTable, addPrimaryKey, addForeignKeyConstraint (x2), createTable, addPrimaryKey, addForeignKeyConstraint (x2)		\N	3.2.2
#5293_product_inherited_order_meta_fields	Alexander Aksenov	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.66	357	EXECUTED	7:218b3ffdf03f97e2e369076b4537a734	createTable, addForeignKeyConstraint (x2)	Item related changes	\N	3.2.2
1337623084753-114	Maruthi	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.691	358	EXECUTED	7:91bbe9c305dc6d45e0ebb5712cbf6d03	createTable		\N	3.2.2
#5338 Route-based Rating	Rahul Asthana	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.738	359	EXECUTED	7:74d50fa474a8287b861d9889a09e815b	createTable		\N	3.2.2
#5557 Matching Field	Rahul Asthana	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.848	360	EXECUTED	7:b4999f87529380b9c16a22d45a9dc479	createTable, addForeignKeyConstraint, insert		\N	3.2.2
#5373 - Development: Order Hierarchies	Alexander Aksenov	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.88	361	EXECUTED	7:7bcddb9931fc77dbfc1468c28ed2166b	addColumn, addForeignKeyConstraint, addColumn, addForeignKeyConstraint		\N	3.2.2
#5712 - MF1J - Java based Metafield validation	Shweta Gupta	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.895	362	EXECUTED	7:5858b0d04db53a21ea68c7f472adbbef	addForeignKeyConstraint		\N	3.2.2
#5294_order_cancellation_fields	Bilal Nasir	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.911	363	EXECUTED	7:5e6b43749bcbda647a86bd6891fd2839	addColumn	Adding fields in purchase_order table for order cancellation fees	\N	3.2.2
#5294_order_cancellation_fields_table_entries	Bilal Nasir	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.927	364	EXECUTED	7:97b97b614724bbde22367f3d19a3ce34	insert (x3), delete (x6), update		\N	3.2.2
requirement # 5292 - 01	Khobab Chaudhary	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.927	365	EXECUTED	7:35ac07f331f3c11d41982ef04953ba2d	createTable		\N	3.2.2
requirement # 5292 - 02	Khobab Chaudhary	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.942	366	EXECUTED	7:f9a9541a223b7905f5ccf71cafa5c8af	addForeignKeyConstraint (x2)		\N	3.2.2
requirement # 5292 - 03	Khobab Chaudhary	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.989	367	EXECUTED	7:2815b73b41101a9567d0c49dde4ad0db	addColumn		\N	3.2.2
requirement # 5292 - 04	Khobab Chaudhary	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:27.989	368	EXECUTED	7:a01619e40c28ad9505f080f276c44372	addForeignKeyConstraint		\N	3.2.2
requirement # 5292 - 05	Khobab Chaudhary	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.005	369	EXECUTED	7:76b7bf5d31d076ea4ae38bb45110c3d1	createTable		\N	3.2.2
requirement # 5292 - 06	Khobab Chaudhary	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.005	370	EXECUTED	7:ae82d4daa14928c7b38f34d96d4ef4c9	createTable		\N	3.2.2
requirement # 5292 - 07	Khobab Chaudhary	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.005	371	EXECUTED	7:b2eef522b8addd13d271c89c76fa2fbf	addForeignKeyConstraint		\N	3.2.2
requirement # 5292 - 08	Khobab Chaudhary	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.02	372	EXECUTED	7:354ce8459251270332180a883ec30e4c	addForeignKeyConstraint		\N	3.2.2
requirement # 5292 - 10	Khobab Chaudhary	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.02	374	EXECUTED	7:edce3c6ab8382969e9a86616211c3b10	addForeignKeyConstraint		\N	3.2.2
requirement # 5292 - 11	Khobab Chaudhary	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.239	375	EXECUTED	7:266de35f318964ea6e5545b627d56361	addColumn (x3)		\N	3.2.2
requirement # 5292 - 15	Khobab Chaudhary	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.255	376	EXECUTED	7:47e7d73bd6ae93e363b5fdbeae40884f	insert (x2)		\N	3.2.2
requirement 5546 - 20130716	Vikas Bodani	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.27	377	EXECUTED	7:04f4f30ff077cf6232bf16ff28d07515	insert (x2)		\N	3.2.2
requirement # 5292 - remove-asset-entity-not-null-constraint	Khobab Chaudhary	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.286	378	EXECUTED	7:503c9aa34417ed7ea608a1b03a56c6d6	dropNotNullConstraint		\N	3.2.2
#5487-script-meta-field	Vladimir Carevski	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.286	379	EXECUTED	7:bdab9ba9fe71dcf375b29e12b29cf63a	addColumn		\N	3.2.2
#6168 - item_type_nullable_entity	Khobab Chaudhary	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.302	380	EXECUTED	7:db4aaea8fc94c588bbcbf5c8669f6b18	dropNotNullConstraint		\N	3.2.2
#6168 - unique constraint on item_entity_map	Vikas Bodani	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.348	381	EXECUTED	7:4dafd75c51626cba097550e5a361bf64	addUniqueConstraint		\N	3.2.2
#5711 - ait-timeline	Khobab Chaudhary	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.458	382	EXECUTED	7:417f4c5985c69d9d73152ea0c3a4a2f5	createTable, addPrimaryKey, addUniqueConstraint, addForeignKeyConstraint (x3)		\N	3.2.2
20130912-#5815 Minimum Quantities for Dependencies	Gerhard Maree	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.52	383	EXECUTED	7:d49db9f84717e284b7619fab51e4a853	createTable, addForeignKeyConstraint (x3), insert (x2)	Specify minimum and maximum quantities for product dependencies	\N	3.2.2
20130912-#5815 Migration	Gerhard Maree	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.536	384	EXECUTED	7:04be598da069bc74137fabd238e04d70	sql, dropTable (x4), update		\N	3.2.2
20130830-#5611	Maeis Gharibjanian	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.552	385	EXECUTED	7:39859cc89c1f1b4fde2672682aa2a5e8	addColumn	Adds columns to customer for credit notification limit1 and limit2	\N	3.2.2
springbatch - #5336 - 1	Khobab	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.598	386	EXECUTED	7:2f860f0f6789fb382e59594e7b5b2a3f	createTable		\N	3.2.2
springbatch - #5336 - 3	Khobab	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.645	387	EXECUTED	7:eec0f5a2272c3b8dfa082371c5f89dd7	createTable		\N	3.2.2
#5447 - Development: Order Changes as Entities	Alexander Aksenov	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.77	388	EXECUTED	7:f112cf5da994ab8cd38cccf951609b08	addColumn, addForeignKeyConstraint, insert (x7), update, createTable, addForeignKeyConstraint (x8), createTable, addForeignKeyConstraint (x2), insert (x2), update (x2), insert, update		\N	3.2.2
#5449 - Integrate Product Meta Fields into Order Changes	Gerhard Maree	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.802	389	EXECUTED	7:8e8ab3bc5294b39365aee082e96c19f7	createTable, addForeignKeyConstraint (x2), createTable, addForeignKeyConstraint (x2)	Order Change Meta Fields\nOrder Line Meta Fields	\N	3.2.2
#6719 - User Codes - Entities	Gerhard Maree	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:28.911	390	EXECUTED	7:ecc7ba52218940cc22955493a97830fa	createTable, insert, createTable, insert, sql, update		\N	3.2.2
#6593-order-line-tiers	Bilal Nasir	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.005	391	EXECUTED	7:c5ae291e303f1323fae1aef75f5825c1	createTable, addForeignKeyConstraint, insert (x4)		\N	3.2.2
#6652-olt-add-column	Amol Gadre	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.02	392	EXECUTED	7:b979830baca77dd6e95a0e345f12f5d9	addColumn		\N	3.2.2
#6652-order-add-column	Amol Gadre	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.02	393	EXECUTED	7:2c72e0d8e34d747f3815c3a22471c92f	addColumn		\N	3.2.2
account-payment-information - #6315	Khobab	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.442	394	EXECUTED	7:83a9e0c94b5a665d2dfa68895f491e2b	createTable (x7), addForeignKeyConstraint (x12), insert (x6), dropNotNullConstraint, createTable, insert, addForeignKeyConstraint (x4)		\N	3.2.2
#7308-usage-pool-consumption-notification	Amol Gadre	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.474	395	EXECUTED	7:9c648bdc6740de93779d9533edcf3bfe	insert (x2), update (x3)		\N	3.2.2
#7308-usage-pool-consumption-notification-test	Amol Gadre	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.505	396	EXECUTED	7:0eb341e7dab62b491edb3fe9932e044e	sql, insert (x5)		\N	3.2.2
#7659-Free-Usage-Pool-Consumption-enhancements	Marco Manzi	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.614	397	EXECUTED	7:883b751603c3b1299174c1a6df32e43c	createTable, insert (x102)		\N	3.2.2
#7308-fup-consumption-notification-fix1	Vishwajeet Borade	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.63	398	EXECUTED	7:1720b88970f225f807be644b2d125c28	sql		\N	3.2.2
#7308-fup-consumption-notification-fix2	Vishwajeet Borade	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.63	399	EXECUTED	7:4020163297c93573760e0645041ddcdb	sql		\N	3.2.2
#7308-fup-consumption-notification-fix3	Vishwajeet Borade	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.63	400	EXECUTED	7:d0e293b6414a84ce567927961e73ad1e	sql		\N	3.2.2
#7308-fup-consumption-notification-fix4	Vishwajeet Borade	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.645	401	EXECUTED	7:5a7cc6544394c7727cf3d163f8a2fd98	sql		\N	3.2.2
#7308-fup-consumption-notification-fix5	Vishwajeet Borade	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.645	402	EXECUTED	7:4c018f3bea4ef8a47887d4c6d2e075fa	sql		\N	3.2.2
#7308-fup-consumption-notification-fix6	Vishwajeet Borade	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.645	403	EXECUTED	7:4b81145d0c0e67bd459e28816c484296	sql		\N	3.2.2
#8048-usercodes-unique-per-company	Nelson Secchi	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.645	404	EXECUTED	7:28980cb681fbdc0e448c86dc2f04e98d	dropUniqueConstraint		\N	3.2.2
7043 - Agents and Commissions	Oscar Bidabehere	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.739	405	EXECUTED	7:63bac3333365edfa44eb80427e11b93d	addColumn (x4), createTable (x2), addColumn, createTable (x4), insert (x5), createTable, insert (x3), sql, insert (x3), sql, dropColumn (x4), dropForeignKeyConstraint, dropColumn, dropForeignKeyConstraint, dropColumn (x4), dropForeignKeyConstraint...	Add partnerType, partner.parentId, standard and master percentages\nAdd commission exception\nAdd referral commission\nAdd agent commission type property\nCreate partner commission\nCreate commission run\nCreate invoice commission\nCreate payment commiss...	\N	3.2.2
Source Readers: pluggable tasks	Marco Manzi	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.755	406	EXECUTED	7:1e1d51ff104dbbe2f25cff972dcdf3c2	insert (x3)		\N	3.2.2
Source Readers: file exchange plugin	Marco Manzi	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.755	407	EXECUTED	7:5d0b7abcbbf2287d47133aaad9b51c8a	delete (x3), insert (x5)		\N	3.2.2
#7514 - Plans Enhancement	Khobab Chaudhary	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.916	408	EXECUTED	7:3eebe2b901823f735e1af9c338fb9ab6	addColumn (x4)		\N	3.2.2
#6266-file-exchange-trigger	Vladimir Carevski	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.932	409	EXECUTED	7:95ecc9a183e2e43e0d74e6eb32f42c8a	insert (x3), update		\N	3.2.2
#7223 - Preference for enabling JQGrid on the site	Nelson Secchi	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.932	410	EXECUTED	7:0795907fcd15d8777f2df05286dbf047	insert (x3)	Should use JQGrid for tables	\N	3.2.2
#8418 - adding currency to commissions	Morales Fernando G.	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.947	411	EXECUTED	7:599beaeb7aa83fa707ea18b19b0b7258	addColumn, addForeignKeyConstraint	Add currency to commissions	\N	3.2.2
#8009-Validation message for lnvalid 'expiry date' field	Sagar Dond	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.947	412	EXECUTED	7:5f623e0c502a92b6cccc88f1f1215d76	update		\N	3.2.2
#6652 - Delete reference of order line tier	Ashok Kale	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.947	413	EXECUTED	7:bf1239f8e9385db08b1da96c0efc5e12	dropTable, delete (x2)		\N	3.2.2
agent_default_preference	Morales Fernando G.	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.963	414	EXECUTED	7:3b9f1b6dedb65bdac5086bd35e4ac733	insert (x3)	Add Agent commission type preference	\N	3.2.2
removed-order-line-tier	Mahesh Shivarkar	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.963	415	EXECUTED	7:edd844449601a623c204668044c6654f	delete (x3)	Removed unused preference for order line tiers i.e. 'Create Invoice Lines based on Order Line Tiers'	\N	3.2.2
20141104-#10343 - entity_id should not be null	Aman Goel	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:29.963	416	EXECUTED	7:3668a67b8bb39013dae8514af6fd12dd	addNotNullConstraint		\N	3.2.2
#9958 - different activeSince and activeUntil dates in same PO	Igor Poteryaev	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:30.01	417	EXECUTED	7:32f57a2b2dddc066ccbbbb147f326e81	addColumn (x2), createIndex	Add db objects for order line tiers support	\N	3.2.2
#10777 - CreditLimitationNotificationTask is missing	Juan Vidal	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:30.026	418	EXECUTED	7:9afafd7f13099e9812dbd5123a432019	insert (x7), update		\N	3.2.2
#12343-Update customer data	Fernando G. Morales	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:30.026	419	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	Empty	Set next_inovice_date value	\N	3.2.2
1337623084753-271	Maruthi	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:41.747	420	EXECUTED	7:02ad7e9bd8fd1144918bb468027fe46c	addForeignKeyConstraint		\N	3.2.2
springbatch - #5336 - 2	Khobab	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:41.778	421	EXECUTED	7:39a21db7a9339b08205baec2af2c25cc	addForeignKeyConstraint		\N	3.2.2
springbatch - #5336 - 4	Khobab	descriptors/database/jbilling-upgrade-3.4.xml	2018-10-25 17:13:41.794	422	EXECUTED	7:c10e065ed4606c7ceb3b9c7979c8338c	addForeignKeyConstraint (x2)		\N	3.2.2
add diameter entities	Emir Calabuch	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:54.631	423	EXECUTED	7:7474da8657492a7d568d0f2d67df1ed7	createTable (x2)	Tables used for managing charge sessions and reservations	\N	3.2.2
add diameter constraints	Emir Calabuch	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:54.777	424	EXECUTED	7:7eee27f2b9788785fde64962a409734c	addPrimaryKey (x2), addForeignKeyConstraint (x2)		\N	3.2.2
#4184 - Implement 'Start Session' API call	Sergio Liendo	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:54.829	425	EXECUTED	7:c5c3d38f8ce0d5cae43f534a7780aad4	insert (x9)	Preference diameter destination realm\nPreference diameter quota threshold\nPreference diameter session grace period seconds	\N	3.2.2
add data column to reserved_amounts table	Oscar Bidabehere	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:54.866	426	EXECUTED	7:ac3c9368641cd88fcfafeab62b275e20	addColumn		\N	3.2.2
add quantity column to reserved amounts table	Emir Calabuch	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:54.873	427	EXECUTED	7:716885f9c1ae83d8e2e9582867f88c2d	addColumn		\N	3.2.2
add quantity multiplier	Emir Calabuch	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:54.883	428	EXECUTED	7:2b0a54d788cfc1457414a4e8174b3f12	insert (x3)	Preference diameter unit multiplier/divisor	\N	3.2.2
#4430 - Call details in order line item	Oscar Bidabehere	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:54.896	429	EXECUTED	7:2ded88547e96ce18fd37bc03d6ad5359	addColumn		\N	3.2.2
Requirements #4501 - Per-customer automatic top-up parameters	Oscar Bidabehere	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:54.905	430	EXECUTED	7:44a56451dbd82dc5a22e7cf955c37e02	addColumn		\N	3.2.2
add carried_units column to charge_sessions table	Oscar bidabehere	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:54.913	431	EXECUTED	7:065b32fae40e53e3bb00586ff1d93359	addColumn		\N	3.2.2
20130510-#4989-customer-notes	Rahul Asthana	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:55.051	432	EXECUTED	7:542267d600932a00e7833f1129895744	createTable, addForeignKeyConstraint (x3), dropColumn, insert		\N	3.2.2
20130520-#4962-customer-notes	Rahul Asthana	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:55.051	433	EXECUTED	7:f7cd7541be674333464e0fb502bf55fe	dropColumn		\N	3.2.2
20130820-add-rating-unit	Panche Isajeski	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:55.16	434	EXECUTED	7:f825b9ce1cfb3164a9aeb9ae51e788e5	createTable, addForeignKeyConstraint		\N	3.2.2
20130820-default-rating-unit-rate-card	Panche Isajeski	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:55.191	435	EXECUTED	7:f6e1a99e5e987c5b000f24664961e211	sql, insert, update, insert		\N	3.2.2
hierarchical_routing	Vladimir Carevski	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:55.347	436	EXECUTED	7:54470187053a8dd94f3b546408606bd7	addColumn		\N	3.2.2
20131024 hierarchical_routing - default_route	Gerhard Maree	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:55.41	437	EXECUTED	7:73a67ef5edeefe72c11797d250df3f65	addColumn		\N	3.2.2
20140220 #7520 - Order Changes Type	Alexander Aksenov	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:55.519	438	EXECUTED	7:8d04933074b145c09fe06565971e099d	createTable, addForeignKeyConstraint, insert (x2), createTable, addForeignKeyConstraint (x2), createTable, addForeignKeyConstraint (x2), insert, addColumn (x2), update, addNotNullConstraint, addForeignKeyConstraint (x2)		\N	3.2.2
20140227 #7520 Order Changes Type plugin for orderStatus change	Alexander Aksenov	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:55.551	439	EXECUTED	7:fc39c0bba8b433d4e4516d9325f43546	insert (x3), update, sql, update		\N	3.2.2
#7870:fix-product-id-in-route-tables	Marco Manzi	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:55.551	440	EXECUTED	7:7c21f0dc9ff599fa785adc9cdcadd3c3	sql		\N	3.2.2
#7899 - Subscription Products	Khobab Chaudhary	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:55.566	441	EXECUTED	7:5d7de50b28e1f805ddcb8148bd2d4953	insert (x2)		\N	3.2.2
#8330:reassign_the_same_asset_for_terminated_order	Marco Manzi	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:55.582	442	EXECUTED	7:a337a286ffcf639932590b433f868335	addColumn (x3), sql, dropForeignKeyConstraint, dropColumn		\N	3.2.2
#8330:start_date_not_null	Marco Manzi	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:55.582	443	EXECUTED	7:23eba83d9ae158c19673a99d25d04d1a	addNotNullConstraint		\N	3.2.2
#8330:asset_transition_seqs	Marco Manzi	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:55.582	444	EXECUTED	7:b75bbdc1a0aa2ba7e186eec7ca08be08	update		\N	3.2.2
20140131-7219-save-nested-search-entities	Gerhard Maree	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:55.676	445	EXECUTED	7:b6933951ebfbed9db734706d9cb5fa88	createTable, addForeignKeyConstraint, insert, createTable, addForeignKeyConstraint, insert		\N	3.2.2
#7045-data_tables-set_it_as_route_table_or_not	Juan Vidal	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:55.801	446	EXECUTED	7:4cb57fd508df0b3a0fc71f3a61a701a3	addColumn		\N	3.2.2
#10045:reverting_the_asset_transition_history	Marco Manzi	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:55.894	447	EXECUTED	7:39af65a616fa06660e7b74ae0e23a5f7	addColumn, addForeignKeyConstraint, sql, dropColumn (x3)		\N	3.2.2
requirement # 9831 - global assets	Rohit Gupta	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:56.035	448	EXECUTED	7:63938f5b0e754adaa49f994eb2b85fe6	addColumn, createTable, addForeignKeyConstraint (x2), addUniqueConstraint		\N	3.2.2
20141104-#10343 - entity_id should not be null	Aman Goel	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:56.035	449	EXECUTED	7:3668a67b8bb39013dae8514af6fd12dd	addNotNullConstraint		\N	3.2.2
20141124-rename-partner-to-Agent	Vikas Bodani	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:56.035	450	EXECUTED	7:4859237ad017f452ef2155abda6b4464	update, delete (x4)	Preference Types 5 through 12 should not being used anywhere. Partner is replaced with Agent.	\N	3.2.2
20141126-rename-ForeignKeyConstraint	Manisha Gupta	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:56.051	451	EXECUTED	7:fda82f25a00179dedcf9f67836402b07	dropForeignKeyConstraint, addForeignKeyConstraint (x2)		\N	3.2.2
10632-event_base_custom_notification_fix	Marco Manzi	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:56.051	452	EXECUTED	7:1f7f8b0812a4163b203762c36a11ea5c	update		\N	3.2.2
#9977:Partner-To-Agent-Fix-demo-data	Marco Manzi	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:56.066	453	EXECUTED	7:60627975097a4d3abe0e1b0b175846c7	update (x9)		\N	3.2.2
#10901-Replacing Partner to Agents in Permissions page	Anand Kushwaha	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:56.066	454	EXECUTED	7:7c98ed064910d41ca61e8868af0a2ff2	update		\N	3.2.2
Rename MENU_93	Manisha Gupta	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:56.082	455	EXECUTED	7:bf1ad825a0ea3e5c9311a5f597535a50	update		\N	3.2.2
#11172-show-category-metafields	Prashant Gupta	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:56.082	456	EXECUTED	7:ec5dfc56eb7419cb522aa6bb6c3b624e	createTable, addForeignKeyConstraint (x2)		\N	3.2.2
#10442 Adding All Account TypecheckboxinpaymentMethodType edit	Anand Kushwaha	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:56.16	457	EXECUTED	7:81128e7021979b4ec0fcf54a7b4c8bd6	addColumn		\N	3.2.2
20150114 - late guided usage delete order	Vikas Bodani	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:56.176	458	EXECUTED	7:3682052d466ffa1aa85a045098bd8347	addColumn		\N	3.2.2
11565-added-invoice-reminder-name	Prashant Gupta	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:56.191	459	EXECUTED	7:229e007d8500b0b5648cc728c5b1ba0a	insert		\N	3.2.2
#12690-index-on_parent_id-customer-table	Prashant Gupta	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:56.238	460	EXECUTED	7:60d91cf9ee88b4c8a882cac11c530057	createIndex		\N	3.2.2
#12691-Add field_usage column	Ravi Singhal	descriptors/database/jbilling-upgrade-4.0.xml	2018-10-25 17:13:56.254	461	EXECUTED	7:a724cdd8bf6164cf36fb2a59241efbe7	addColumn, sql, dropTable	Drop table metafield_type_map. One meta field can have only one usage type.	\N	3.2.2
#6316-new-password-column-size	Maeis Gharibjanian	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:25.598	462	EXECUTED	7:a69af898af6060ad2d0517488e188a44	modifyDataType	Increasing the size of the password column. This should be enough to store\n            most hashes generated from known hashing methods plus the generated salt.	\N	3.2.2
#6316-hashing-method-column	Khurram M Cheema	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:25.614	463	EXECUTED	7:036f9f96c6e43aac3f5b9d35f2dfdcc0	addColumn, update, addNotNullConstraint	Adding a column to represent the encryption scheme. Here we are assuming that\n            all clients are sticking to the default password hashing method which is MD5.	\N	3.2.2
#10595-Password lockout for failed login attempts	Bilal Shah	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:25.645	464	EXECUTED	7:f07d2c0f2498e8ef7b2587fc9a9aff76	addColumn, insert (x3), update, insert (x2)	Constant ID may need to be changed during merging of this feature to later branches to avoid overlapping with other preference IDs	\N	3.2.2
#11107 - Line Percentage	Rohit Gupta	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:25.958	465	EXECUTED	7:6db888e7c55aeb530e55840193ee6d23	dropColumn, addColumn (x2)		\N	3.2.2
#10256:Asset Reservation	Morales Fernando G.	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.192	466	EXECUTED	7:cedb8fafce6fbd6013eb22a57c560123	addColumn, createTable, createIndex, addForeignKeyConstraint (x3)	Adding reservation parameter\nAsset reservation table\nAdding indexes	\N	3.2.2
#11243-AIT-Inhancement	Rohit Gupta	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.208	467	EXECUTED	7:14eae727b861c4856f58f3c2d09763a0	addColumn		\N	3.2.2
20141030-#10344-asset-assignment-history	Vladimir Carevski	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.286	468	EXECUTED	7:5fbe0a2774db17deb42fb03d95d25ebb	createTable, addForeignKeyConstraint (x2), insert (x2), sql, update	#10344 Implementing the asset assignment feature	\N	3.2.2
#10355 - reset password after expiry period	Bilal Shah	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.395	469	EXECUTED	7:68f190ea4b1614612a893e12fe5e57d9	createTable		\N	3.2.2
21	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:59.852	505	EXECUTED	7:e45440207013f759dadb51ea9575edd8	createTable		\N	3.2.2
20150307-missing-not-null-constraint	Vikas Bodani	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.411	470	EXECUTED	7:c9267f9080df0cefd6cf3eec8330da71	addNotNullConstraint		\N	3.2.2
#8922-20150309-customer-price-active-expiry-date	Vikas Bodani	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.426	471	EXECUTED	7:dbaf95d6034043e784fb1a86a90e9583	addColumn	Price subscription and expiration dates for customer price. Price expiration dates for Account Type price	\N	3.2.2
#10256:Asset Reservation scheduler plugin	Aman Goel	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.426	472	EXECUTED	7:90aea8639ce31a2f7ac2f3ec125763cb	update		\N	3.2.2
#11369-Feature to identify inactive accounts	Aadil Nazir	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.442	473	EXECUTED	7:0029c3ea1466b22e1614446811447527	addColumn, insert (x6)	#11369 Develop ability to identify inactive accounts\nAdded new column in base_user, value is set to date on which a user is marked in-active\nAdd new preference of Number of days after which a User's account will become inactive\nConstant ID may nee...	\N	3.2.2
#11369-Report for Feature to identify inactive accounts	Aadil Nazir	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.473	474	EXECUTED	7:2d1c3191bac0f451e55b33913117f2c1	insert (x5)		\N	3.2.2
#10815-filter-key-data	Aman Goel	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.473	475	EXECUTED	7:356b48eb7828a2853e02eafcf06bb88c	addColumn		\N	3.2.2
#12636-granting-user-credentials	Javier Rivero	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.489	476	EXECUTED	7:ed963aa825b6157a3ec6bc956fd4b38c	insert (x3)		\N	3.2.2
#12702:Default credentials changed	Nelson Secchi	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.505	477	EXECUTED	7:35065b00a050ae10ca0042bd16557ba3	insert (x3)	Description for the preference type, this is shown on the list of preferences	\N	3.2.2
#12702:Credentials email message notification	Nelson Secchi	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.52	478	EXECUTED	7:783b49539fb94b3473a4a1d0da39b7ff	insert (x2)	We need a new message for when credentials are being created\nDefine the notification message type. For new entities, this id will be used on EntityDefaults	\N	3.2.2
#12686_Default_Security_Preferences:validation_rules	Fernando G. Morales	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.551	479	EXECUTED	7:53dd8bd71fcea8b8569fce4179903be3	addColumn, addForeignKeyConstraint, insert (x4), update, insert (x4), update, insert (x4), update	Add validation rule to the preference type\nDefine validation rules and add to preferences\nSet rule for preference: Lock-out user after failed login attempts\nSet rule for preference: 'Expire user passwords after days'\nSet rule for preference: 'Expi...	\N	3.2.2
#12686_Default_Security_Preferences:remove_preferences	Fernando G. Morales	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.567	480	EXECUTED	7:1883338c62a37c25051f10319d25f896	delete (x3)	Removed the HIDE CC CARD NUMBER preference	\N	3.2.2
#12686_Default_Security_Preferences:validation_rules for Telco-4.1	Nelson Secchi	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.583	481	EXECUTED	7:e5405d4382d92d96ba131c215d32b5b4	update (x2)	Reverts the validation set for validation rule 69\nSet rule for preference: 'Expire Inactive Accounts After Days'\nThis assumes that the last changeset that added validations was #12686_Default_Security_Preferences:validation_rules	\N	3.2.2
#12602-audit-log-user-related-information	Bilal Shah	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.598	482	EXECUTED	7:ece4e4787c89579d6f4d3559b3e10a19	insert (x6)		\N	3.2.2
#08072015	Ravi Singhal	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.598	483	EXECUTED	7:b29f6452dfcfb3d951ab0707167fcafd	update		\N	3.2.2
#14013 Adding Asset reservation minute and it's validation	Vivek Yadav	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.63	484	EXECUTED	7:00c17424aaffa96a0d0b97ef9d232db2	insert (x7)	Adding default reservation minute for asset reservation\nAdd validation rule for Asset reservation duration	\N	3.2.2
Removing PricingRuleTask	Manisha Gupta	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.63	485	EXECUTED	7:6c0d9c3a2b606d6eee9f88f5a7afb064	delete (x3)		\N	3.2.2
Removing Preferences for mediation, provisioning and ITG	Manisha Gupta	descriptors/database/jbilling-upgrade-4.1.xml	2018-10-25 17:14:26.645	486	EXECUTED	7:8341a3e69161ab22b689419a01f98f22	delete (x2)		\N	3.2.2
1	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:58.493	487	EXECUTED	7:8a2084c3a91d14978be72aaaca6e2a20	createTable		\N	3.2.2
2	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:58.681	488	EXECUTED	7:a3018470a4a2762b9071fcbd95bdb54b	createTable		\N	3.2.2
3	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:58.759	489	EXECUTED	7:f77fea8965f76ac1db3a6740614897a3	createTable		\N	3.2.2
4	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:58.852	490	EXECUTED	7:d4054d723267e3469696c34e057f355b	createTable		\N	3.2.2
5	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:58.915	491	EXECUTED	7:916763481fec338d287d3bdf9eef4465	createTable		\N	3.2.2
6	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:59.024	492	EXECUTED	7:8cc4528fb9833de00cc48e0dc30846c0	createTable		\N	3.2.2
7	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:59.056	493	EXECUTED	7:1251e5b41f89330198586d11be69daa8	createTable		\N	3.2.2
9	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:59.102	494	EXECUTED	7:d7dd1f5d6f9751d94161aaad66e98ea9	createTable		\N	3.2.2
10	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:59.165	495	EXECUTED	7:d557dfdb6111d31fbb4276d016a88810	createTable		\N	3.2.2
11	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:59.212	496	EXECUTED	7:b623c7a60fec5c508a78abc2e3022b25	createTable		\N	3.2.2
12	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:59.274	497	EXECUTED	7:7239b3d721fa069ce11e81a1e2414fe7	createTable		\N	3.2.2
13	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:59.337	498	EXECUTED	7:48ad107ab99b6e3ab0e3b17841e661c2	createTable		\N	3.2.2
14	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:59.415	499	EXECUTED	7:d188ef3f23e0010de2fc7e610e7c1dfe	createTable		\N	3.2.2
15	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:59.524	500	EXECUTED	7:6ee79a511cea93cfff7a86d32e3667f3	createTable		\N	3.2.2
16	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:59.649	501	EXECUTED	7:2e0009409f5bb19d47827c00c4dd2e03	createTable		\N	3.2.2
17	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:59.727	502	EXECUTED	7:2d1467087b50bda112cbc6c0bfc0120f	createTable		\N	3.2.2
19	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:59.79	503	EXECUTED	7:d9095f7c65fadaafd94c1599a864667c	createTable		\N	3.2.2
20	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:59.806	504	EXECUTED	7:59ad4eaf11e4daa694d080b77a68b2e5	createTable		\N	3.2.2
23	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:14:59.993	507	EXECUTED	7:f50aad73b1f84515a5b12f86d602b068	createTable		\N	3.2.2
24	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.04	508	EXECUTED	7:c4bd80be6f7fda8070ba30ba97a3e20e	createTable		\N	3.2.2
25	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.087	509	EXECUTED	7:8b225b4998a28a6f83144ef83b12040e	createTable		\N	3.2.2
26	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.181	510	EXECUTED	7:8768f89b05aa7a3cd164d7d97ee96bb9	createTable		\N	3.2.2
27	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.228	511	EXECUTED	7:761239ee676836213633bf054630f39d	createTable		\N	3.2.2
27-01	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.29	512	EXECUTED	7:de66cd4f80b21fade7fc25590eb2ab2c	addUniqueConstraint		\N	3.2.2
28	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.353	513	EXECUTED	7:a40ec1119b5ee1eed2cc0a557918a5b4	createTable		\N	3.2.2
29	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.431	514	EXECUTED	7:92dce3cccb043a769e4220ce43781aae	createTable		\N	3.2.2
30	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.478	515	EXECUTED	7:3790f4d9f3f0593b7aa6a7966cd3976f	createTable		\N	3.2.2
30-01	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.54	516	EXECUTED	7:d80b8333c291ffd033c415a28bff4af8	createIndex		\N	3.2.2
30-02	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.603	517	EXECUTED	7:b786c591e505e5e673657636729905f7	createIndex		\N	3.2.2
30-03	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.665	518	EXECUTED	7:f465c0054f8bbe53fe1eac578432cbc9	createIndex		\N	3.2.2
31	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.728	519	EXECUTED	7:62232d7b467c78b64e1e8b91a425dc95	createTable		\N	3.2.2
32	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.775	520	EXECUTED	7:111f7dbf8741a5ba17ac1276e6cd6237	createTable		\N	3.2.2
32-01	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.822	521	EXECUTED	7:804e53188bfa62b3db4ee7d78192740f	createIndex		\N	3.2.2
33	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.9	522	EXECUTED	7:2bab3f674d8d9bbed7f7e377ec980798	createTable		\N	3.2.2
34	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.9	523	EXECUTED	7:9782a098f8c9a64308e2179e8e05bb55	createTable		\N	3.2.2
34-01	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:00.962	524	EXECUTED	7:fa641e4315f780ca71d7b2d1e1f7a5d9	createIndex		\N	3.2.2
34-02	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.009	525	EXECUTED	7:a219cb48f0a96c085f2342d93cbaf7d2	createIndex		\N	3.2.2
35	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.072	526	EXECUTED	7:5b481259fdb1a13e1de963e9461f6c68	createTable		\N	3.2.2
35-01	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.118	527	EXECUTED	7:7656e34222549aee86370efcab8f5e97	createIndex		\N	3.2.2
36	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.211	528	EXECUTED	7:e2926d4505f2a872fb40e831842e9bb4	createTable		\N	3.2.2
36-01	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.275	529	EXECUTED	7:95bc5077d43607670c26d1b4c00c3530	createIndex		\N	3.2.2
36-03	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.319	530	EXECUTED	7:ff535ea485352539b01b766385a392d2	createIndex		\N	3.2.2
36-04	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.365	531	EXECUTED	7:e7de4e989de7e48546150e94dbea1acb	createIndex		\N	3.2.2
37	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.418	532	EXECUTED	7:7777ced8dda63e667680b9e24c3eb77a	createTable		\N	3.2.2
37-01	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.477	533	EXECUTED	7:eb44789a43bbcb44d1241b66415a40cc	createIndex		\N	3.2.2
37-02	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.551	534	EXECUTED	7:c3043bdef4e6066bd62065ea0620a002	createIndex		\N	3.2.2
38	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.645	535	EXECUTED	7:38fbe3d6823fb4e7d99a2e1e84e743f0	createTable		\N	3.2.2
38-01	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.691	536	EXECUTED	7:155450123a8781527a871e1a050b2381	createIndex		\N	3.2.2
39	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.77	537	EXECUTED	7:93035b693c117540ad028ce90d542666	createTable		\N	3.2.2
40	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.816	538	EXECUTED	7:b52377872bd5f2979b396437954af2e9	createTable		\N	3.2.2
41	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.895	539	EXECUTED	7:9757010af23b9eb80fb43905fd702760	createTable		\N	3.2.2
41-01	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.941	540	EXECUTED	7:9ddcc1a1fe06298067bc95cb755eaf0d	createIndex		\N	3.2.2
42	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:01.988	541	EXECUTED	7:a4fb735b515c0e1199846e90f1d9075a	createTable		\N	3.2.2
42-01	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:02.066	542	EXECUTED	7:ae62af388e49250d04a21ddcc903943b	createIndex		\N	3.2.2
42-02	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:02.113	543	EXECUTED	7:000f6896d93d86c9c5844af9edd025d0	createIndex		\N	3.2.2
43	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:02.16	544	EXECUTED	7:778bd817e5201cdf7497b12992a0d4a1	createTable		\N	3.2.2
43-01	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:02.207	545	EXECUTED	7:c6ca30a1ac988f5bd3df2332419128f2	createIndex		\N	3.2.2
43-02	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:02.27	546	EXECUTED	7:f1e5dcf71fbc1678d008a9244cd4a04c	createIndex		\N	3.2.2
44	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:02.332	547	EXECUTED	7:2e0c5710b36b31bdf395aca32b5971ba	createTable		\N	3.2.2
45	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:02.379	548	EXECUTED	7:55c6996eb3c84e127a9bc69d2a37a7d0	createTable		\N	3.2.2
46	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:02.442	549	EXECUTED	7:8659d42be393a3364a39f8f201b2cafe	createTable		\N	3.2.2
46-01	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:02.488	550	EXECUTED	7:f1d5a0edaec68e07db37af34497d22fa	createIndex		\N	3.2.2
46-02	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:02.551	551	EXECUTED	7:3f3c95dd74c49dc177141c268b148585	createIndex		\N	3.2.2
47	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:02.613	552	EXECUTED	7:b1dff5baf378c1bff0a9f7a538a2e8c2	createTable		\N	3.2.2
47-01	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:02.66	553	EXECUTED	7:32bfe80fd217f8f3fcf33207546da8ee	createIndex		\N	3.2.2
48	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:02.723	554	EXECUTED	7:15a423ae72ad8628e535783c2453d6e8	createTable		\N	3.2.2
49	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:02.785	555	EXECUTED	7:135307037a18f79cfe8f6bda1bafcbcf	createTable		\N	3.2.2
49-01	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:02.832	556	EXECUTED	7:ca5313f3f7ae2df9d568a86635b8fb60	createIndex		\N	3.2.2
50	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:02.942	557	EXECUTED	7:bfa4aa9dcc28907cc1610d259dbdfc22	createTable		\N	3.2.2
51	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.02	558	EXECUTED	7:ae99bfbec7150b9a7743cf4cc1a79eef	createTable		\N	3.2.2
52	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.098	559	EXECUTED	7:cd14513d85c0d5f92ae429b557719719	createTable		\N	3.2.2
53	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.176	560	EXECUTED	7:973b6a6058b0498735fa6d9a6c6120fd	createTable		\N	3.2.2
54	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.238	561	EXECUTED	7:ebc6819071823327c383abfd8c33dd9e	createTable		\N	3.2.2
55	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.254	562	EXECUTED	7:808113e58304770e7aeb322ac2996327	createTable		\N	3.2.2
56	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.27	563	EXECUTED	7:a75b508fca84972b43f6827cec15e13d	createTable		\N	3.2.2
57	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.285	564	EXECUTED	7:e82d614b0a5afa61ddac5e1cc3abe040	createTable		\N	3.2.2
57-01	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.363	565	EXECUTED	7:c063b45130df4ec7571b6e55e7b8701f	createIndex		\N	3.2.2
57-02	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.426	566	EXECUTED	7:45ce26001a01e831b8ee2d5ae0299fd8	createIndex		\N	3.2.2
58	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.488	567	EXECUTED	7:26556c21c13bd25aa423d308090fef83	createTable		\N	3.2.2
58-01	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.535	568	EXECUTED	7:0d9107f8551aeccd23185a9d11389a7e	createIndex		\N	3.2.2
58-02	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.598	569	EXECUTED	7:b05bb763af699a8c3736e6bae92d9b45	createIndex		\N	3.2.2
58-03	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.629	570	EXECUTED	7:2418bca4e5428057a166162fe1e1233c	createIndex		\N	3.2.2
58-04	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.692	571	EXECUTED	7:032e109bbe993928bfe643abf40af562	createIndex		\N	3.2.2
58-05	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.738	572	EXECUTED	7:663d0ec51c3683a707213d804e795ca2	createIndex		\N	3.2.2
58-06	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.785	573	EXECUTED	7:47fefe42eedd67faca2346228b983b67	createIndex		\N	3.2.2
58-07	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.832	574	EXECUTED	7:7c85f030e1397fa6b623599524f1955b	createIndex		\N	3.2.2
58-08	Emiliano Conde	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.879	575	EXECUTED	7:c0eba6dfd4a1d96ffd8379c45719e6c7	createIndex		\N	3.2.2
59	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.926	576	EXECUTED	7:763f36b20344e4e5835aa263324cb336	createTable		\N	3.2.2
60	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.942	577	EXECUTED	7:c2f6f45f06fce0b10cf511fb18c28844	createTable		\N	3.2.2
61	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:03.989	578	EXECUTED	7:04b9e032303979e784b890b78779b30f	createTable		\N	3.2.2
62	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:04.051	579	EXECUTED	7:6ff6adda1a181d70e1672cffe15dd535	createTable		\N	3.2.2
63	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:04.114	580	EXECUTED	7:36945a24f0a7657a371291a59e815018	createTable		\N	3.2.2
64	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:04.192	581	EXECUTED	7:ed7759bbfc4809e5765790ae66459e3e	createTable		\N	3.2.2
65	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:04.239	582	EXECUTED	7:99874eb2554e0d54a340f8fdebfb85d7	createTable		\N	3.2.2
66	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:04.379	583	EXECUTED	7:01559b8ea126c03847eee5ac5c6a56ed	createTable		\N	3.2.2
67	han	descriptors/database/openbrm-4-schema.xml	2018-10-25 17:15:04.442	584	EXECUTED	7:7bcd054f019a276dd1fbe52db43bc341	createTable		\N	3.2.2
1	Han	descriptors/database/openbrm-4-data.xml	2018-10-25 17:15:29.227	585	EXECUTED	7:97f0afe69b43f4385a0e137ef25a3e6f	insert (x4)		\N	3.2.2
5	Han	descriptors/database/openbrm-4-data.xml	2018-10-25 17:15:29.243	586	EXECUTED	7:490e71c349ac9f4c557163c24209a94f	insert (x3)		\N	3.2.2
6	Han	descriptors/database/openbrm-4-data.xml	2018-10-25 17:15:29.258	587	EXECUTED	7:86d68d87975b842cee0b168c0d6363a7	insert (x7)		\N	3.2.2
7	Han	descriptors/database/openbrm-4-data.xml	2018-10-25 17:15:29.289	588	EXECUTED	7:78dc6b5a1fa3c24c4b3b0503702d5ef7	insert (x7)		\N	3.2.2
8	Han	descriptors/database/openbrm-4-data.xml	2018-10-25 17:15:29.305	589	EXECUTED	7:a21efd2a8412bbdd31d597395b14c20a	insert		\N	3.2.2
9	Han	descriptors/database/openbrm-4-data.xml	2018-10-25 17:15:29.352	590	EXECUTED	7:d5fa2c937f513224253fbdd8790c4522	insert (x2)		\N	3.2.2
\.


--
-- TOC entry 3833 (class 0 OID 264698)
-- Dependencies: 221
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- TOC entry 3834 (class 0 OID 264701)
-- Dependencies: 222
-- Data for Name: destination_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY destination_map (id, map_group, prefix, tier_code, description, category, rank) FROM stdin;
\.


--
-- TOC entry 3835 (class 0 OID 264705)
-- Dependencies: 223
-- Data for Name: device; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY device (id, type_id, serial_num, device_code, vendor_code, status_id, created_date, last_updated_date, deleted, optlock, entity_id, icc, imsi, puk1, puk2, pin1, pin2) FROM stdin;
\.


--
-- TOC entry 3836 (class 0 OID 264712)
-- Dependencies: 224
-- Data for Name: device_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY device_type (id) FROM stdin;
1
2
3
4
\.


--
-- TOC entry 3837 (class 0 OID 264715)
-- Dependencies: 225
-- Data for Name: discount; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY discount (id, code, discount_type, rate, start_date, end_date, entity_id, last_update_datetime) FROM stdin;
\.


--
-- TOC entry 3838 (class 0 OID 264718)
-- Dependencies: 226
-- Data for Name: discount_attribute; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY discount_attribute (discount_id, attribute_name, attribute_value) FROM stdin;
\.


--
-- TOC entry 3839 (class 0 OID 264724)
-- Dependencies: 227
-- Data for Name: discount_line; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY discount_line (id, discount_id, item_id, order_id, discount_order_line_id, order_line_amount, description) FROM stdin;
\.


--
-- TOC entry 3840 (class 0 OID 264730)
-- Dependencies: 228
-- Data for Name: entity; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY entity (id, external_id, description, create_datetime, language_id, currency_id, optlock, deleted, invoice_as_reseller, parent_id) FROM stdin;
10	\N	openbrm	2018-10-25 17:20:53.122	1	1	1	0	f	\N
\.


--
-- TOC entry 3841 (class 0 OID 264735)
-- Dependencies: 229
-- Data for Name: entity_delivery_method_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY entity_delivery_method_map (method_id, entity_id) FROM stdin;
1	10
2	10
3	10
\.


--
-- TOC entry 3842 (class 0 OID 264738)
-- Dependencies: 230
-- Data for Name: entity_payment_method_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY entity_payment_method_map (entity_id, payment_method_id) FROM stdin;
10	1
10	2
10	3
\.


--
-- TOC entry 3843 (class 0 OID 264741)
-- Dependencies: 231
-- Data for Name: entity_report_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY entity_report_map (report_id, entity_id) FROM stdin;
3	10
11	10
12	10
13	10
9	10
8	10
1	10
4	10
2	10
5	10
6	10
7	10
\.


--
-- TOC entry 3844 (class 0 OID 264744)
-- Dependencies: 232
-- Data for Name: enumeration; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY enumeration (id, entity_id, name, optlock) FROM stdin;
10	10	ach.account.type	0
\.


--
-- TOC entry 3845 (class 0 OID 264747)
-- Dependencies: 233
-- Data for Name: enumeration_values; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY enumeration_values (id, enumeration_id, value, optlock) FROM stdin;
1000	10	CHECKING	0
1001	10	SAVINGS	0
\.


--
-- TOC entry 3846 (class 0 OID 264750)
-- Dependencies: 234
-- Data for Name: event_log; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY event_log (id, entity_id, user_id, table_id, foreign_id, create_datetime, level_field, module_id, message_id, old_num, old_str, old_date, optlock, affected_user_id) FROM stdin;
1000	10	\N	10	10	2018-10-25 17:22:24.111	2	2	38	\N	admin	\N	0	10
1001	10	10	25	31	2018-10-25 17:23:10.689	2	11	25	\N	\N	\N	0	\N
1002	10	10	25	32	2018-10-25 17:23:22.39	2	11	25	\N	\N	\N	0	\N
1003	10	10	25	33	2018-10-25 17:24:25.943	2	11	25	\N	\N	\N	0	\N
1004	10	10	25	34	2018-10-25 17:27:59.475	2	11	25	\N	\N	\N	0	\N
2000	10	\N	10	10	2018-10-27 11:43:21.882	2	2	38	\N	admin	\N	0	10
2001	10	10	25	33	2018-10-27 11:47:22.143	2	11	9	\N	\N	\N	0	\N
2002	10	10	34	100	2018-10-27 11:56:07.24	2	1	9	1	\N	\N	0	\N
2003	10	10	25	34	2018-10-27 11:56:47.92	2	11	9	\N	\N	\N	0	\N
3000	10	\N	10	10	2018-10-27 19:01:48.572	2	2	38	\N	admin	\N	0	10
3001	10	10	25	33	2018-10-27 19:03:05.435	2	11	9	\N	\N	\N	0	\N
3002	10	10	25	34	2018-10-27 19:04:50.435	2	11	9	\N	\N	\N	0	\N
4000	10	\N	10	10	2018-10-29 14:57:28.502	2	2	38	\N	admin	\N	0	10
\.


--
-- TOC entry 3847 (class 0 OID 264756)
-- Dependencies: 235
-- Data for Name: event_log_message; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY event_log_message (id) FROM stdin;
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
\.


--
-- TOC entry 3848 (class 0 OID 264759)
-- Dependencies: 236
-- Data for Name: event_log_module; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY event_log_module (id) FROM stdin;
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
\.


--
-- TOC entry 3849 (class 0 OID 264762)
-- Dependencies: 237
-- Data for Name: event_type_rate_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY event_type_rate_map (id, charge_rate_id, event_type_id, data_type, customer_readonly, optlock) FROM stdin;
\.


--
-- TOC entry 3850 (class 0 OID 264765)
-- Dependencies: 238
-- Data for Name: ex_rate; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY ex_rate (id, prefix, destination, field1, field2, version, deleted, rate_plan, created_date, valid_from, valid_to, last_updated_date, entity_id) FROM stdin;
\.


--
-- TOC entry 3851 (class 0 OID 264770)
-- Dependencies: 239
-- Data for Name: filter; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY filter (id, filter_set_id, type, constraint_type, field, template, visible, integer_value, string_value, start_date_value, end_date_value, version, boolean_value, decimal_value, decimal_high_value, field_key_data) FROM stdin;
\.


--
-- TOC entry 3852 (class 0 OID 264776)
-- Dependencies: 240
-- Data for Name: filter_set; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY filter_set (id, name, user_id, version) FROM stdin;
\.


--
-- TOC entry 3854 (class 0 OID 264781)
-- Dependencies: 242
-- Data for Name: filter_set_filter; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY filter_set_filter (filter_set_filters_id, filter_id, id) FROM stdin;
\.


--
-- TOC entry 4037 (class 0 OID 0)
-- Dependencies: 241
-- Name: filter_set_filter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: openbrm_demo
--

SELECT pg_catalog.setval('filter_set_filter_id_seq', 1, false);


--
-- TOC entry 3855 (class 0 OID 264785)
-- Dependencies: 243
-- Data for Name: generic_status; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY generic_status (id, dtype, status_value, can_login, ordr, attribute1, entity_id, deleted) FROM stdin;
9	subscriber_status	1	\N	\N	\N	\N	\N
10	subscriber_status	2	\N	\N	\N	\N	\N
11	subscriber_status	3	\N	\N	\N	\N	\N
12	subscriber_status	4	\N	\N	\N	\N	\N
13	subscriber_status	5	\N	\N	\N	\N	\N
14	subscriber_status	6	\N	\N	\N	\N	\N
15	subscriber_status	7	\N	\N	\N	\N	\N
16	order_status	1	\N	\N	\N	\N	\N
17	order_status	2	\N	\N	\N	\N	\N
18	order_status	3	\N	\N	\N	\N	\N
19	order_status	4	\N	\N	\N	\N	\N
26	invoice_status	1	\N	\N	\N	\N	\N
27	invoice_status	2	\N	\N	\N	\N	\N
28	invoice_status	3	\N	\N	\N	\N	\N
33	process_run_status	1	\N	\N	\N	\N	\N
34	process_run_status	2	\N	\N	\N	\N	\N
35	process_run_status	3	\N	\N	\N	\N	\N
207	service_status	1	\N	\N	\N	\N	\N
208	service_status	2	\N	\N	\N	\N	\N
225	mediation_record_status	1	\N	\N	\N	\N	\N
226	mediation_record_status	2	\N	\N	\N	\N	\N
227	mediation_record_status	3	\N	\N	\N	\N	\N
228	mediation_record_status	4	\N	\N	\N	\N	\N
52	voucher_status	1	0	\N	\N	\N	\N
53	voucher_status	2	0	\N	\N	\N	\N
54	voucher_status	3	0	\N	\N	\N	\N
55	voucher_status	4	0	\N	\N	\N	\N
56	voucher_status	5	0	\N	\N	\N	\N
62	bundle_status	1	\N	\N	\N	\N	\N
63	bundle_status	2	\N	\N	\N	\N	\N
64	bundle_status	3	\N	\N	\N	\N	\N
229	order_change_status	1	\N	0	NO	\N	0
230	order_change_status	2	\N	0	NO	\N	0
231	order_change_status	3	\N	1	YES	10	0
\.


--
-- TOC entry 3856 (class 0 OID 264788)
-- Dependencies: 244
-- Data for Name: generic_status_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY generic_status_type (id) FROM stdin;
order_status
subscriber_status
user_status
invoice_status
process_run_status
service_status
mediation_record_status
voucher_status
bundle_status
order_change_status
\.


--
-- TOC entry 3857 (class 0 OID 264791)
-- Dependencies: 245
-- Data for Name: international_description; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY international_description (table_id, foreign_id, psudo_column, language_id, content) FROM stdin;
17	5	description	1	All Orders
50	20	description	1	Manual invoice deletion
46	9	description	1	Invoice maintenance
46	11	description	1	Pluggable tasks maintenance
47	16	description	1	A purchase order as been manually applied to an invoice.
52	17	description	1	Payment (failed)
52	16	description	1	Payment (successful)
35	7	description	1	Diners
50	16	description	1	Days before expiration for order notification 2
50	17	description	1	Days before expiration for order notification 3
52	13	description	1	Order about to expire. Step 1
52	14	description	1	Order about to expire. Step 2
52	15	description	1	Order about to expire. Step 3
35	4	description	1	AMEX
35	5	description	1	ACH
50	14	description	1	Include customer notes in invoice
50	18	description	1	Invoice number prefix
64	234	description	1	Wallis and Futuna
64	235	description	1	Yemen
64	236	description	1	Zambia
64	237	description	1	Zimbabwe
50	15	description	1	Days before expiration for order notification
50	21	description	1	Use invoice reminders
50	22	description	1	Number of days after the invoice generation for the first reminder
50	23	description	1	Number of days for next reminder
64	227	description	1	Uzbekistan
64	147	description	1	Nauru
64	148	description	1	Nepal
64	149	description	1	Netherlands
64	150	description	1	Netherlands Antilles
64	151	description	1	New Caledonia
64	152	description	1	New Zealand
64	153	description	1	Nicaragua
64	154	description	1	Niger
64	155	description	1	Nigeria
64	156	description	1	Niue
64	157	description	1	Norfolk Island
64	158	description	1	North Korea
64	159	description	1	Northern Mariana Islands
64	160	description	1	Norway
64	161	description	1	Oman
64	162	description	1	Pakistan
64	163	description	1	Palau
64	164	description	1	Panama
64	165	description	1	Papua New Guinea
64	166	description	1	Paraguay
64	167	description	1	Peru
64	168	description	1	Philippines
64	169	description	1	Pitcairn Islands
64	170	description	1	Poland
64	171	description	1	Portugal
64	172	description	1	Puerto Rico
64	173	description	1	Qatar
64	174	description	1	Reunion
64	175	description	1	Romania
64	176	description	1	Russia
64	177	description	1	Rwanda
64	178	description	1	Samoa
64	179	description	1	San Marino
64	180	description	1	Sao Tome and Principe
64	181	description	1	Saudi Arabia
64	182	description	1	Senegal
64	183	description	1	Serbia and Montenegro
64	184	description	1	Seychelles
64	185	description	1	Sierra Leone
64	186	description	1	Singapore
64	187	description	1	Slovakia
64	188	description	1	Slovenia
64	189	description	1	Solomon Islands
64	190	description	1	Somalia
64	191	description	1	South Africa
64	192	description	1	South Georgia and the South Sandwich Islands
64	193	description	1	Spain
64	194	description	1	Sri Lanka
64	195	description	1	St. Helena
64	196	description	1	St. Kitts and Nevis
64	197	description	1	St. Lucia
64	198	description	1	St. Pierre and Miquelon
64	199	description	1	St. Vincent and the Grenadines
64	200	description	1	Sudan
64	201	description	1	Suriname
64	202	description	1	Svalbard and Jan Mayen
64	203	description	1	Swaziland
64	204	description	1	Sweden
64	205	description	1	Switzerland
64	206	description	1	Syria
64	207	description	1	Taiwan
64	208	description	1	Tajikistan
64	209	description	1	Tanzania
64	210	description	1	Thailand
64	211	description	1	Togo
64	212	description	1	Tokelau
64	213	description	1	Tonga
64	214	description	1	Trinidad and Tobago
64	215	description	1	Tunisia
64	216	description	1	Turkey
64	217	description	1	Turkmenistan
64	218	description	1	Turks and Caicos Islands
64	219	description	1	Tuvalu
64	220	description	1	Uganda
64	221	description	1	Ukraine
64	222	description	1	United Arab Emirates
64	223	description	1	United Kingdom
64	224	description	1	United States
64	225	description	1	United States Minor Outlying Islands
64	226	description	1	Uruguay
64	228	description	1	Vanuatu
64	229	description	1	Vatican City
64	230	description	1	Venezuela
64	231	description	1	Viet Nam
64	232	description	1	Virgin Islands - British
64	233	description	1	Virgin Islands
64	57	description	1	Congo - DRC
64	58	description	1	Denmark
64	59	description	1	Djibouti
64	60	description	1	Dominica
64	61	description	1	Dominican Republic
64	62	description	1	East Timor
64	63	description	1	Ecuador
64	64	description	1	Egypt
64	65	description	1	El Salvador
64	66	description	1	Equatorial Guinea
64	67	description	1	Eritrea
64	68	description	1	Estonia
64	69	description	1	Ethiopia
64	70	description	1	Malvinas Islands
64	71	description	1	Faroe Islands
64	72	description	1	Fiji Islands
64	73	description	1	Finland
64	74	description	1	France
64	75	description	1	French Guiana
64	76	description	1	French Polynesia
64	77	description	1	French Southern and Antarctic Lands
64	78	description	1	Gabon
64	79	description	1	Gambia
64	80	description	1	Georgia
64	81	description	1	Germany
64	82	description	1	Ghana
64	83	description	1	Gibraltar
64	84	description	1	Greece
64	85	description	1	Greenland
64	86	description	1	Grenada
64	87	description	1	Guadeloupe
64	88	description	1	Guam
64	89	description	1	Guatemala
64	90	description	1	Guinea
64	91	description	1	Guinea-Bissau
64	92	description	1	Guyana
64	93	description	1	Haiti
64	94	description	1	Heard Island and McDonald Islands
64	95	description	1	Honduras
64	96	description	1	Hong Kong SAR
64	97	description	1	Hungary
64	98	description	1	Iceland
64	99	description	1	India
64	100	description	1	Indonesia
64	101	description	1	Iran
64	102	description	1	Iraq
64	103	description	1	Ireland
64	104	description	1	Israel
64	105	description	1	Italy
64	106	description	1	Jamaica
64	107	description	1	Japan
64	108	description	1	Jordan
64	109	description	1	Kazakhstan
64	110	description	1	Kenya
64	111	description	1	Kiribati
64	112	description	1	Korea
64	113	description	1	Kuwait
64	114	description	1	Kyrgyzstan
64	115	description	1	Laos
64	116	description	1	Latvia
64	117	description	1	Lebanon
64	118	description	1	Lesotho
64	119	description	1	Liberia
64	120	description	1	Libya
64	121	description	1	Liechtenstein
64	122	description	1	Lithuania
64	123	description	1	Luxembourg
64	124	description	1	Macao SAR
64	125	description	1	Macedonia, Former Yugoslav Republic of
64	126	description	1	Madagascar
64	127	description	1	Malawi
64	128	description	1	Malaysia
64	129	description	1	Maldives
64	130	description	1	Mali
64	131	description	1	Malta
64	132	description	1	Marshall Islands
64	133	description	1	Martinique
64	134	description	1	Mauritania
64	135	description	1	Mauritius
64	136	description	1	Mayotte
64	137	description	1	Mexico
64	138	description	1	Micronesia
64	139	description	1	Moldova
64	140	description	1	Monaco
64	141	description	1	Mongolia
64	142	description	1	Montserrat
64	143	description	1	Morocco
64	144	description	1	Mozambique
64	145	description	1	Myanmar
64	146	description	1	Namibia
64	1	description	1	Afghanistan
64	2	description	1	Albania
64	3	description	1	Algeria
64	4	description	1	American Samoa
64	5	description	1	Andorra
64	6	description	1	Angola
64	7	description	1	Anguilla
64	8	description	1	Antarctica
64	9	description	1	Antigua and Barbuda
64	10	description	1	Argentina
64	11	description	1	Armenia
64	12	description	1	Aruba
64	13	description	1	Australia
64	14	description	1	Austria
64	15	description	1	Azerbaijan
64	16	description	1	Bahamas
64	17	description	1	Bahrain
64	18	description	1	Bangladesh
64	19	description	1	Barbados
64	20	description	1	Belarus
64	21	description	1	Belgium
64	22	description	1	Belize
64	23	description	1	Benin
64	24	description	1	Bermuda
64	25	description	1	Bhutan
64	26	description	1	Bolivia
64	27	description	1	Bosnia and Herzegovina
64	28	description	1	Botswana
64	29	description	1	Bouvet Island
64	30	description	1	Brazil
64	31	description	1	British Indian Ocean Territory
64	32	description	1	Brunei
64	33	description	1	Bulgaria
64	34	description	1	Burkina Faso
64	35	description	1	Burundi
64	36	description	1	Cambodia
64	37	description	1	Cameroon
64	38	description	1	Canada
64	39	description	1	Cape Verde
64	40	description	1	Cayman Islands
64	41	description	1	Central African Republic
64	42	description	1	Chad
64	43	description	1	Chile
64	44	description	1	China
64	45	description	1	Christmas Island
64	46	description	1	Cocos - Keeling Islands
64	47	description	1	Colombia
64	48	description	1	Comoros
64	49	description	1	Congo
64	50	description	1	Cook Islands
64	51	description	1	Costa Rica
64	52	description	1	Cote d Ivoire
64	53	description	1	Croatia
64	54	description	1	Cuba
64	55	description	1	Cyprus
64	56	description	1	Czech Republic
4	1	description	1	United States Dollar
4	2	description	1	Canadian Dollar
4	3	description	1	Euro
4	4	description	1	Yen
4	5	description	1	Pound Sterling
4	6	description	1	Won
4	7	description	1	Swiss Franc
4	8	description	1	Swedish Krona
6	1	description	1	Month
6	2	description	1	Week
6	3	description	1	Day
6	4	description	1	Year
7	1	description	1	Email
7	2	description	1	Paper
9	1	description	1	Active
81	1	description	1	Active
81	2	description	1	Pending Unsubscription
81	3	description	1	Unsubscribed
81	4	description	1	Pending Expiration
81	5	description	1	Expired
81	6	description	1	Nonsubscriber
81	7	description	1	Discontinued
60	1	description	1	An internal user with all the permissions
60	1	title	1	Internal
60	2	description	1	The super user of an entity
60	2	title	1	Super user
60	3	description	1	A billing clerk
60	3	title	1	Clerk
60	5	description	1	A customer that will query his/her account
60	5	title	1	Customer
17	1	description	1	One time
18	1	description	1	Items
18	2	description	1	Tax
19	1	description	1	pre paid
19	2	description	1	post paid
20	1	description	1	Active
20	2	description	1	Finished
20	3	description	1	Suspended
35	1	description	1	Cheque
35	2	description	1	Visa
35	3	description	1	MasterCard
41	1	description	1	Successful
41	2	description	1	Failed
41	3	description	1	Processor unavailable
41	4	description	1	Entered
46	1	description	1	Billing Process
46	2	description	1	User maintenance
46	3	description	1	Item maintenance
46	4	description	1	Item type maintenance
46	5	description	1	Item user price maintenance
46	6	description	1	Promotion maintenance
46	7	description	1	Order maintenance
46	8	description	1	Credit card maintenance
47	1	description	1	A prepaid order has unbilled time before the billing process date
47	2	description	1	Order has no active time at the date of process.
47	3	description	1	At least one complete period has to be billable.
47	4	description	1	Already billed for the current date.
47	5	description	1	This order had to be maked for exclusion in the last process.
47	6	description	1	Pre-paid order is being process after its expiration.
47	7	description	1	A row was marked as deleted.
47	8	description	1	A user password was changed.
47	9	description	1	A row was updated.
47	10	description	1	Running a billing process, but a review is found unapproved.
47	11	description	1	Running a billing process, review is required but not present.
47	12	description	1	A user status was changed.
47	13	description	1	An order status was changed.
47	14	description	1	A user had to be aged, but there's no more steps configured.
47	15	description	1	A partner has a payout ready, but no payment instrument.
50	1	description	1	Process payment with billing process
50	2	description	1	URL of CSS file
50	3	description	1	URL of logo graphic
50	4	description	1	Grace period
50	13	description	1	Self delivery of paper invoices
52	1	description	1	Invoice (email)
52	2	description	1	User Reactivated
60	4	title	1	Agent
60	4	description	1	A agent that will bring customers
52	3	description	1	User Overdue
52	4	description	1	User Overdue 2
52	5	description	1	User Overdue 3
52	6	description	1	User Suspended
52	7	description	1	User Suspended 2
52	8	description	1	User Suspended 3
52	9	description	1	User Deleted
52	12	description	1	Invoice (paper)
50	24	description	1	Data Fattura Fine Mese
4	9	description	1	Singapore Dollar
4	10	description	1	Malaysian Ringgit
4	11	description	1	Australian Dollar
50	19	description	1	Next invoice number
7	3	description	1	Email + Paper
35	8	description	1	PayPal
52	19	description	1	Update Credit Card
20	4	description	1	Suspended (auto)
18	3	description	1	Penalty
52	20	description	1	Lost password
88	1	description	1	Active
88	2	description	1	Inactive
88	3	description	1	Pending Active
88	4	description	1	Pending Inactive
88	5	description	1	Failed
88	6	description	1	Unavailable
50	20	description	2	Eliminação manual de facturas
46	9	description	2	Manutenção de facturas
46	11	description	2	Manutenção de tarefas de plug-ins
47	16	description	2	Uma ordem de compra foi aplicada manualmente a uma factura.
52	17	description	2	Payment (sem sucesso)
52	16	description	2	Payment (com sucesso)
35	7	description	2	Diners
50	16	description	2	Dias antes da expiração para notificação de ordens 2
50	17	description	2	Dias antes da expiração para notificação de ordens 3
52	13	description	2	Ordem de compra a expirar. Passo 1
52	14	description	2	Ordem de compra a expirar. Passo 2
52	15	description	2	Ordem de compra a expirar. Passo 3
35	4	description	2	AMEX
35	5	description	2	CCA
50	14	description	2	Incluir notas do cliente na factura
50	18	description	2	NÚmero de prefixo da factura
64	234	description	2	Wallis and Futuna
64	235	description	2	Yemen
64	236	description	2	Zâmbia
64	237	description	2	Zimbabwe
50	15	description	2	Dias antes da expiração para notificação de ordens
50	21	description	2	Usar os lembretes de factura
50	22	description	2	NÚmero de dias após a geração da factura para o primeiro lembrete
50	23	description	2	NÚmero de dias para o próximo lembrete
64	227	description	2	Uzbekistão
64	147	description	2	Nauru
64	148	description	2	Nepal
64	149	description	2	Holanda
64	150	description	2	Antilhas Holandesas
64	151	description	2	Nova Caledônia
64	152	description	2	Nova Zelândia
64	153	description	2	Nicarágua
64	154	description	2	Niger
64	155	description	2	Nigéria
64	156	description	2	Niue
64	157	description	2	Ilhas Norfolk
64	158	description	2	Coreia do Norte
64	159	description	2	Ilhas Mariana do Norte
64	160	description	2	Noruega
64	161	description	2	Oman
64	162	description	2	Pakistão
64	163	description	2	Palau
64	164	description	2	Panama
64	165	description	2	Papua Nova Guiné
64	166	description	2	Paraguai
64	167	description	2	Perú
64	168	description	2	Filipinas
64	169	description	2	Ilhas Pitcairn
64	170	description	2	Polônia
64	171	description	2	Portugal
64	172	description	2	Porto Rico
64	173	description	2	Qatar
64	174	description	2	Reunião
64	175	description	2	Romênia
64	176	description	2	Rússia
64	177	description	2	Rwanda
64	178	description	2	Samoa
64	179	description	2	São Marino
64	180	description	2	São Tomé e Princepe
64	181	description	2	Arábia Saudita
64	182	description	2	Senegal
64	183	description	2	Sérvia e Montenegro
64	184	description	2	Seychelles
64	185	description	2	Serra Leoa
64	186	description	2	Singapure
64	187	description	2	Eslováquia
64	188	description	2	Eslovenia
64	189	description	2	Ilhas Salomão
64	190	description	2	Somália
64	191	description	2	África do Sul
64	192	description	2	Georgia do Sul e Ilhas Sandwich South
64	193	description	2	Espanha
64	194	description	2	Sri Lanka
64	195	description	2	Sta. Helena
64	196	description	2	Sta. Kitts e Nevis
64	197	description	2	Sta. Lucia
64	198	description	2	Sta. Pierre e Miquelon
64	199	description	2	Sto. Vicente e Grenadines
64	200	description	2	Sudão
64	201	description	2	Suriname
64	202	description	2	Svalbard e Jan Mayen
64	203	description	2	Suazilândia
64	204	description	2	Suécia
64	205	description	2	Suíça
64	206	description	2	Síria
64	207	description	2	Taiwan
64	208	description	2	Tajikistão
64	209	description	2	Tanzânia
64	210	description	2	Tailândia
64	211	description	2	Togo
64	212	description	2	Tokelau
64	213	description	2	Tonga
64	214	description	2	Trinidade e Tobago
64	215	description	2	Tunísia
64	216	description	2	Turquia
64	217	description	2	Turkmenistão
64	218	description	2	Ilhas Turks e Caicos
64	219	description	2	Tuvalu
64	220	description	2	Uganda
64	221	description	2	Ucrânia
64	222	description	2	Emiados Árabes Unidos
64	223	description	2	Reino Unido
64	224	description	2	Estados Unidos
64	225	description	2	Estados Unidos e Ilhas Menores Circundantes
64	226	description	2	Uruguai
64	228	description	2	Vanuatu
64	229	description	2	Cidade do Vaticano
64	230	description	2	Venezuela
64	231	description	2	Vietname
64	232	description	2	Ilhas Virgens Britânicas
64	233	description	2	Ilhas Virgens
64	57	description	2	República Democrática do Congo
64	58	description	2	Dinamarca
64	59	description	2	Djibouti
64	60	description	2	Dominica
64	61	description	2	República Dominicana
64	62	description	2	Timor Leste
64	63	description	2	Ecuador
64	64	description	2	Egipto
64	65	description	2	El Salvador
64	66	description	2	Guiné Equatorial
64	67	description	2	Eritreia
64	68	description	2	Estônia
64	69	description	2	Etiopia
64	70	description	2	Ilhas Malvinas
64	71	description	2	Ilhas Faroé
64	72	description	2	Ilhas Fiji
64	73	description	2	Finlândia
64	74	description	2	França
64	75	description	2	Guiana Francesa
64	76	description	2	Polinésia Francesa
64	77	description	2	Terras Antárticas e do Sul Francesas
64	78	description	2	Gabão
64	79	description	2	Gâmbia
64	80	description	2	Georgia
64	81	description	2	Alemanha
64	82	description	2	Gana
64	83	description	2	Gibraltar
64	84	description	2	Grécia
64	85	description	2	Gronelândia
64	86	description	2	Granada
64	87	description	2	Guadalupe
64	88	description	2	Guantanamo
64	89	description	2	Guatemala
64	90	description	2	Guiné
64	91	description	2	Guiné-Bissau
64	92	description	2	Guiana
64	93	description	2	Haiti
64	94	description	2	Ilhas Heard e McDonald
64	95	description	2	Honduras
64	96	description	2	Hong Kong SAR
64	97	description	2	Hungria
64	98	description	2	Islândia
64	99	description	2	Índia
64	100	description	2	Indonésia
64	101	description	2	Irâo
64	102	description	2	Iraque
64	103	description	2	Irlanda
64	104	description	2	Israel
64	105	description	2	Itália
64	106	description	2	Jamaica
64	107	description	2	Japão
64	108	description	2	Jordânia
64	109	description	2	Kazaquistão
64	110	description	2	Kênia
64	111	description	2	Kiribati
64	112	description	2	Coreia
64	113	description	2	Kuwait
64	114	description	2	Kirgistão
64	115	description	2	Laos
64	116	description	2	Latvia
64	117	description	2	Líbano
64	118	description	2	Lesoto
64	119	description	2	Libéria
64	120	description	2	Líbia
64	121	description	2	Liechtenstein
64	122	description	2	Lituânia
64	123	description	2	Luxemburgo
64	124	description	2	Macau SAR
64	125	description	2	Macedónia, Antiga República Jugoslava da
64	126	description	2	Madagáscar
64	127	description	2	Malaui
64	128	description	2	Malásia
64	129	description	2	Maldivas
64	130	description	2	Mali
64	131	description	2	Malta
64	132	description	2	Ilhas Marshall
64	133	description	2	Martinica
64	134	description	2	Mauritânia
64	135	description	2	Maurícias
64	136	description	2	Maiote
64	137	description	2	México
64	138	description	2	Micronésia
64	139	description	2	Moldova
64	140	description	2	Mônaco
64	141	description	2	Mongólia
64	142	description	2	Monserrate
64	143	description	2	Marrocos
64	144	description	2	Moçambique
64	145	description	2	Mianmar
64	146	description	2	Namíbia
64	1	description	2	Afganistão
64	2	description	2	Albânia
64	3	description	2	Algéria
64	4	description	2	Samoa Americana
64	5	description	2	Andorra
64	6	description	2	Angola
64	7	description	2	Anguilha
64	8	description	2	Antártida
64	9	description	2	Antigua e Barbuda
64	10	description	2	Argentina
64	11	description	2	Armênia
64	12	description	2	Aruba
64	13	description	2	Austrália
64	14	description	2	Áustria
64	15	description	2	Azerbaijão
64	16	description	2	Bahamas
64	17	description	2	Bahrain
64	18	description	2	Bangladesh
64	19	description	2	Barbados
64	20	description	2	Belarus
64	21	description	2	Bélgica
64	22	description	2	Belize
64	23	description	2	Benin
64	24	description	2	Bermuda
64	25	description	2	Butão
64	26	description	2	Bolívia
64	27	description	2	Bosnia e Herzegovina
64	28	description	2	Botswana
64	29	description	2	Ilha Bouvet
64	30	description	2	Brasil
64	31	description	2	Território Britânico do Oceano Índico
64	32	description	2	Brunei
64	33	description	2	Bulgária
64	34	description	2	Burquina Faso
64	35	description	2	Burundi
64	36	description	2	Cambodia
64	37	description	2	Camarões
64	38	description	2	Canada
64	39	description	2	Cabo Verde
64	40	description	2	Ilhas Caimáo
64	41	description	2	República Centro Africana
64	42	description	2	Chade
64	43	description	2	Chile
64	44	description	2	China
64	45	description	2	Ilha Natal
64	46	description	2	Ilha Cocos e Keeling
64	47	description	2	Colômbia
64	48	description	2	Comoros
64	49	description	2	Congo
64	50	description	2	Ilhas Cook
64	51	description	2	Costa Rica
64	52	description	2	Costa do Marfim
64	53	description	2	Croácia
64	54	description	2	Cuba
64	55	description	2	Chipre
64	56	description	2	República Checa
4	1	description	2	DÓlares Norte Americanos
4	2	description	2	DÓlares Canadianos
4	3	description	2	Euro
4	4	description	2	Ien
4	5	description	2	Libras Estrelinas
4	6	description	2	Won
4	7	description	2	Franco Suíço
4	8	description	2	Coroa Sueca
6	1	description	2	Mês
6	2	description	2	Semana
6	3	description	2	Dia
6	4	description	2	Ano
7	1	description	2	Email
7	2	description	2	Papel
9	1	description	2	Activo
60	1	description	2	Um utilizador interno com todas as permissões
60	1	title	2	Interno
60	2	description	2	O super utilizador de uma entidade
60	2	title	2	Super utilizador
60	3	description	2	Um operador de facturação
60	3	title	2	Operador
60	4	description	2	Um parceiro que vai angariar clientes
60	4	title	2	Parceiro
60	5	description	2	Um cliente que vai fazer pesquisas na sua conta
60	5	title	2	Cliente
17	1	description	2	uma vez
18	1	description	2	Items
18	2	description	2	Imposto
19	1	description	2	Pré pago
19	2	description	2	Pós pago
20	1	description	2	Activo
20	2	description	2	Terminado
20	3	description	2	Suspenso
35	1	description	2	Cheque
35	2	description	2	Visa
35	3	description	2	MasterCard
41	1	description	2	Com sucesso
41	2	description	2	Sem sucesso
41	3	description	2	Processador indisponível
41	4	description	2	Inserido
46	1	description	2	Processo de facturação
46	2	description	2	Manutenção de Utilizador
46	3	description	2	Item de Manutenção
46	4	description	2	Item tipo de Manutenção
46	5	description	2	Item Manutenção de preço de utilizador
46	6	description	2	Manutenção de promoção
46	7	description	2	Manutenção por ordem
46	8	description	2	Manutenção de cartão de crédito
47	1	description	2	Uma ordem prê-paga tem tempo não facturado anterior data de facturação
47	2	description	2	A ordem não tem nenhum período activo data de processamento.
47	3	description	2	Pelo menos um período completo tem de ser facturável.
47	4	description	2	Já há facturação para o período.
47	5	description	2	Esta ordem teve de ser marcada para exclusão do último processo.
47	6	description	2	Pre-paid order is being process after its expiration.
47	7	description	2	A linha marcada foi eliminada.
47	8	description	2	A senha de utilizador foi alterada.
47	9	description	2	Uma linha foi actualizada.
47	10	description	2	A correr um processo de facturação, foi encontrada uma revisão rejeitada.
47	11	description	2	A correr um processo de facturação, uma necessária mas não encontrada.
47	12	description	2	Um status de utilizador foi alterado.
47	13	description	2	Um status de uma ordem foi alterado.
47	14	description	2	Um utilizador foi inserido no processo de antiguidade, mas não há mais passos configurados.
47	15	description	2	Um parceiro tem um pagamento a receber, mas não tem instrumento de pagamento.
50	1	description	2	Processar pagamento com processo de facturação
50	2	description	2	URL ou ficheiro CSS
50	3	description	2	URL ou gráfico de logotipo
50	4	description	2	Período de graça
50	13	description	2	Entrega pelo mesmo das facturas em papel
52	1	description	2	Factura (email)
52	2	description	2	Utilizador Reactivado
52	3	description	2	Utilizador Em Atraso
52	4	description	2	Utilizador Em Atraso 2
52	5	description	2	Utilizador Em Atraso 3
52	6	description	2	Utilizador Suspenso
52	7	description	2	Utilizador Suspenso 2
52	8	description	2	Utilizador Suspenso 3
52	9	description	2	Utilizador Eliminado
52	10	description	2	Pagamento Remascente
52	11	description	2	Parceiro Pagamento
52	12	description	2	Factura (papel)
50	24	description	2	Data Factura Fim do Mês
4	9	description	2	DÓlar da Singapura
4	10	description	2	Ringgit Malasiano
4	11	description	2	DÓlar Australiano
50	19	description	2	próximo NÚmero de factura
7	3	description	2	Email + Papel
35	8	description	2	PayPal
52	19	description	2	Actualizar cartão de crédito
20	4	description	2	Suspender (auto)
18	3	description	2	Penalidade
52	20	description	2	Senha esquecida
89	1	description	1	None
89	2	description	1	Pre-paid balance
89	3	description	1	Credit limit
91	1	description	1	Done and billable
91	2	description	1	Done and not billable
91	3	description	1	Error detected
91	4	description	1	Error declared
92	1	description	1	Running
92	2	description	1	Finished: successful
92	3	description	1	Finished: failed
23	1	description	1	Item management and order line total calculation
23	2	description	1	Billing process: order filters
23	3	description	1	Billing process: invoice filters
23	4	description	1	Invoice presentation
23	5	description	1	Billing process: order periods calculation
23	6	description	1	Payment gateway integration
23	7	description	1	Notifications
23	8	description	1	Payment instrument selection
23	9	description	1	Penalties for overdue invoices
23	10	description	1	Alarms when a payment gateway is down
23	11	description	1	Subscription status manager
23	12	description	1	Parameters for asynchronous payment processing
23	13	description	1	Add one product to order
23	14	description	1	Product pricing
23	17	description	1	Generic internal events listener
23	19	description	1	Purchase validation against pre-paid balance / credit limit
23	20	description	1	Billing process: customer selection
23	22	description	1	Scheduled Plug-ins
23	23	description	1	Rules Generators
23	24	description	1	Ageing for customers with overdue invoices
24	1	title	1	Default order totals
24	1	description	1	Calculates the order total and the total for each line, considering the item prices, the quantity and if the prices are percentage or not.
24	2	title	1	VAT
24	2	description	1	Adds an additional line to the order with a percentage charge to represent the value added tax.
24	3	title	1	Invoice due date
24	3	description	1	A very simple implementation that sets the due date of the invoice. The due date is calculated by just adding the period of time to the invoice date.
24	4	title	1	Default invoice composition.
24	4	description	1	This task will copy all the lines on the orders and invoices to the new invoice, considering the periods involved for each order, but not the fractions of periods. It will not copy the lines that are taxes. The quantity and total of each line will be multiplied by the amount of periods.
24	5	title	1	Standard Order Filter
24	5	description	1	Decides if an order should be included in an invoice for a given billing process.  This is done by taking the billing process time span, the order period, the active since/until, etc.
24	6	title	1	Standard Invoice Filter
24	6	description	1	Always returns true, meaning that the overdue invoice will be carried over to a new invoice.
24	7	title	1	Default Order Periods
24	7	description	1	Calculates the start and end period to be included in an invoice. This is done by taking the billing process time span, the order period, the active since/until, etc.
24	8	title	1	Authorize.net payment processor
24	8	description	1	Integration with the authorize.net payment gateway.
24	9	title	1	Standard Email Notification
24	9	description	1	Notifies a user by sending an email. It supports text and HTML emails
24	10	title	1	Default payment information
24	10	description	1	Finds the information of a payment method available to a customer, given priority to credit card. In other words, it will return the credit car of a customer or the ACH information in that order.
24	11	title	1	Testing plug-in for partner payouts
24	11	description	1	Plug-in useful only for testing
24	12	title	1	PDF invoice notification
24	12	description	1	Will generate a PDF version of an invoice.
24	14	title	1	No invoice carry over
24	14	description	1	Returns always false, which makes jBilling to never carry over an invoice into another newer invoice.
24	15	title	1	Default interest task
24	15	description	1	Will create a new order with a penalty item. The item is taken as a parameter to the task.
24	16	title	1	Anticipated order filter
24	16	description	1	Extends BasicOrderFilterTask, modifying the dates to make the order applicable a number of months before it would be by using the default filter.
24	17	title	1	Anticipate order periods.
24	17	description	1	Extends BasicOrderPeriodTask, modifying the dates to make the order applicable a number of months before itd be by using the default task.
24	19	title	1	Email & process authorize.net
24	19	description	1	Extends the standard authorize.net payment processor to also send an email to the company after processing the payment.
24	20	title	1	Payment gateway down alarm
24	20	description	1	Sends an email to the billing administrator as an alarm when a payment gateway is down.
24	21	title	1	Test payment processor
64	140	description	4	Monaco
24	21	description	1	A test payment processor implementation to be able to test jBillings functions without using a real payment gateway.
24	22	title	1	Router payment processor based on Custom Fields
24	22	description	1	Allows a customer to be assigned a specific payment gateway. It checks a custom contact field to identify the gateway and then delegates the actual payment processing to another plugin.
24	23	title	1	Default subscription status manager
24	23	description	1	It determines how a payment event affects the subscription status of a user, considering its present status and a state machine.
24	24	title	1	ACH Commerce payment processor
24	24	description	1	Integration with the ACH commerce payment gateway.
24	25	title	1	Standard asynchronous parameters
24	25	description	1	A dummy task that does not add any parameters for asynchronous payment processing. This is the default.
24	26	title	1	Router asynchronous parameters
24	26	description	1	This plug-in adds parameters for asynchronous payment processing to have one processing message bean per payment processor. It is used in combination with the router payment processor plug-ins.
24	28	title	1	Standard Item Manager
24	28	description	1	It adds items to an order. If the item is already in the order, it only updates the quantity.
24	29	title	1	Rules Item Manager
24	29	description	1	This is a rules-based plug-in. It will do what the basic item manager does (actually calling it); but then it will execute external rules as well. These external rules have full control on changing the order that is getting new items.
24	30	title	1	Rules Line Total
24	30	description	1	This is a rules-based plug-in. It calculates the total for an order line (typically this is the price multiplied by the quantity); allowing for the execution of external rules.
24	31	title	1	Rules Pricing
24	32	title	1	Separator file reader
24	34	title	1	Fixed length file reader
24	35	title	1	Payment information without validation
24	35	description	1	This is exactly the same as the standard payment information task, the only difference is that it does not validate if the credit card is expired. Use this plug-in only if you want to submit payment with expired credit cards.
24	36	title	1	Notification task for testing
24	36	description	1	This plug-in is only used for testing purposes. Instead of sending an email (or other real notification); it simply stores the text to be sent in a file named emails_sent.txt.
24	37	title	1	Order periods calculator with pro rating.
24	37	description	1	This plugin takes into consideration the field cycle starts of orders to calculate fractional order periods.
24	38	title	1	Invoice composition task with pro-rating (day as fraction)
24	38	description	1	When creating an invoice from an order, this plug-in will pro-rate any fraction of a period taking a day as the smallest billable unit.
24	39	title	1	Payment process for the Intraanuity payment gateway
24	39	description	1	Integration with the Intraanuity payment gateway.
24	40	title	1	Automatic cancellation credit.
24	40	description	1	This plug-in will create a new order with a negative price to reflect a credit when an order is canceled within a period that has been already invoiced.
24	42	title	1	Blacklist filter payment processor.
24	42	description	1	Used for blocking payments from reaching real payment processors. Typically configured as first payment processor in the processing chain.
24	43	title	1	Blacklist user when their status becomes suspended or higher.
24	43	description	1	Causes users and their associated details (e.g., credit card number, phone number, etc.) to be blacklisted when their status becomes suspended or higher. 
24	49	title	1	Currency Router payment processor
24	49	description	1	Delegates the actual payment processing to another plug-in based on the currency of the payment.
24	51	title	1	Filters out negative invoices for carry over.
24	51	description	1	This filter will only invoices with a positive balance to be carried over to the next invoice.
24	52	title	1	File invoice exporter.
24	52	description	1	It will generate a file with one line per invoice generated.
24	53	title	1	Rules caller on an event.
24	53	description	1	It will call a package of rules when an internal event happens.
24	54	title	1	Dynamic balance manager
24	54	description	1	It will update the dynamic balance of a customer (pre-paid or credit limit) when events affecting the balance happen.
24	55	title	1	Balance validator based on the customer balance.
24	56	title	1	Balance validator based on rules.
24	57	title	1	Payment processor for Payments Gateway.
24	57	description	1	Integration with the Payments Gateway payment processor.
24	58	title	1	Credit cards are stored externally.
24	58	description	1	Saves the credit card information in the payment gateway, rather than the jBilling DB.
24	59	title	1	Rules Item Manager 2
24	60	title	1	Rules Line Total - 2
24	61	title	1	Rules Pricing 2
24	63	title	1	Test payment processor for external storage.
24	63	description	1	A fake plug-in to test payments that would be stored externally.
24	64	title	1	WorldPay integration
24	64	description	1	Payment processor plug-in to integrate with RBS WorldPay
24	65	title	1	WorldPay integration with external storage
24	65	description	1	Payment processor plug-in to integrate with RBS WorldPay. It stores the credit card information (number, etc) in the gateway.
24	66	title	1	Auto recharge
24	66	description	1	Monitors the balance of a customer and upon reaching a limit, it requests a real-time payment
24	67	title	1	Beanstream gateway integration
24	67	description	1	Payment processor for integration with the Beanstream payment gateway
64	141	description	3	Mongolien
24	68	title	1	Sage payments gateway integration
24	68	description	1	Payment processor for integration with the Sage payment gateway
24	69	title	1	Standard billing process users filter
24	69	description	1	Called when the billing process runs to select which users to evaluate. This basic implementation simply returns every user not in suspended (or worse) status
24	70	title	1	Selective billing process users filter
24	70	description	1	Called when the billing process runs to select which users to evaluate. This only returns users with orders that have a next invoice date earlier than the billing process.
24	71	description	1	Event records with errors are saved to a file
24	73	description	1	Event records with errors are saved to a database table
24	75	title	1	Paypal integration with external storage
24	75	description	1	Submits payments to paypal as a payment gateway and stores credit card information in PayPal as well
24	76	title	1	Authorize.net integration with external storage
24	76	description	1	Submits payments to authorize.net as a payment gateway and stores credit card information in authorize.net as well
24	77	title	1	Payment method router payment processor
24	77	description	1	Delegates the actual payment processing to another plug-in based on the payment method of the payment.
24	78	title	1	Dynamic rules generator
24	78	description	1	Generates rules dynamically based on a Velocity template.
24	79	title	1	Price Model Pricing Task
24	79	description	1	This is a plugin that handles the pricing calculation depending on the implemenations of the different Pricing Models.
24	80	title	1	Billing Process Task
24	80	description	1	A scheduled task to execute the Billing Process.
24	87	title	1	Basic ageing
24	87	description	1	Ages a user based on the number of days that the account is overdue.
24	88	title	1	Ageing process task
24	88	description	1	A scheduled task to execute the Ageing Process.
24	89	title	1	Business day ageing
24	89	description	1	Ages a user based on the number of business days (excluding holidays) that the account is overdue.
24	90	title	1	Simple Tax Composition Task
24	90	description	1	A pluggable task of the type AbstractChargeTask to apply tax item to an Invoice with a facility of exempting an exempt item or an exemp customer.
24	91	title	1	Country Tax Invoice Composition Task
24	91	description	1	A pluggable task of the type AbstractChargeTask to apply tax item to the Invoice if the Partner's country code is matching.
24	92	title	1	Payment Terms Penalty Task
24	92	description	1	A pluggable task of the type AbstractChargeTask to apply a Penalty to an Invoice having a due date beyond a configurable days period.
47	17	description	1	The order line has been updated
47	18	description	1	The order next billing date has been changed
47	19	description	1	Last API call to get the the user subscription status transitions
47	20	description	1	User subscription status has changed
47	21	description	1	User account is now locked
47	22	description	1	The order main subscription flag was changed
47	24	description	1	A valid payment method was not found. The payment request was cancelled
47	25	description	1	A new row has been created
47	26	description	1	An invoiced order was cancelled, a credit order was created
47	27	description	1	A user id was added to the blacklist
47	28	description	1	A user id was removed from the blacklist
47	32	description	1	User subscription status has NOT changed
47	33	description	1	The dynamic balance of a user has changed
47	34	description	1	The invoice if child flag has changed
47	150	description	1	919666095219:Welcome to openbrm
47	200	description	1	support@openbrm.com:email
101	1	description	1	Invoice Reports
101	2	description	1	Order Reports
101	3	description	1	Payment Reports
101	4	description	1	Customer Reports
100	1	description	1	Total amount invoiced grouped by period.
100	2	description	1	Detailed balance ageing report. Shows the age of outstanding customer balances.
100	3	description	1	Number of users subscribed to a specific product.
100	4	description	1	Total payment amount received grouped by period.
100	5	description	1	Number of customers created within a period.
100	6	description	1	Total revenue (sum of received payments) per customer.
100	7	description	1	Simple accounts receivable report showing current account balances.
100	8	description	1	General ledger details of all invoiced charges for the given day.
100	9	description	1	General ledger summary of all invoiced charges for the given day, grouped by item type.
100	11	description	1	Total invoiced per customer grouped by product category.
100	12	description	1	Total invoiced per customer over years grouped by year.
104	1	description	1	Invoices
104	2	description	1	Orders
104	3	description	1	Payments
104	4	description	1	Users
50	25	description	1	Use overdue penalties (interest).
50	27	description	1	Use order anticipation.
50	28	description	1	Paypal account.
50	29	description	1	Paypal button URL.
50	30	description	1	URL for HTTP ageing callback.
50	31	description	1	Use continuous invoice dates.
50	32	description	1	Attach PDF invoice to email notification.
50	33	description	1	Force one order per invoice.
50	35	description	1	Add order Id to invoice lines.
50	36	description	1	Allow customers to edit own contact information.
50	38	description	1	Link ageing to customer subscriber status.
50	39	description	1	Lock-out user after failed login attempts.
50	40	description	1	Expire user passwords after days.
50	41	description	1	Use main-subscription orders.
50	42	description	1	Use pro-rating.
50	43	description	1	Use payment blacklist.
50	44	description	1	Allow negative payments.
50	45	description	1	Delay negative invoice payments.
50	46	description	1	Allow invoice without orders.
50	49	description	1	Automatic customer recharge threshold.
50	50	description	1	Invoice decimal rounding.
50	4	instruction	1	Grace period in days before ageing a customer with an overdue invoice.
50	13	instruction	1	Set to '1' to e-mail invoices as the billing company. '0' to deliver invoices as jBilling.
50	14	instruction	1	Set to '1' to show notes in invoices, '0' to disable.
50	15	instruction	1	Days before the orders 'active until' date to send the 1st notification. Leave blank to disable.
50	16	instruction	1	Days before the orders 'active until' date to send the 2nd notification. Leave blank to disable.
50	17	instruction	1	Days before the orders 'active until' date to send the 3rd notification. Leave blank to disable.
50	18	instruction	1	Prefix value for generated invoice public numbers.
50	19	instruction	1	The current value for generated invoice public numbers. New invoices will be assigned a public number by incrementing this value.
50	20	instruction	1	Set to '1' to allow invoices to be deleted, '0' to disable.
50	21	instruction	1	Set to '1' to allow invoice reminder notifications, '0' to disable.
50	24	instruction	1	Set to '1' to enable, '0' to disable.
50	25	instruction	1	Set to '1' to enable the billing process to calculate interest on overdue payments, '0' to disable. Calculation of interest is handled by the selected penalty plug-in.
50	27	instruction	1	Set to '1' to use the 'OrderFilterAnticipateTask' to invoice a number of months in advance, '0' to disable. Plug-in must be configured separately.
50	28	instruction	1	PayPal account name.
50	29	instruction	1	A URL where the graphic of the PayPal button resides. The button is displayed to customers when they are making a payment. The default is usually the best option, except when another language is needed.
50	30	instruction	1	URL for the HTTP Callback to invoke when the ageing process changes a status of a user.
50	32	instruction	1	Set to '1' to attach a PDF version of the invoice to all invoice notification e-mails. '0' to disable.
50	33	instruction	1	Set to '1' to show the 'include in separate invoice' flag on an order. '0' to disable.
50	35	instruction	1	Set to '1' to include the ID of the order in the description text of the resulting invoice line. '0' to disable. This can help to easily track which exact orders is responsible for a line in an invoice, considering that many orders can be included in a single invoice.
50	36	instruction	1	Set to '1' to allow customers to edit their own contact information. '0' to disable.
50	38	instruction	1	Set to '1' to change the subscription status of a user when the user ages. '0' to disable.
50	40	instruction	1	If greater than zero, it represents the number of days that a password is valid. After those days, the password is expired and the user is forced to change it.
50	42	instruction	1	Set to '1' to allow the use of pro-rating to invoice fractions of a period. Shows the 'cycle' attribute of an order. Note that you need to configure the corresponding plug-ins for this feature to be fully functional.
50	43	instruction	1	If the payment blacklist feature is used, this is set to the id of the configuration of the PaymentFilterTask plug-in. See the Blacklist section of the documentation.
50	44	instruction	1	Set to '1' to allow negative payments. '0' to disable
50	45	instruction	1	Set to '1' to delay payment of negative invoice amounts, causing the balance to be carried over to the next invoice. Invoices that have had negative balances from other invoices transferred to them are allowed to immediately make a negative payment (credit) if needed. '0' to disable. Preference 44 & 46 are usually also enabled.
50	46	instruction	1	Set to '1' to allow invoices with negative balances to generate a new invoice that isn't composed of any orders so that their balances will always get carried over to a new invoice for the credit to take place. '0' to disable. Preference 44 & 45 are usually also enabled.
50	49	instruction	1	The threshold value for automatic payments. Pre-paid users with an automatic recharge value set will generate an automatic payment whenever the account balance falls below this threshold. Note that you need to configure the AutoRechargeTask plug-in for this feature to be fully functional.
50	50	instruction	1	The number of decimal places to be shown on the invoice. Defaults to 2.
90	1	description	1	Paid
90	2	description	1	Unpaid
90	3	description	1	Carried
59	10	description	1	Create customer
59	11	description	1	Edit customer
59	12	description	1	Delete customer
59	13	description	1	Inspect customer
59	14	description	1	Blacklist customer
59	15	description	1	View customer details
59	16	description	1	Download customer CSV
59	17	description	1	View all customers
59	18	description	1	View customer sub-accounts
59	20	description	1	Create order
59	21	description	1	Edit order
59	22	description	1	Delete order
59	23	description	1	Generate invoice for order
59	24	description	1	View order details
59	25	description	1	Download order CSV
59	26	description	1	Edit line price
59	27	description	1	Edit line description
59	28	description	1	View all customers
59	29	description	1	View customer sub-accounts
59	30	description	1	Create payment
59	31	description	1	Edit payment
59	32	description	1	Delete payment
59	33	description	1	Link payment to invoice
59	34	description	1	View payment details
59	35	description	1	Download payment CSV
59	36	description	1	View all customers
59	37	description	1	View customer sub-accounts
59	40	description	1	Create product
59	41	description	1	Edit product
59	42	description	1	Delete product
59	43	description	1	View product details
59	44	description	1	Download Product CSV
59	50	description	1	Create product category
59	51	description	1	Edit product category
59	52	description	1	Delete product category
59	70	description	1	Delete invoice
59	71	description	1	Send invoice notification
59	72	description	1	View invoice details
59	73	description	1	Download invoice CSV
59	74	description	1	View all customers
59	75	description	1	View customer sub-accounts
59	80	description	1	Approve / Disapprove review
59	90	description	1	Show customer menu
59	91	description	1	Show invoices menu
59	92	description	1	Show order menu
59	94	description	1	Show billing menu
59	96	description	1	Show reports menu
59	97	description	1	Show products menu
59	99	description	1	Show configuration menu
59	110	description	1	Switch to sub-account
59	111	description	1	Switch to any user
59	120	description	1	Web Service API access
50	999	description	1	UploadCDR
50	999	instruction	1	Choose the directory to upload the UploadCDR files
144	1	description	1	New
59	100	description	1	Show agent menu
59	93	description	1	Show payments and refunds menu
144	2	description	1	Exported
144	3	description	1	Sold
144	4	description	1	Redeemed
144	5	description	1	Invalid
100	10	description	4	Historique des tarifs du plan pour tous les produits et les dates de début du plan.
100	11	description	3	Gesamtrechnungen pro Kunde nach Produktkategorien gruppiert.
100	11	description	4	Totaux facturés par client regroupés par catégorie de produit.
100	12	description	3	Gesamtrechnungen pro Kunde über die Jahre, in Jahre gruppiert.
100	12	description	4	Total facturé par client au fil des ans avec regroupement par année.
100	13	description	4	Relevé de l'activité de l'utilisateur pendant un nombre de jours spécifié
100	1	description	3	Gesamtsumme berechnet, in Zeiträume gruppiert.
100	1	description	4	Montant total facturé regroupé par période
100	2	description	3	Detaillierter Balance Datierungsbericht. Zeigt die Datierung der hervorragenden Kundenguthaben.
100	2	description	4	Rapport détaillé sur l'avancement des phases du solde. Affiche la phase d'avancement des soldes débiteurs de clients.
100	3	description	3	Anzahl der Benutzer die ein spezifisches Produkt abonniert haben
100	3	description	4	Nombre d'utilisateurs abonnés à un produit spécifique.
100	4	description	3	Gesamtbezahlungen gruppiert bei Zeiträumen.
100	4	description	4	Montant total des paiements reçus regroupés par période
100	5	description	3	Anzahl der Kunden die in diesem Zeitraum erstellt wurden Number
100	5	description	4	Nombre de clients créés au sein d'une période.
100	6	description	3	Gesamteinnahmen (Summe der erhaltenen Bezahlunge) pro Kunde.
100	6	description	4	Total des revenus (somme des paiements reçus) par client.
100	7	description	3	Einfacher Forderungesbericht der Leistungsbilanzen anzeigt.
100	7	description	4	Simple rapport sur les comptes clients montrant les soldes actuels des comptes.
100	8	description	3	Hauptbuch Details aller in Rechnung gestellten Gebühren für den angegebenen Tag.
100	8	description	4	Détails du grand compte de tous les frais facturés pour le jour donné.
100	9	description	3	Hauptbuch Zusammenfassung aller in Rechnung gestellten Gebühren für den bestimmten Tag, in Elementtypen gruppiert.
100	9	description	4	Synthèse du grand compte de tous les frais facturés pour le jour donné, groupés par type d'article.
101	1	description	3	Rechnungsberichte
101	1	description	4	Rapports relatifs aux factures
101	2	description	3	Bestellungsberichte
101	2	description	4	Rapports relatifs aux commandes
101	3	description	3	Zahlungsberichte
101	3	description	4	Rapports relatifs aux paiements
101	4	description	3	Kundenberichte
101	4	description	4	Rapports relatifs aux clients
101	5	description	4	Rapports sur les plans
104	1	description	3	Rechnungen
104	1	description	4	Factures.
104	2	description	3	Bestellungen
104	2	description	4	Commandes.
104	3	description	3	Bezahlungen
104	3	description	4	Paiements.
104	4	description	3	Benutzer
104	4	description	4	Utilisateurs.
104	5	description	4	Notifications personnalisées
114	10	errorMessage	3	Bezahlungskartennummer ist nicht mehr gƒltig
114	10	errorMessage	4	Le numéro de carte de paiement est invalide
114	11	errorMessage	3	Auslaufsdatum sollte im Format MM/jjjj sein
114	11	errorMessage	4	La date d'expiration doit être au format mm/aaaa
114	12	errorMessage	3	ABA Routing oder Bank Kontonummer kann nur Zahlen sein
114	12	errorMessage	4	Le numéro de routage ABA ou le numéro de compte bancaire ne peut contenir que des chiffres
114	20	errorMessage	4	Le numéro de carte de paiement est invalide
114	21	errorMessage	4	La date d'expiration doit être au format mm/aaaa
23	8	description	3	Zahlungsinstrument Auswahl
114	22	errorMessage	4	Le numéro de routage ABA ou le numéro de compte bancaire ne peut contenir que des chiffres
114	23	errorMessage	4	Le numéro de carte de paiement est invalide
114	24	errorMessage	4	La date d'expiration doit être au format mm/aaaa
114	25	errorMessage	4	Le numéro de routage ABA ou le numéro de compte bancaire ne peut contenir que des chiffres
114	26	errorMessage	4	Le numéro de carte de paiement est invalide
114	27	errorMessage	4	La date d'expiration doit être au format mm/aaaa
114	28	errorMessage	4	Le numéro de routage ABA ou le numéro de compte bancaire ne peut contenir que des chiffres
114	29	errorMessage	4	Le numéro de carte de paiement est invalide
114	30	errorMessage	4	La date d'expiration doit être au format mm/aaaa
114	31	errorMessage	4	Le numéro de routage ABA ou le numéro de compte bancaire ne peut contenir que des chiffres
114	32	errorMessage	4	Le numéro de carte de paiement est invalide
114	33	errorMessage	4	La date d'expiration doit être au format mm/aaaa
114	34	errorMessage	4	Le numéro de routage ABA ou le numéro de compte bancaire ne peut contenir que des chiffres
114	35	errorMessage	4	Le numéro de carte de paiement est invalide
114	36	errorMessage	4	La date d'expiration doit être au format mm/aaaa
114	37	errorMessage	4	Le numéro de routage ABA ou le numéro de compte bancaire ne peut contenir que des chiffres
114	38	errorMessage	4	Le numéro de carte de paiement est invalide
114	39	errorMessage	4	La date d'expiration doit être au format mm/aaaa
114	40	errorMessage	4	Le numéro de routage ABA ou le numéro de compte bancaire ne peut contenir que des chiffres
114	41	errorMessage	4	Le numéro de carte de paiement est invalide
114	42	errorMessage	4	La date d'expiration doit être au format mm/aaaa
17	1	description	3	Einmal
17	1	description	4	Une fois
17	5	description	3	Alle Auftrège
17	5	description	4	Toutes les commandes
18	1	description	3	Artikel
18	1	description	4	Articles
18	2	description	3	Steuer
18	2	description	4	Taxe
18	3	description	3	Strafe
18	3	description	4	Pénalité
18	4	description	3	Rabatt
18	4	description	4	Réduction
18	5	description	4	Abonnement
18	5	description	3	Abonnement
19	1	description	3	vorausbezahlt
19	1	description	4	prépayée
19	2	description	3	danach bezahlt
19	2	description	4	post-payée
23	10	description	3	Alarmiert wen nein Zahlungs Gateway nicht funktioniert
23	10	description	4	Alertes quand une passerelle de paiement est en dysfonctionnement
23	11	description	3	Abonnement Status Manager
23	11	description	4	Gestionnaire de statut des abonnements
23	12	description	3	 Parameter fƒr Asynchron-Zahlungsabwicklung
23	12	description	4	Paramètres pour le traitement asynchrone des paiements
23	13	description	3	Ein Produkt zur Bestllung hinzufƒgen
23	13	description	4	Ajouter un produit à commander
23	14	description	3	Produktpreise
23	14	description	4	Prix du produit
23	15	description	3	Vermittlungs Reader
23	15	description	4	Visionneuse de médiation
23	16	description	3	Vermittlungs Prozessor
23	16	description	4	Système de traitement de la médiation
23	17	description	3	generische interne Ereignisse ZuhÖrer
23	17	description	4	Observateur d'évènements internes génériques
23	18	description	3	externer Beschaffungsprozessor 
23	18	description	4	Système de traitement de l'approvisionnement externe
23	19	description	3	 Kauf Validierung gegen Prepaid-Guthaben / Kreditlimit
23	19	description	4	Validation de l'achat par rapport au solde prépayé/à la limite de crédit
23	1	description	3	Artikel Management und Auftragsposition Gesamtberechnung
23	1	description	4	Gestion des articles et calcul du total des lignes de commande
23	20	description	3	Abrechnungsprozess: Kundenauswahl
23	20	description	4	Processus de facturation : sélection du client
23	21	description	3	Vermittlungsfehler Steuerungsprogram
23	21	description	4	Gestionnaire des erreurs de médiation
23	22	description	3	Geplante Plug-ins
23	22	description	4	Plugins programmés
23	23	description	3	Regelgenarator
23	23	description	4	Générateurs de règles
23	24	description	3	Vergƒtung fƒr Kunden mit ƒberfèlligen Rechnungen
23	24	description	4	Avancement de phase pour les clients avec des factures en retard de paiement
23	25	description	4	Processus de calcul des commissions des agents
23	26	description	4	Échange de fichiers avec des sites distants, télécharger
23	2	description	3	Abrechnungsprozess: Bestellung Filter
23	2	description	4	Processus de facturation : filtres des commandes
23	3	description	3	Abrechnungsprozess: Rechnung Filter
23	3	description	4	Processus de facturation : filtres des factures
23	4	description	3	Rechnungsvorlage
23	4	description	4	Présentation des factures
23	5	description	3	Abrechnungsprozess:  Auftragskalkulation Zeitraum
23	5	description	4	Processus de facturation : calcul des périodes de commande
23	6	description	3	Zahlungs Gateway integration
23	6	description	4	Intégration d'une passerelle de paiement
23	7	description	3	Mitteilungen
23	7	description	4	Notifications
23	8	description	4	Sélection d'un instrument de paiement
23	9	description	3	Strafen fƒr ƒberfèllige Rechnungen
23	9	description	4	Pénalités pour les factures impayées
24	101	description	3	Die Event basierte benutzerdefinierten Mitteilungsaufgabe nimmt die benutzerdefinierte Benachrichtigung und führt die Benachrichtigung durch, wenn ein internes Ereignis eingetreten ist
24	101	description	4	La tâche Notification personnalisée basée sur les évènements prend le message de notification personnalisé et réalise la notification lorsque l'évènement interne survient
24	101	title	3	Event basierte Kundenmitteilungsaufgabe
24	101	title	4	Tâche Notification personnalisée basée sur les évènements
24	103	title	3	Einfacher Vermittlungsprozessor
24	103	title	4	Système de traitement de médiation simple
24	105	description	3	Dieser plugin fügt Steuerzeilen auf die Rechnung hinzu durch die Befragung der Suretax Engine.
24	105	description	4	Ce plugin ajoute des lignes Taxe aux factures en consultant le moteur Suretax.
24	105	title	3	Suretax Plugin
24	105	title	4	Plugin Suretax
24	107	description	3	
24	107	description	4	Ce plugin définira la valeur du solde et du total d'une facture négative à 0, et il créera un paiement 'créditeur' pour le montant restant.
24	107	title	3	Kredit auf negativer Rechnung
24	107	title	4	Crédit sur facture négative
24	108	description	4	Une tâche pour utiliser un plugin du type InternalEventsTask afin de vérifier si le solde prépayé des utilisateurs est inférieur à un niveau seuil et d'envoyer des notifications.
24	108	title	4	Tâche Notification du seuil du solde de l'utilisateur
24	137	description	4	Si un évènement de facturation de consommation de regroupement d'utilisation a lieu, ce plugin facturera des frais au client
24	109	description	4	Ce plugin fournit une cartographie entre le statut de l'utilisateur (étapes d'avancement des phases) et les notifications devant être envoyées pour chaque statut
24	109	title	4	Notifications personnalisées à l'utilisateur par étapes d'avancement des phases
24	10	description	3	Findet die Informationen einer Zahlungsmethode die dem Kunden zur Verfƒgung stehen, Prioritèt auf Kreditkarten. Mit anderen Worten, es wird die Kreditkarte eines Kunden oder die ACH Informationen in dieser Reihenfolge zurƒckgeben.
24	10	description	4	Trouve les informations sur une méthode de paiement disponible pour un utilisateur, priorité étant donné aux cartes bancaires. En d'autres termes, it will return the credit car of a customer or the ACH information in that order.
24	10	title	3	Standard Zahlungsinformationen
24	10	title	4	Informations relatives au paiement par défaut
24	110	description	4	Cette tâche supprimera les fichiers ultérieur à une certaine période.
24	110	title	4	Supprimer les anciens fichiers
24	111	description	4	Ce plugin mettra à jour AssetTransitions en cas de changement de statut d'un actif.
24	111	title	4	Met à jour les transactions des actifs
24	112	description	4	Ce plugin supprimera les propriétaires de l'actif au moment de l'expiration de la commande associée.
24	112	title	4	Supprimer les actifs des commandes TERMINÉES
24	113	description	4	Une tâche pour utiliser un plugin de type InternalEventsTask pour contrôler des changements relatifs à activeUntil sur une commande
24	113	title	4	Tâche d'annulation de la commande
24	117	description	4	Ce plugin créera le regroupement d'utilisation pour le client si le client s'abonne à un plan qui est rattaché à des regroupements d'utilisation.
24	117	title	4	Créer un regroupement d'utilisation pour le client
24	118	description	4	Ce plugin évaluera et mettra à jour les regroupements d'utilisation du client afin de définir les dates de fin du cycle conformément à la période de regroupement d'utilisation, et il réinitialisera les quantités conformément au paramètre de définition des regroupements d'utilisation.
24	118	title	4	Tâche d'évaluation et de mise à jour du regroupement d'utilisation du client
24	119	description	4	Ce plugin mettra à jour le regroupement d'utilisation du client si un des évènements suivants se produit : NewOrderEvent, NewQuantityEvent, OrderDeletedEvent.
24	119	title	4	Tâche de mise à jour du regroupement d'utilisation du client
24	11	description	3	Plug-in nur hilfreich fƒr Testing useful
24	11	description	4	Plugin uniquement utile à des fins de test
24	11	title	3	Testing plug-in fƒr Partner Auszahlungen
24	11	title	4	Test du plugin pour le paiement des partenaires
24	120	description	4	Ce plugin mettra à jour les regroupements d'utilisation du client comme expirés si le client se désabonne d'un plan.
24	120	title	4	Il traite un évènement de désabonnement d'un plan pour un client. Il met à jour les regroupements d'utilisation du client comme expirés.
24	121	description	4	Si un évènement de consommation de regroupement d'utilisation a lieu, ce plugin lancera une action définie sur le FUP pour la consommation du pourcentage donnée
24	121	title	4	Tâche de consommation du regroupement d'utilisation du client
24	122	description	4	Ajoute des commandes d'approvisionnement pour la ligne de commande.
24	122	title	4	Ajoute des commandes d'approvisionnement pour la ligne de commande.
24	123	description	4	Ajoute des commandes d'approvisionnement lorsque les actifs sont créés, mis à jour et ajouté à la ligne du client
24	123	title	4	Ajoute des commandes d'approvisionnement pour les actifs.
24	124	description	4	Ajouter une commande d'approvisionnement lorsque le paiement est effectué.
24	124	title	4	Ajoute une commande d'approvisionnement lorsque le paiement est effectué
24	125	description	4	Traite le changement de statut de la commande
24	125	title	4	Traite le changement de statut de la commande
24	126	description	4	Crée des commandes à chaque qu'une ligne de commande est remplie via un changement de commande.
24	126	title	4	Crée des commandes d'approvisionnement pour le changement de commande.
24	127	description	4	Cette tâche planifie le processus qui calcule les commissions des agents.
24	127	title	4	Calculer les commissions des agents
24	128	description	4	Cette tâche calcule les commissions des agents.
24	128	title	4	Tâche Commissions des agents basiques
24	129	description	4	Ce plugin créera des commissions sur des paiements lorsque des paiements sont associés et désassociés des factures.
24	129	title	4	Générer des commissions sur les paiements pour les agents.
24	12	description	3	Wird eine PDF Version der Rechnung generieren.
24	12	description	4	Génèrera une version PDF d'une facture.
24	12	title	3	PDF Rechnung Mitteilung
24	12	title	4	Notification de facture au format PDF
24	133	description	4	Il déclenche le téléchargement par rapport à un système tiers
24	133	title	4	Déclencher le téléchargement des fichiers
24	134	description	4	Une tâche pour utiliser un plugin du type InternalEventsTask afin de vérifier si le solde prépayé des utilisateurs est inférieur aux niveaux 1 ou 2 de la limitation de crédit et d'envoyer des notifications.
24	134	title	3	Benutzer Kreditlimit Mitteilungsaufgabe
24	134	title	4	Tâche Notification de la limitation de crédit de l'utilisateur
24	135	description	4	Ce gestionnaire des erreurs de médiation enregistre automatiquement les CDR qui se sont soldés par un échec vers le tableau 'cdr_recycling' de HBase.
24	135	title	4	Gestionnaire des erreurs de médiation HBase
24	136	description	4	Ce plugin changera la statut de la commande au moment où le changement de la commande s'appliquer au changement de commande sélectionné.
24	136	title	4	Changer le statut de la commande au moment où le changement s'applique
24	137	title	4	Tâche Facturation de la consommation du regroupement d'utilisation
24	138	description	4	Il s'agit d'un plugin programmé qui prend l'utilisateur qui ne s'est pas connecté pendant un nombre de jours indiqué dans Préférence 55 et qui met à jour son statut en Inactif.
24	138	title	4	Plugin de gestion des comptes utilisateur inactifs
24	14	description	3	Kommt immer falsch zurƒck, das ist warum Jbilling nie eine Rechnung auf eine neue Rechnung ƒbertrègt.
24	14	description	4	Renvoie toujours une valeur fausse, ce qui que jBilling ne reporte jamais une facture sur une autre plus récente.
24	14	title	3	Keine åbertragung der Rechnung
24	14	title	4	Aucune facture à reporter
24	15	description	3	Wird eine neue Bestellung mit einem Strafeartikel erstellen. Der Artikel wird als Parameter der Aufgabe gemacht.
24	15	description	4	Créera une nouvelle commande avec un article Pénalité. l'article est considéré comme un paramètre de la tâche.
24	15	title	3	Standard Interessepflicht
24	15	title	4	Tâche relative aux intérêts par défaut
24	16	description	3	 Erstreckt BasicOrderFilterTask, modifiziert die Daten, um die Bestellung ein paar Monaten im Vorraus zutreffen zu lassen, bevor es den Standardfilter benutzen wƒrde.
24	16	description	4	Étend BasicOrderFilterTask, en modifiant les dates pour que la commande soit applicable pendant un nombre de mois dans le passé plus élevé que ce qu'elle aurait dû en utilisant le filtre par défaut.
24	16	title	3	Voraussichtlicher Bestellungsfilter
24	16	title	4	Filtre pour les commandes anticipées
24	17	description	3	 Erstreckt BasicOrderFilterTask, modifiziert die Daten, um die Bestellung ein paar Monaten im Vorraus zutreffen zu lassen, bevor es den Standardfilter benutzen wƒrde.
24	17	description	4	Étend BasicOrderPeriodTask, en modifiant les dates pour que la commande soit applicable pendant un nombre de mois dans le passé plus élevé que ce qu'elle aurait dû en utilisant la tâche par défaut.
24	17	title	3	Voraussichtliche Bestellungszeitrèume.
24	17	title	4	Anticiper les périodes de commande
24	19	description	3	 Erweitert den standard authorize.net Zahlungsprozessor, und sendet auch eine E-Mail an das Unternehmen nach der Verarbeitung der Bezahlung.
24	19	description	4	Élargit les capacités du système de traitement des paiements standard authorize.net pour qu'il puisse également envoyer un e-mail à la société après le traitement du paiement.
24	19	title	3	Email & Prozess authorize.net
24	19	title	4	E-mail et traitement authorize.net
24	1	description	3	Berechnet die Auftragssumme und die Summe fƒr jede Zeile, unter Berƒcksichtigung der Artikelpreise, der Menge und ob die Preise ein Prozentsatz sind oder nicht.
24	1	description	4	Calcule le total de la commande et la total pour chaque ligne, en prenant en compte les prix des articles, the quantity and if the prices are percentage or not.
24	1	title	3	Standard Auftragssumme
24	1	title	4	Totaux des commandes par défaut
24	20	description	3	Sendet eine E-Mail an die Rechnungsadministrator als Alarm, wenn ein Zahlungsportal ausfèllt.
24	20	description	4	Envoie un e-mail au gestionnaire de facturation pour l'avertir qu'une passerelle de paiement est en dysfonctionnement.
24	20	title	3	Zahlungs Gateway ausgefallen alarm
24	20	title	4	Alerte Passerelle en dysfonctionnement.
24	21	description	3	 Ein Test der Zahlungsprozessorimplementierung, um jBillings Funktionen testen zu kÖnnen, ohne einen echten Zahlungs- Gateway zu benutzen.
24	21	description	4	Mise en place d'un système de traitement des paiements de test pour permettre de tester les fonctions de jBillings sans utiliser une véritable passerelle de paiement.
24	21	title	3	Test Zahlungsprozessor
24	21	title	4	Traitement test des paiements
24	22	description	3	AEin Kunde kann einem bestimmten Zahlungs-Gateway zugeordnet werden. Es prƒft ein benutzerdefiniertes Kontaktfeld, um den Gateway zu identifizieren und delegiert dann die Zahlungsabwicklung zu einem anderen Plug-in.
24	22	description	4	Il permet à un client de se voir assigné une passerelle de paiement spécifique. Le champ Contact personnalisé est vérifié en vue d'identifier la passerelle, puis le traitement du paiement réel est traité par un autre plugin.
24	34	title	4	Lecteur de fichier avec longueur fixe
24	22	title	3	Router Zahlungsprozessor auf kundenspezifische Felder basiert
24	22	title	4	Système de traitement des paiements via un routeur basé sur les champs personnalisés
24	23	description	3	Es legt fest, wie ein Zahlungsereignis sich auf den Abo-Status eines Benutzers auswirkt, gemessen an dem gegenwèrtigen Status und einer Zustandsmaschine.
24	23	description	4	Détermine la manière dont un évènement lié à un paiement affecte le statut de l'abonnement d'un utilisateur, en prenant en compte son statut actuel et une machine d'état.
24	23	title	3	Standard Abonnement Status Manager
24	23	title	4	Gestionnaire de statut des abonnements par défaut
24	24	description	3	Integration mit dem ACH commerce Zahlungs Gateway.
24	24	description	4	Intégration avec la passerelle de paiement commercial ACH.
24	24	title	3	ACH Commerce Zahlungsprozessor
24	24	title	4	Système de traitement des paiements commerçants ACH
24	25	description	3	 Eine Dummy Aufgabe, die keine Parameter fƒr asynchrone Zahlungsabwicklung hinzufƒgt. Dies ist der Standard.
24	25	description	4	Une tâche factice qui n'ajoute aucun paramètre pour le traitement des paiements asynchrone. C'est le défaut.
24	25	title	3	Standard asynchrone Parameter 
24	25	title	4	Paramètres asynchrones standards
24	26	description	3	Dieser Plug-in fƒgt Parameter fƒr Asynchrone Zahlungsabwicklung hinzu, um eine Verarbeitungsnachricht bean pro Zahlungsprozessor zu haben. Es wird in Kombination mit den Router Zahlungsprozessor -PlugIns verwendet.
24	26	description	4	Ce plugin ajoute des paramètres pour le traitement des paiements asynchrone pour qu'il ait un ben de message de traitement par système de traitement des paiements. Il est utilisé en combinaison avec les plugins des systèmes de traitement des paiements via un routeur.
24	26	title	3	Router asynchrone Parameter
24	26	title	4	Paramètres asynchrones via un routeur
24	28	description	3	Es fƒgt Artikel zu einer Bestellung hinzu. Wenn der Artikel bereits in der Bestellung ist, aktualisiert es nur die Menge.
24	28	description	4	Il ajoute des articles à une commande. Si l'article est déjà dans la commande, il ne met à jour que la quantité.
24	28	title	3	Standard Artikel Manager
24	28	title	4	Gestionnaire d'articles standard
24	29	description	3	Dies ist ein regelbasierte Plug-in. Er wird das tun, was der Grundelementmanager tut (eigentlich genannt); aber dann wird er auch externe Regeln durchfƒhren. Diese externen Regeln haben die volle Kontrolle ƒber die Bestllung die neue Artikel bekommt.
24	29	description	4	Il s'agit d'un plugin basé sur des règles. Il fera ce que le gestionnaire d'articles basique fait (l'appeler en réalité), mais ensuite il exécutera également des règles externes. Ces règles externes ont un contrôle total sur le changement de la commande qui reçoit de nouveaux articles.
24	29	title	3	Regelartikel Manager
24	29	title	4	Gestionnaire de l'article Règles
24	2	description	3	Fƒgt eine zusètzliche Zeile zum Autrag hinzu mit einem Prozentsatz um die Mehrwertsteuer darzustellen.
24	2	description	4	Ajoute une ligne supplémentaire à la commentaire avec une majoration en pourcentage représentant la taxe sur la valeur ajoutée.
24	2	title	3	VAT
24	2	title	4	TVA
24	30	description	3	 Dies ist ein regelbasierter Plug-in. Er berechnet die Gesamtsumme fƒr eine Bestellung (in der Regel ist dies der Preis, multipliziert mit der Menge); so dass externe Regeln durchgefƒhrt werden kÖnnen.
24	30	description	4	Il s'agit d'un plug-in basé sur des règles. Il calcule le total pour une ligne de commande (généralement il s'agit du prix multiplié par la quantité), permettant ainsi l'exécution des règles externes.
24	30	title	3	Regel Zeile Gesamtsumme
24	30	title	4	Règles du total de la ligne
24	31	description	3	Dies ist ein regelbasierter Plug-in. Er gibt den Preis eines Artikels durch die Ausfƒhrung externer Vorschriften. Anschlieºend kÖnnen Sie Logik extern fƒr die Preise hinzufƒgen. Es ist auch mit dem Vermittlungsverfahren integriert, durch den Zugang zu der Vermittlungspreisdaten.
24	31	description	4	Il s'agit d'un plug-in basé sur des règles. Il donne un prix à un article en appliquant des règles externes. Vous pouvez ajouter une logique externe pour la tarification. Il est également intégré avec le processus de médiation en ayant accès aux données de tarification de la médiation.
24	31	title	3	Regelpreise
24	31	title	4	Règles de tarification
24	32	description	3	 Dies ist ein Reader fƒr das Vermittlungsverfahren. Er liest Datensètze aus einer Textdatei, deren Felder durch ein Zeichen (oder Zeichenfolge) getrennt sind.
24	32	description	4	Il s'agit d'une visionneuse pour le processus de médiation. Il lit les enregistrements provenant d'un fichier texte dont les champs sont séparés par un caractère (ou une chaîne de caractères).
24	32	title	3	Trenner Datei Reader
24	32	title	4	Visionneuse de fichier avec séparateur
24	33	description	3	Dies ist ein regelbasierter Plug-In (siehe Kapitel 7). Er nimmt eine Ereignisaufzeichnung aus dem Vermittlungsverfahren und fƒhrt externe Regeln durch, um den Datensatz in aussagekrèftige Abrechungsdaten zu ƒbersetzen. Dies ist der Kern des Vermittlungselements, siehe die ? Telecom Guide? Dokumentation fƒr weitere Informationen.
24	33	description	4	Il s'agit d'un plug-in basé sur des règles (voir Chapitre 7) Il effectue un enregistrement des évènements à partir du processus de médiation et il exécute des règles externes pour traduire l'enregistrement en données de facturation pertinentes. Il s'agit d'un élément essentiel du composant de la médiation, reportez-vous au 'Guide des télécoms' pour obtenir plus d'informations.
24	33	title	3	Regel Vermittlungsprozessor
24	33	title	4	Système de traitement des règles de médiation
24	34	description	3	 Dies ist ein Reader fƒr das Vermittlungsverfahren. Er liest Datensètze aus einer Textdatei, deren Felder fixierte Positionen haben, und der Datensatz hat eine feste Lènge.
24	34	description	4	Il s'agit d'une visionneuse pour le processus de médiation. Il lit les enregistrements provenant d'un fichier texte dont les champs ont des positions fixes, 'et l'enregistrement dispose d'une longueur fixe.
24	34	title	3	Festgelegte Lènge Dateireader
24	35	description	3	Das ist genau das gleiche wie die Standard-Zahlungsinformationen Aufgabe, der einzige Unterschied ist, dass es nicht validiert, wenn die Kreditkarte abgelaufen ist. Verwenden Sie dieses Plug-in nur, wenn Sie die Zahlung mit abgelaufene Kreditkarten einreichen mÖchten.
24	35	description	4	Il s'agit d'exactement la même chose que pour la tâche des informations relatives aux paiements, la seule différence est qu'il ne valide pas si la carte bancaire a expiré. Utilisez ce plugin uniqumenet si vous voulez envoyer des paiements avec des cartes bancaires expirées.
24	35	title	3	Zahlungsinformationen ohne Bestètigung
24	35	title	4	Informations relatives aux paiements sans validation
24	36	description	3	 Dieser Plug-in ist nur zu Testzwecken zu verwenden. Anstatt einer E-Mail (oder anderen wirklichen Mitteilungen); speichert es einfach den Text in einer Datei mit dem Namen emails_sent.txt.
24	36	description	4	Ce plugin est uniquement utilisé à des fins de test. Au lieu d'envoyer un e-mail (ou une autre notification réelle), il stocke simplement le texte à envoyer dans un fichier appelé emails_sent.txt.
24	36	title	3	Mitteilung fƒr Testing
24	36	title	4	Tâche de notification à des fins de test
24	37	description	3	 Dieses Plugin berƒcksichtigt den Feldkreislauf der Bestellungen um zu die Teilbestellzeiten zu berechnen.
24	37	description	4	Ce plugin prend en considération le champ Débuts de cycles des commandes pour calculer des périodes de commande fractionnées.
24	37	title	3	 Bestellfristen Rechner mit Pro-Bewertung.
24	37	title	4	Calculateur de périodes de commande avec paiement au prorata.
24	38	description	3	 Bei der Erstellung einer Rechnung aus einer Bestellung, wird dieses Plug-in jeder Bruchteil eines Zeitraums berechnen, mit einem Tages als kleinste abrechenbare Einheit.
24	50	description	3	Ein externer Bereitstellungs plug-in für die Kommunikation mit dem TeliaSonera MMSC.
24	38	description	4	Lors de la création d'une facture à partir d'une commande, ce plugin payera au prorata toute fraction d'une période en prenant un jour comme unité facturable la plus petite.
24	38	title	3	 Rechnungs Zusammensetzungsaufgabe mit pro-Rating (Tag-Fraktion)
24	38	title	4	Tâche de composition des factures avec paiement au prorata (jour sous forme de fraction)
24	39	description	3	Integration mit dem Intraanuity Zahlungs Gateway.
24	39	description	4	Intégration avec la passerelle de paiement Intraanuity.
24	39	title	3	Zahlungsprozess fƒr den Intraanuity Zahlungs Gateway
24	39	title	4	Processus de paiement pour la passerelle de paiement Intraanuity
24	3	description	3	Eine sehr einfache Implementierung, die das Fèlligkeitsdatum der Rechnung festsetzt. Das Fèlligkeitsdatum wird berechnet der Zeitraum auf das Rechnungsdatum hinzugefƒgt wird.
24	3	description	4	Une intégration très simple qui permet de définir la date d'échéance de la facture. La date d'échéance est calculée en ajoutant simplement la période de temps à la date facturée.
24	3	title	3	Rechnung Fèlligkeitsdatum
24	3	title	4	Date d'échéance de la facture
24	40	description	3	 Dieser Plug-in wird eine neue Bestllung mit einem negativen Preis erstellen, welche einen Kredit widerspiegelt, wenn eine Bestellung innerhalb eines bereits abgerechneten Zeitraums storniert wurde.
24	40	description	4	Ce plugin créera une nouvelle commande avec un prix négatif afin de refléter un crédit lorsqu'une commande est annulée au cours d'une période qui a déjà été facturée.
24	40	title	3	Automatischer Storierungskredit.
24	40	title	4	Crédit automatique pour annulation.
24	42	description	3	 Verwendet fƒr die Sperrung der Zahlungen vom Erreichen realer Zahlungsdienste. In der Regel als erster Zahlungsprozessor in der Verarbeitungskette konfiguriert.
24	42	description	4	Il est utilisé pour empêcher que les paiements n'atteignent de véritables systèmes de traitement des paiements. Il est généralement configuré comme premier système de traitement des paiements dans la chaîne de traitement.
24	42	title	3	Sperrliste Filter Zahlungsprozessor.
24	42	title	4	Filtre Liste noire pour systèmes de traitement des paiements.
24	43	description	3	Setzt Benutzer und die dazugehÖrigen Informationen (zB Kreditkartennummer, Telefonnummer, etc.) auf die schwarze Liste, wenn ihr Status ausgesetzt oder hÖher ist.
24	43	description	4	Entraîne l'inscription sur la liste noire des clients et de leurs informations associées (ex : numéro de carte bancaire, numéro de téléphone, etc.) si leur statut devient Suspendu ou supérieu. 
24	43	title	3	 Benutzer sperren, wenn deren Status wird ausgesetzt oder höher wird.
24	43	title	4	Place l'utilisateur sur une liste noire lorsque son statut devient suspendu ou supérieur.
24	44	description	3	Dies ist ein Reader für das Vermittlungsverfahren. Er liest Datensètze aus einer JDBC-Datenbankquelle.
24	44	description	4	Il s'agit d'une visionneuse pour le processus de médiation. Il lit les enregistrements à partir d'une source de bases de données JDBC.
24	44	title	3	JDBC Vermittlungs Reader.
24	44	title	4	Visionneuse de médiation JDBC
24	45	description	3	Dies ist ein Reader für das Vermittlungssverfahren. Es ist eine Erweiterung des JDBC-Reader, der eine einfache Konfiguration einer MySQL-Datenbankquelle erlaubt.
24	45	description	4	Il s'agit d'une visionneuse pour le processus de médiation. C'est une extension du lecteur JDBC, permettant une configuration aisée d'une source de base de données MySQL.
24	45	title	4	Visionneuse de médiation MySQL.
24	46	description	3	Reagiert auf Events die mit Bestellungen verbunden sind. Lässt Regeln laufen, um Befehle zu erzeugen, die über JMS-Nachrichten an das externe Bereitstellungsmodul geschickt werden.
24	46	description	4	Il réagit aux évènements associées aux commandes. Il exécute des règles pour générer des commandes à envoyer via des messages JMS vers un module d'approvisionnement externe.
24	46	title	3	 Bereitstellungsbefehle Regelaufgabe
24	46	title	4	Tâche des règles des commandes d'approvisionnement.
24	47	description	3	Dieses Plug-in wird nur zu Testzwecken verwendet. Es ist eine Test externe Bereitstellungsaufgabe zum Testen der Bereitstellungsmodule.
24	47	description	4	Ce plugin est uniquement utilisé à des fins de test. Il s'agit d'une tâche de test d'approvisionnement externe afin de tester les modules d'approvisionnement.
24	47	title	3	Externe Bereitstellungsaufgabe testen.
24	47	title	4	Tâche de test d'approvisionnement externe.
24	48	description	3	Ein externer Bereitstellungs Plug-in für die Kommunikation mit dem Ericsson Kundenverwaltungs Interface (CAI).
24	48	description	4	Un plugin d'approvisionnement externe pour communiquer avec l'interface d'administration des clients d'Erisson (CAI).
24	48	title	3	CAI externe Bereitstellungsaufgabe
24	48	title	4	Tâche d'approvisionnement externe pour CAI.
24	49	description	3	Delegiert die eigentliche Zahlungsabwicklung zu einem anderen Plug-in auf der Basis der Währung der Zahlung.
24	49	description	4	Il délègue le traitement réel des paiements à un autre plugin selon la devise du paiement.
24	49	title	3	Währungs Router Zahlungsanbieter
24	49	title	4	Système de traitement des paiements avec routeur pour les devises
24	4	description	3	Diese Aufgabe wird alle Linien auf den Bestellungen und Rechnungen auf die neuen Rechnung kopieren, unter Berƒcksichtigung der Zeitrèume fƒr jeden beteiligten Auftrag, nicht aber die Fraktionen von Zeitrèumen. Die Zeilen, die Steuern sind werden nicht kopiert. Die Menge und Gesamtbetrag jeder Zeile wird durch die Menge der Zeitrèume multipliziert werden.
24	4	description	4	Cette tâche copiera toutes les lignes sur les commandes et les factures vers la nouvelle facture, en prenant en compte les périodes concernées pour chaque commande, but not the fractions of periods. It will not copy the lines that are taxes. The quantity and total of each line will be multiplied by the amount of periods.
24	4	title	3	Standard Rechnungszusammensetzung.
24	4	title	4	Composition de la facture par défaut.
35	5	description	4	ACH
24	50	description	4	Un plugin d'approvisionnement externe pour communiquer avec le MMSC de TeliaSonera.
24	50	title	3	MMSC externe Bereitstellungsaufgabe
24	50	title	4	Tâche d'approvisionnement externe pour MMSC.
24	51	description	3	Dieser Filter wird nur Rechnungen mit einem positiven Saldo auf die nächste Rechnung übertragen.
24	51	description	4	Ce plug-in filtrera uniquement les factures avec un solde positif devant être reportées sur la facture suivante.
24	51	title	3	Filtert negative Rechnungen für Übertragungen.
24	51	title	4	Filtre les factures négative pour les reports.
24	52	description	3	Es wird eine Datei mit einer Zeile pro Rechnung generieren.
24	52	description	4	Il génèrera un fichier avec une ligne par facture générée.
24	52	title	3	Datei-Rechnungs Exporteur.
24	52	title	4	Exportateur de fichier de factures.
24	53	description	3	Es wird ein Bündel von Vorschriften nennen, wenn ein internes Ereignis eintritt.
24	53	description	4	Il appellera un ensemble de règles lorsqu'un évènement interne se produira.
24	53	title	3	Regel Caller für ein Ereignis.
24	53	title	4	Contrôleur de règles pour un évènement.
24	54	description	3	Es wird das dynamische Gleichgewicht eines Kunden (Prepaid-oder Kreditlimit) aktualisieren, wenn Ereignisse mit Auswirkungen auf das Gleichgewicht auftreten.
24	54	description	4	Il mettra à jour le solde dynamique d'un client (prépayé ou limite de crédit) si des évènements affectant le solde se produisent.
24	54	title	3	Dynamischer Balance Manager
24	54	title	4	Gestionnaire de solde dynamique
24	55	description	3	Für die Echtzeit-Vermittlung benutzt, dieser Plug-in wird einen Anruf auf der Grundlage des aktuellen dynamischen Gleichgewichts eines Kunden validieren.
24	55	description	4	Utilisé pour la médiation en temps réel, ce plugin validera un appel selon le solde dynamique actuel d'un client.
24	55	title	3	Balanceprüfer auf der Grundlage der Kundenbilanz.
24	55	title	4	Validateur de solde basé sur le solde du client.
24	56	description	3	Für die Echtzeit-Vermittlung benutzt, dieses Plug-in wird einen Anruf auf der Grundlage eines Bündels oder Regeln validieren
24	56	description	4	Utilisé pour la médiation en temps réel, ce plugin validera un appel selon un lot ou des règles.
24	56	title	3	Balanceprüfer basierend auf Regeln
24	56	title	4	Validateur de solde basé sur des règles.
24	57	description	3	Integration mit dem Gateway-Zahlungs Zahlungsanbieter.
24	57	description	4	Intégration avec le système de traitement des paiements Payments Gateway.
24	57	title	3	Zahlungsanbiert für Zahlung Gateway.
24	57	title	4	Système de traitement de paiements Payments Gateway.
24	58	description	3	Speichert die Kreditkarteninformationen in dem Zahlungs-Gateway, anstatt der Jbilling DB.
24	58	description	4	Il enregistre les informations relatives à la carte bancaire sur la passerelle de paiement, au lieu de la base de données jBilling.
24	58	title	3	Kreditkarten werden extern gespeichert.
24	58	title	4	Les cartes bancaires sont stockées en externe.
24	59	description	3	Dies ist ein regelbasierter Plug-in kompatibel mit dem Vermittlungsmodul von Jbilling 2.2.x. Er wird das tun, was die Grundelementmanager tut (eigentlich genannt); aber dann wird er auch externen Regeln ausführen. Diese externen Regeln haben die volle Kontrolle über die Veränderung der Bestellung welche neue Artikel bekommt.
24	59	description	4	Il s'agit d'un plugin basé sur des règles avec le module de médiation de jBilling 2.2.x., Il fera ce que le gestionnaire d'articles basique fait (l'appeler en réalité), mais ensuite il exécutera également des règles externes. Ces règles externes ont un contrôle total sur le changement de la commande qui reçoit de nouveaux articles.
24	59	title	3	Artikelregel Manager 2
24	59	title	4	Gestionnaire de l'article Règles 2
24	5	description	3	 Entscheidet, ob eine Bestellung in einer Rechnung fƒr einen bestimmten Abrechnungsprozess einbezogen werden soll. Dies geschieht, indem man die Abrechnungszeitspanne, den Zeitraum, die aktive Zeit seit/bis, usw berechnet
50	31	description	4	Utiliser des dates de facture continues.
24	5	description	4	Décide si une commande doit être incluse dans une facture pour un processus de facturation donné.  Cela s'effectue en prenant la période déterminée pour le processus de facturation, la période de commande, the active since/until, etc.
24	5	title	3	Standard Bestellungs Filter
24	5	title	4	Filtre standard pour les commandes
24	60	description	3	Dies ist ein regelbasierter Plug-in, kompatibel mit dem Vermittlungsverfahren von Jbilling 2.2.x und besser. Er berechnet die Gesamtleitung für einen Auftrag (in der Regel ist dies der Preis, multipliziert mit der Menge); so dass externen Regeln durchgeführt werden können.
24	60	description	4	Il s'agit d'un plugin basé sur des règles, compatible avec les versions du processus de médiation de jBilling 2.2.x et supérieures. Il calcule le total pour une ligne de commande (généralement il s'agit du prix multiplié par la quantité), permettant ainsi l'exécution des règles externes.
24	60	title	3	Regeln Gesamtzeilen- 2
24	60	title	4	Règles du total de la ligne - 2
24	61	description	3	Dies ist ein regelbasierter Plug-in kompatibel mit dem Vermittlungsmodul von Jbilling 2.2.x. Er gibt einen Preis zu einem Artikel an, durch Ausführen externer Vorschriften. Anschließend können Sie Logik extern für die Preise hinzufügen. Er ist auch mit dem Vermittlungsverfahren durch den Zugang zu der Vermittlungs Preisdaten integriert.
24	61	description	4	Il s'agit d'un plugin basé sur des règles avec le module de médiation de jBilling 2.2.x., Il donne un prix à un article en appliquant des règles externes. Vous pouvez ajouter une logique externe pour la tarification. Il est également intégré avec le processus de médiation en ayant accès aux données de tarification de la médiation.
24	61	title	3	Regel Preisliste 2
24	61	title	4	Règles de tarification 2
24	63	description	3	Eine falscher Plug-in, um Zahlungen, die extern gespeichert werden würden zu testen.
24	63	description	4	Un faux plugin pour tester les paiements qui seraient stockées en externe.
24	63	title	3	Test Zahlungprozessor für externe Speicher.
24	63	title	4	Système de traitement des paiements test pour stockage externe.
24	64	description	3	Zahlungsprozessor-Plug-in, mit RBS WorldPay integriert
24	64	description	4	Plugin de système de traitement des paiements à intégrer avec RBS WorldPay.
24	64	title	3	WorldPay Integration
24	64	title	4	Intégration de WorldPay.
24	65	description	3	 Zahlungsprozessor-Plug-in, mit RBS WorldPay integriert. Er speichert die Kreditkarteninformationen (Nummer, usw.) in dem Gateway.
24	65	description	4	Plugin de système de traitement des paiements à intégrer avec RBS WorldPay. Il stocke les informations relatives à la carte bancaire (numéro, etc) sur la passerelle.
24	65	title	3	WorldPay Integration mit externem Speicher
24	65	title	4	Intégration de WorldPay avec stockage externe.
24	66	description	3	Überwacht das Gleichgewicht von einem Kunden und beim Erreichen eines Limits, fordert eine Echtzeit-Zahlung an
24	66	description	4	Il contrôle le solde d'un client et au moment d'atteindre une limite, il demande un paiement en temps réel
24	66	title	3	Auto Aufladen
24	66	title	4	Recharge automatique.
24	67	description	3	Zahlungsanbiter für Integration mit dem Beanstream Zahlungs gateway
24	67	description	4	Système de traitement des paiements pour une intégration avec la passerelle de paiement Beanstream.
24	67	title	3	Beanstream Gateway Integration
24	67	title	4	Intégration d'une passerelle Beanstream
24	68	description	3	Zahlunganbieter für Integration mit dem Sage Zahlungs Gateway
24	68	description	4	Système de traitement des paiements pour une intégration avec la passerelle de paiement Sage.
24	68	title	3	Sage Zahlungs gateway Integration
24	68	title	4	Intégration d'une passerelle de paiement Sage
24	69	description	3	Wird aufgerufen, wenn die Abrechnung läuft um auszuwählen welche Benutzer bewertet werden. Diese grundlegende Implementierung zeigt einfach jedem Benutzer an der nicht im gesperrten (oder schlimmer) Status ist
24	69	description	4	Appelé lorsque le processus de facturation s'exécute pour sélectionner quels utilisateurs évaluer. Cet exercice de base renvoie simplement le fait que tous les utilisateurs n'ont pas un statut Suspendu (ou pire)
24	69	title	3	Standard Abrechnungs Benutzer Filter 
24	69	title	4	Filtre utilisateurs pour le processus de facturation standard
24	6	description	3	 Gibt immer True zurƒck, was bedeutet, dass die ƒberfèllige Rechnung auf eine neue Rechnung ƒbertragen wird.
24	6	description	4	Renvoie toujours une valeur vraie, ce qui signifie que la facture impayée sera reportée sur une nouvelle facture.
24	6	title	3	Standard Rechnungs Filter
24	6	title	4	Filtre pour les factures standard
24	70	description	3	Wird aufgerufen, wenn die Abrechnung läuft, um auswählen, welche Benutzer zu bewerten. Dies zeigt nur Benutzer mit Bestellungen an, die ein nächstes Abrechnungsdatum früher als den Abrechnungsprozess haben.
24	70	description	4	Appelé lorsque le processus de facturation s'exécute pour sélectionner quels utilisateurs évaluer. Il ne renvoie que les utilisateurs avec des commandes dont la date de la prochaine facture est antérieure au processus de facturation.
24	70	title	3	Auswahl Abrechnungs Benutzerfilter
24	70	title	4	Filtre utilisateurs pour le processus de facturation sélectif
24	71	description	3	Ereignisdatensätze mit Fehlern werden in einer Datei gespeichert
24	71	description	4	Les enregistrements avec des erreurs sont enregistrés dans un fichier
24	71	title	3	Vermittlungs Datei Fehler Steuerungsprogramm
24	71	title	4	Gestionnaire des erreurs du fichier de médiation
24	73	description	3	 Ereignis-Datensätzen mit Fehler werden in einer Datenbanktabelle gespeichert
24	73	description	4	Les enregistrements avec des erreurs sont enregistrés dans la table d'une base de données
24	73	title	3	Vermittlungsdatensatz basiertes Fehler Steuerungsprogramm
24	73	title	4	Gestionnaire des erreurs de la base de données de médiation
64	141	description	4	Mongolie
24	75	description	3	Sendet Zahlungen an PayPal als Zahlungsgateway und speichert auch Kreditkarteninformationen in PayPal
24	75	description	4	Il envoie des paiements à PayPal en tant que passerelle de paiement et il stocke également les informations relatives à la carte bancaire dans PayPal
24	75	title	3	Paypal Integration mit externem Speicher
24	75	title	4	Intégration de PayPal avec stockage externe.
24	76	description	3	Sendet Zahlungen an authorize.net als Zahlungs-Gateway und speichert auch Kreditkarteninformationen in authorize.net
24	76	description	4	Il envoie des paiements à authorize.net en tant que passerelle de paiement et il stocke également les informations relatives à la carte bancaire dans authorize.net
24	76	title	3	Authorize.net Integration mit externem Speicher
24	76	title	4	Intégration de authorize.net avec stockage externe.
24	77	description	3	Delegiert die eigentliche Zahlungsabwicklung zu einem anderen Plug-in auf der Grundlage der Zahlungsmethode der Zahlung.
24	77	description	4	Il délègue le traitement réel des paiements à un autre plugin selon la méthode de paiement.
24	77	title	3	Zahlungsmethode Router Zahlungsprozessor
24	77	title	4	Système de traitement des paiements avec routage selon la méthode de paiement
24	78	description	3	Erzeugt Regeln dynamisch, basiert auf auf eine Velocity Vorlage.
24	78	description	4	Il génère des règles de manière dynamique selon un modèle Velocity
24	78	title	3	Dynamischer Regelgenerator
24	78	title	4	Générateur de règles dynamiques
24	79	description	3	Dies ist ein Plugin, das sich mit Preisberechnungbefasst, auf die it von den implemenations der verschiedenen Preismodelle basiert.
24	79	description	4	Il s'agit d'un plugin qui gère le calcul des tarifs selon l'exécution de différents modèles de prix.
24	79	title	3	Preismodell Preisaufgabe
24	79	title	4	Tâche de tarification selon des modèles de prix.
24	7	description	3	Berechnet den Beginn und den Endzeitraum in einer Rechnung. Dies geschieht, indem man die Abrechnungszeitspanne, den Zeitraum, die aktiven Zeit seit/bis, usw berechnet.
24	7	description	4	Calcule le début et la fin de la période à inclure dans une facture. Cela s'effectue en prenant la période déterminée pour le processus de facturation, la période de commande, the active since/until, etc.
24	7	title	3	Standard Bestellungszeitraum
24	7	title	4	Périodes de commande par défaut
24	80	description	3	Eine geplante Aufgabe, um den Abrechnungsablauf durchzuführen.
24	80	description	4	Une tâche programmée pour exécuter le processus de facturation.
24	80	title	3	Abrechnungsaufgabe
24	80	title	4	Tâche Processus de facturation
24	81	description	3	Eine geplante Aufgabe, um den Vermittlungsablauf auszuführen.
24	81	description	4	Une tâche programmée pour exécuter le processus de médiation.
24	81	title	3	Vermittlungsprozessaufgabe
24	81	title	4	Tâche Processus de médiation
24	87	description	3	 Datiert einen Benutzer auf der Grundlage der Anzahl der Tage, die das Konto überfällig ist.
24	87	description	4	Détermine la phase d'un utilisateur selon le nombre de jours pendant lequel le compte est débiteur.
24	87	title	3	Einfache Datierung
24	87	title	4	Avancement basique des phases
24	88	description	3	Eine geplante Aufgabe, um den Datierungsprozess auszuführen.
24	88	description	4	Une tâche programmée pour exécuter le processus d'avancement des phases.
24	88	title	3	Datierungprozessaufgabe
24	88	title	4	Tâche Processus d'avancement des phases
24	89	description	3	Datiert einen Benutzer auf der Grundlage der Anzahl von Werktagen (außer an Feiertagen), die das Konto überfällig ist.
24	89	description	4	Détermine la phase d'un utilisateur selon le nombre de jours ouvrés (hors week-end et jours fériés) pendant lequel le compte est débiteur.
24	89	title	3	Werktag Datierung
24	89	title	4	Avancement des phases en jours ouvrés
24	8	description	3	Integration mit dem  authorize.net Zahlungs Gateway.
24	8	description	4	Intégration avec la passerelle de paiement authorize.net.
24	8	title	3	Authorize.net Zahlungsprozessor
24	8	title	4	Système de traitement des paiements Authorize.net
24	90	description	3	Eine steckbare Aufgabe der Art von AbstractChargeTask um einen Steuer Artikel auf die Rechnung hinzuzüfugen, mit einer Einrichtung der Freistellung um einen Artikel freizugeben oder einen Kunden freizustellen.
24	90	description	4	Une tâche pour utiliser le plugin du type AbstractChargeTask pour appliquer un article fiscal à une facture avec une fonction permettant d'exempter un article ou un client.
24	90	title	3	Einfache Steuer Zusammensetzungsaufgabe
24	90	title	4	Tâche Composition fiscale simple
24	91	description	3	Eine steckbare Aufgabe der Art von AbstractChargeTask um einen Steuer Artikel auf die Rechnung hinzuzufügen, wenn der Ländercode des Partners übereinstimmt.
24	91	description	4	Une tâche pour utiliser un plugin AbstractChargeTask pour appliquer un article fiscal à la facture si le code pays du partenaire correspond.
24	91	title	3	Landsteuerrechnung Zusammensetzungsaufgabe 
24	91	title	4	Tâche Composition d'une facture de taxe nationale
24	92	description	3	Eine steckbare Aufgabe der Art von AbstractChargeTask um eine Strafe auf eine Rechnung hinzuzufügen, die ein Fälligkeitsdatum über einen konfigurierbaren Zeitraum hinweg hat.
24	92	description	4	Une tâche pour utiliser un plugin du type AbstractChargeTask pour appliquer une pénalité à une facture dont la date d'échéance est au-delà de la période configurable en termes de nombre de jours.
24	92	title	3	Zahlungsbedingungen Strafaufgabe
24	92	title	4	Tâche Pénalité relative aux Conditions de Paiement
47	15	description	4	Un paiement est prêt pour un partenaire, mais aucun instrument de paiement.
50	53	description	3	Spezifische Emails erzwingen
24	96	description	3	Dies ist ein Abonnement Ereignis basiertes Plugin. Es nimmt Datensätze aus dem Vermittlungsverfahren auf und übersetzt sie in aussagekräftige Rechnungsdaten. Es konzentriert sich auf wiederkehrende Bestellungen. Wenn kein Bestellung verfügbar ist, erstellt es eine neue.
24	96	description	4	Plugin basé sur les évènements liés aux abonnements. Il effectue des enregistrements à partir du processus de médiation et il les traduit en données de facturation pertinentes. Il se centre sur des commandes récurrentes. Si aucune facture n'est disponible, il en créer une nouvelle.
24	96	title	3	Abonnement Ereignisprozessor
24	96	title	4	Système de traitement des évènements liés aux abonnements
24	97	description	3	Diese Aufgabe ist zum Anlegen eines % -Satzes oder einem festen Strafbetrag auf eine überfällige Rechnung verantwortlich. Diese Aufgabe ist aussagekräftig, weil es diese Aktion kurz vor dem Abrechnungsprozess der gesammelten Bestellungen ausführt.
24	97	description	4	Cette tâche est chargée d'appliquer une pénalité correspondant à un pourcentage ou à un montant fixe sur une facture impayée. Cette tâche est très efficace car elle effectue cette action juste avant que le processus de facturation ne collecte les commandes.
24	97	title	3	Strafaufgabe für überfällige Rechnung
24	97	title	4	Tâche Pénalité sur les impayés
24	9	description	3	Teil dem Benutzer etwas per Email mit. Text und HTML Emails sind unterstƒzt.
24	9	description	4	Notifie un utilisateur par l'envoi d'un e-mail. Les e-mails texte et HTML sont pris en charge
24	9	title	3	Standard Email Mitteilungen
24	9	title	4	Notification standard par e-mail
35	15	description	3	Kredit
35	15	description	4	Crédit
35	1	description	3	Scheck
35	1	description	4	Chèque
35	2	description	3	Visa
35	2	description	4	Visa
35	3	description	3	MasterCard
35	3	description	4	MasterCard
35	4	description	3	AMEX
35	4	description	4	AMEX
35	5	description	3	ACH
35	6	description	3	Entdeckung
35	6	description	4	Discover
35	7	description	3	Diners
35	7	description	4	Diners
35	8	description	3	PayPal
35	8	description	4	PayPal
4	10	description	3	Malaysischer Ringgit
4	10	description	4	Ringgit malaysien
4	11	description	3	Australischer Dollar
41	1	description	3	Erfoglreich
4	11	description	4	Dollar australien
41	1	description	4	Réussite
41	2	description	3	Fehlgeschlagen
41	2	description	4	Échec
41	3	description	3	Prozessor nicht verfƒgbar
41	3	description	4	Système de traitement indisponible
41	4	description	3	Eingetreten
41	4	description	4	Saisie
4	1	description	3	US-Dollar
4	1	description	4	Dollar américain
4	2	description	3	Kanadischer Dollar
4	2	description	4	Dollar canadien
4	3	description	3	Euro
4	3	description	4	Euro
4	4	description	3	Yen
4	4	description	4	Yen
4	5	description	3	Pfund Sterling
4	5	description	4	Livre Sterling
4	60	description	4	Dollar australien
46	11	description	3	Steckbare Aufgabenwartung
46	11	description	4	Entretien des tâches pour utiliser des plugins
46	1	description	3	Abrechnungsprozess
4	61	description	4	AUd
46	1	description	4	Processus de facturation
46	2	description	3	Benutzerwartung
4	62	description	4	Dollar australien
46	2	description	4	Entretien des préférences de l'utilisateur
46	3	description	3	Artikelwartung
4	63	description	4	Dollar australien
46	3	description	4	Entretien des articles
46	4	description	3	Artikeltyp Wartung
4	64	description	4	Bitcoin
46	4	description	4	Entretien du type d'articles
46	5	description	3	Artikel Kundenpreis Wartung
46	5	description	4	Entretien du prix de l'article pour l'utilisateur
46	6	description	3	Promotion Wartung
46	6	description	4	Entretien des promotions
46	7	description	3	Bestellungswartung
46	7	description	4	Entretien des commandes
46	8	description	3	Kreditkareten Wartung
46	8	description	4	Entretien des cartes bancaires
46	9	description	3	Rechnungswartung
46	9	description	4	Entretien de la facture
4	6	description	3	Won
4	6	description	4	Won
47	10	description	3	 Ein Abrechnungprozess lèuft, aber eine Prƒfung wurde als ungenehmigt befunden.
47	10	description	4	Exécution d'un processus de facturation, mais un examen s'avère non approuvé
47	11	description	3	 Ein Abrechnungprozess lèuft, eine Prƒfung ist notwendig aber wurde nicht gefunden.
47	11	description	4	Exécution d'un processus de facturation, un examen est requis mais non présent.
47	12	description	3	Ein Benutzerstatus wurde geèndert.
47	12	description	4	Le statut d'un utilisateur a été modifié.
47	13	description	3	Ein Bestellungszustand wurde geèndert.
47	13	description	4	Le statut d'une commande a été modifié.
47	14	description	3	 Ein Benutzer musste vegƒted werden, aber keine weiteren Schritte sind konfiguriert.
47	14	description	4	Un utilisateur doit être à un stade, mais il n'y a plus d'étapes configurées
47	15	description	3	Ein Partner hat eine Bezahlung, aber kein Bezahlungsinstrument.
47	16	description	3	Eine Bestellung wurde manuell auf eine Rechnung hinzugefƒgt.
47	16	description	4	Un bon de commande a été manuellement appliqué à une facture.
47	17	description	3	Die Bestellungszeile wurde aktualisiert
47	17	description	4	La ligne de commande a été mise à jour
47	18	description	3	Das Abrechnunsdatung der Betellung wurde geändert
47	18	description	4	La prochaine de facturation des commandes a été modifiée
47	19	description	3	Letzer API-Aufruf, um die Benutzer Abonnement Zustandsübergänge zu erhalten
47	19	description	4	Dernier appel API pour obtenir les changements du statut des abonnements des utilisateurs
47	1	description	3	Eine voraus bezahlte Bestellung hat noch nicht abgerechneten Zeit vor dem Abrechnungsdatum
47	1	description	4	Une commande prépayée comprend du temps non facturé avant la date de traitement de la facturation
47	20	description	3	Benutzer Abonnement Status wurde geändert
47	20	description	4	Le statut de l'abonnement de l'utilisateur a changé
47	21	description	3	Benutzerkonto ist jetzt gesperrt
47	21	description	4	Le compte utilisateur est désormais bloqué
47	22	description	3	Die Hauptabonnement Markierung der Betstellung wurde geändert
47	22	description	4	La case à cocher Abonnement principal pour les commandes a été modifiée
47	23	description	3	Alle einmaligen Bestellungen die Vermittlung befanden sich im beendeten Status
47	23	description	4	Toutes les commandes uniques trouvées par la médiation avaient le statut Terminée
47	24	description	3	Eine gültige Zahlungsmethode konnte nicht gefunden werden. Die Zahlungsanforderung wurde storniert
47	24	description	4	Aucune méthode de paiement valide n'a été trouvée. La demande de paiement a été annulée
47	25	description	3	Eine neue Zeile wurde erstellt
47	25	description	4	Une nouvelle ligne a été créée
47	26	description	3	Eine abrechnete Bestellung wurde storniert, eine Kreditbestellung wurde erstellt
47	26	description	4	Une commande facturée a été annulée, un ordre de crédit a été créé
47	27	description	3	Eine Benutzer ID wurde auf die Sperrliste hinzugefügt
47	27	description	4	Un identifiant utilisateur a été ajouté à la liste noire
47	28	description	3	Eine Benutzer ID wurde von der Sperrliste entfernt
47	28	description	4	Un identifiant utilisateur a été supprimé de la liste noire
47	29	description	3	Verwendet einen Bereitstellungsbefehl mit einem UUID
47	29	description	4	A publié une commande d'approvisionnement en utilisant un UUId
47	2	description	3	 Bestellung hat keine aktive Zeit zum Zeitpunkt des Prozesses.
47	2	description	4	La commande n'a pas d'heure active à la date du traitement.
47	30	description	3	Es wurde ein Befehl für die Bereitstellung veröffentlicht
47	30	description	4	Une commande d'approvisionnement a été publiée
47	31	description	3	Der Bereitstellungsstatus einer Bestellzeile hat sich geändert
47	31	description	4	Le statut d'approvisionnement d'une ligne de commande a changé
47	32	description	3	Benutzer Abonnement Status wurde NICHT geändert
47	32	description	4	Le statut de l'abonnement de l'utilisateur n'a PAS changé
47	33	description	3	Die dynamische Balance eines Benutzers hat sich geändert
47	33	description	4	Le solde dynamique d'un utilisateur a changé
47	34	description	3	Die Rechnung wenn eine Untermarkierung sich geändert hat
47	34	description	4	La facture si la case à cocher Enfant a changé
47	35	description	4	Une commande revendeur a été créée pour l'entité racine au cours de la génération d'une facture pour une entité enfant.
47	37	description	4	Une tentative de connexion infructueuse a été effectuée.
47	3	description	3	 Mindestens ein kompletter Zeitraum ist abrechenbar.
47	3	description	4	Au moins une période complète doit être facturable.
47	4	description	3	Bereits fƒr das jetzige Datum abgrechnet.
47	4	description	4	Déjà facturée pour la date actuelle.
47	5	description	3	 Diese Bestellung musste im letzten Prozess als ausgeschlossen markiert werden.
47	5	description	4	Cette commande a dû être exclu lors du dernier traitement.
47	6	description	3	 Vorausbezahlte Bestellung wird nach dem Verfallsprozess bearbeitet.
47	6	description	4	La commande prépayée est traitée après son expiration
47	7	description	3	Eine Linie wurde als gelÖscht markiert.
47	7	description	4	Une ligne a été signalée comme supprimée.
47	8	description	3	Ein Benutzerpassword wurde geèndert.
47	8	description	4	Le mot de passe d'un utilisateur a été modifié.
47	9	description	3	Eine Linie wurde aktualisiert.
47	9	description	4	Une ligne a été mise à jour.
4	7	description	3	Schweizer Franken
4	7	description	4	Franc suisse
4	8	description	3	Schwedische Krone
4	8	description	4	couronne suédoise
4	9	description	3	Singapur Dollar
4	9	description	4	Dollar de Singapour
50	13	description	3	Selbstbelieferung von Papierrechnungen
50	13	description	4	Factures papier par courrier postal
50	13	instruction	3	Auf '1' einstellen um Rechnungen als Abrechnungsunternehmen per Email zu schicken. “0” um Rechnungen als jBilling zu schicken.
50	13	instruction	4	Configurez sur '1' pour envoyer des factures par e-mail sous le nom de la société de facturation. Sur '0' pour transmettre les factures en tant que jBilling.
50	14	description	3	Kundenanmerkungen zur Rechnung hinzufƒgen
50	14	description	4	Inclure les notes du client sur la facture
50	14	instruction	3	Auf '1' einstellen um Anmerkungen in Rechnungen anzuzeigen, “0” um dies auszuschalten.
64	142	description	3	Montserrat
50	14	instruction	4	Configurez sur '1' pour afficher des notes sur les factures', sur '0' pour désactiver.
50	15	description	3	Tage vor Ablauf der Auftragsbenachrichtigung
50	15	description	4	Jours avant l'expiration de la notification de la commande
50	15	instruction	3	Tage vor dem Bestellungs 'aktiv bis ' Datum um die 1. Benachrichtigung zu senden. Leer lassen, um zu deaktivieren.
50	15	instruction	4	Jours avant la date 'actives jusqu'au' des commandes pour envoyer la 1ère notification. Laissez ce champ vide pour désactiver.
50	16	description	3	Tage vor Ablauf der Auftragsbenachrichtigung 2
50	16	description	4	Jours avant l'expiration pour la notification de la commande 2
50	16	instruction	3	Tage vor dem Bestellungs 'aktiv bis ' Datum um die 2. Benachrichtigung zu senden. Leer lassen, um zu deaktivieren.
50	16	instruction	4	Jours avant la date 'actives jusqu'au' des commandes pour envoyer la 2ème notification. Laissez ce champ vide pour désactiver.
50	17	description	3	Tage vor Ablauf der Auftragsbenachrichtigung 3
50	17	description	4	Jours avant l'expiration pour la notification de la commande 3
50	17	instruction	3	Tage vor dem Bestellungs 'aktiv bis ' Datum um die 3. Benachrichtigung zu senden. Leer lassen, um zu deaktivieren.
50	17	instruction	4	Jours avant la date 'actives jusqu'au' des commandes pour envoyer la 3ème notification. Laissez ce champ vide pour désactiver.
50	18	description	3	Rechnungsnummer Prèfix 
50	18	description	4	Préfixe du numéro de facture
50	18	instruction	3	 Prefix Wert für generierte Rechnung öffentlichen Zahlen.
50	18	instruction	4	Valeur du préfixe pour les numéros publics des factures générés.
50	19	description	3	Nèchste Rechnungsnummer
50	19	description	4	Prochain numéro de facture
50	19	instruction	3	 Der aktuelle Wert für die generierte Rechnung öffentlichen Zahlen. Neuen Rechnungen wird eine öffentliche Zahl zugewiesen durch Eröhung dieses Werts.
64	205	description	4	Suisse
50	19	instruction	4	La valeur actuelle pour les numéros publics des factures générés. Les nouvelles factures se verront assignées un numéro public en incrémentant cette valeur.
50	1	description	3	 Bezahlung mit dem Zahlungsprozess durchfƒhren 
50	1	description	4	Traiter le paiement avec le processus de facturation
50	20	description	3	Manuelle Rechnungslöschung
50	20	description	4	Suppression manuelle de la facture
50	20	instruction	3	Auf ' 1 ' einstellen, um es zu ermöglichen Rechnungen zu löschen, ' 0 ' um dies zu deaktivieren.
50	20	instruction	4	Configurez sur '1' pour autoriser la suppression des factures, sur '0' pour désactiver.
50	21	description	3	Rechnungserinnerungen benutzen
50	21	description	4	Utiliser des relances de facture
50	21	instruction	3	 Auf ' 1 ' einstellen um Rechnungsbenachrichtigungen zu erlauben ' 0 ' um dies zu deaktivieren.
50	21	instruction	4	Configurez sur '1' pour autoriser les notifications de relances, sur '0' pour désactiver.
50	22	description	3	Anzahl der Tage nach der Rechnungsgenerierung fƒr die erste Mahnung
50	22	description	4	Nombre de jours après la génération de la facture pour la première relance
50	23	description	3	Anzahl der Tage fƒr die nèchste Erinnerung
50	23	description	4	Nombre de jours pour la prochaine relance
50	24	description	3	Datei Fattura Fine Mese
50	24	description	4	Data Fattura Fine Mese
50	24	instruction	3	Auf '1' einstellen um es zu ermögliche, “0” um es zu deakivieren.
50	24	instruction	4	Configurez sur '1' pour activer, sur '0' pour désactiver.
50	25	description	3	Verwenden Sie überfällig Strafen (Zinsen).
50	25	description	4	Utiliser des pénalités pour impayés (intérêt).
50	25	instruction	3	 Auf '1' einstellen, um den Abrechnungsablauf zu ermöglichen Verzugszinsen zu berechnen, ' 0 ' um dies zu deaktivieren. Berechnung der Zinsen wird durch den gewählten Straf Plug-in bearbeitet.
50	25	instruction	4	Configurez sur '1' pour activer le processus de facturation pour calculer les intérêts sur les retards de paiement, sur '0' pour désactiver. Le calcul des intérêts est géré par le plugin des pénalités sélectionné.
50	27	description	3	Bestellungsvorgriffe verwenden.
50	27	description	4	Utiliser l'anticipation des commandes.
50	27	instruction	3	Auf '1' einstellen, um den 'OrderFilterAnticipateTask' zu verwenden, um eine Anzahl von Monate im Voraus in Rechnung zu setzen, ' 0 ' um dies zu deaktivieren. Plug-ins müssen separat konfiguriert werden.
50	27	instruction	4	Configurez sur '1' pour utiliser OrderFilterAnticipateTask pour facturer un certain nombre de mois à l'avance, sur '0' pour désactiver. Le plugin doit être configuré séparément.
50	28	description	3	Paypal Konto.
50	28	description	4	Compte PayPal.
50	28	instruction	3	PayPal Kontoname .
50	28	instruction	4	Nom du compte PayPal.
50	29	description	3	Paypal Knopf URL.
50	29	description	4	URL du bouton PayPal.
50	29	instruction	3	Eine URL, wo sich die Grafik des PayPal-Button befindet. Die Taste wird für die Kunden angezeigt, wenn sie eine Zahlung durchführen. Der Standardwert ist in der Regel die beste Option, es sei denn, eine andere Sprache wird benötigt.
50	29	instruction	4	Une URL où l'image du bouton PayPal est présente. Le bouton est affiché pour les clients lorsqu'ils effectuent un paiement. l'option Par défaut est la meilleure, sauf quand une autre langue est nécessaire.
50	2	description	3	URL der CSS Datei
50	2	description	4	URL du fichier CSS
50	30	description	3	URL für HTTP Datierungsaufruf.
50	30	description	4	URL pour le rappel des phases de vieillissement en HTTP.
50	30	instruction	3	URL des HTTP Rückrufs wenn der Datierungsprozess den Status eines Benutzers ändert.
50	30	instruction	4	URL pour le rappel au format HTTP afin d'invoquer le moment où le processus d'avancement des phases modifie le statut d'un utilisateur.
50	31	description	3	 Kontinuierliche Rechnungsdaten verwenden.
50	31	instruction	3	Standard: leer. Diese Einstellung muss ein Datum (im Format JJJJ-MM-TT. Beispiel: 2000.01.31) sein, das System wird sicherstellen, dass alle Ihre Rechnungen ihre Daten in einer inkrementellen Weise haben. Jede Rechnung mit einer größeren ' ID ' wird auch ein größeres (oder gleiches) Datum haben. In anderen Worten, kann eine neue Rechnung kein früheres Datum als eine bestehende (ältere) Rechnung haben. Um diese Einstellung zu verwenden, setzen Sie diese als Kette mit dem Tag, andem es anfangen soll. Diese Einstellung wird nicht verwendet werden wenn es leer ist 
50	31	instruction	4	Espace par défaut. Cette préférence doit être une date (au format aaaa-mm-dd. Exemple : 2000-01-31); le système s'assurera que les dates de toutes vos factures sont incrémentales. Toute facture avec un 'ID' supérieur aura également une date postérieure (ou égale). En d'autres termes, ', a new invoice can not have an earlier date than an existing (older) invoice. To use this preference, set it as a string with the date where to start. This preference will not be used if blank
50	32	description	3	PDF Rechnung zur Email hinzufügen.
50	32	description	4	Attacher une facture PDF aux notifications par e-mail.
50	32	instruction	3	Auf '1' einstellen, um eine PDF-Version der Rechnung für alle Rechnungs Benachrichtigungs-E-Mails anzuhängen. ' 0 ' um dies zu deaktivieren.
50	32	instruction	4	Configurez sur '1' pour joindre une version PDF de la facture à toutes les notifications de factures par e-mail. Sur '0' pour désactiver.
50	33	description	3	 Erzwingen einer Bestellung pro Rechnung.
50	33	description	4	Forcer une commande par facture.
50	33	instruction	3	Auf '1' einstellen, um die 'zur separaten Rechnung hinzugefügt' Markierung auf einer Bestellung anzuzeigen. '0' um dies zu deaktivieren.
50	33	instruction	4	Configurez sur '1' pour afficher la case à cocher 'inclure dans une facture séparée' sur une commande. Sur '0' pour désactiver.
50	35	description	3	Bestellungs ID zu Rechnungszeilen hinzufügen.
50	35	description	4	Ajouter un ID de commande aux lignes de la facture.
50	35	instruction	3	Auf '1' einstellen , um die ID der Bestellung im Beschreibungstext der resultierenden Rechnungsposten hinzuzufügen. '0' um dies zu deaktivieren. Dies kann helfen, zu verfolgen, welche Aufträge für eine exakte Linie in einer Rechnung zuständig ist, wenn man bedenkt, dass viele Aufträge in einer einzigen Rechnung aufgenommen werden können.
50	35	instruction	4	Configurez sur '1' pour inclure l'ID de la commande dans le texte descriptif de la ligne de facture résultante. Sur '0' pour désactiver. Cela peut aider à suivre avec précision quelles sont exactement les commandes responsables pour une ligne sur une facture, en prenant en compte que de nombreuses commandes peuvent être incluses dans une facture unique.
50	36	description	3	Es Kunden erlauben Kontaktinformationen zu editieren.
50	36	description	4	Autoriser les clients à modifier ses propres coordonnées.
50	36	instruction	3	Auf '1' einstellen um es Kunden zu erlauben ihre eigenen Kontaktinformationen zu editieren. '0' um dies zu deaktivieren.
50	36	instruction	4	Configurez sur '1' pour autoriser les clients à modifier leurs propres coordonnées. Sur '0' pour désactiver.
50	38	description	3	Datierung mit dem Kundenabonnentenstatus vebinden.
50	38	description	4	Lien des phases d'avancement vers le statut d'abonné du client.
50	38	instruction	3	 Auf '1' einstellen, um den Abo-Status eines Benutzers zu ändern, wenn der Benutzer datiert wird. '0' um dies zu deaktivieren.
50	38	instruction	4	Configurez sur '1' pour modifier le statut de l'abonnement d'un utilisateur lorsqu'il y a un avancement dans les phases de ce dernier. Sur '0' pour désactiver.
50	39	description	3	Benutzer nach fehlgeschlagenen Anmeldeversuchen sperren.
50	39	description	4	Bloquer l'utilisateur après des tentatives de connexion échouées.
50	39	instruction	4	Le nombre de tentatives à autoriser avant le blocage du compte utilisateur. Un compte utilisateur bloqué le sera pendant le nombre de minutes indiquées dans Préférence 68. Pour activer cette fonction de blocage, configurer la Préférence 68 sur une valeur différente de zéro est un plus.
50	3	description	3	URL der Logografik
50	3	description	4	URL de l'image du logo
50	40	description	3	Benutzerpasswörter nach zwei Tagen ablaufen lassen.
50	40	description	4	Faire expirer les mots de passe des utilisateurs après plusieurs jours.
50	40	instruction	3	Wenn größer als Null, stellt es die Anzahl der Tage dar, für die ein Passwort gültig ist. Nach diesen Tagen, ist das Passwort abgelaufen und der Benutzer ist gezwungen, es zu ändern.
50	40	instruction	4	Si la valeur est supérieure à zéro, Il représente le nombre de jours pendant lesquels un mot de passe est valide. Une fois ces jours passés, the password is expired and the user is forced to change it.
50	41	description	3	Hauptabonnement Bestellungen benutzen.
50	41	description	4	Utiliser les commandes de l'abonnement principal.
50	41	instruction	3	Auf '1' einstellen, um die Nutzung der 'Haupt Abonnement' Markierung für Bestellungen zu ermöglichen. Diese Markierung wird nur durch das Vermittlungsverfahren gelesen, wenn festgelegt wird wo Bezahlungen eingefügt werden müssen, die von externen Ereignissen kommen.
50	41	instruction	4	Configurez sur '1' pour autoriser l'utilisation de la case à cocher 'abonnement principal' pour les commandes. Cette case est uniquement lu par le processus de médiation au moment de déterminer où placer les frais provenant d'évènements externes. 
50	42	description	3	Pro-rating benutzen.
50	42	description	4	Utiliser les paiements au prorata.
50	42	instruction	3	Auf ' 1 ' einstellen, um den Einsatz von pro-rating zu ermöglichen, um Bruchteile einer Zeitraum in Rechnung zu stellen. Zeigt das ' Zyklus ' Attribut einer Bestellung. Beachten Sie, dass Sie die entsprechenden Plug-Ins für diese Funktion konfigurieren müssen, um voll funktionsfähig zu sein.
50	42	instruction	4	Configurez sur '1' pour autoriser l'utilisation des paiements au prorata pour facturer des fractions d'une période. Afficher l'attribut 'cycle' d'une commande. Notez que vous devez configurer les plugins correspondants pour que cette fonction soit totalement fonctionnelle.
50	43	description	3	Zahlungssperrliste benutzen.
50	43	description	4	Utiliser la liste noire des paiements.
50	53	description	4	Forcer les e-mails uniques
59	120	description	3	Web Service API Zugriff
50	43	instruction	3	Wenn die Zahlung Sperrfunktion verwendet wird, dies wird auf die ID der Konfiguration des PaymentFilterTask plug-in eingestellt. Siehe den Sperrlist-Abschnitt der Dokumentation.
50	43	instruction	4	Si la fonction d'inscription sur la liste noire des paiements est utilisée, cet élément est défini comme l'ID de configuration du plugin PaymentFilterTask. Consultez la section Liste noire de la documentation.
50	44	description	3	Negative Zahlugen erlauben.
50	44	description	4	Autoriser les paiements négatifs.
50	44	instruction	3	Auf '1' einstellen um negatives Zahlugen zu erlauben. '0' um dies zu deaktivieren
50	44	instruction	4	Configurez sur '1' pour autoriser les paiements négatifs. Sur '0' pour désactiver.
50	45	description	3	Negative Rechnungszahlungen verzögern.
50	45	description	4	Retarder les paiements des factures négatives.
50	45	instruction	3	Auf ' 1 ' einstellen, um die Zahlung der negativen Rechnungsbeträge zu verzögern, wodurch die Balance auf die nächste Rechnung übertragen wird. Rechnungen, die negative Salden von anderen Rechnungen auf sie übertragen haben dürfen unverzüglich eine negative Zahlung (Kredit) durchführen, wenn nötig. '0' um dies zu deaktivieren. Präferenz 44 & 46 sind in der Regel ebenfalls aktiviert.
50	64	description	4	Royaume de destination Diameter
50	64	instruction	4	Le royaume à facturer. Il peut être utilisé pour router les messages Diameter, il faut donc que cela corresponde au royaume configuré localement.
50	65	description	4	Seuil du quota Diameter
50	45	instruction	4	Configurez sur '1' pour retarder le paiement des montants de factures négatifs, ', causant le report su solde sur la facture suivante. Les factures ayant des soldes négatifs provenant d'autres factures sont autorisées à effectuer immédiatement un paiement négatif (crédit) si nécessaire. sur '0' pour désactiver. Les préférences 44 et 46 sont généralement également activées.
50	46	description	3	Rechnung ohne Bestellungen erlaube.
50	46	description	4	Autoriser les factures sans commandes.
50	46	instruction	3	Auf '1' einstellen, damit Rechnungen mit Negativsalden zu erlauben eine neue Rechnung zu erstellen, die nicht aus Bestellungen bestehet, so dass ihr Guthaben wird immer auf eine neue Rechnung übertragen wird, damit der Kredit erfolgen kann. '0' um dies zu deaktivieren. Präferenz 44 & 45 sind in der Regel ebenfalls aktiviert.
50	46	instruction	4	Configurez sur '1' pour autoriser les factures avec des soles négatifs à générer une nouvelle facture qui n'est pas composée de commandes afin que leurs soldes soient toujours reportés sur une nouvelle facture pour que le crédit soit pris en compte. Sur '0' pour désactiver. Les préférences 44 et 45 sont généralement également activées.
50	47	description	3	Zuletzt gelesene Vermittlungsbericht ID.
50	47	description	4	Dernier ID d'enregistrement la médiation lu.
50	47	instruction	3	ID des letzten Datensatzes durch das Vermittlungs verfahren. Dies wird verwendet, um festzustellen, welche Datensätze 'neu' sind und gelesen weren müssen.
50	47	instruction	4	ID du dernier enregistrement lu par le processus de médiation. Cela sert à déterminer quels enregistrements sont 'nouveaux' et doivent être lus.
50	48	description	3	Bereitstellung benutzen.
50	48	description	4	Utiliser l'approvisionnement.
50	48	instruction	3	Auf '1' einstellen um die Benutzung von Bereitstellungen zu erlauben. '0' um dies zu deaktivieren.
50	48	instruction	4	Configurez sur '1' pour autoriser l'utilisation de l'approvisionnement. Sur '0' pour désactiver.
50	49	description	3	Automatische Kundenaufladeschwelle.
50	49	description	4	Seuil de recharge automatique des clients.
50	49	instruction	3	Der Schwellwert für automatische Zahlungen. Prepaid-Nutzer mit einem eingestellten automatischen Wiederaufladungwert eingestellte erzeugen eine automatische Zahlung, wenn der Kontostand unter diesen Schwellwert fällt. Beachten Sie, dass Sie der AutoRechargeTask Plug-in für diese Funktion konfiguriert werden muss, um voll funktionsfähig zu sein.
50	49	instruction	4	La valeur seuil pour les paiements automatiques. Les utilisateurs prépayés avec une valeur de recharge automatique définie génèreront un paiement automatique à chaque fois que le solde du compte tombe sous ce seuil. Notez que vous devez configurer les plugins correspondants pour que le plugin AutoRechargeTask soit totalement fonctionnel.
50	4	description	3	Frist
50	4	description	4	Délai supplémentaire
50	4	instruction	3	Schonfrist in Tagen vor der Datierung eines Kunden mit einer überfälligen Rechnung.
50	4	instruction	4	Délai supplémentaire en jours avant l'avancement des phases d'un client avec un retard de paiement pour une facture.
50	50	description	3	Dezimale Rechnunsaufrundung.
50	50	description	4	Arrondissement des factures aux décimales.
50	50	instruction	3	Die Anzahl der Dezimalstellen welche auf der Rechnung ausgewiesen sind. Der Standardwert ist 2.
50	50	instruction	4	Le nombre de décimales à afficher sur la facture. Par défaut sur 2.
50	51	description	3	Minimum Balance um Datierung zu ignorieren
50	51	description	4	Solde minimum pour lequel ignorer l'avancement des phases
50	51	instruction	3	Minimum Balance, welche das Unternehmen bereit ist zu ignorieren, wenn überfällig auf einer Rechnung. Wenn dies eingestellt ist, wird dieser Wert bestimmen, ob der Nutzer hat genug Balance hat weiter zu datieren oder Benachrichtigungen für unbezahlten Rechnungen erhält
50	51	instruction	4	Solde minimum que la société est prête à ignorer en cas de retard de paiement sur une facture. Si l'option est configurée, cette valeur déterminera si l'utilisateur a un solde suffisant pour continuer à avancer dans les phases ou pour recevoir des notifications pour des factures impayées
50	52	description	3	Aktuelle Rechnung an alle überfälligen Mitteilungen anhängen.
50	52	description	4	Joindre la dernière facture à toutes les Notifications de retard de paiement.
50	52	instruction	3	Überfällig Mitteilungen 1, 2 und 3 hängen normalerweise keine Rechnungen an die E-Mail-Benachrichtigungen an. Mit dieser Einstellung kann die neueste Rechnung automatisch auf diese Mitteilungen befestigt werden.
50	52	instruction	4	Notification d'impayé. Impayés 1, 2 et 3 par défaut ne joignent pas de factures à la notification par e-mail. Avec cette préférence, la dernière facture peut être jointe automatiquement à ces notifications.
50	53	instruction	3	Auf 1 einstellen, um spezifische E-Mails zwischen den Benutzern/Kunden und den Unternehmen zu erzwingen. Ansonsten auf 0 gesetzt.
50	53	instruction	4	Configurez sur '1' pour forcer les e-mails uniques parmi les utilisateurs/clients dans la société. Sinon, configurez sur '0'
50	55	description	4	Code produit unique
50	55	instruction	4	Autorise un code produit unique, S'il est défini, le code produit ou la référence interne d'un produit/article doit être forcé(e) pour être unique
50	61	description	3	Agent Provisions Typ
50	61	description	4	Type de commission des agents
50	61	instruction	3	Definiert den Provisionstyp des Standardagenten für das Unternehmen, einer dieser: RECHNUNG, ZAHLUNG
50	61	instruction	4	Il définit le type de commission des agents par défaut pour l'entité, une des : FACTURE, PAYMENT
50	62	description	4	Afficher les articles du plan sans impact
50	63	description	3	Sollte JQGrid für Tabellen benutzen
50	63	description	4	Doit utiliser JQGrid pour les tableaux
50	63	instruction	3	Auf '0'einstellen um den Stadardlayout zu benutzen, oder auf '1' einstellen um JQGrid auf den Tabellen der Seite zu benutzen
50	63	instruction	4	Configurez sur '0' pour utiliser la disposition classique, ou sur '1' pour utiliser JQGrid  sur les tableaux du site
64	151	description	3	Neukaledonien
50	65	instruction	4	Lorsque ce nombre de secondes demeure, l'unité de traitement des appels doit demander une nouvelle autorisation.
50	66	description	4	Délai supplémentaire pour la session Diameter
50	66	instruction	4	Nombre de secondes à attendre avant que les sessions Diameter soient fermées de force.
50	67	description	4	Multiplicateur/Diviseur d'unités Diameter
50	67	instruction	4	La valeur des unités reçues de la part de Diameter est divisée/multipliée par ce facteur pour convertir les secondes entrées en d'autres unités de temps. Les valeurs < 1 configurent le multiplicateur sur 1.
50	68	description	4	Durée de blocage du compte
50	68	instruction	4	Nombre de minutes pendant lesquelles un compte utilisateur restera bloqué après que le nombre de tentatives autorisées soit épuisé (Préférence 39).
50	69	description	4	Notification de facture ITG
50	69	instruction	4	Actives les notifications de factures ITG (Générateur de modèles de factures).
50	70	description	4	Faire expirer les comptes inactifs après plusieurs jours.
50	70	instruction	4	Nombre de jours après lesquels un compte utilisateur devient inactif. Cela désactiver la capacité de cet utilisateur à se connecter à jBilling.
52	12	description	3	Rechnung (Papier)
52	12	description	4	Facture (papier)
52	13	description	3	Bestellung verfèllt bald. Schritt 1
52	13	description	4	Commande sur le point d'expirer. Étape 1
52	14	description	3	Bestellung verfèllt bald. Schritt 2
52	14	description	4	Commande sur le point d'expirer. Étape 2
52	15	description	3	Bestellung verfèllt bald. Schritt 3
52	15	description	4	Commande sur le point d'expirer. Étape 3
52	16	description	3	Payment (erfolgreich)
52	16	description	4	Paiement (réussi)
52	17	description	3	Bezahlung (fehlgeschlagen)
52	17	description	4	Paiement (échec)
52	18	description	4	Relance de facture
52	19	description	3	Kreditkarte aktualisieren
52	19	description	4	Mettre à jour la carte bancaire
52	1	description	3	Rechnung (email)
52	1	description	4	Facture (e-mail)
52	20	description	3	Passwort verloren
52	20	description	4	Mot de passe perdu
52	22	description	3	Bezahlung eingegeben
52	22	description	4	Paiement saisi
52	23	description	3	Bezahlung (Rückerstattung)
52	23	description	4	Paiement (remboursement)
52	24	description	4	Seuil inférieur au solde
52	25	description	4	Consommation du regroupement d'utilisation
52	26	description	4	Limitation de crédit 1
52	27	description	4	Limitation de crédit 2
52	2	description	3	Benutzer neu aktiviert
52	2	description	4	Utilisateur réactivé
52	3	description	3	Benutzer ƒberfèllig
52	3	description	4	Retard de paiement du client
52	4	description	3	Benutzer ƒberfèllig 2
52	4	description	4	Retard de paiement 2 du client
52	5	description	3	Benutzer ƒberfèllig 3
52	5	description	4	Retard de paiement 3 du client
52	6	description	3	Benutzer gesperrt
52	6	description	4	Utilisateur suspendu
52	7	description	3	Benutzer gesperrt 2
52	7	description	4	Utilisateur suspendu 2
52	8	description	3	Benutzer gesperrt 3
52	8	description	4	Utilisateur suspendu 3
52	9	description	3	Benutzer gelÖscht
52	9	description	4	Utilisateur supprimé
59	100	description	3	Agentmenü erstellen
59	100	description	4	Afficher le menu Agent
59	101	description	3	Agent erstellen
59	101	description	4	Créer un agent
59	102	description	4	Modifier l'agent
59	103	description	4	Supprimer l'agent
59	104	description	4	Voir les détails de l'agent
59	10	description	3	Kunden erstellen
59	10	description	4	Créer un client
59	110	description	3	Zu Unterkonto wechseln
59	110	description	4	Passer au sous-compte
59	111	description	3	Zu anderem Benutzer wechseln
59	111	description	4	Passer à n'importe quel utilisateur
59	11	description	3	Kunden editieren
59	11	description	4	Modifier le client
60	84	title	4	Client
59	120	description	4	Accès l'API du service web
59	121	description	3	Abrechnungszeitraum des Kunden editieren
59	121	description	4	Modifier le cycle de facturation du client
59	12	description	3	Kunden löschen
59	12	description	4	Supprimer le client
59	130	description	4	Ajouter un actif
59	131	description	4	Modifier l'actif
59	132	description	4	Supprimer l'actif
59	133	description	4	Télécharger le fichier des actifs
59	13	description	3	Kunden prüfen
59	13	description	4	Inspecter le client
59	140	description	4	Ajouter un code utilisateur
59	141	description	4	Modifier le code utilisateur
59	142	description	4	Voir le code utilisateur
59	143	description	4	Assigner le code utilisateur à l'entité
59	144	description	4	Modifier le code utilisateur pour l'entité
59	145	description	4	Forçage du mot de passe
59	14	description	3	Kunden sperren
59	14	description	4	Inscrire le client sur la liste noire
59	151	description	4	Créer une réduction
59	152	description	4	Supprimer la réduction
59	153	description	4	Modifier la réduction
59	15	description	3	Kundendetails ansehen
59	15	description	4	Voir les informations du client
59	160	description	4	Voir mon compte
59	161	description	4	Modifier le mot de passe
59	162	description	4	Modifier mon compte
59	16	description	3	Kunden CSV herunterladen
59	16	description	4	Télécharger le CSV du client
59	170	description	4	Modifier les requêtes générales
59	17	description	3	Alle Kunden anzeigen
59	17	description	4	Voir tous les clients
59	180	description	4	Modifier les modèles de factures
59	181	description	4	Ajouter des modèles de facture
59	182	description	4	Liste des modèles de factures
59	183	description	4	Supprimer des modèles de factures
59	18	description	3	Alle Kunden Unterkonten anzeigen
59	18	description	4	Voir les sous-comptes du client
59	19	description	3	Nächstes Rechnungsdatum editieren
59	19	description	4	Modifier la date de la prochaine facture
59	20	description	3	Bestellung erstellen
59	20	description	4	Créer une commande
59	21	description	3	Bestellung editieren
59	21	description	4	Modifier la commande
59	22	description	3	Bestellung löschen
59	22	description	4	Supprimer la commande
59	23	description	3	Rechnung für Bestellung erzeugen
59	23	description	4	Générer une facture pour la commande
59	24	description	3	Bestellungsdetails anzeigen
59	24	description	4	Voir les détails de la commande
59	25	description	3	Bestellungs CSV herunterladen
59	25	description	4	Télécharger le CSV des commandes
59	26	description	3	Zeilenpreis editieren
59	26	description	4	Modifier le prix de la ligne
59	27	description	3	Zeilenbeschreibung editieren
59	27	description	4	Modifier la description de la ligne
59	28	description	3	Alle Kunden anzeigen
59	28	description	4	Voir tous les clients
59	29	description	3	Alle Kunden Unterkonten anzeigen
59	29	description	4	Voir les sous-comptes du client
59	30	description	3	Zahlung erstellen
59	30	description	4	Créer un paiement
59	31	description	3	Bezahlung editieren
59	31	description	4	Modifier le paiement.
59	32	description	3	Zahlung löschen
59	32	description	4	Supprimer le paiement
59	33	description	3	Zahlung mit der Rechnung verbinden
59	33	description	4	Il associe les paiements aux factures.
59	34	description	3	Zahlungsdetails anzeigen
59	34	description	4	Voir les détails du paiement
59	35	description	3	Zahlungs CSV herunterladen
59	35	description	4	Télécharger le CSV des paiements
59	36	description	3	Alle Kunden anzeigen
59	36	description	4	Voir tous les clients
59	37	description	3	Kunden Unterkonten anzeigen
59	37	description	4	Voir les sous-comptes du client
59	40	description	3	Produkt erstellen
59	40	description	4	Créer un produit
59	41	description	3	Produkt editieren
59	41	description	4	Modifier le produit
59	42	description	3	Produkt löschen
59	42	description	4	Supprimer le produit
59	43	description	3	Produkt Details anzeigen
59	43	description	4	Voir les détails du produit
59	44	description	3	Zahlungs CSV anzeigen
59	44	description	4	Télécharger le CSV des paiements
59	50	description	3	Produktkategorie erstellen
59	50	description	4	Créer une catégorie de produit
59	51	description	3	Produktkategorie erstellen
59	51	description	4	Modifier la catégorie de produit
59	52	description	3	Produktkategorie löschen
59	52	description	4	Supprimer la catégorie de produit
59	53	description	4	Modifier les statuts de la catégorie
59	54	description	4	Modifier les meta-champs de la catégorie
59	60	description	3	Plan erstellen
59	60	description	4	Créer un plan
59	61	description	3	Plan editieren
59	61	description	4	Modifier le plan
59	62	description	3	Plan löschen
59	62	description	4	Supprimer le plan
59	63	description	3	Plan details anzeigen
59	63	description	4	Voir les détails du plan
59	70	description	3	Rechnung löschen
59	70	description	4	Supprimer la facture
59	71	description	3	Rechnungsmitteilung schicken
59	71	description	4	Envoi d'une notification pour la facture
59	72	description	3	Rechnungsdetails anzeigen
59	72	description	4	Voir les détails de la facture
59	73	description	3	Rechnungs CSV anzeigen
59	73	description	4	Télécharger le CSV des factures
59	74	description	3	Alle Kunden anzeigen
59	74	description	4	Voir tous les clients
59	75	description	3	Kundenunterkonten anzeigen
59	75	description	4	Voir les sous-comptes du client
59	80	description	3	Review Genehmigen/nicht genehmigen
59	80	description	4	Approuver/Désapprouver l'examen
59	900	description	4	Afficher le menu Approvisionnement
59	901	description	4	Afficher le menu Agent
59	902	description	4	Afficher le menu Réductions
59	90	description	3	Kundenmenü anzeigen
59	90	description	4	Afficher le menu Client
59	91	description	3	Rechnungsmenü anzeigen
59	91	description	4	Afficher le menu Factures
59	92	description	3	Bestellungsmenü anzeigen
59	92	description	4	Afficher le menu Commande
59	94	description	3	Abrechnungsmenü anzeigen
59	94	description	4	Afficher le menu Facturation
59	95	description	3	Vermittlungsmenü anzeigen
59	95	description	4	Afficher le menu Médiation
59	96	description	3	Berichtmenü anzeigen
59	96	description	4	Afficher le menu Rapports
59	97	description	3	Produktmenü anzeigen
59	97	description	4	Afficher le menu Produits
59	98	description	3	Planmenü anzeigen
59	98	description	4	Afficher le menu Plans
59	99	description	3	Einstellungsmenü anzeigen
59	99	description	4	Afficher le menu Configuration
60	1	description	3	Ein interner Benutzer mit allen Rechten
60	1	description	4	Un utilisateur interne disposant de toutes les permissions
60	1	title	3	Intern
60	1	title	4	Interne
60	2	description	3	Der super User eines Unternehmens
60	2	description	4	Le super utilisateur d'une entité
60	2	title	3	Super User
60	2	title	4	Super utilisateur
60	3	description	3	Ein Buchhalter
60	3	description	4	Un employé chargé de la facturation
60	3	title	3	Angestellter
60	3	title	4	Employé
60	4	description	3	Ein Agent der Kunden bringen wird
60	4	description	4	Un agent qui ramènera des clients
60	4	title	3	Agent
60	4	title	4	Agent
60	5	description	3	Ein Kunde der sein/ihr Konto abfragen wird
60	5	description	4	Un client qui cherchera son compte
60	5	title	3	Kunde
60	5	title	4	Client
60	60	description	3	Der Super User eines Unternehmens
60	60	description	4	Le super utilisateur d'une entité
60	60	title	3	Super User
60	60	title	4	Super utilisateur
60	61	description	3	ein Buchhalterc
60	61	description	4	Un employé chargé de la facturation
60	61	title	3	Angestellter
60	61	title	4	Employé
60	62	description	3	 Ein Kunde, der sein/ihr Konto abfragen wird
60	62	description	4	Un client qui cherchera son compte
60	62	title	3	Kunde
60	62	title	4	Client
60	63	description	3	Ein Agent der Kunden bringen wird
60	63	description	4	Un agent qui ramènera des clients
60	63	title	3	Agent
60	63	title	4	Agent
60	70	description	4	Le super utilisateur d'une entité
60	70	title	4	Super utilisateur
60	71	description	4	Un employé chargé de la facturation
60	71	title	4	Employé
60	72	description	4	Un client qui cherchera son compte
60	72	title	4	Client
60	73	description	4	Un agent qui ramènera des clients
60	73	title	4	Agent
60	74	description	4	Le super utilisateur d'une entité
60	74	title	4	Super utilisateur
60	75	description	4	Un employé chargé de la facturation
60	75	title	4	Employé
60	76	description	4	Un client qui cherchera son compte
60	76	title	4	Client
60	77	description	4	Un agent qui ramènera des clients
60	77	title	4	Agent
60	78	description	4	Le super utilisateur d'une entité
60	78	title	4	Super utilisateur
60	79	description	4	Un employé chargé de la facturation
60	79	title	4	Employé
60	80	description	4	Un client qui cherchera son compte
60	80	title	4	Client
60	81	description	4	Un agent qui ramènera des clients
60	81	title	4	Agent
60	82	description	4	Le super utilisateur d'une entité
60	82	title	4	Super utilisateur
60	83	description	4	Un employé chargé de la facturation
60	83	title	4	Employé
60	84	description	4	Un client qui cherchera son compte
60	85	description	4	Un agent qui ramènera des clients
60	85	title	4	Agent
60	87	description	4	Le super utilisateur d'une entité
60	87	title	4	Super utilisateur
60	88	description	4	Un employé chargé de la facturation
60	88	title	4	Employé
60	89	description	4	Un client qui cherchera son compte
60	89	title	4	Client
60	90	description	4	Un agent qui ramènera des clients
60	90	title	4	Agent
60	91	description	4	Le super utilisateur d'une entité
60	91	title	4	Super utilisateur
60	92	description	4	Un employé chargé de la facturation
60	92	title	4	Employé
60	93	description	4	Un client qui cherchera son compte
60	93	title	4	Client
60	94	description	4	Un agent qui ramènera des clients
60	94	title	4	Agent
60	95	description	4	Le super utilisateur d'une entité
60	95	title	4	Super utilisateur
60	96	description	4	Un employé chargé de la facturation
60	96	title	4	Employé
60	97	description	4	Un client qui cherchera son compte
60	97	title	4	Client
60	98	description	4	Un agent qui ramènera des clients
60	98	title	4	Agent
6	1	description	3	Monat
6	1	description	4	Mois
6	2	description	3	Woche
6	2	description	4	Semaine
6	3	description	3	Tag
6	3	description	4	Jour
64	100	description	3	Indonesien
64	100	description	4	Indonésie
64	101	description	3	Iran
64	101	description	4	Iran
64	102	description	3	Irak
64	102	description	4	Irak
64	103	description	3	Irland
64	103	description	4	Irlande
64	104	description	3	Israel
64	104	description	4	Israël
64	105	description	3	Italien
64	105	description	4	Italie
64	106	description	3	Jamaica
64	106	description	4	Jamaïque
64	107	description	3	Japan
64	107	description	4	Japon
64	108	description	3	Jordan
64	108	description	4	Jordanie
64	109	description	3	Kazakhstan
64	109	description	4	Kazakhstan
64	10	description	3	Argentinien
64	10	description	4	Argentine
64	110	description	3	Kenia
64	110	description	4	Kenya
64	111	description	3	Kiribati
64	111	description	4	Kiribati
64	112	description	3	Korea
64	112	description	4	Corée
64	113	description	3	Kuwait
64	113	description	4	Koweït
64	114	description	3	Kyrgyzstan
64	114	description	4	Kirghizistan
64	115	description	3	Laos
64	115	description	4	Laos
64	116	description	3	Latvia
64	116	description	4	Lettonie
64	117	description	3	Lebanon
64	117	description	4	Liban
64	118	description	3	Lesotho
64	118	description	4	Lesotho
64	119	description	3	Liberia
64	119	description	4	Liberia
64	11	description	3	Armenien
64	11	description	4	Arménie
64	120	description	3	Libia
64	120	description	4	Libye
64	121	description	3	Liechtenstein
64	121	description	4	Liechtenstein
64	122	description	3	Lithuanien
64	122	description	4	Lituanie
64	123	description	3	Luxemburg
64	123	description	4	Luxembourg
64	124	description	3	Macao SAR
64	124	description	4	Macao - Région administrative spéciale
64	125	description	3	Mazedonien,ehemalige Jugoslavische Republik
64	125	description	4	Macédoine, ancienne République yougoslave de
64	126	description	3	Madagaskar
64	126	description	4	Madagascar
64	127	description	3	Malawi
64	127	description	4	Malawi
64	128	description	3	Malaysia
64	128	description	4	Malaisie
64	129	description	3	Maldiven
64	129	description	4	Maldives
64	12	description	3	Aruba
64	12	description	4	Aruba
64	130	description	3	Mali
64	130	description	4	Mali
64	131	description	3	Malta
64	131	description	4	Malte
64	132	description	3	Marshall Inseln
64	132	description	4	Îles Marshall
64	133	description	3	Martinique
64	133	description	4	Martinique
64	134	description	3	Mauritanien
64	134	description	4	Mauritanie
64	135	description	3	Mauritius
64	135	description	4	Maurice
64	136	description	3	Mayotte
64	136	description	4	Mayotte
64	137	description	3	Mexiko
64	137	description	4	Mexique
64	138	description	3	Mikronesien
64	138	description	4	Micronésie
64	139	description	3	Moldawien
64	139	description	4	Moldavie
64	13	description	3	Australia
64	13	description	4	Australie
64	140	description	3	Monaco
64	142	description	4	Montserrat
64	143	description	3	Marokko
64	143	description	4	Maroc
64	144	description	3	Mozambique
64	144	description	4	Mozambique
64	145	description	3	Myanmar
64	145	description	4	Myanmar
64	146	description	3	Namibien
64	146	description	4	Namibie
64	147	description	3	Nauru
64	147	description	4	Nauru
64	148	description	3	Nepal
64	148	description	4	Népal
64	149	description	3	Holland
64	149	description	4	Pays-Bas
64	14	description	3	àsterreich
64	14	description	4	Autriche
64	150	description	3	Niederlèndische Antillen
64	150	description	4	Antilles néerlandaises
64	151	description	4	Nouvelle-Calédonie
64	152	description	3	Neuseeland
64	152	description	4	Nouvelle-Zélande
64	153	description	3	Nicaragua
64	153	description	4	Nicaragua
64	154	description	3	Niger
64	154	description	4	Niger
64	155	description	3	Nigeria
64	155	description	4	Nigéria
64	156	description	3	Niue
64	156	description	4	Niue
64	157	description	3	Norfolk Island
64	157	description	4	Île Norfolk
64	158	description	3	Nord Korea
64	158	description	4	Corée du Nord
64	159	description	3	NÖrdliche Mariana Islands
64	159	description	4	Îles Mariannes du Nord
64	15	description	3	Azerbaijan
64	15	description	4	Azerbaïdjan
64	160	description	3	Norwegen
64	160	description	4	Norvège
64	161	description	3	Oman
64	161	description	4	Oman
64	162	description	3	Pakistan
64	162	description	4	Pakistan
64	163	description	3	Palau
64	163	description	4	Palaos
64	164	description	3	Panama
64	164	description	4	Panama
64	165	description	3	Papua Neu Guinea
64	165	description	4	Papouasie-Nouvelle-Guinée
64	166	description	3	Paraguay
64	166	description	4	Paraguay
64	167	description	3	Peru
64	167	description	4	Pérou
64	168	description	3	Philippien
64	168	description	4	Philippines
64	169	description	3	Pitcairn Islands
64	169	description	4	Îles Pitcairn
64	16	description	3	Bahamas
64	16	description	4	Bahamas
64	170	description	3	Polen
64	170	description	4	Pologne
64	171	description	3	Portugal
64	171	description	4	Portugal
64	172	description	3	Puerto Rico
64	172	description	4	Porto Rico
64	173	description	3	Qatar
64	173	description	4	Qatar
64	174	description	3	Reunion
64	174	description	4	Réunion
64	175	description	3	Romènien
64	175	description	4	Roumanie
64	176	description	3	Russland
64	176	description	4	Russie
64	177	description	3	Rwanda
64	177	description	4	Rwanda
64	178	description	3	Samoa
64	178	description	4	Samoa
64	179	description	3	San Marino
64	179	description	4	San Marin
64	17	description	3	Bahrain
64	17	description	4	Bahreïn
64	180	description	3	Sao Tome und Principe
64	180	description	4	Sao Tomé-et-Principe
64	181	description	3	Saudi Arabien
64	181	description	4	Arabie Saoudite
64	182	description	3	Senegal
64	182	description	4	Sénégal
64	183	description	3	Serben und Montenegro
64	183	description	4	Serbie-et-Monténégro
64	184	description	3	Seychellen
64	184	description	4	Seychelles
64	185	description	3	Sierra Leone
64	185	description	4	Sierra Leone
64	186	description	3	Singapur
64	186	description	4	Singapour
64	187	description	3	Slovakien
64	187	description	4	Slovaquie
64	188	description	3	Slovenien
64	188	description	4	Slovénie
64	189	description	3	Solomon Islands
64	189	description	4	Îles Salomon
64	18	description	3	Bangladesch
64	18	description	4	Bangladesh
64	190	description	3	Somalien
64	190	description	4	Somalie
64	191	description	3	Sƒdafrika
64	191	description	4	Afrique du Sud
64	192	description	3	Sƒdgeorgien und sƒdliche Sandwichinseln
64	192	description	4	Géorgie du Sud-et-les Îles Sandwich du Sud
64	193	description	3	Spanien
64	193	description	4	Espagne
64	194	description	3	Sri Lanka
64	194	description	4	Sri Lanka
64	195	description	3	St. Helena
64	195	description	4	Sainte- Hélène
64	196	description	3	St. Kitts und Nevis
64	196	description	4	Saint- Christophe-et-Niévès
64	197	description	3	St. Lucia
64	197	description	4	Saint- Lucie
64	198	description	3	St. Pierre und Miquelon
64	198	description	4	Saint- Pierre-et-Miquelon
64	199	description	3	St. Vincent and the Grenadines
64	199	description	4	Saint- Vincent-et-les-Grenadines
64	19	description	3	Barbados
64	19	description	4	Barbade
64	1	description	3	Afghanistan
64	1	description	4	Afghanistan
64	200	description	3	Sudan
64	200	description	4	Soudan
64	201	description	3	Suriname
64	201	description	4	Suriname
64	202	description	3	Svalbard und Jan Mayen
64	202	description	4	Svalbard et Jan Mayen
64	203	description	3	Swaziland
64	203	description	4	Swaziland
64	204	description	3	Schweden
64	204	description	4	Suède
64	205	description	3	Schweiz
64	206	description	3	Syrien
64	206	description	4	Syrie
64	207	description	3	Taiwan
64	207	description	4	Taïwan
64	208	description	3	Tajikistan
64	208	description	4	Tadjikistan
64	209	description	3	Tanzania
64	209	description	4	Tanzanie
64	20	description	3	Belarus
64	20	description	4	Biélorussie
64	210	description	3	Thailand
64	210	description	4	Thaïlande
64	211	description	3	Togo
64	211	description	4	Togo
64	212	description	3	Tokelau
64	212	description	4	Tokelau
64	213	description	3	Tonga
64	213	description	4	Tonga
64	214	description	3	Trinidad und Tobago
64	214	description	4	Trinité-et-Tobago
64	215	description	3	Tunesien
64	215	description	4	Tunisie
64	216	description	3	Turkei
64	216	description	4	Turquie
64	217	description	3	Turkmenistan
64	217	description	4	Turkménistan
64	218	description	3	Turks und Caicos Islands
64	218	description	4	Îles Turques-et-Caïques
64	219	description	3	Tuvalu
64	219	description	4	Tuvalu
64	21	description	3	Belgien
64	21	description	4	Belgique
64	220	description	3	Uganda
64	220	description	4	Ouganda
64	221	description	3	Ukraine
64	221	description	4	Ukraine
64	222	description	3	Vereinigte Arabische Emirate
64	222	description	4	Émirats Arabes Unis
64	223	description	3	Vereinigtes KÖnigreich
64	223	description	4	Royaume-Uni
64	224	description	3	Vereinigte Staaten
64	224	description	4	États-Unis
64	225	description	3	Amerikanisch Ozeanien
64	225	description	4	Îles mineures éloignées des États-Unis
64	226	description	3	Uruguay
64	226	description	4	Uruguay
64	227	description	3	Uzbekistan
64	227	description	4	Ouzbékistan
64	228	description	3	Vanuatu
64	228	description	4	Vanuatu
64	229	description	3	Vatikanstadt
64	229	description	4	Cité du Vatican
64	22	description	3	Belize
64	22	description	4	Belize
64	230	description	3	Venezuela
64	230	description	4	Venezuela
64	231	description	3	Vietnam
64	231	description	4	Vietnam
64	232	description	3	Britische Junferninseln
64	232	description	4	Îles Vierges britanniques
64	233	description	3	Jungferninseln
64	233	description	4	Îles Vierges
64	234	description	3	Wallis und Futuna
64	234	description	4	Wallis-et-Futuna
64	235	description	3	Yemen
64	235	description	4	Yémen
64	236	description	3	Zambia
64	236	description	4	Zambie
64	237	description	3	Zimbabwe
64	237	description	4	Zimbabwe
64	23	description	3	Benin
64	23	description	4	Benin
64	24	description	3	Bermudas
64	24	description	4	Bermudes
64	25	description	3	Bhutan
64	25	description	4	Bhoutan
64	26	description	3	Bolivien
64	26	description	4	Bolivie
64	27	description	3	Bosnien und Herzegovina
64	27	description	4	Bosnie-Herzégovine
64	28	description	3	Botswana
64	28	description	4	Botswana
64	29	description	3	Bouvet Insel
64	29	description	4	Île Bouvet
64	2	description	3	Albanien
64	2	description	4	Albanie
64	30	description	3	Brazilien
64	30	description	4	Brésil
64	31	description	3	Britisches Territorium im Indischen Ozean
64	31	description	4	Territoire britannique de l'Océan Indien
64	32	description	3	Brunei
64	32	description	4	Brunei
64	33	description	3	Bulgarien
64	33	description	4	Bulgarie
64	34	description	3	Burkina Faso
64	34	description	4	Burkina Faso
64	35	description	3	Burundi
64	35	description	4	Burundi
64	36	description	3	Kambodien
64	36	description	4	Cambodge
64	37	description	3	Karmun
64	37	description	4	Cameroun
64	38	description	3	Kanada
64	38	description	4	Canada
64	39	description	3	Kap Verde
64	39	description	4	Cap-Vert
64	3	description	3	Algerien
64	3	description	4	Algérie
64	40	description	3	Kaimaninseln
64	40	description	4	Îles Caïmans
64	41	description	3	Zentralfrikanische Republik
64	41	description	4	République centrafricaine
64	42	description	3	Chad
64	42	description	4	Tchad
64	43	description	3	Chile
64	43	description	4	Chili
64	44	description	3	China
64	44	description	4	Chine
64	45	description	3	Weihnachtsinsel
64	45	description	4	Île Christmas
64	46	description	3	Cocos - Keeling Islands
64	46	description	4	Îles Cocos
64	47	description	3	Kolumbien
64	47	description	4	Colombie
64	48	description	3	Komoren
64	48	description	4	Comores
64	49	description	3	Kongo
64	49	description	4	Congo
64	4	description	3	Amerikanisch-Samoa
64	4	description	4	Samoa américaines
64	50	description	3	Cook Inseln
64	50	description	4	Îles Cook
64	51	description	3	Costa Rica
64	51	description	4	Costa Rica
64	52	description	3	Cote d Ivoire
64	52	description	4	Côte d'Ivoire
64	53	description	3	Kroatien
64	53	description	4	Croatie
64	54	description	3	Kuba
64	54	description	4	Cuba
64	55	description	3	Zypern
64	55	description	4	Chypre
64	56	description	3	Tschechische Republik
64	56	description	4	République Tchèque
64	57	description	3	Kongo - DRC
64	57	description	4	Congo - République démocratique du Congo
64	58	description	3	Dènemarkd
64	58	description	4	Danemark
64	59	description	3	Djibouti
64	59	description	4	Djibouti
64	5	description	3	Andorra
64	5	description	4	Andorre
64	60	description	3	Dominica
64	60	description	4	Dominique
64	61	description	3	Dominikanische Republike
64	61	description	4	République Dominicaine
64	62	description	3	ost Timor
64	62	description	4	Timor oriental
64	63	description	3	Equador
64	63	description	4	Equateur
64	64	description	3	Çgypten
64	64	description	4	Égypte
64	65	description	3	El Salvador
64	65	description	4	El Salvador
64	66	description	3	quatorialguinea
64	66	description	4	Guinée équatoriale
64	67	description	3	Eritrea
64	67	description	4	Érythrée
64	68	description	3	Estonien
64	68	description	4	Estonie
64	69	description	3	Ethiopien
64	69	description	4	Éthiopie
64	6	description	3	Angola
64	6	description	4	Angola
64	70	description	3	Malediven
64	70	description	4	Îles Malouines
64	71	description	3	FèrÖr
64	71	description	4	Îles Féroé
64	72	description	3	Fiji Inseln
64	72	description	4	Îles Fidji
64	73	description	3	Finland
64	73	description	4	Finlande
64	74	description	3	Frankreich
64	74	description	4	France
64	75	description	3	FranzÖsisch-Guayana
64	75	description	4	Guyane
64	76	description	3	FranzÖsisch Polynesien
64	76	description	4	Polynésie française
64	77	description	3	FranzÖsische Sƒd- und Antartisgebiete
64	77	description	4	Terres australes et antarctiques françaises
64	78	description	3	Gabon
64	78	description	4	Gabon
64	79	description	3	Gambia
64	79	description	4	Gambie
64	7	description	3	Anguilla
64	7	description	4	Anguilla
64	80	description	3	Georgien
64	80	description	4	Géorgie
64	81	description	3	Deutschland
64	81	description	4	Allemagne
64	82	description	3	Ghana
64	82	description	4	Ghana
64	83	description	3	Gibraltar
64	83	description	4	Gibraltar
64	84	description	3	Griechenland
64	84	description	4	Grèce
64	85	description	3	GrÖnland
64	85	description	4	Groenland
64	86	description	3	Grenada
64	86	description	4	Grenade
64	87	description	3	Guadeloupe
64	87	description	4	Guadeloupe
64	88	description	3	Guam
64	88	description	4	Guam
64	89	description	3	mala
64	89	description	4	Guatemala
64	8	description	3	Antarktik
64	8	description	4	Antarctique
64	90	description	3	Guinea
64	90	description	4	Guinée
64	91	description	3	Guinea-Bissau
64	91	description	4	Guinée-Bissau
64	92	description	3	Guyana
64	92	description	4	Guyane
64	93	description	3	Haiti
64	93	description	4	Haïti
64	94	description	3	Heard Inseln und McDonald Inseln
64	94	description	4	Îles Heard-et-MacDonald
64	95	description	3	Honduras
64	95	description	4	Honduras
64	96	description	3	Hong Kong SAR
64	96	description	4	Hong Kong - Région administrative spéciale
64	97	description	3	Ungarn
64	97	description	4	Hongrie
64	98	description	3	Island
64	98	description	4	Islande
64	99	description	3	Indien
64	99	description	4	Inde
64	9	description	3	Antigua und Barbuda
64	9	description	4	Antigua-et-Barbuda
6	4	description	3	Jahr
6	4	description	4	Année
6	5	description	3	Zeimal monatlich
6	5	description	4	Deux fois par mois
7	1	description	3	Email
7	1	description	4	E-mail
7	2	description	3	Papoer
7	2	description	4	Papier
7	3	description	3	Email + Papier
7	3	description	4	E-mail + Papier
81	1	description	3	Aktiv
81	1	description	4	Actif
81	2	description	3	Anstehende Kƒndigung
81	2	description	4	Désabonnement imminent
81	3	description	3	Gekƒndigt
81	3	description	4	Désabonné
81	4	description	3	Anstehender Verfall
81	4	description	4	Expiration imminente
81	5	description	3	verfallen
81	5	description	4	Expiré
81	6	description	3	Nichtabonnentend
81	6	description	4	Non-abonné
81	7	description	3	Eingestellt
81	7	description	4	Interrompu
88	1	description	3	Aktiv
88	1	description	4	Actif
88	2	description	3	Inaktiv
88	2	description	4	Inactif
88	3	description	3	ausstehend aktiv
88	3	description	4	En attente d'être actif
88	4	description	3	ausstehend inaktiv
88	4	description	4	En attente d'être inactif
88	5	description	3	Fehlgeschlagen
88	5	description	4	Échec
88	6	description	3	nicht verfƒgbar
88	6	description	4	Indisponible
90	1	description	3	Bezahlt
90	1	description	4	Payée
90	2	description	3	Unbezahlt
90	2	description	4	Impayée
90	3	description	3	Übertragen
90	3	description	4	Reportée
91	1	description	3	Fertig und abrechenbar
91	1	description	4	Terminée et facturable
91	2	description	3	Fertig und nicht abrechenbar
91	2	description	4	Terminée et non facturable
91	3	description	3	Fehler gefunden
91	3	description	4	Erreur détectée
91	4	description	3	Fehler gemeldet
91	4	description	4	Erreur déclarée
9	1	description	3	Aktiv
9	1	description	4	Actif
92	1	description	3	Laufend
92	1	description	4	En cours d'exécution
92	2	description	3	Fertig: Erfolgreich
92	2	description	4	Terminée : succès
92	3	description	3	Fertig: Fehlgeschlagen
92	3	description	4	Terminée : échec
4	10000	description	1	Included Data
4	10001	description	1	Included Minutes
4	10002	description	1	Included SMS
50	51	description	1	Minimum Balance for which to ignore ageing
50	51	instruction	1	Minimum Balance that the business is willing to ignore if overdue on an Invoice. If set, this value will determine if the User has enough balance to continue to Ageing or receive Notifications for Unpaid Invoices
52	22	description	1	Payment Entered
50	52	description	1	Attach latest Invoice to all Overdue Notification.
50	52	instruction	1	Overdue Notification Overdue 1 2 and 3 by default do not attach Invoices to the notification email. With this preference, the latest Invoice can be attached to such notifications automatically.
24	97	title	1	Penalty Task on Overude Invoice
24	97	description	1	This task is responsible for applying a %-age or a fixed amount penalty on an Overdue Invoice. This task is powerful because it performs this action just before the Billing process collects orders.
24	101	title	1	Event based custom notification task
24	101	description	1	The event based custom notification task takes the custom notification message and does the notification when the internal event occurred
50	53	description	1	Force Unique Emails
50	53	instruction	1	Set to 1 in order to force unique emails among the users/customers into the company. Set to 0 otherwise.
24	105	title	1	Suretax Plugin
24	105	description	1	This plugin adds tax lines to invoice by consulting the Suretax Engine.
50	31	instruction	1	Default blank. This preference has to be a date (In the format yyyy-mm-dd. Example: 2000-01-31), the system will make sure that all your invoices have their dates in an incremental way. Any invoice with a greater 'ID' will also have a greater (or equal) date. In other words, a new invoice can not have an earlier date than an existing (older) invoice. To use this preference, set it as a string with the date where to start. This preference will not be used if blank
52	23	description	1	Payment (refund)
35	6	description	1	Discover
35	6	description	2	Discover
18	4	description	1	Discount
6	5	description	1	Semi-Monthly
59	121	description	1	Edit billing cycle of customer
35	15	description	1	Credit
24	131	title	1	Credit on negative invoice
24	131	description	1	This plug-in will set the balance and total of a negative invoice to 0 and create a 'credit' payment for the remaining amount.
24	132	title	1	User Balance threshold notification task
24	132	description	1	A pluggable task of the type InternalEventsTask to monitor if users pre-paid balance is below a threshold level and send notifications.
104	5	description	1	Custom Notifications
52	24	description	1	Balance Below Threshold
24	133	title	1	Custom user notifications per ageing steps
24	133	description	1	This plug-in provides mapping between the user status(ageing steps) and notifications that needs to be sent for each status
50	55	description	1	Unique product code
50	55	instruction	1	Allows unique product code, If set the product code or internal number of a product/item would be enforced to be unique
24	134	title	1	Delete old files
24	134	description	1	This task will delete files older than a certain time.
24	135	title	1	Updates Asset Transitions
24	135	description	1	This plug-in will update AssetTransitions when an asset status changes.
24	136	title	1	Remove Assets From FINISHED Orders
24	136	description	1	This plug-in will remove Asset owners when the linked order expires.
108	1	description	1	Member Of Group
24	137	description	1	A pluggable task of type InternalEventsTask to monitor when activeUntil changes of an order
24	137	title	1	Order Cancellation Task
47	35	description	1	A Reseller Order was created for the Root Entity during Invoice generation for a Child Entity.
529	1	description	1	PENDING
529	2	description	1	APPLY ERROR
52	25	description	1	Usage Pool Consumption
24	141	title	1	Calculate Agents' Commissions
24	141	description	1	This task schedules the process that calculates the Agents' Commissions.
23	25	description	1	Agent Commission Calculation Process.
24	142	title	1	Basic Agents' Commissions task
24	142	description	1	This task calculates the Agents' Commissions.
24	143	title	1	Generate payment commissions for agents.
24	143	description	1	This plug-in will create payment commissions when payments are linked an unlinked from invoices.
23	26	description	1	Files exchange with remote locations, upload and download
24	147	title	1	Trigger File Download/Upload
24	147	description	1	Triggers File Download/Upload against third party system
50	63	description	1	Should use JQGrid for tables
50	63	instruction	1	Set to '0' to use the common layout or set to '1' to use JQGrid on the site's tables
50	61	description	1	Agent Commission Type
50	61	instruction	1	Defines the default agents' commission type for the entity, one of: INVOICE, PAYMENT
24	148	title	1	User Credit Limitation notification task
24	148	description	1	A pluggable task of the type InternalEventsTask to monitor if users pre-paid balance is below a credit limitation 1 or 2 levels and send notifications.
52	26	description	1	Credit Limitation 1
52	27	description	1	Credit Limitation 2
50	64	description	1	Diameter Destination Realm
50	64	instruction	1	The realm to be charged. This can be used for routing Diameter messages, so should match a locally-configured realm.
50	65	description	1	Diameter Quota Threshold
50	65	instruction	1	When this number of seconds remains the call handling unit should request re-authorisation.
50	66	description	1	Diameter Session Grace Period
50	66	instruction	1	Number of seconds to wait before Diameter sessions are forcibly closed.
50	67	description	1	Diameter units multiplier/divisor
50	67	instruction	1	The units value received from Diameter is divided/multiplied by this factor to convert input seconds to other time units. Values < 1 set the multiplier to 1.
24	149	title	1	Change order status on order change apply
24	149	description	1	This plug-in will change the status of order during order change apply to selected in order change.
18	5	description	1	Subscription
59	101	description	1	Create agent
59	102	description	1	Edit agent
59	103	description	1	Delete agent
59	104	description	1	View agent details
59	93	description	3	Show payments and refunds menu
59	93	description	4	Show payments and refunds menu
52	18	description	1	Invoice Reminder
50	68	description	1	Account Lockout Time
50	68	instruction	1	Number of minutes a User's account will remain locked after the number of allowed retries (Preference 39) are exhausted.
50	39	instruction	1	The number of retries to allow before locking the user account. A locked user account will be locked for the amount of minutes specified in Preference 68. To enable this locking feature, setting Preference 68 to a non-zero value is a must.
47	37	description	1	A failed login attempt was made.
50	70	description	1	Expire Inactive Accounts After Days
50	70	instruction	1	Number of days after which a User's account will become inactive. This will disable the ability to login to jBilling for that user.
24	150	title	1	Inactive user account management plugin
24	150	description	1	This is a scheduled plugin that takes in user that has not been logged-in for number of days specified in preference 55 and update there status to Inactive.
100	13	description	1	Statement of User Activity within specified number of days
50	71	description	1	Forgot Password Expiration (hours)
50	71	instruction	1	Hours until the link for password change expires.
50	75	description	1	Should credentials be created by default
50	75	instruction	1	1 to have credentials created by default when the user is created. 0 (default) to require credential creation be requested upon creation.
52	21	description	1	Credentials creation
528	1	errorMessage	1	Failed login attempts can not be more than 6
528	2	errorMessage	1	Passwords must expire before 90 days
528	3	errorMessage	1	Inactive account checks must be done quicker than 90 days
47	38	description	1	User logged in successfully
47	39	description	1	User logged out successfully
47	40	description	1	User failed to log in due to incorrect username/password
528	4	errorMessage	1	Reservation duration should be between 0 and 600000
50	76	description	1	Default Asset Reservation Duration
50	76	instruction	1	Add Default Asset reservation minute here. It will work if product is asset enabled. (Must be greater than zero)
60	60	description	1	The super user of an entity
60	60	title	1	Super user
60	61	description	1	A billing clerk
60	61	title	1	Clerk
60	62	description	1	A customer that will query his/her account
60	62	title	1	Customer
60	63	description	1	A agent that will bring customers
60	63	title	1	Agent
20	500	description	1	Active
20	501	description	1	Finished
20	502	description	1	Suspended
20	503	description	1	Suspended ageing(auto)
17	200	description	1	Monthly
529	3	description	1	Default (Apply)
525	100	description	1	Default
528	10	errorMessage	1	Payment card number is not valid
528	11	errorMessage	1	Expiry date should be in format MM/yyyy
528	12	errorMessage	1	ABA Routing or Bank Account Number can only be digits
14	100	description	1	samsung
525	101	description	1	Business
14	200	description	1	Monthly Electricity Charge
14	201	description	1	rating_product
\.


--
-- TOC entry 3858 (class 0 OID 264797)
-- Dependencies: 246
-- Data for Name: invoice; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY invoice (id, create_datetime, billing_process_id, user_id, delegated_invoice_id, due_date, total, payment_attempts, status_id, balance, carried_balance, in_process_payment, is_review, currency_id, deleted, paper_invoice_batch_id, customer_notes, public_number, last_reminder, overdue_step, create_timestamp, optlock) FROM stdin;
\.


--
-- TOC entry 3859 (class 0 OID 264807)
-- Dependencies: 247
-- Data for Name: invoice_commission; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY invoice_commission (id, partner_id, referral_partner_id, commission_process_run_id, invoice_id, standard_amount, master_amount, exception_amount, referral_amount, commission_id) FROM stdin;
\.


--
-- TOC entry 3860 (class 0 OID 264810)
-- Dependencies: 248
-- Data for Name: invoice_delivery_method; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY invoice_delivery_method (id) FROM stdin;
1
2
3
\.


--
-- TOC entry 3861 (class 0 OID 264813)
-- Dependencies: 249
-- Data for Name: invoice_line; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY invoice_line (id, invoice_id, type_id, amount, quantity, price, deleted, item_id, description, source_user_id, is_percentage, optlock, order_id) FROM stdin;
\.


--
-- TOC entry 3862 (class 0 OID 264821)
-- Dependencies: 250
-- Data for Name: invoice_line_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY invoice_line_type (id, description, order_position) FROM stdin;
1	item recurring	2
2	tax	6
3	due invoice	1
4	interests	4
5	sub account	5
6	item one-time	3
\.


--
-- TOC entry 3863 (class 0 OID 264824)
-- Dependencies: 251
-- Data for Name: invoice_meta_field_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY invoice_meta_field_map (invoice_id, meta_field_value_id) FROM stdin;
\.


--
-- TOC entry 3864 (class 0 OID 264827)
-- Dependencies: 252
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY item (id, internal_number, entity_id, deleted, has_decimals, optlock, gl_code, price_manual, asset_management_enabled, standard_availability, global, standard_partner_percentage, master_partner_percentage, active_since, active_until, reservation_duration) FROM stdin;
200	1	10	0	0	2	11	0	0	t	f	0.0000000000	0.0000000000	\N	\N	600000
201	2	10	0	0	2	22	0	0	t	f	0.0000000000	0.0000000000	\N	\N	600000
\.


--
-- TOC entry 3865 (class 0 OID 264836)
-- Dependencies: 253
-- Data for Name: item_account_type_availability; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY item_account_type_availability (item_id, account_type_id) FROM stdin;
\.


--
-- TOC entry 3866 (class 0 OID 264839)
-- Dependencies: 254
-- Data for Name: item_dependency; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY item_dependency (id, dtype, item_id, min, max, dependent_item_id, dependent_item_type_id) FROM stdin;
\.


--
-- TOC entry 3867 (class 0 OID 264842)
-- Dependencies: 255
-- Data for Name: item_entity_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY item_entity_map (item_id, entity_id) FROM stdin;
200	10
201	10
\.


--
-- TOC entry 3868 (class 0 OID 264845)
-- Dependencies: 256
-- Data for Name: item_meta_field_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY item_meta_field_map (item_id, meta_field_value_id) FROM stdin;
\.


--
-- TOC entry 3869 (class 0 OID 264848)
-- Dependencies: 257
-- Data for Name: item_price; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY item_price (id, item_id, currency_id, price, optlock) FROM stdin;
200	200	1	100.0000000000	0
201	201	1	1.0000000000	0
\.


--
-- TOC entry 3870 (class 0 OID 264851)
-- Dependencies: 258
-- Data for Name: item_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY item_type (id, entity_id, description, order_line_type_id, optlock, internal, parent_id, allow_asset_management, asset_identifier_label, global, one_per_order, one_per_customer) FROM stdin;
101	10	Provisionable	1	1	f	\N	0		f	f	f
102	10	Plans	1	1	f	\N	0		f	f	f
200	10	Usage	1	1	f	\N	0		f	f	f
\.


--
-- TOC entry 3871 (class 0 OID 264858)
-- Dependencies: 259
-- Data for Name: item_type_entity_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY item_type_entity_map (item_type_id, entity_id) FROM stdin;
101	10
102	10
200	10
\.


--
-- TOC entry 3872 (class 0 OID 264861)
-- Dependencies: 260
-- Data for Name: item_type_exclude_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY item_type_exclude_map (item_id, type_id) FROM stdin;
\.


--
-- TOC entry 3873 (class 0 OID 264864)
-- Dependencies: 261
-- Data for Name: item_type_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY item_type_map (item_id, type_id) FROM stdin;
200	102
200	101
201	200
\.


--
-- TOC entry 3874 (class 0 OID 264867)
-- Dependencies: 262
-- Data for Name: item_type_meta_field_def_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY item_type_meta_field_def_map (item_type_id, meta_field_id) FROM stdin;
\.


--
-- TOC entry 3875 (class 0 OID 264870)
-- Dependencies: 263
-- Data for Name: item_type_meta_field_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY item_type_meta_field_map (item_type_id, meta_field_value_id) FROM stdin;
\.


--
-- TOC entry 3876 (class 0 OID 264873)
-- Dependencies: 264
-- Data for Name: jbilling_seqs; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY jbilling_seqs (name, next_id) FROM stdin;
entity_delivery_method_map	4
contact_field_type	10
user_role_map	13
entity_payment_method_map	26
currency_entity_map	10
user_credit_card_map	5
period_unit	5
invoice_delivery_method	4
user_status	9
order_line_type	4
order_billing_type	3
pluggable_task_type_category	22
invoice_line_type	6
currency	11
payment_method	9
payment_result	5
event_log_module	10
event_log_message	17
preference_type	37
country	238
currency_exchange	25
partner_range	1
partner	1
contact_type	2
promotion	1
ach	1
payment_info_cheque	1
partner_payout	1
process_run_total_pm	1
payment_authorization	1
billing_process	1
process_run	1
process_run_total	1
paper_invoice_batch	1
ageing_entity_step	1
purchase_order	1
order_line	1
invoice	1
invoice_line	1
order_process	1
payment	2
customer	1
contact_field	1
credit_card	1
language	2
payment_invoice	1
subscriber_status	7
blacklist	1
balance_type	0
price_model_attribute	0
filter	0
filter_set	0
shortcut	0
report	0
report_type	0
report_parameter	0
service	100
service_feature_info	100
service_feature	100
service_alias	100
provisioning_tag	100
provisioning_tag_map	100
provisioning_tag_map_info	100
mediation_process	100
mediation_record	100
mediation_record_line	100
voucher	2
enumeration_values	2
sure_tax_txn_log_seq	2
discount	2
discount_attribute	0
discount_line	1
contact	2
notification_message_type	27
customer_notes	1
rating_unit	1
contact_map	6781
role	7
base_user	2
order_status	6
notification_category	1
matching_field	1
pluggable_task	4
asset	1
route	1
order_period	3
asset_status	1
order_change_type	2
item_dependency	1
pluggable_task_type	150
order_change	1
order_change_status	3
preference	2
generic_status	232
user_code	1
user_code_link	1
notification_message_arch_line	2
payment_method_template	1
payment_method_type	1
payment_information	1
payment_instrument_info	1
notification_message_arch	2
notification_message	2
asset_transition	0
data_table_query_entry	1
data_table_query	1
asset_assignment	1
package_price	100
package_product	100
price_package	100
purchased_bundle	100
purchased_bundle_product	100
support_ticket	100
ticket_details	100
entity	2
account_type	2
billing_process_configuration	2
notification_message_section	3
notification_message_line	2
validation_rule	2
enumeration	2
meta_field_name	3
meta_field_group	2
item_type	3
item	3
item_price	3
mediation_cfg	101
pluggable_task_parameter	3
recent_item	8
event_log	5
breadcrumb	85
\.


--
-- TOC entry 3877 (class 0 OID 264876)
-- Dependencies: 265
-- Data for Name: jbilling_table; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY jbilling_table (id, name) FROM stdin;
3	language
4	currency
5	entity
6	period_unit
7	invoice_delivery_method
8	entity_delivery_method_map
9	user_status
10	base_user
11	partner
12	customer
13	item_type
14	item
15	item_price
17	order_period
18	order_line_type
19	order_billing_type
20	order_status
21	purchase_order
22	order_line
23	pluggable_task_type_category
24	pluggable_task_type
25	pluggable_task
26	pluggable_task_parameter
27	contact
28	contact_type
29	contact_map
30	invoice_line_type
31	paper_invoice_batch
32	billing_process
33	process_run
34	billing_process_configuration
35	payment_method
36	entity_payment_method_map
37	process_run_total
38	process_run_total_pm
39	invoice
40	invoice_line
41	payment_result
42	payment
43	payment_info_cheque
44	credit_card
45	user_credit_card_map
46	event_log_module
47	event_log_message
48	event_log
49	order_process
50	preference_type
51	preference
52	notification_message_type
53	notification_message
54	notification_message_section
55	notification_message_line
56	notification_message_arch
57	notification_message_arch_line
60	role
62	user_role_map
64	country
65	promotion
66	payment_authorization
67	currency_exchange
68	currency_entity_map
69	ageing_entity_step
70	partner_payout
75	ach
76	contact_field
79	partner_range
80	payment_invoice
81	subscriber_status
85	blacklist
87	generic_status
89	balance_type
90	invoice_status
92	process_run_status
99	contact_field_type
100	report
101	report_type
102	report_parameter
104	notification_category
105	enumeration
106	enumeration_values
107	service
108	service_status
109	service_feature_info
110	service_feature
111	service_feature_status
112	service_alias
113	provisioning_tag
114	provisioning_tag_map
115	provisioning_tag_map_info
116	device
120	device_status
121	user_device
123	user_device_status
124	device_type
139	support_ticket
140	ticket_details
515	package_price
516	package_price_type
517	package_product
518	price_package
519	purchased_bundle
520	purchased_bundle_product
500	mediation_cfg
501	mediation_process
502	mediation_record
503	mediation_record_line
504	mediation_record_status
144	voucher_status
521	discount
522	asset_status
523	asset
524	asset_transition
525	account_type
526	meta_field_group
527	meta_field_name
528	validation_rule
1	item_dependency
529	order_change_status
530	order_change
531	order_change_type
532	asset_assignment
\.


--
-- TOC entry 3878 (class 0 OID 264879)
-- Dependencies: 266
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY language (id, code, description) FROM stdin;
1	en	English
2	pt	Portuguese
3	de	Deutsch
4	fr	French
\.


--
-- TOC entry 3880 (class 0 OID 264884)
-- Dependencies: 268
-- Data for Name: list_meta_field_values; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY list_meta_field_values (meta_field_value_id, list_value, id) FROM stdin;
\.


--
-- TOC entry 4038 (class 0 OID 0)
-- Dependencies: 267
-- Name: list_meta_field_values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: openbrm_demo
--

SELECT pg_catalog.setval('list_meta_field_values_id_seq', 1, false);


--
-- TOC entry 3881 (class 0 OID 264888)
-- Dependencies: 269
-- Data for Name: matching_field; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY matching_field (id, description, required, route_id, matching_field, type, order_sequence, optlock, longest_value, smallest_value, mandatory_fields_query) FROM stdin;
\.


--
-- TOC entry 3882 (class 0 OID 264894)
-- Dependencies: 270
-- Data for Name: mediation_cfg; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY mediation_cfg (id, entity_id, create_datetime, name, order_value, pluggable_task_id, optlock) FROM stdin;
1000	10	2018-10-27 11:55:17.435	OpenBRM Mediation	1	33	0
\.


--
-- TOC entry 3883 (class 0 OID 264898)
-- Dependencies: 271
-- Data for Name: mediation_errors; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY mediation_errors (accountcode, src, dst, dcontext, clid, channel, dstchannel, lastapp, lastdata, start_to, answer, end_to, duration, billsec, disposition, amaflags, userfield, error_message, should_retry) FROM stdin;
\.


--
-- TOC entry 3884 (class 0 OID 264917)
-- Dependencies: 272
-- Data for Name: mediation_order_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY mediation_order_map (mediation_process_id, order_id) FROM stdin;
\.


--
-- TOC entry 3885 (class 0 OID 264920)
-- Dependencies: 273
-- Data for Name: mediation_process; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY mediation_process (id, configuration_id, start_datetime, end_datetime, orders_affected, optlock) FROM stdin;
\.


--
-- TOC entry 3886 (class 0 OID 264924)
-- Dependencies: 274
-- Data for Name: mediation_record; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY mediation_record (id_key, start_datetime, mediation_process_id, optlock, status_id, id) FROM stdin;
\.


--
-- TOC entry 3887 (class 0 OID 264928)
-- Dependencies: 275
-- Data for Name: mediation_record_line; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY mediation_record_line (id, order_line_id, event_date, amount, quantity, description, optlock, mediation_record_id) FROM stdin;
\.


--
-- TOC entry 3888 (class 0 OID 264933)
-- Dependencies: 276
-- Data for Name: meta_field_group; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY meta_field_group (id, date_created, date_updated, entity_id, display_order, optlock, entity_type, discriminator, name, account_type_id) FROM stdin;
10	\N	\N	10	1	0	ACCOUNT_TYPE	ACCOUNT_TYPE	Contact	101
\.


--
-- TOC entry 3889 (class 0 OID 264936)
-- Dependencies: 277
-- Data for Name: meta_field_name; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY meta_field_name (id, name, entity_type, data_type, is_disabled, is_mandatory, display_order, default_value_id, optlock, entity_id, error_message, is_primary, validation_rule_id, filename, field_usage) FROM stdin;
1	cc.cardholder.name	PAYMENT_METHOD_TEMPLATE	STRING	f	t	1	\N	0	10	\N	t	\N	\N	TITLE
2	cc.number	PAYMENT_METHOD_TEMPLATE	STRING	f	t	2	\N	0	10	\N	t	10	\N	PAYMENT_CARD_NUMBER
3	cc.expiry.date	PAYMENT_METHOD_TEMPLATE	STRING	f	t	3	\N	0	10	\N	t	11	\N	DATE
4	cc.gateway.key	PAYMENT_METHOD_TEMPLATE	STRING	t	f	4	\N	0	10	\N	t	\N	\N	GATEWAY_KEY
5	cc.type	PAYMENT_METHOD_TEMPLATE	INTEGER	t	f	5	\N	0	10	\N	t	\N	\N	CC_TYPE
6	ach.routing.number	PAYMENT_METHOD_TEMPLATE	STRING	f	t	1	\N	0	10	\N	t	12	\N	BANK_ROUTING_NUMBER
7	ach.customer.name	PAYMENT_METHOD_TEMPLATE	STRING	f	t	2	\N	0	10	\N	t	\N	\N	TITLE
8	ach.account.number	PAYMENT_METHOD_TEMPLATE	STRING	f	t	3	\N	0	10	\N	t	\N	\N	BANK_ACCOUNT_NUMBER
9	ach.bank.name	PAYMENT_METHOD_TEMPLATE	STRING	f	t	4	\N	0	10	\N	t	\N	\N	BANK_NAME
10	ach.account.type	PAYMENT_METHOD_TEMPLATE	ENUMERATION	f	t	5	\N	0	10	\N	t	\N	\N	BANK_ACCOUNT_TYPE
11	ach.gateway.key	PAYMENT_METHOD_TEMPLATE	STRING	t	f	6	\N	0	10	\N	t	\N	\N	GATEWAY_KEY
12	cheque.bank.name	PAYMENT_METHOD_TEMPLATE	STRING	f	t	1	\N	0	10	\N	t	\N	\N	BANK_NAME
13	cheque.number	PAYMENT_METHOD_TEMPLATE	STRING	f	t	2	\N	0	10	\N	t	\N	\N	CHEQUE_NUMBER
14	cheque.date	PAYMENT_METHOD_TEMPLATE	DATE	f	t	3	\N	0	10	\N	t	\N	\N	DATE
15	Address1	ACCOUNT_TYPE	STRING	f	t	5	\N	0	10	\N	f	\N	Address1	ADDRESS1
16	LastName	ACCOUNT_TYPE	STRING	f	f	2	\N	0	10	\N	f	\N	LastName	LAST_NAME
17	Address2	ACCOUNT_TYPE	STRING	f	f	6	\N	0	10	\N	f	\N	Address2	ADDRESS2
18	City	ACCOUNT_TYPE	STRING	f	t	7	\N	0	10	\N	f	\N	City	CITY
19	State	ACCOUNT_TYPE	STRING	f	t	8	\N	0	10	\N	f	\N	State	STATE_PROVINCE
20	FirstName	ACCOUNT_TYPE	STRING	f	t	1	\N	0	10	\N	f	\N	FirstName	FIRST_NAME
21	Organization	ACCOUNT_TYPE	STRING	f	t	3	\N	0	10	\N	f	\N	Organization	ORGANIZATION
22	Email	ACCOUNT_TYPE	STRING	f	t	4	\N	0	10	\N	f	\N	Email	EMAIL
23	Country	ACCOUNT_TYPE	STRING	f	t	9	\N	0	10	\N	f	\N	Country	COUNTRY_CODE
24	PostalCode	ACCOUNT_TYPE	STRING	f	t	10	\N	0	10	\N	f	\N	PostalCode	POSTAL_CODE
\.


--
-- TOC entry 3890 (class 0 OID 264944)
-- Dependencies: 278
-- Data for Name: meta_field_value; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY meta_field_value (id, meta_field_name_id, dtype, boolean_value, date_value, decimal_value, integer_value, string_value) FROM stdin;
\.


--
-- TOC entry 3891 (class 0 OID 264950)
-- Dependencies: 279
-- Data for Name: metafield_group_meta_field_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY metafield_group_meta_field_map (metafield_group_id, meta_field_value_id) FROM stdin;
10	16
10	23
10	18
10	20
10	21
10	22
10	24
10	19
10	17
10	15
\.


--
-- TOC entry 3892 (class 0 OID 264953)
-- Dependencies: 280
-- Data for Name: notification_category; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY notification_category (id) FROM stdin;
1
2
3
4
5
\.


--
-- TOC entry 3893 (class 0 OID 264956)
-- Dependencies: 281
-- Data for Name: notification_config; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY notification_config (id, event_id, created_datetime, message_id, notify_type, deleted, optlock) FROM stdin;
\.


--
-- TOC entry 3894 (class 0 OID 264959)
-- Dependencies: 282
-- Data for Name: notification_event; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY notification_event (id, subject, created_datetime) FROM stdin;
\.


--
-- TOC entry 3895 (class 0 OID 264963)
-- Dependencies: 283
-- Data for Name: notification_medium_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY notification_medium_type (notification_id, medium_type) FROM stdin;
1	SMS
1	EMAIL
1	PDF
2	SMS
2	EMAIL
2	PDF
3	SMS
3	EMAIL
3	PDF
4	SMS
4	EMAIL
4	PDF
7	SMS
7	EMAIL
7	PDF
8	SMS
8	EMAIL
8	PDF
9	SMS
9	EMAIL
9	PDF
10	SMS
10	EMAIL
10	PDF
11	SMS
11	EMAIL
11	PDF
12	SMS
12	EMAIL
12	PDF
13	SMS
13	EMAIL
13	PDF
14	SMS
14	EMAIL
14	PDF
15	SMS
15	EMAIL
15	PDF
17	SMS
17	EMAIL
17	PDF
18	SMS
18	EMAIL
18	PDF
19	SMS
19	EMAIL
19	PDF
16	SMS
16	EMAIL
16	PDF
20	SMS
20	EMAIL
20	PDF
21	SMS
21	EMAIL
21	PDF
22	SMS
22	EMAIL
22	PDF
23	SMS
23	EMAIL
23	PDF
24	SMS
24	EMAIL
24	PDF
25	SMS
25	EMAIL
25	PDF
26	SMS
26	EMAIL
26	PDF
27	SMS
27	EMAIL
27	PDF
28	SMS
28	EMAIL
28	PDF
29	SMS
29	EMAIL
29	PDF
30	SMS
30	EMAIL
30	PDF
31	SMS
31	EMAIL
31	PDF
32	SMS
32	EMAIL
32	PDF
33	SMS
33	EMAIL
33	PDF
34	SMS
34	EMAIL
34	PDF
35	SMS
35	EMAIL
35	PDF
36	SMS
36	EMAIL
36	PDF
100	EMAIL
100	SMS
100	PDF
101	EMAIL
101	SMS
101	PDF
102	EMAIL
102	SMS
102	PDF
103	EMAIL
103	SMS
103	PDF
104	EMAIL
104	SMS
104	PDF
105	EMAIL
105	SMS
105	PDF
106	EMAIL
106	SMS
106	PDF
107	EMAIL
107	SMS
107	PDF
108	EMAIL
108	SMS
108	PDF
109	EMAIL
109	SMS
109	PDF
\.


--
-- TOC entry 3896 (class 0 OID 264966)
-- Dependencies: 284
-- Data for Name: notification_message; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY notification_message (id, type_id, entity_id, language_id, use_flag, optlock, attachment_type, include_attachment, attachment_design, notify_admin, notify_partner, notify_parent, notify_all_parents) FROM stdin;
100	1	10	1	1	2	\N	\N	\N	0	0	0	0
101	2	10	1	1	1	\N	\N	\N	0	0	0	0
102	3	10	1	1	1	\N	\N	\N	0	0	0	0
103	13	10	1	1	1	\N	\N	\N	0	0	0	0
104	16	10	1	1	1	\N	\N	\N	0	0	0	0
105	17	10	1	1	1	\N	\N	\N	0	0	0	0
106	18	10	1	1	1	\N	\N	\N	0	0	0	0
107	19	10	1	1	1	\N	\N	\N	0	0	0	0
108	20	10	1	1	1	\N	\N	\N	0	0	0	0
109	21	10	1	1	1	\N	\N	\N	0	0	0	0
\.


--
-- TOC entry 3897 (class 0 OID 264970)
-- Dependencies: 285
-- Data for Name: notification_message_arch; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY notification_message_arch (id, type_id, create_datetime, user_id, result_message, optlock) FROM stdin;
100	21	2018-10-25 17:20:56.804	10	Exception sending the message.Mail server connection failed; nested exception is javax.mail.MessagingException: Connection error (java.net.ConnectException: Connection refused: connect). Failed messag	1
101	21	2018-10-25 17:20:59.103	10	\N	1
102	21	2018-10-25 17:20:59.119	10	\N	1
\.


--
-- TOC entry 3898 (class 0 OID 264973)
-- Dependencies: 286
-- Data for Name: notification_message_arch_line; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY notification_message_arch_line (content, message_archive_id, section, optlock, id) FROM stdin;
Initial Credentials	100	1	1	100
Hello admin admin,\n\nWelcome to OpenBRM!.\n\nPlease follow this link to set your credentials:\n\nhttp://www.yourcompany.com/openbrm/resetPassword/changePassword?token=qx82c528pngfHHfSdv6aDJSGWORbEkUm\n\nAdmin:\topenbrm	100	2	1	101
Initial Credentials	101	1	1	102
Hello admin admin,\n\nWelcome to OpenBRM!.\n\nPlease follow this link to set your credentials:\n\nhttp://www.yourcompany.com/openbrm/resetPassword/changePassword?token=qx82c528pngfHHfSdv6aDJSGWORbEkUm\n\nAdmin:\topenbrm	101	2	1	103
Initial Credentials	102	1	1	104
Hello admin admin,\n\nWelcome to OpenBRM!.\n\nPlease follow this link to set your credentials:\n\nhttp://www.yourcompany.com/openbrm/resetPassword/changePassword?token=qx82c528pngfHHfSdv6aDJSGWORbEkUm\n\nAdmin:\topenbrm	102	2	1	105
\.


--
-- TOC entry 3899 (class 0 OID 264979)
-- Dependencies: 287
-- Data for Name: notification_message_line; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY notification_message_line (id, message_section_id, content, optlock) FROM stdin;
1	1	Usage pool consumption status.	0
2	2	Dear $userSalutation,\\r\\n\\r\\nYou have used $percentageConsumption% from Free Usage Pool - $usagePoolName.\\r\\n\\r\\nThanks.	0
100	200	Billing Statement from $company_name	0
101	101	Dear $first_name $last_name,\n\n This is to notify you that your latest invoice (number $number) is now available. The total amount due is: $total. You can view it by login in to:\n\n" + Util.getSysProp("url") + "/billing/user/login.jsp?entityId=$company_id\n\nFor security reasons, your statement is password protected.\nTo login in, you will need your user name: $username and your account password: $password\n \n After logging in, please click on the menu option  ï¿½Listï¿½, to see all your invoices.  You can also see your payment history, your current purchase orders, as well as update your payment information and submit online payments.\n\n\nThank you for choosing $company_name, we appreciate your business,\n\nBilling Department\n$company_name	0
102	102	You account is now up to date	0
103	103	Dear $first_name $last_name,\n\n  This email is to notify you that we have received your latest payment and your account no longer has an overdue balance.\n\n  Thank you for keeping your account up to date,\n\n\nBilling Department\n$company_name	0
104	104	Overdue Balance	0
105	105	Dear $first_name $last_name,\n\nOur records show that you have an overdue balance on your account. Please submit a payment as soon as possible.\n\nBest regards,\n\nBilling Department\n$company_name	0
106	106	Your service from $company_name is about to expire	0
107	107	Dear $first_name $last_name,\n\nYour service with us will expire on $period_end. Please make sure to contact customer service for a renewal.\n\nRegards,\n\nBilling Department\n$company_name	0
108	108	Thank you for your payment	0
109	109	Dear $first_name $last_name\n\n   We have received your payment made with $method for a total of $total.\n\n   Thank you, we appreciate your business,\n\nBilling Department\n$company_name	0
110	110	Payment failed	0
111	111	Dear $first_name $last_name\n\n   A payment with $method was attempted for a total of $total, but it has been rejected by the payment processor.\nYou can update your payment information and submit an online payment by login into :\n" + Util.getSysProp("url") + "/billing/user/login.jsp?entityId=$company_id\n\nFor security reasons, your statement is password protected.\nTo login in, you will need your user name: $username and your account password: $password\n\nThank you,\n\nBilling Department\n$company_name	0
112	112	Invoice reminder	0
113	113	Dear $first_name $last_name\n\n   This is a reminder that the invoice number $number remains unpaid. It was sent to you on $date, and its total is $total. Although you still have $days days to pay it (its due date is $dueDate), we would greatly appreciate if you can pay it at your earliest convenience.\n\nYours truly,\n\nBilling Department\n$company_name	0
114	114	It is time to update your credit card	0
115	115	Dear $first_name $last_name,\n\nWe want to remind you that the credit card that we have in our records for your account is about to expire. Its expiration date is $expiry_date.\n\nUpdating your credit card is easy. Just login into " + Util.getSysProp("url") + "/billing/user/login.jsp?entityId=$company_id. using your user name: $username and password: $password. After logging in, click on 'Account' and then 'Edit Credit Card'. \nThank you for keeping your account up to date.\n\nBilling Department\n$company_name	0
116	116	Reset password request	0
117	117	Hello  $first_name $last_name,\n\nYou (or someone pretending to be you) requested a password reset of your account.\n\nYou may reset your password from the following link:\n\n$newPasswordLink\n\nAdmin:\t$organization_name	0
118	118	Initial Credentials	0
119	119	Hello $first_name $last_name,\n\nWelcome to OpenBRM!.\n\nPlease follow this link to set your credentials:\n\n$newPasswordLink\n\nAdmin:\t$organization_name	0
\.


--
-- TOC entry 3900 (class 0 OID 264985)
-- Dependencies: 288
-- Data for Name: notification_message_section; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY notification_message_section (id, message_id, section, optlock) FROM stdin;
1	\N	1	0
2	\N	2	0
3	\N	3	0
200	100	1	0
100	100	1	0
101	100	2	0
102	101	1	0
103	101	2	0
104	102	1	0
105	102	2	0
106	103	1	0
107	103	2	0
108	104	1	0
109	104	2	0
110	105	1	0
111	105	2	0
112	106	1	0
113	106	2	0
114	107	1	0
115	107	2	0
116	108	1	0
117	108	2	0
118	109	1	0
119	109	2	0
\.


--
-- TOC entry 3901 (class 0 OID 264988)
-- Dependencies: 289
-- Data for Name: notification_message_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY notification_message_type (id, optlock, category_id) FROM stdin;
1	1	1
2	1	4
3	1	4
4	1	4
5	1	4
6	1	4
7	1	4
8	1	4
9	1	4
12	1	1
13	1	2
14	1	2
15	1	2
16	1	3
17	1	3
18	1	1
19	1	4
20	1	4
22	1	3
23	1	3
24	0	5
25	0	4
26	0	4
27	0	4
21	0	4
\.


--
-- TOC entry 3902 (class 0 OID 264991)
-- Dependencies: 290
-- Data for Name: notification_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY notification_type (id) FROM stdin;
\.


--
-- TOC entry 3903 (class 0 OID 264994)
-- Dependencies: 291
-- Data for Name: ob_rated_cdr_record; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY ob_rated_cdr_record (id, process_id, record_id, order_id, user_id, invoice_id, calling_number, destination_number, call_start_date, call_end_date, duration, cost, product_id, destination_descr, rate_id, call_type, cdr_source) FROM stdin;
\.


--
-- TOC entry 3904 (class 0 OID 265008)
-- Dependencies: 292
-- Data for Name: order_billing_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY order_billing_type (id) FROM stdin;
1
2
\.


--
-- TOC entry 3905 (class 0 OID 265011)
-- Dependencies: 293
-- Data for Name: order_change; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY order_change (id, parent_order_change_id, parent_order_line_id, order_id, item_id, quantity, price, description, use_item, user_id, create_datetime, start_date, application_date, status_id, user_assigned_status_id, order_line_id, optlock, error_message, error_codes, applied_manually, removal, next_billable_date, end_date, order_change_type_id, order_status_id, is_percentage) FROM stdin;
\.


--
-- TOC entry 3906 (class 0 OID 265018)
-- Dependencies: 294
-- Data for Name: order_change_asset_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY order_change_asset_map (order_change_id, asset_id) FROM stdin;
\.


--
-- TOC entry 3907 (class 0 OID 265021)
-- Dependencies: 295
-- Data for Name: order_change_meta_field_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY order_change_meta_field_map (order_change_id, meta_field_value_id) FROM stdin;
\.


--
-- TOC entry 3908 (class 0 OID 265024)
-- Dependencies: 296
-- Data for Name: order_change_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY order_change_type (id, name, entity_id, default_type, allow_order_status_change, optlock) FROM stdin;
1	Default	\N	t	f	0
\.


--
-- TOC entry 3909 (class 0 OID 265029)
-- Dependencies: 297
-- Data for Name: order_change_type_item_type_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY order_change_type_item_type_map (order_change_type_id, item_type_id) FROM stdin;
\.


--
-- TOC entry 3910 (class 0 OID 265032)
-- Dependencies: 298
-- Data for Name: order_change_type_meta_field_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY order_change_type_meta_field_map (order_change_type_id, meta_field_id) FROM stdin;
\.


--
-- TOC entry 3911 (class 0 OID 265035)
-- Dependencies: 299
-- Data for Name: order_line; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY order_line (id, order_id, item_id, type_id, amount, quantity, price, item_price, create_datetime, deleted, description, optlock, use_item, parent_line_id, start_date, end_date, sip_uri, is_percentage) FROM stdin;
\.


--
-- TOC entry 3912 (class 0 OID 265043)
-- Dependencies: 300
-- Data for Name: order_line_meta_field_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY order_line_meta_field_map (order_line_id, meta_field_value_id) FROM stdin;
\.


--
-- TOC entry 3913 (class 0 OID 265046)
-- Dependencies: 301
-- Data for Name: order_line_meta_fields_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY order_line_meta_fields_map (item_id, meta_field_id) FROM stdin;
\.


--
-- TOC entry 3914 (class 0 OID 265049)
-- Dependencies: 302
-- Data for Name: order_line_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY order_line_type (id, editable) FROM stdin;
1	1
2	0
3	0
4	0
5	1
\.


--
-- TOC entry 3915 (class 0 OID 265052)
-- Dependencies: 303
-- Data for Name: order_meta_field_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY order_meta_field_map (order_id, meta_field_value_id) FROM stdin;
\.


--
-- TOC entry 3916 (class 0 OID 265055)
-- Dependencies: 304
-- Data for Name: order_period; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY order_period (id, entity_id, value, unit_id, optlock) FROM stdin;
5	\N	\N	\N	1
1	\N	\N	\N	1
200	10	1	1	0
\.


--
-- TOC entry 3917 (class 0 OID 265058)
-- Dependencies: 305
-- Data for Name: order_process; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY order_process (id, order_id, invoice_id, billing_process_id, periods_included, period_start, period_end, is_review, origin, optlock) FROM stdin;
\.


--
-- TOC entry 3918 (class 0 OID 265061)
-- Dependencies: 306
-- Data for Name: order_status; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY order_status (id, order_status_flag, entity_id) FROM stdin;
500	0	10
501	1	10
502	2	10
503	3	10
\.


--
-- TOC entry 3919 (class 0 OID 265064)
-- Dependencies: 307
-- Data for Name: package_price; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY package_price (id, pkg_prod_id, type_id, amount, discount, start_date, end_date, start_offset, start_offset_unit, end_offset, end_offset_unit, optlock, deleted, period_id, billing_type_id) FROM stdin;
\.


--
-- TOC entry 3920 (class 0 OID 265068)
-- Dependencies: 308
-- Data for Name: package_price_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY package_price_type (id, type) FROM stdin;
\.


--
-- TOC entry 3921 (class 0 OID 265071)
-- Dependencies: 309
-- Data for Name: package_product; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY package_product (id, package_id, quantity, product_id, deleted, optlock, create_datetime) FROM stdin;
\.


--
-- TOC entry 3922 (class 0 OID 265076)
-- Dependencies: 310
-- Data for Name: paper_invoice_batch; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY paper_invoice_batch (id, total_invoices, delivery_date, is_self_managed, optlock) FROM stdin;
\.


--
-- TOC entry 3923 (class 0 OID 265079)
-- Dependencies: 311
-- Data for Name: partner; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY partner (id, user_id, total_payments, total_refunds, total_payouts, due_payout, optlock, type, parent_id, commission_type) FROM stdin;
\.


--
-- TOC entry 3924 (class 0 OID 265085)
-- Dependencies: 312
-- Data for Name: partner_commission; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY partner_commission (id, amount, type, partner_id, commission_process_run_id, currency_id) FROM stdin;
\.


--
-- TOC entry 3925 (class 0 OID 265088)
-- Dependencies: 313
-- Data for Name: partner_commission_exception; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY partner_commission_exception (id, partner_id, start_date, end_date, percentage, item_id) FROM stdin;
\.


--
-- TOC entry 3926 (class 0 OID 265091)
-- Dependencies: 314
-- Data for Name: partner_commission_proc_config; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY partner_commission_proc_config (id, entity_id, next_run_date, period_unit_id, period_value) FROM stdin;
\.


--
-- TOC entry 3927 (class 0 OID 265094)
-- Dependencies: 315
-- Data for Name: partner_commission_process_run; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY partner_commission_process_run (id, run_date, period_start, period_end, entity_id) FROM stdin;
\.


--
-- TOC entry 3928 (class 0 OID 265097)
-- Dependencies: 316
-- Data for Name: partner_meta_field_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY partner_meta_field_map (partner_id, meta_field_value_id) FROM stdin;
\.


--
-- TOC entry 3929 (class 0 OID 265100)
-- Dependencies: 317
-- Data for Name: partner_payout; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY partner_payout (id, starting_date, ending_date, payments_amount, refunds_amount, balance_left, payment_id, partner_id, optlock) FROM stdin;
\.


--
-- TOC entry 3930 (class 0 OID 265103)
-- Dependencies: 318
-- Data for Name: partner_referral_commission; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY partner_referral_commission (id, referral_id, referrer_id, start_date, end_date, percentage) FROM stdin;
\.


--
-- TOC entry 3931 (class 0 OID 265106)
-- Dependencies: 319
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY payment (id, user_id, attempt, result_id, amount, create_datetime, update_datetime, payment_date, method_id, credit_card_id, deleted, is_refund, is_preauth, payment_id, currency_id, payout_id, ach_id, balance, optlock, payment_period, payment_notes) FROM stdin;
\.


--
-- TOC entry 3932 (class 0 OID 265115)
-- Dependencies: 320
-- Data for Name: payment_authorization; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY payment_authorization (id, payment_id, processor, code1, code2, code3, approval_code, avs, transaction_id, md5, card_code, create_datetime, response_message, optlock) FROM stdin;
\.


--
-- TOC entry 3933 (class 0 OID 265121)
-- Dependencies: 321
-- Data for Name: payment_commission; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY payment_commission (id, invoice_id, payment_amount) FROM stdin;
\.


--
-- TOC entry 3934 (class 0 OID 265124)
-- Dependencies: 322
-- Data for Name: payment_info_cheque; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY payment_info_cheque (id, payment_id, bank, cheque_number, cheque_date, optlock) FROM stdin;
\.


--
-- TOC entry 3935 (class 0 OID 265127)
-- Dependencies: 323
-- Data for Name: payment_information; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY payment_information (id, user_id, payment_method_id, processing_order, deleted, optlock) FROM stdin;
\.


--
-- TOC entry 3936 (class 0 OID 265130)
-- Dependencies: 324
-- Data for Name: payment_information_meta_fields_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY payment_information_meta_fields_map (payment_information_id, meta_field_value_id) FROM stdin;
\.


--
-- TOC entry 3937 (class 0 OID 265133)
-- Dependencies: 325
-- Data for Name: payment_instrument_info; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY payment_instrument_info (id, result_id, method_id, instrument_id, payment_id) FROM stdin;
\.


--
-- TOC entry 3938 (class 0 OID 265136)
-- Dependencies: 326
-- Data for Name: payment_invoice; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY payment_invoice (id, payment_id, invoice_id, amount, create_datetime, optlock) FROM stdin;
\.


--
-- TOC entry 3939 (class 0 OID 265139)
-- Dependencies: 327
-- Data for Name: payment_meta_field_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY payment_meta_field_map (payment_id, meta_field_value_id) FROM stdin;
\.


--
-- TOC entry 3940 (class 0 OID 265142)
-- Dependencies: 328
-- Data for Name: payment_method; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY payment_method (id) FROM stdin;
1
2
3
4
5
6
7
8
9
15
\.


--
-- TOC entry 3941 (class 0 OID 265145)
-- Dependencies: 329
-- Data for Name: payment_method_account_type_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY payment_method_account_type_map (payment_method_id, account_type_id) FROM stdin;
\.


--
-- TOC entry 3942 (class 0 OID 265148)
-- Dependencies: 330
-- Data for Name: payment_method_meta_fields_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY payment_method_meta_fields_map (payment_method_id, meta_field_id) FROM stdin;
\.


--
-- TOC entry 3943 (class 0 OID 265151)
-- Dependencies: 331
-- Data for Name: payment_method_template; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY payment_method_template (id, template_name, optlock) FROM stdin;
1	Payment Card	2
2	ACH	3
3	Cheque	1
\.


--
-- TOC entry 3944 (class 0 OID 265154)
-- Dependencies: 332
-- Data for Name: payment_method_template_meta_fields_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY payment_method_template_meta_fields_map (method_template_id, meta_field_id) FROM stdin;
1	1
1	2
1	3
1	4
1	5
2	6
2	7
2	8
2	9
2	10
2	11
3	12
3	13
3	14
\.


--
-- TOC entry 3945 (class 0 OID 265157)
-- Dependencies: 333
-- Data for Name: payment_method_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY payment_method_type (id, method_name, is_recurring, entity_id, template_id, optlock, all_account_type) FROM stdin;
\.


--
-- TOC entry 3946 (class 0 OID 265162)
-- Dependencies: 334
-- Data for Name: payment_result; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY payment_result (id) FROM stdin;
1
2
3
4
\.


--
-- TOC entry 3947 (class 0 OID 265165)
-- Dependencies: 335
-- Data for Name: period_unit; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY period_unit (id) FROM stdin;
1
2
3
4
5
\.


--
-- TOC entry 3948 (class 0 OID 265168)
-- Dependencies: 336
-- Data for Name: permission; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY permission (id, type_id, foreign_id) FROM stdin;
\.


--
-- TOC entry 3949 (class 0 OID 265171)
-- Dependencies: 337
-- Data for Name: permission_role_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY permission_role_map (permission_id, role_id) FROM stdin;
\.


--
-- TOC entry 3950 (class 0 OID 265174)
-- Dependencies: 338
-- Data for Name: permission_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY permission_type (id, description) FROM stdin;
\.


--
-- TOC entry 3951 (class 0 OID 265177)
-- Dependencies: 339
-- Data for Name: permission_user; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY permission_user (permission_id, user_id, is_grant, id) FROM stdin;
\.


--
-- TOC entry 3952 (class 0 OID 265180)
-- Dependencies: 340
-- Data for Name: pluggable_task; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY pluggable_task (id, entity_id, type_id, processing_order, optlock, notes) FROM stdin;
10	10	21	1	0	\N
11	10	9	1	0	\N
12	10	12	2	0	\N
13	10	1	1	0	\N
14	10	3	1	0	\N
15	10	4	2	0	\N
16	10	5	1	0	\N
17	10	6	1	0	\N
18	10	7	1	0	\N
19	10	10	1	0	\N
20	10	25	1	0	\N
21	10	28	1	0	\N
22	10	54	1	0	\N
23	10	82	1	0	\N
24	10	88	2	0	\N
25	10	87	1	0	\N
26	10	69	1	0	\N
27	10	138	2	0	\N
28	10	139	3	0	\N
29	10	149	7	0	\N
30	10	36	3	0	\N
31	10	94	4	1	
32	10	95	5	1	
33	10	32	1	3	
34	10	160	1	3	
\.


--
-- TOC entry 3953 (class 0 OID 265186)
-- Dependencies: 341
-- Data for Name: pluggable_task_parameter; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY pluggable_task_parameter (id, task_id, name, int_value, str_value, float_value, optlock) FROM stdin;
100	10	all	\N	yes	\N	0
101	11	smtp_server	\N		\N	1
102	11	port	\N		\N	1
103	11	ssl_auth	\N	false	\N	1
104	11	tls	\N	false	\N	1
105	11	username	\N		\N	1
106	11	password	\N		\N	1
107	12	design	\N	simple_invoice_b2b	\N	1
108	30	from	\N	admin@jbilling.com	\N	1
110	33	rename	\N	true	\N	0
113	33	format_file	\N	openrate.xml	\N	0
114	34	Currency id	\N	1	\N	0
111	33	suffix	\N	.Cout	\N	1
200	34	rating_product	\N	201	\N	0
\.


--
-- TOC entry 3954 (class 0 OID 265192)
-- Dependencies: 342
-- Data for Name: pluggable_task_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY pluggable_task_type (id, category_id, class_name, min_parameters) FROM stdin;
1	1	com.sapienter.jbilling.server.pluggableTask.BasicLineTotalTask	0
13	4	com.sapienter.jbilling.server.pluggableTask.CalculateDueDateDfFm	0
3	4	com.sapienter.jbilling.server.pluggableTask.CalculateDueDate	0
4	4	com.sapienter.jbilling.server.pluggableTask.BasicCompositionTask	0
5	2	com.sapienter.jbilling.server.pluggableTask.BasicOrderFilterTask	0
6	3	com.sapienter.jbilling.server.pluggableTask.BasicInvoiceFilterTask	0
7	5	com.sapienter.jbilling.server.pluggableTask.BasicOrderPeriodTask	0
8	6	com.sapienter.jbilling.server.pluggableTask.PaymentAuthorizeNetTask	2
14	3	com.sapienter.jbilling.server.pluggableTask.NoInvoiceFilterTask	0
10	8	com.sapienter.jbilling.server.pluggableTask.BasicPaymentInfoTask	0
11	6	com.sapienter.jbilling.server.pluggableTask.PaymentPartnerTestTask	0
12	7	com.sapienter.jbilling.server.pluggableTask.PaperInvoiceNotificationTask	1
2	1	com.sapienter.jbilling.server.pluggableTask.GSTTaxTask	2
16	2	com.sapienter.jbilling.server.pluggableTask.OrderFilterAnticipatedTask	0
9	7	com.sapienter.jbilling.server.pluggableTask.BasicEmailNotificationTask	6
17	5	com.sapienter.jbilling.server.pluggableTask.OrderPeriodAnticipateTask	0
19	6	com.sapienter.jbilling.server.pluggableTask.PaymentEmailAuthorizeNetTask	1
20	10	com.sapienter.jbilling.server.pluggableTask.ProcessorEmailAlarmTask	3
21	6	com.sapienter.jbilling.server.pluggableTask.PaymentFakeTask	0
22	6	com.sapienter.jbilling.server.payment.tasks.PaymentRouterCCFTask	2
23	11	com.sapienter.jbilling.server.user.tasks.BasicSubscriptionStatusManagerTask	0
24	6	com.sapienter.jbilling.server.user.tasks.PaymentACHCommerceTask	5
25	12	com.sapienter.jbilling.server.payment.tasks.NoAsyncParameters	0
26	12	com.sapienter.jbilling.server.payment.tasks.RouterAsyncParameters	0
28	13	com.sapienter.jbilling.server.item.tasks.BasicItemManager	0
29	13	com.sapienter.jbilling.server.item.tasks.RulesItemManager	0
30	1	com.sapienter.jbilling.server.order.task.RulesLineTotalTask	0
31	14	com.sapienter.jbilling.server.item.tasks.RulesPricingTask	0
35	8	com.sapienter.jbilling.server.user.tasks.PaymentInfoNoValidateTask	0
36	7	com.sapienter.jbilling.server.notification.task.TestNotificationTask	0
39	6	com.sapienter.jbilling.server.payment.tasks.PaymentAtlasTask	5
40	17	com.sapienter.jbilling.server.order.task.RefundOnCancelTask	0
41	17	com.sapienter.jbilling.server.order.task.CancellationFeeRulesTask	1
42	6	com.sapienter.jbilling.server.payment.tasks.PaymentFilterTask	0
43	17	com.sapienter.jbilling.server.payment.blacklist.tasks.BlacklistUserStatusTask	0
129	17	dk.comtalk.billing.server.customer.task.SimpleBundleResourceManager	0
128	17	com.sapienter.jbilling.server.order.task.OpenbrmRefundOnCancelTask	1
127	17	in.saralam.sbs.server.notification.OpenBRMNotificationTask	1
49	6	com.sapienter.jbilling.server.payment.tasks.PaymentRouterCurrencyTask	2
51	3	com.sapienter.jbilling.server.invoice.task.NegativeBalanceInvoiceFilterTask	0
52	17	com.sapienter.jbilling.server.invoice.task.FileInvoiceExportTask	1
53	17	com.sapienter.jbilling.server.system.event.task.InternalEventsRulesTask	0
54	17	com.sapienter.jbilling.server.user.balance.DynamicBalanceManagerTask	0
55	19	com.sapienter.jbilling.server.user.tasks.UserBalanceValidatePurchaseTask	0
56	19	com.sapienter.jbilling.server.user.tasks.RulesValidatePurchaseTask	0
57	6	com.sapienter.jbilling.server.payment.tasks.PaymentsGatewayTask	4
58	17	com.sapienter.jbilling.server.payment.tasks.SaveCreditCardExternallyTask	1
59	13	com.sapienter.jbilling.server.order.task.RulesItemManager2	0
60	1	com.sapienter.jbilling.server.order.task.RulesLineTotalTask2	0
61	14	com.sapienter.jbilling.server.item.tasks.RulesPricingTask2	0
62	17	com.sapienter.jbilling.server.payment.tasks.SaveCreditCardExternallyTask	1
63	6	com.sapienter.jbilling.server.pluggableTask.PaymentFakeExternalStorage	0
64	6	com.sapienter.jbilling.server.payment.tasks.PaymentWorldPayTask	3
65	6	com.sapienter.jbilling.server.payment.tasks.PaymentWorldPayExternalTask	3
66	17	com.sapienter.jbilling.server.user.tasks.AutoRechargeTask	0
67	6	com.sapienter.jbilling.server.payment.tasks.PaymentBeanstreamTask	3
68	6	com.sapienter.jbilling.server.payment.tasks.PaymentSageTask	2
69	20	com.sapienter.jbilling.server.process.task.BasicBillingProcessFilterTask	0
70	20	com.sapienter.jbilling.server.process.task.BillableUsersBillingProcessFilterTask	0
75	6	com.sapienter.jbilling.server.payment.tasks.PaymentPaypalExternalTask	3
76	6	com.sapienter.jbilling.server.payment.tasks.PaymentAuthorizeNetCIMTask	2
77	6	com.sapienter.jbilling.server.payment.tasks.PaymentMethodRouterTask	4
82	22	com.sapienter.jbilling.server.billing.task.BillingProcessTask	0
83	22	com.sapienter.jbilling.server.process.task.ScpUploadTask	4
84	17	com.sapienter.jbilling.server.payment.tasks.SaveACHExternallyTask	1
85	20	com.sapienter.jbilling.server.process.task.BillableUserOrdersBillingProcessFilterTask	0
87	24	com.sapienter.jbilling.server.process.task.BasicAgeingTask	0
88	22	com.sapienter.jbilling.server.process.task.AgeingProcessTask	0
89	24	com.sapienter.jbilling.server.process.task.BusinessDayAgeingTask	0
15	17	com.sapienter.jbilling.server.pluggableTask.BasicPenaltyTask	1
91	4	com.sapienter.jbilling.server.process.task.CountryTaxCompositionTask	2
92	4	com.sapienter.jbilling.server.process.task.PaymentTermPenaltyTask	2
94	17	com.sapienter.jbilling.server.order.task.SubscriptionManagerTask	0
95	17	in.saralam.sbs.server.subscription.task.SubscriptionActiveEventTask	0
32	15	com.sapienter.jbilling.server.mediation.task.SeparatorFileReader	1
81	22	com.sapienter.jbilling.server.mediation.task.MediationProcessTask	0
34	15	com.sapienter.jbilling.server.mediation.task.FixedFileReader	1
44	15	com.sapienter.jbilling.server.mediation.task.JDBCReader	0
45	15	com.sapienter.jbilling.server.mediation.task.MySQLReader	0
71	21	com.sapienter.jbilling.server.mediation.task.SaveToFileMediationErrorHandler	0
73	21	com.sapienter.jbilling.server.mediation.task.SaveToJDBCMediationErrorHandler	1
98	16	in.saralam.sbs.server.mediation.task.OpenBRM4MediationTask	1
90	4	com.sapienter.jbilling.server.process.task.SimpleTaxCompositionTask	1
97	17	com.sapienter.jbilling.server.pluggableTask.OverdueInvoicePenaltyTask	1
105	4	com.sapienter.jbilling.server.process.task.SureTaxCompositionTask	0
130	17	com.sapienter.jbilling.server.process.task.SuretaxDeleteInvoiceTask	0
131	17	com.sapienter.jbilling.server.invoice.task.ApplyNegativeInvoiceToPaymentTask	0
132	17	com.sapienter.jbilling.server.user.tasks.BalanceThresholdNotificationTask	1
133	17	com.sapienter.jbilling.server.user.tasks.UserAgeingNotificationTask	0
134	22	com.sapienter.jbilling.server.pluggableTask.FileCleanupTask	2
135	17	com.sapienter.jbilling.server.item.tasks.AssetUpdatedTask	0
136	17	com.sapienter.jbilling.server.item.tasks.RemoveAssetFromFinishedOrderTask	0
137	17	com.sapienter.jbilling.server.order.task.OrderCancellationTask	1
138	17	com.sapienter.jbilling.server.order.task.CreateOrderForResellerTask	0
139	17	com.sapienter.jbilling.server.invoice.task.DeleteResellerOrderTask	0
140	22	com.sapienter.jbilling.server.order.task.OrderChangeUpdateTask	0
141	22	com.sapienter.jbilling.server.user.partner.task.CalculateCommissionTask	0
142	25	com.sapienter.jbilling.server.user.partner.task.BasicPartnerCommissionTask	0
143	17	com.sapienter.jbilling.server.payment.tasks.GeneratePaymentCommissionTask	0
144	26	com.sapienter.jbilling.server.process.task.FtpRemoteCopyTask	0
145	26	com.sapienter.jbilling.server.process.task.FtpsRemoteCopyTask	0
146	26	com.sapienter.jbilling.server.process.task.StpRemoteCopyTask	0
147	22	com.sapienter.jbilling.server.process.task.FileExchangeTriggerTask	1
148	17	com.sapienter.jbilling.server.user.tasks.CreditLimitationNotificationTask	0
149	17	com.sapienter.jbilling.server.order.task.OrderChangeApplyOrderStatusTask	0
101	17	com.sapienter.jbilling.server.user.tasks.EventBasedCustomNotificationTask	0
150	22	com.sapienter.jbilling.server.pluggableTask.InactiveUserManagementTask	0
160	16	in.saralam.sbs.server.mediation.task.AdvanceRatingMediationTask	0
\.


--
-- TOC entry 3955 (class 0 OID 265195)
-- Dependencies: 343
-- Data for Name: pluggable_task_type_category; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY pluggable_task_type_category (id, interface_name) FROM stdin;
1	com.sapienter.jbilling.server.pluggableTask.OrderProcessingTask
2	com.sapienter.jbilling.server.pluggableTask.OrderFilterTask
3	com.sapienter.jbilling.server.pluggableTask.InvoiceFilterTask
4	com.sapienter.jbilling.server.pluggableTask.InvoiceCompositionTask
5	com.sapienter.jbilling.server.pluggableTask.OrderPeriodTask
6	com.sapienter.jbilling.server.pluggableTask.PaymentTask
7	com.sapienter.jbilling.server.pluggableTask.NotificationTask
8	com.sapienter.jbilling.server.pluggableTask.PaymentInfoTask
9	com.sapienter.jbilling.server.pluggableTask.PenaltyTask
10	com.sapienter.jbilling.server.pluggableTask.ProcessorAlarm
11	com.sapienter.jbilling.server.user.tasks.ISubscriptionStatusManager
12	com.sapienter.jbilling.server.payment.tasks.IAsyncPaymentParameters
13	com.sapienter.jbilling.server.item.tasks.IItemPurchaseManager
14	com.sapienter.jbilling.server.item.tasks.IPricing
17	com.sapienter.jbilling.server.system.event.task.IInternalEventsTask
19	com.sapienter.jbilling.server.user.tasks.IValidatePurchaseTask
20	com.sapienter.jbilling.server.process.task.IBillingProcessFilterTask
22	com.sapienter.jbilling.server.process.task.IScheduledTask
23	com.sapienter.jbilling.server.rule.task.IRulesGenerator
24	com.sapienter.jbilling.server.process.task.IAgeingTask
15	com.sapienter.jbilling.server.mediation.task.IMediationReader
16	com.sapienter.jbilling.server.mediation.task.IMediationProcess
21	com.sapienter.jbilling.server.mediation.task.IMediationErrorHandler
25	com.sapienter.jbilling.server.user.partner.task.IPartnerCommissionTask
26	com.sapienter.jbilling.server.process.task.IFileExchangeTask
\.


--
-- TOC entry 3956 (class 0 OID 265198)
-- Dependencies: 344
-- Data for Name: preference; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY preference (id, type_id, table_id, foreign_id, value) FROM stdin;
10	14	5	10	1
11	18	5	10	
12	19	5	10	1
\.


--
-- TOC entry 3957 (class 0 OID 265201)
-- Dependencies: 345
-- Data for Name: preference_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY preference_type (id, def_value, validation_rule_id) FROM stdin;
4	\N	\N
13	\N	\N
14	\N	\N
15	\N	\N
16	\N	\N
17	\N	\N
18	\N	\N
19	1	\N
20	1	\N
21	0	\N
22	\N	\N
23	\N	\N
24	0	\N
25	0	\N
27	0	\N
28	\N	\N
29	https://www.paypal.com/en_US/i/btn/x-click-but6.gif	\N
30	\N	\N
32	0	\N
33	0	\N
35	0	\N
36	1	\N
38	1	\N
41	0	\N
43	0	\N
44	0	\N
45	0	\N
46	0	\N
49	\N	\N
50	2	\N
51	0	\N
52	0	\N
53	0	\N
31		\N
55	0	\N
63	0	\N
61	INVOICE	\N
64	realm	\N
65	0	\N
66	0	\N
67	1	\N
68	0	\N
71	24	\N
75	0	\N
39	0	1
40	0	2
76	10	4
999	\N	\N
\.


--
-- TOC entry 3958 (class 0 OID 265204)
-- Dependencies: 346
-- Data for Name: price_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY price_map (id, map_group, origin_zone, dest_zone, zone_result, time_result, price_group, description, rate_price, setup_price, deleted, rating_type, price_map_plan, created_date, start_date, end_date, last_updated_date, entity_id) FROM stdin;
\.


--
-- TOC entry 3959 (class 0 OID 265210)
-- Dependencies: 347
-- Data for Name: price_model; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY price_model (id, price_model, qty_step, tier_from, tier_to, beat, factor, charge_base, deleted, price_plan, created_date, last_updated_date, entity_id) FROM stdin;
\.


--
-- TOC entry 3960 (class 0 OID 265216)
-- Dependencies: 348
-- Data for Name: price_package; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY price_package (id, package_code, description, created_date, active_until, category, entity_id, optlock, deleted, active_since, mbg_days) FROM stdin;
\.


--
-- TOC entry 3961 (class 0 OID 265219)
-- Dependencies: 349
-- Data for Name: process_run; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY process_run (id, process_id, run_date, started, finished, payment_finished, invoices_generated, optlock, status_id) FROM stdin;
\.


--
-- TOC entry 3962 (class 0 OID 265222)
-- Dependencies: 350
-- Data for Name: process_run_total; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY process_run_total (id, process_run_id, currency_id, total_invoiced, total_paid, total_not_paid, optlock) FROM stdin;
\.


--
-- TOC entry 3963 (class 0 OID 265225)
-- Dependencies: 351
-- Data for Name: process_run_total_pm; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY process_run_total_pm (id, process_run_total_id, payment_method_id, total, optlock) FROM stdin;
\.


--
-- TOC entry 3964 (class 0 OID 265228)
-- Dependencies: 352
-- Data for Name: process_run_user; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY process_run_user (id, process_run_id, user_id, status, created, optlock) FROM stdin;
\.


--
-- TOC entry 3965 (class 0 OID 265231)
-- Dependencies: 353
-- Data for Name: product_charge; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY product_charge (id, item_id, created_date, charge_type, deleted, tax_code) FROM stdin;
\.


--
-- TOC entry 3966 (class 0 OID 265235)
-- Dependencies: 354
-- Data for Name: product_charge_rate; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY product_charge_rate (id, charge_id, currency_id, fixed_amount, scaled_amount, unit_id, dependee_id, rum_id, last_modified, optlock, deleted, salience, destination_map_id) FROM stdin;
\.


--
-- TOC entry 3967 (class 0 OID 265238)
-- Dependencies: 355
-- Data for Name: promotion; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY promotion (id, item_id, code, notes, once, since, until) FROM stdin;
\.


--
-- TOC entry 3968 (class 0 OID 265241)
-- Dependencies: 356
-- Data for Name: promotion_user_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY promotion_user_map (user_id, promotion_id) FROM stdin;
\.


--
-- TOC entry 3969 (class 0 OID 265244)
-- Dependencies: 357
-- Data for Name: provisioning_tag; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY provisioning_tag (id, code, level, parent_id, deleted) FROM stdin;
\.


--
-- TOC entry 3970 (class 0 OID 265248)
-- Dependencies: 358
-- Data for Name: provisioning_tag_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY provisioning_tag_map (id, item_id, tag_id, level, parent_id, deleted) FROM stdin;
\.


--
-- TOC entry 3971 (class 0 OID 265253)
-- Dependencies: 359
-- Data for Name: provisioning_tag_map_info; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY provisioning_tag_map_info (id, map_id, parameter) FROM stdin;
\.


--
-- TOC entry 3972 (class 0 OID 265257)
-- Dependencies: 360
-- Data for Name: purchase_order; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY purchase_order (id, user_id, period_id, billing_type_id, active_since, active_until, cycle_start, create_datetime, next_billable_day, created_by, status_id, currency_id, deleted, notify, last_notified, notification_step, due_date_unit_id, due_date_value, df_fm, anticipate_periods, own_invoice, notes, notes_in_invoice, optlock, primary_order_id, prorate_flag, parent_order_id, cancellation_fee_type, cancellation_fee, cancellation_fee_percentage, cancellation_maximum_fee, cancellation_minimum_period, reseller_order, free_usage_quantity, deleted_date) FROM stdin;
\.


--
-- TOC entry 3973 (class 0 OID 265262)
-- Dependencies: 361
-- Data for Name: purchased_bundle; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY purchased_bundle (id, bundle_id, status_id, valid_from, valid_to, update_datetime, created_datetime, user_id) FROM stdin;
\.


--
-- TOC entry 3974 (class 0 OID 265265)
-- Dependencies: 362
-- Data for Name: purchased_bundle_product; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY purchased_bundle_product (id, pb_id, product_id, recurring_charge, recurring_discount, recurring_start_time, recurring_end_time, oneoff_charge, oneoff_discount, oneoff_start_time, oneoff_end_time, usage_charge, usage_discount, usage_start_time, usage_end_time, cancel_charge, cancel_discount, cancel_start_time, cancel_end_time, oneoff_order_id, recurring_order_id, cancel_order_id) FROM stdin;
\.


--
-- TOC entry 3975 (class 0 OID 265268)
-- Dependencies: 363
-- Data for Name: rate; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY rate (id, prefix, destination, version, deleted, flat_rate, conn_charge, scaled_rate, rate_plan, created_date, valid_from, valid_to, last_updated_date, rate_type, entity_id) FROM stdin;
\.


--
-- TOC entry 3976 (class 0 OID 265273)
-- Dependencies: 364
-- Data for Name: rate_dependee; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY rate_dependee (id, currency_id, min_balance, max_balance, dependency_type, optlock) FROM stdin;
\.


--
-- TOC entry 3977 (class 0 OID 265276)
-- Dependencies: 365
-- Data for Name: rate_dependency_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY rate_dependency_type (id, type) FROM stdin;
\.


--
-- TOC entry 3978 (class 0 OID 265279)
-- Dependencies: 366
-- Data for Name: rating_event_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY rating_event_type (id, entity_id, event_name, optlock) FROM stdin;
\.


--
-- TOC entry 3979 (class 0 OID 265283)
-- Dependencies: 367
-- Data for Name: rating_unit; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY rating_unit (id, name, entity_id, price_unit_name, increment_unit_name, increment_unit_quantity, can_be_deleted, optlock) FROM stdin;
\.


--
-- TOC entry 3980 (class 0 OID 265287)
-- Dependencies: 368
-- Data for Name: recent_item; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY recent_item (id, type, object_id, user_id, version) FROM stdin;
3	PRODUCT	201	10	0
4	PLUGIN	33	10	0
5	PLUGIN	34	10	0
6	PLUGIN	33	10	0
7	PLUGIN	34	10	0
\.


--
-- TOC entry 3981 (class 0 OID 265290)
-- Dependencies: 369
-- Data for Name: report; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY report (id, type_id, name, file_name, optlock) FROM stdin;
1	1	total_invoiced	total_invoiced.jasper	0
2	1	ageing_balance	ageing_balance.jasper	0
3	2	product_subscribers	product_subscribers.jasper	0
4	3	total_payments	total_payments.jasper	0
5	4	user_signups	user_signups.jasper	0
6	4	top_customers	top_customers.jasper	0
7	1	accounts_receivable	accounts_receivable.jasper	0
8	1	gl_detail	gl_detail.jasper	0
9	1	gl_summary	gl_summary.jasper	0
11	4	total_invoiced_per_customer	total_invoiced_per_customer.jasper	0
12	4	total_invoiced_per_customer_over_years	total_invoiced_per_customer_over_years.jasper	0
13	4	user_activity	user_activity.jasper	0
\.


--
-- TOC entry 3982 (class 0 OID 265296)
-- Dependencies: 370
-- Data for Name: report_parameter; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY report_parameter (id, report_id, dtype, name) FROM stdin;
1	1	date	start_date
2	1	date	end_date
3	1	integer	period
4	3	integer	item_id
5	4	date	start_date
6	4	date	end_date
7	4	integer	period
8	5	date	start_date
9	5	date	end_date
10	5	integer	period
11	6	date	start_date
12	6	date	end_date
13	8	date	date
14	9	date	date
18	11	date	start_date
19	11	date	end_date
20	12	string	start_year
21	12	string	end_year
22	13	integer	activity_days
23	13	string	active_status
24	13	string	order_by
\.


--
-- TOC entry 3983 (class 0 OID 265299)
-- Dependencies: 371
-- Data for Name: report_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY report_type (id, name, optlock) FROM stdin;
1	invoice	0
2	order	0
3	payment	0
4	user	0
\.


--
-- TOC entry 3984 (class 0 OID 265302)
-- Dependencies: 372
-- Data for Name: reseller_entityid_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY reseller_entityid_map (entity_id, user_id) FROM stdin;
\.


--
-- TOC entry 3985 (class 0 OID 265305)
-- Dependencies: 373
-- Data for Name: reserved_amounts; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY reserved_amounts (id, session_id, ts_created, currency_id, reserved_amount, item_id, data, quantity) FROM stdin;
\.


--
-- TOC entry 3986 (class 0 OID 265311)
-- Dependencies: 374
-- Data for Name: reset_password_code; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY reset_password_code (base_user_id, date_created, token, new_password) FROM stdin;
10	2018-10-25 17:20:56.147	qx82c528pngfHHfSdv6aDJSGWORbEkUm	\N
\.


--
-- TOC entry 3987 (class 0 OID 265314)
-- Dependencies: 375
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY role (id, entity_id, role_type_id) FROM stdin;
2	\N	2
3	\N	3
4	\N	4
5	\N	5
60	10	2
61	10	3
62	10	5
63	10	4
\.


--
-- TOC entry 3988 (class 0 OID 265317)
-- Dependencies: 376
-- Data for Name: route; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY route (id, name, table_name, entity_id, optlock, root_table, output_field_name, default_route, route_table) FROM stdin;
\.


--
-- TOC entry 3989 (class 0 OID 265325)
-- Dependencies: 377
-- Data for Name: rum_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY rum_map (id, price_group, step, price_model, rum, resource, resource_id, rum_type, consume_flag, deleted, rummap_plan, created_date, last_updated_date, entity_id) FROM stdin;
\.


--
-- TOC entry 3990 (class 0 OID 265329)
-- Dependencies: 378
-- Data for Name: rum_type; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY rum_type (id, type) FROM stdin;
\.


--
-- TOC entry 3991 (class 0 OID 265332)
-- Dependencies: 379
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY schedule (id, subject, period_id, user_id, status_id, created_datetime, active_since, active_until, date_of_event, last_update_time, entity_id, user_name) FROM stdin;
\.


--
-- TOC entry 3992 (class 0 OID 265335)
-- Dependencies: 380
-- Data for Name: schedule_action; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY schedule_action (id, schedule_id, status_id, type_id, plugin_id, action_period_id) FROM stdin;
\.


--
-- TOC entry 3993 (class 0 OID 265338)
-- Dependencies: 381
-- Data for Name: schedule_action_param; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY schedule_action_param (id, schedule_action_id, name, value) FROM stdin;
\.


--
-- TOC entry 3994 (class 0 OID 265346)
-- Dependencies: 382
-- Data for Name: scheduler_status; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY scheduler_status (id, type) FROM stdin;
\.


--
-- TOC entry 3995 (class 0 OID 265349)
-- Dependencies: 383
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY service (id, user_id, login, password, status_id, create_datetime, order_id, order_line_id, name, service_type, deleted, optlock) FROM stdin;
\.


--
-- TOC entry 3996 (class 0 OID 265357)
-- Dependencies: 384
-- Data for Name: service_alias; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY service_alias (id, service_id, alias_name, created_date, last_updated_date, deleted) FROM stdin;
\.


--
-- TOC entry 3997 (class 0 OID 265361)
-- Dependencies: 385
-- Data for Name: service_feature; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY service_feature (id, service_id, prov_tag_map_id, deleted, parent_id, level, status_id) FROM stdin;
\.


--
-- TOC entry 3998 (class 0 OID 265364)
-- Dependencies: 386
-- Data for Name: service_feature_info; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY service_feature_info (id, service_feature_id, parameter) FROM stdin;
\.


--
-- TOC entry 3999 (class 0 OID 265368)
-- Dependencies: 387
-- Data for Name: service_site; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY service_site (id, service_id, site_addr, created_date, last_updated_date, deleted) FROM stdin;
\.


--
-- TOC entry 4000 (class 0 OID 265375)
-- Dependencies: 388
-- Data for Name: shortcut; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY shortcut (id, user_id, controller, action, name, object_id, version) FROM stdin;
\.


--
-- TOC entry 4001 (class 0 OID 265381)
-- Dependencies: 389
-- Data for Name: support_ticket; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY support_ticket (id, subject, user_id, assigned_user_id, status_id, created_datetime, last_modified) FROM stdin;
\.


--
-- TOC entry 4002 (class 0 OID 265384)
-- Dependencies: 390
-- Data for Name: sure_tax_txn_log; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY sure_tax_txn_log (id, txn_id, txn_type, txn_data, txn_date, resp_trans_id, request_type) FROM stdin;
\.


--
-- TOC entry 4003 (class 0 OID 265390)
-- Dependencies: 391
-- Data for Name: tab; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY tab (id, message_code, controller_name, access_url, required_role, version, default_order) FROM stdin;
1	menu.link.customers	customer	/customer/list		1	1
2	menu.link.partners	partner	/partner/list		1	2
3	menu.link.invoices	invoice	/invoice/list		1	3
4	menu.link.payments.refunds	payment	/payment/list		1	4
5	menu.link.orders	order	/order/list		1	5
6	menu.link.billing	billing	/billing/list		1	6
8	menu.link.reports	report	/report/list		1	8
9	menu.link.products	product	/product/list		1	10
11	menu.link.configuration	config	/config/index		1	12
12	menu.link.discounts	discount	/discount/list		1	9
16	menu.link.voucher	voucher	/voucher/list	 	1	16
17	menu.link.support	CRM	/crm/list	 	1	17
18	menu.link.devices	device	/device/list	 	1	18
19	menu.link.bundles	bundle	/bundle/list	 	1	19
20	menu.link.openrate	openRate	/openrate/list	 	1	20
21	menu.link.subscription	subscription	/subscription/list	 	1	21
22	menu.link.mediation	mediation	/mediation/list	 	1	22
\.


--
-- TOC entry 4004 (class 0 OID 265393)
-- Dependencies: 392
-- Data for Name: tab_configuration; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY tab_configuration (id, user_id, version) FROM stdin;
\.


--
-- TOC entry 4005 (class 0 OID 265396)
-- Dependencies: 393
-- Data for Name: tab_configuration_tab; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY tab_configuration_tab (id, tab_id, tab_configuration_id, display_order, visible, version) FROM stdin;
\.


--
-- TOC entry 4006 (class 0 OID 265399)
-- Dependencies: 394
-- Data for Name: tax_code; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY tax_code (id, tax_code, country, rate) FROM stdin;
\.


--
-- TOC entry 4007 (class 0 OID 265405)
-- Dependencies: 395
-- Data for Name: ticket_details; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY ticket_details (created_datetime, ticket_id, ticket_body, id) FROM stdin;
\.


--
-- TOC entry 4008 (class 0 OID 265408)
-- Dependencies: 396
-- Data for Name: ticket_status; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY ticket_status (id, type) FROM stdin;
1	New
2	Open
3	Closed
\.


--
-- TOC entry 4009 (class 0 OID 265411)
-- Dependencies: 397
-- Data for Name: uploadcdr; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY uploadcdr (name, date, status, type, id) FROM stdin;
\.


--
-- TOC entry 4010 (class 0 OID 265414)
-- Dependencies: 398
-- Data for Name: usage_bals; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY usage_bals (user_id, currency_id, plan_id, valid_from, valid_to, balance) FROM stdin;
\.


--
-- TOC entry 4011 (class 0 OID 265417)
-- Dependencies: 399
-- Data for Name: usage_monitor; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY usage_monitor (id, resource_id, thershold, entity_id) FROM stdin;
\.


--
-- TOC entry 4012 (class 0 OID 265420)
-- Dependencies: 400
-- Data for Name: usage_monitor_filter; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY usage_monitor_filter (id, "user", used, resource_id) FROM stdin;
\.


--
-- TOC entry 4013 (class 0 OID 265424)
-- Dependencies: 401
-- Data for Name: user_balance; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY user_balance (id, user_id, active_since, active_until, create_datetime, currency_id, deleted, optlock, balance, order_id, order_line_id) FROM stdin;
\.


--
-- TOC entry 4014 (class 0 OID 265427)
-- Dependencies: 402
-- Data for Name: user_code; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY user_code (id, user_id, identifier, external_ref, type, type_desc, valid_from, valid_to) FROM stdin;
\.


--
-- TOC entry 4015 (class 0 OID 265430)
-- Dependencies: 403
-- Data for Name: user_code_link; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY user_code_link (id, user_code_id, object_type, object_id) FROM stdin;
\.


--
-- TOC entry 4017 (class 0 OID 265435)
-- Dependencies: 405
-- Data for Name: user_credit_card_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY user_credit_card_map (user_id, credit_card_id, id) FROM stdin;
\.


--
-- TOC entry 4039 (class 0 OID 0)
-- Dependencies: 404
-- Name: user_credit_card_map_id_seq; Type: SEQUENCE SET; Schema: public; Owner: openbrm_demo
--

SELECT pg_catalog.setval('user_credit_card_map_id_seq', 1, false);


--
-- TOC entry 4018 (class 0 OID 265439)
-- Dependencies: 406
-- Data for Name: user_device; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY user_device (id, user_id, device_id, created_date, last_updated_date, order_id, order_line_id, telephone_number, ip, deleted, optlock, ext_id1, status_id) FROM stdin;
\.


--
-- TOC entry 4019 (class 0 OID 265443)
-- Dependencies: 407
-- Data for Name: user_password_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY user_password_map (id, base_user_id, date_created, new_password) FROM stdin;
\.


--
-- TOC entry 4020 (class 0 OID 265449)
-- Dependencies: 408
-- Data for Name: user_role_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY user_role_map (user_id, role_id) FROM stdin;
10	60
\.


--
-- TOC entry 4021 (class 0 OID 265452)
-- Dependencies: 409
-- Data for Name: user_status; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY user_status (id, can_login) FROM stdin;
1	1
\.


--
-- TOC entry 4022 (class 0 OID 265455)
-- Dependencies: 410
-- Data for Name: validation_rule; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY validation_rule (id, rule_type, enabled, optlock) FROM stdin;
1	RANGE	t	0
2	RANGE	t	0
3	RANGE	t	0
4	RANGE	t	0
10	PAYMENT_CARD	t	0
11	REGEX	t	0
12	REGEX	t	0
\.


--
-- TOC entry 4023 (class 0 OID 265458)
-- Dependencies: 411
-- Data for Name: validation_rule_attributes; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY validation_rule_attributes (validation_rule_id, attribute_name, attribute_value) FROM stdin;
1	minRange	0
1	maxRange	7
2	minRange	0
2	maxRange	91
3	minRange	0
3	maxRange	91
4	minRange	0
4	maxRange	600000
11	regularExpression	(?:0[1-9]|1[0-2])/[0-9]{4}
12	regularExpression	(?<=\\s|^)\\d+(?=\\s|$)
\.


--
-- TOC entry 4024 (class 0 OID 265464)
-- Dependencies: 412
-- Data for Name: voucher; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY voucher (id, created_datetime, last_modified, status_id, entity_id, serial_no, pin_code, batch_id, product_id) FROM stdin;
\.


--
-- TOC entry 4025 (class 0 OID 265467)
-- Dependencies: 413
-- Data for Name: world_zone_map; Type: TABLE DATA; Schema: public; Owner: openbrm_demo
--

COPY world_zone_map (map_group, tier_code, world_zone, id) FROM stdin;
\.


--
-- TOC entry 2960 (class 2606 OID 265474)
-- Name: account_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY account_type
    ADD CONSTRAINT account_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2962 (class 2606 OID 265476)
-- Name: ach_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY ach
    ADD CONSTRAINT ach_pkey PRIMARY KEY (id);


--
-- TOC entry 2964 (class 2606 OID 265478)
-- Name: advance_rated_cdr_record_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY advance_rated_cdr_record
    ADD CONSTRAINT advance_rated_cdr_record_pkey PRIMARY KEY (id);


--
-- TOC entry 2966 (class 2606 OID 265480)
-- Name: ageing_entity_step_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY ageing_entity_step
    ADD CONSTRAINT ageing_entity_step_pkey PRIMARY KEY (id);


--
-- TOC entry 2972 (class 2606 OID 265482)
-- Name: asset_assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY asset_assignment
    ADD CONSTRAINT asset_assignment_pkey PRIMARY KEY (id);


--
-- TOC entry 2974 (class 2606 OID 265484)
-- Name: asset_entity_map_uc_1; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY asset_entity_map
    ADD CONSTRAINT asset_entity_map_uc_1 UNIQUE (asset_id, entity_id);


--
-- TOC entry 2970 (class 2606 OID 265486)
-- Name: asset_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY asset
    ADD CONSTRAINT asset_pkey PRIMARY KEY (id);


--
-- TOC entry 2977 (class 2606 OID 265488)
-- Name: asset_reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY asset_reservation
    ADD CONSTRAINT asset_reservation_pkey PRIMARY KEY (id);


--
-- TOC entry 2979 (class 2606 OID 265490)
-- Name: asset_status_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY asset_status
    ADD CONSTRAINT asset_status_pkey PRIMARY KEY (id);


--
-- TOC entry 2981 (class 2606 OID 265492)
-- Name: asset_transition_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY asset_transition
    ADD CONSTRAINT asset_transition_pkey PRIMARY KEY (id);


--
-- TOC entry 2983 (class 2606 OID 265494)
-- Name: base_user_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY base_user
    ADD CONSTRAINT base_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2988 (class 2606 OID 265496)
-- Name: batch_job_execution_context_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY batch_job_execution_context
    ADD CONSTRAINT batch_job_execution_context_pkey PRIMARY KEY (job_execution_id);


--
-- TOC entry 2986 (class 2606 OID 265498)
-- Name: batch_job_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY batch_job_execution
    ADD CONSTRAINT batch_job_execution_pkey PRIMARY KEY (job_execution_id);


--
-- TOC entry 2990 (class 2606 OID 265500)
-- Name: batch_job_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY batch_job_instance
    ADD CONSTRAINT batch_job_instance_pkey PRIMARY KEY (job_instance_id);


--
-- TOC entry 2996 (class 2606 OID 265502)
-- Name: batch_step_execution_context_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY batch_step_execution_context
    ADD CONSTRAINT batch_step_execution_context_pkey PRIMARY KEY (step_execution_id);


--
-- TOC entry 2994 (class 2606 OID 265504)
-- Name: batch_step_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY batch_step_execution
    ADD CONSTRAINT batch_step_execution_pkey PRIMARY KEY (step_execution_id);


--
-- TOC entry 3000 (class 2606 OID 265506)
-- Name: billing_process_config_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY billing_process_configuration
    ADD CONSTRAINT billing_process_config_pkey PRIMARY KEY (id);


--
-- TOC entry 3002 (class 2606 OID 265508)
-- Name: billing_process_failed_user_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY billing_process_failed_user
    ADD CONSTRAINT billing_process_failed_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2992 (class 2606 OID 265510)
-- Name: billing_process_info_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY batch_process_info
    ADD CONSTRAINT billing_process_info_pkey PRIMARY KEY (id);


--
-- TOC entry 2998 (class 2606 OID 265512)
-- Name: billing_process_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY billing_process
    ADD CONSTRAINT billing_process_pkey PRIMARY KEY (id);


--
-- TOC entry 3004 (class 2606 OID 265514)
-- Name: blacklist_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY blacklist
    ADD CONSTRAINT blacklist_pkey PRIMARY KEY (id);


--
-- TOC entry 3008 (class 2606 OID 265516)
-- Name: breadcrumb_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY breadcrumb
    ADD CONSTRAINT breadcrumb_pkey PRIMARY KEY (id);


--
-- TOC entry 3010 (class 2606 OID 265518)
-- Name: bulk_notification_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY bulk_notification_type
    ADD CONSTRAINT bulk_notification_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3012 (class 2606 OID 265520)
-- Name: bundle_meta_field_map_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY bundle_meta_field_map
    ADD CONSTRAINT bundle_meta_field_map_pkey PRIMARY KEY (bundle_id);


--
-- TOC entry 3014 (class 2606 OID 265522)
-- Name: c_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY c_rate
    ADD CONSTRAINT c_rate_pkey PRIMARY KEY (id);


--
-- TOC entry 3016 (class 2606 OID 265524)
-- Name: cdrentries_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY cdrentries
    ADD CONSTRAINT cdrentries_pkey PRIMARY KEY (id);


--
-- TOC entry 3018 (class 2606 OID 265526)
-- Name: charge_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY charge_sessions
    ADD CONSTRAINT charge_sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 3020 (class 2606 OID 265528)
-- Name: charge_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY charge_type
    ADD CONSTRAINT charge_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3320 (class 2606 OID 265530)
-- Name: code; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY provisioning_tag
    ADD CONSTRAINT code UNIQUE (code);


--
-- TOC entry 3031 (class 2606 OID 265532)
-- Name: contact_map_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY contact_map
    ADD CONSTRAINT contact_map_pkey PRIMARY KEY (id);


--
-- TOC entry 3023 (class 2606 OID 265534)
-- Name: contact_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- TOC entry 3033 (class 2606 OID 265536)
-- Name: contact_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY contact_type
    ADD CONSTRAINT contact_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3035 (class 2606 OID 265538)
-- Name: country_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- TOC entry 3037 (class 2606 OID 265540)
-- Name: credit_card_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY credit_card
    ADD CONSTRAINT credit_card_pkey PRIMARY KEY (id);


--
-- TOC entry 3043 (class 2606 OID 265542)
-- Name: currency_entity_map_compositekey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY currency_entity_map
    ADD CONSTRAINT currency_entity_map_compositekey PRIMARY KEY (currency_id, entity_id);


--
-- TOC entry 3046 (class 2606 OID 265544)
-- Name: currency_exchange_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY currency_exchange
    ADD CONSTRAINT currency_exchange_pkey PRIMARY KEY (id);


--
-- TOC entry 3041 (class 2606 OID 265546)
-- Name: currency_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY currency
    ADD CONSTRAINT currency_pkey PRIMARY KEY (id);


--
-- TOC entry 3051 (class 2606 OID 265548)
-- Name: customer_account_info_type_timeline_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY customer_account_info_type_timeline
    ADD CONSTRAINT customer_account_info_type_timeline_pkey PRIMARY KEY (id);


--
-- TOC entry 3053 (class 2606 OID 265550)
-- Name: customer_account_info_type_timeline_uk; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY customer_account_info_type_timeline
    ADD CONSTRAINT customer_account_info_type_timeline_uk UNIQUE (customer_id, meta_field_value_id, account_info_type_id);


--
-- TOC entry 3055 (class 2606 OID 265552)
-- Name: customer_docs_id_key; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY customer_docs
    ADD CONSTRAINT customer_docs_id_key UNIQUE (id);


--
-- TOC entry 3058 (class 2606 OID 265554)
-- Name: customer_meta_field_map_compositekey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY customer_meta_field_map
    ADD CONSTRAINT customer_meta_field_map_compositekey PRIMARY KEY (customer_id, meta_field_value_id);


--
-- TOC entry 3048 (class 2606 OID 265556)
-- Name: customer_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);


--
-- TOC entry 3068 (class 2606 OID 265558)
-- Name: destination_map_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY destination_map
    ADD CONSTRAINT destination_map_pkey PRIMARY KEY (id);


--
-- TOC entry 3070 (class 2606 OID 265560)
-- Name: device_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY device
    ADD CONSTRAINT device_pkey PRIMARY KEY (id);


--
-- TOC entry 3072 (class 2606 OID 265562)
-- Name: device_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY device_type
    ADD CONSTRAINT device_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3076 (class 2606 OID 265564)
-- Name: discount_attribute_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY discount_attribute
    ADD CONSTRAINT discount_attribute_pkey PRIMARY KEY (discount_id, attribute_name);


--
-- TOC entry 3078 (class 2606 OID 265566)
-- Name: discount_line_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY discount_line
    ADD CONSTRAINT discount_line_pkey PRIMARY KEY (id);


--
-- TOC entry 3074 (class 2606 OID 265568)
-- Name: discount_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY discount
    ADD CONSTRAINT discount_pkey PRIMARY KEY (id);


--
-- TOC entry 3082 (class 2606 OID 265570)
-- Name: entity_delivery_method_map_compositekey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY entity_delivery_method_map
    ADD CONSTRAINT entity_delivery_method_map_compositekey PRIMARY KEY (method_id, entity_id);


--
-- TOC entry 3084 (class 2606 OID 265572)
-- Name: entity_payment_method_map_compositekey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY entity_payment_method_map
    ADD CONSTRAINT entity_payment_method_map_compositekey PRIMARY KEY (entity_id, payment_method_id);


--
-- TOC entry 3080 (class 2606 OID 265574)
-- Name: entity_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY entity
    ADD CONSTRAINT entity_pkey PRIMARY KEY (id);


--
-- TOC entry 3086 (class 2606 OID 265576)
-- Name: entity_report_map_compositekey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY entity_report_map
    ADD CONSTRAINT entity_report_map_compositekey PRIMARY KEY (report_id, entity_id);


--
-- TOC entry 2968 (class 2606 OID 265578)
-- Name: entity_step_days; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY ageing_entity_step
    ADD CONSTRAINT entity_step_days UNIQUE (entity_id, days);


--
-- TOC entry 3088 (class 2606 OID 265580)
-- Name: enumeration_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY enumeration
    ADD CONSTRAINT enumeration_pkey PRIMARY KEY (id);


--
-- TOC entry 3090 (class 2606 OID 265582)
-- Name: enumeration_values_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY enumeration_values
    ADD CONSTRAINT enumeration_values_pkey PRIMARY KEY (id);


--
-- TOC entry 3095 (class 2606 OID 265584)
-- Name: event_log_message_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY event_log_message
    ADD CONSTRAINT event_log_message_pkey PRIMARY KEY (id);


--
-- TOC entry 3097 (class 2606 OID 265586)
-- Name: event_log_module_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY event_log_module
    ADD CONSTRAINT event_log_module_pkey PRIMARY KEY (id);


--
-- TOC entry 3092 (class 2606 OID 265588)
-- Name: event_log_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY event_log
    ADD CONSTRAINT event_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3100 (class 2606 OID 265590)
-- Name: event_type_rate_map_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY event_type_rate_map
    ADD CONSTRAINT event_type_rate_map_pkey PRIMARY KEY (id);


--
-- TOC entry 3103 (class 2606 OID 265592)
-- Name: ex_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY ex_rate
    ADD CONSTRAINT ex_rate_pkey PRIMARY KEY (id);


--
-- TOC entry 3105 (class 2606 OID 265594)
-- Name: filter_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY filter
    ADD CONSTRAINT filter_pkey PRIMARY KEY (id);


--
-- TOC entry 3107 (class 2606 OID 265596)
-- Name: filter_set_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY filter_set
    ADD CONSTRAINT filter_set_pkey PRIMARY KEY (id);


--
-- TOC entry 3109 (class 2606 OID 265598)
-- Name: generic_status_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY generic_status
    ADD CONSTRAINT generic_status_pkey PRIMARY KEY (id);


--
-- TOC entry 3111 (class 2606 OID 265600)
-- Name: generic_status_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY generic_status_type
    ADD CONSTRAINT generic_status_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3114 (class 2606 OID 265602)
-- Name: international_description_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY international_description
    ADD CONSTRAINT international_description_pkey PRIMARY KEY (table_id, foreign_id, psudo_column, language_id);


--
-- TOC entry 3123 (class 2606 OID 265604)
-- Name: invoice_delivery_method_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY invoice_delivery_method
    ADD CONSTRAINT invoice_delivery_method_pkey PRIMARY KEY (id);


--
-- TOC entry 3125 (class 2606 OID 265606)
-- Name: invoice_line_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY invoice_line
    ADD CONSTRAINT invoice_line_pkey PRIMARY KEY (id);


--
-- TOC entry 3127 (class 2606 OID 265608)
-- Name: invoice_line_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY invoice_line_type
    ADD CONSTRAINT invoice_line_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3129 (class 2606 OID 265610)
-- Name: invoice_meta_field_map_compositekey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY invoice_meta_field_map
    ADD CONSTRAINT invoice_meta_field_map_compositekey PRIMARY KEY (invoice_id, meta_field_value_id);


--
-- TOC entry 3116 (class 2606 OID 265612)
-- Name: invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (id);


--
-- TOC entry 3134 (class 2606 OID 265614)
-- Name: item_dependency_pk; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY item_dependency
    ADD CONSTRAINT item_dependency_pk PRIMARY KEY (id);


--
-- TOC entry 3136 (class 2606 OID 265616)
-- Name: item_entity_map_uc_1; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY item_entity_map
    ADD CONSTRAINT item_entity_map_uc_1 UNIQUE (entity_id, item_id);


--
-- TOC entry 3138 (class 2606 OID 265618)
-- Name: item_meta_field_map_compositekey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY item_meta_field_map
    ADD CONSTRAINT item_meta_field_map_compositekey PRIMARY KEY (item_id, meta_field_value_id);


--
-- TOC entry 3131 (class 2606 OID 265620)
-- Name: item_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_pkey PRIMARY KEY (id);


--
-- TOC entry 3140 (class 2606 OID 265622)
-- Name: item_price_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY item_price
    ADD CONSTRAINT item_price_pkey PRIMARY KEY (id);


--
-- TOC entry 3144 (class 2606 OID 265624)
-- Name: item_type_exclude_map_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY item_type_exclude_map
    ADD CONSTRAINT item_type_exclude_map_pkey PRIMARY KEY (item_id, type_id);


--
-- TOC entry 3146 (class 2606 OID 265626)
-- Name: item_type_map_compositekey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY item_type_map
    ADD CONSTRAINT item_type_map_compositekey PRIMARY KEY (item_id, type_id);


--
-- TOC entry 3142 (class 2606 OID 265628)
-- Name: item_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY item_type
    ADD CONSTRAINT item_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3148 (class 2606 OID 265630)
-- Name: jbilling_seqs_pk; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY jbilling_seqs
    ADD CONSTRAINT jbilling_seqs_pk PRIMARY KEY (name);


--
-- TOC entry 3150 (class 2606 OID 265632)
-- Name: jbilling_table_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY jbilling_table
    ADD CONSTRAINT jbilling_table_pkey PRIMARY KEY (id);


--
-- TOC entry 3152 (class 2606 OID 265634)
-- Name: language_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY language
    ADD CONSTRAINT language_pkey PRIMARY KEY (id);


--
-- TOC entry 3154 (class 2606 OID 265636)
-- Name: matching_field_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY matching_field
    ADD CONSTRAINT matching_field_pkey PRIMARY KEY (id);


--
-- TOC entry 3157 (class 2606 OID 265638)
-- Name: mediation_cfg_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY mediation_cfg
    ADD CONSTRAINT mediation_cfg_pkey PRIMARY KEY (id);


--
-- TOC entry 3159 (class 2606 OID 265640)
-- Name: mediation_errors_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY mediation_errors
    ADD CONSTRAINT mediation_errors_pkey PRIMARY KEY (accountcode);


--
-- TOC entry 3164 (class 2606 OID 265642)
-- Name: mediation_process_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY mediation_process
    ADD CONSTRAINT mediation_process_pkey PRIMARY KEY (id);


--
-- TOC entry 3172 (class 2606 OID 265644)
-- Name: mediation_record_line_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY mediation_record_line
    ADD CONSTRAINT mediation_record_line_pkey PRIMARY KEY (id);


--
-- TOC entry 3169 (class 2606 OID 265646)
-- Name: mediation_record_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY mediation_record
    ADD CONSTRAINT mediation_record_pkey PRIMARY KEY (id);


--
-- TOC entry 3177 (class 2606 OID 265648)
-- Name: meta_field_name_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY meta_field_name
    ADD CONSTRAINT meta_field_name_pkey PRIMARY KEY (id);


--
-- TOC entry 3179 (class 2606 OID 265650)
-- Name: meta_field_value_id_key; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY meta_field_value
    ADD CONSTRAINT meta_field_value_id_key UNIQUE (id);


--
-- TOC entry 3175 (class 2606 OID 265652)
-- Name: metafield_group_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY meta_field_group
    ADD CONSTRAINT metafield_group_pkey PRIMARY KEY (id);


--
-- TOC entry 3181 (class 2606 OID 265654)
-- Name: notification_category_pk; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY notification_category
    ADD CONSTRAINT notification_category_pk PRIMARY KEY (id);


--
-- TOC entry 3185 (class 2606 OID 265656)
-- Name: notification_config_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY notification_config
    ADD CONSTRAINT notification_config_pkey PRIMARY KEY (id);


--
-- TOC entry 3187 (class 2606 OID 265658)
-- Name: notification_event_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY notification_event
    ADD CONSTRAINT notification_event_pkey PRIMARY KEY (id);


--
-- TOC entry 3203 (class 2606 OID 265660)
-- Name: notification_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY notification_type
    ADD CONSTRAINT notification_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3195 (class 2606 OID 265662)
-- Name: notifictn_msg_arch_line_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY notification_message_arch_line
    ADD CONSTRAINT notifictn_msg_arch_line_pkey PRIMARY KEY (id);


--
-- TOC entry 3193 (class 2606 OID 265664)
-- Name: notifictn_msg_arch_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY notification_message_arch
    ADD CONSTRAINT notifictn_msg_arch_pkey PRIMARY KEY (id);


--
-- TOC entry 3197 (class 2606 OID 265666)
-- Name: notifictn_msg_line_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY notification_message_line
    ADD CONSTRAINT notifictn_msg_line_pkey PRIMARY KEY (id);


--
-- TOC entry 3191 (class 2606 OID 265668)
-- Name: notifictn_msg_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY notification_message
    ADD CONSTRAINT notifictn_msg_pkey PRIMARY KEY (id);


--
-- TOC entry 3199 (class 2606 OID 265670)
-- Name: notifictn_msg_section_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY notification_message_section
    ADD CONSTRAINT notifictn_msg_section_pkey PRIMARY KEY (id);


--
-- TOC entry 3201 (class 2606 OID 265672)
-- Name: notifictn_msg_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY notification_message_type
    ADD CONSTRAINT notifictn_msg_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3205 (class 2606 OID 265674)
-- Name: ob_rated_cdr_record_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY ob_rated_cdr_record
    ADD CONSTRAINT ob_rated_cdr_record_pkey PRIMARY KEY (id);


--
-- TOC entry 3208 (class 2606 OID 265676)
-- Name: order_billing_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY order_billing_type
    ADD CONSTRAINT order_billing_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3211 (class 2606 OID 265678)
-- Name: order_change_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY order_change
    ADD CONSTRAINT order_change_pkey PRIMARY KEY (id);


--
-- TOC entry 3213 (class 2606 OID 265680)
-- Name: order_change_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY order_change_type
    ADD CONSTRAINT order_change_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3215 (class 2606 OID 265682)
-- Name: order_line_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY order_line
    ADD CONSTRAINT order_line_pkey PRIMARY KEY (id);


--
-- TOC entry 3217 (class 2606 OID 265684)
-- Name: order_line_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY order_line_type
    ADD CONSTRAINT order_line_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3219 (class 2606 OID 265686)
-- Name: order_meta_field_map_compositekey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY order_meta_field_map
    ADD CONSTRAINT order_meta_field_map_compositekey PRIMARY KEY (order_id, meta_field_value_id);


--
-- TOC entry 3221 (class 2606 OID 265688)
-- Name: order_period_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY order_period
    ADD CONSTRAINT order_period_pkey PRIMARY KEY (id);


--
-- TOC entry 3226 (class 2606 OID 265690)
-- Name: order_process_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY order_process
    ADD CONSTRAINT order_process_pkey PRIMARY KEY (id);


--
-- TOC entry 3228 (class 2606 OID 265692)
-- Name: order_status_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY order_status
    ADD CONSTRAINT order_status_pkey PRIMARY KEY (id);


--
-- TOC entry 3230 (class 2606 OID 265694)
-- Name: package_price_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY package_price
    ADD CONSTRAINT package_price_pkey PRIMARY KEY (id);


--
-- TOC entry 3232 (class 2606 OID 265696)
-- Name: package_price_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY package_price_type
    ADD CONSTRAINT package_price_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3234 (class 2606 OID 265698)
-- Name: package_product_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY package_product
    ADD CONSTRAINT package_product_pkey PRIMARY KEY (id);


--
-- TOC entry 3236 (class 2606 OID 265700)
-- Name: paper_invoice_batch_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY paper_invoice_batch
    ADD CONSTRAINT paper_invoice_batch_pkey PRIMARY KEY (id);


--
-- TOC entry 3240 (class 2606 OID 265702)
-- Name: partner_meta_field_map_compositekey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY partner_meta_field_map
    ADD CONSTRAINT partner_meta_field_map_compositekey PRIMARY KEY (partner_id, meta_field_value_id);


--
-- TOC entry 3242 (class 2606 OID 265704)
-- Name: partner_payout_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY partner_payout
    ADD CONSTRAINT partner_payout_pkey PRIMARY KEY (id);


--
-- TOC entry 3238 (class 2606 OID 265706)
-- Name: partner_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY partner
    ADD CONSTRAINT partner_pkey PRIMARY KEY (id);


--
-- TOC entry 3249 (class 2606 OID 265708)
-- Name: payment_authorization_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY payment_authorization
    ADD CONSTRAINT payment_authorization_pkey PRIMARY KEY (id);


--
-- TOC entry 3252 (class 2606 OID 265710)
-- Name: payment_info_cheque_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY payment_info_cheque
    ADD CONSTRAINT payment_info_cheque_pkey PRIMARY KEY (id);


--
-- TOC entry 3254 (class 2606 OID 265712)
-- Name: payment_information_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY payment_information
    ADD CONSTRAINT payment_information_pkey PRIMARY KEY (id);


--
-- TOC entry 3256 (class 2606 OID 265714)
-- Name: payment_instrument_info_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY payment_instrument_info
    ADD CONSTRAINT payment_instrument_info_pkey PRIMARY KEY (id);


--
-- TOC entry 3259 (class 2606 OID 265716)
-- Name: payment_invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY payment_invoice
    ADD CONSTRAINT payment_invoice_pkey PRIMARY KEY (id);


--
-- TOC entry 3261 (class 2606 OID 265718)
-- Name: payment_meta_field_map_compositekey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY payment_meta_field_map
    ADD CONSTRAINT payment_meta_field_map_compositekey PRIMARY KEY (payment_id, meta_field_value_id);


--
-- TOC entry 3263 (class 2606 OID 265720)
-- Name: payment_method_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY payment_method
    ADD CONSTRAINT payment_method_pkey PRIMARY KEY (id);


--
-- TOC entry 3265 (class 2606 OID 265722)
-- Name: payment_method_template_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY payment_method_template
    ADD CONSTRAINT payment_method_template_pkey PRIMARY KEY (id);


--
-- TOC entry 3267 (class 2606 OID 265724)
-- Name: payment_method_template_template_name_key; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY payment_method_template
    ADD CONSTRAINT payment_method_template_template_name_key UNIQUE (template_name);


--
-- TOC entry 3269 (class 2606 OID 265726)
-- Name: payment_method_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY payment_method_type
    ADD CONSTRAINT payment_method_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3246 (class 2606 OID 265728)
-- Name: payment_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- TOC entry 3271 (class 2606 OID 265730)
-- Name: payment_result_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY payment_result
    ADD CONSTRAINT payment_result_pkey PRIMARY KEY (id);


--
-- TOC entry 3273 (class 2606 OID 265732)
-- Name: period_unit_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY period_unit
    ADD CONSTRAINT period_unit_pkey PRIMARY KEY (id);


--
-- TOC entry 3275 (class 2606 OID 265734)
-- Name: permission_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3277 (class 2606 OID 265736)
-- Name: permission_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY permission_type
    ADD CONSTRAINT permission_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3281 (class 2606 OID 265738)
-- Name: permission_user_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY permission_user
    ADD CONSTRAINT permission_user_pkey PRIMARY KEY (id);


--
-- TOC entry 3060 (class 2606 OID 265740)
-- Name: pk_customer_notes; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY customer_notes
    ADD CONSTRAINT pk_customer_notes PRIMARY KEY (id);


--
-- TOC entry 3062 (class 2606 OID 265742)
-- Name: pk_data_table_query; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY data_table_query
    ADD CONSTRAINT pk_data_table_query PRIMARY KEY (id);


--
-- TOC entry 3064 (class 2606 OID 265744)
-- Name: pk_data_table_query_entry; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY data_table_query_entry
    ADD CONSTRAINT pk_data_table_query_entry PRIMARY KEY (id);


--
-- TOC entry 3066 (class 2606 OID 265746)
-- Name: pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- TOC entry 3189 (class 2606 OID 265748)
-- Name: pk_notification_medium_type; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY notification_medium_type
    ADD CONSTRAINT pk_notification_medium_type PRIMARY KEY (notification_id, medium_type);


--
-- TOC entry 3350 (class 2606 OID 265750)
-- Name: pk_rating_unit; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY rating_unit
    ADD CONSTRAINT pk_rating_unit PRIMARY KEY (id);


--
-- TOC entry 3362 (class 2606 OID 265752)
-- Name: pk_reset_password_code; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY reset_password_code
    ADD CONSTRAINT pk_reset_password_code PRIMARY KEY (token);


--
-- TOC entry 3412 (class 2606 OID 265754)
-- Name: pk_usage_monitor_filter; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY usage_monitor_filter
    ADD CONSTRAINT pk_usage_monitor_filter PRIMARY KEY (id);


--
-- TOC entry 3285 (class 2606 OID 265756)
-- Name: pluggable_task_parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY pluggable_task_parameter
    ADD CONSTRAINT pluggable_task_parameter_pkey PRIMARY KEY (id);


--
-- TOC entry 3283 (class 2606 OID 265758)
-- Name: pluggable_task_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY pluggable_task
    ADD CONSTRAINT pluggable_task_pkey PRIMARY KEY (id);


--
-- TOC entry 3289 (class 2606 OID 265760)
-- Name: pluggable_task_type_cat_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY pluggable_task_type_category
    ADD CONSTRAINT pluggable_task_type_cat_pkey PRIMARY KEY (id);


--
-- TOC entry 3287 (class 2606 OID 265762)
-- Name: pluggable_task_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY pluggable_task_type
    ADD CONSTRAINT pluggable_task_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3291 (class 2606 OID 265764)
-- Name: preference_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY preference
    ADD CONSTRAINT preference_pkey PRIMARY KEY (id);


--
-- TOC entry 3293 (class 2606 OID 265766)
-- Name: preference_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY preference_type
    ADD CONSTRAINT preference_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3295 (class 2606 OID 265768)
-- Name: price_map_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY price_map
    ADD CONSTRAINT price_map_pkey PRIMARY KEY (id);


--
-- TOC entry 3297 (class 2606 OID 265770)
-- Name: price_model_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY price_model
    ADD CONSTRAINT price_model_pkey PRIMARY KEY (id);


--
-- TOC entry 3299 (class 2606 OID 265772)
-- Name: price_package_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY price_package
    ADD CONSTRAINT price_package_pkey PRIMARY KEY (id);


--
-- TOC entry 3301 (class 2606 OID 265774)
-- Name: process_run_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY process_run
    ADD CONSTRAINT process_run_pkey PRIMARY KEY (id);


--
-- TOC entry 3303 (class 2606 OID 265776)
-- Name: process_run_total_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY process_run_total
    ADD CONSTRAINT process_run_total_pkey PRIMARY KEY (id);


--
-- TOC entry 3306 (class 2606 OID 265778)
-- Name: process_run_total_pm_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY process_run_total_pm
    ADD CONSTRAINT process_run_total_pm_pkey PRIMARY KEY (id);


--
-- TOC entry 3308 (class 2606 OID 265780)
-- Name: process_run_user_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY process_run_user
    ADD CONSTRAINT process_run_user_pkey PRIMARY KEY (id);


--
-- TOC entry 3310 (class 2606 OID 265782)
-- Name: product_charge_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY product_charge
    ADD CONSTRAINT product_charge_pkey PRIMARY KEY (id);


--
-- TOC entry 3312 (class 2606 OID 265784)
-- Name: product_charge_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY product_charge_rate
    ADD CONSTRAINT product_charge_rate_pkey PRIMARY KEY (id);


--
-- TOC entry 3315 (class 2606 OID 265786)
-- Name: promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY promotion
    ADD CONSTRAINT promotion_pkey PRIMARY KEY (id);


--
-- TOC entry 3317 (class 2606 OID 265788)
-- Name: promotion_user_map_compositekey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY promotion_user_map
    ADD CONSTRAINT promotion_user_map_compositekey PRIMARY KEY (user_id, promotion_id);


--
-- TOC entry 3326 (class 2606 OID 265790)
-- Name: provisioning_tag_map_info_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY provisioning_tag_map_info
    ADD CONSTRAINT provisioning_tag_map_info_pkey PRIMARY KEY (id);


--
-- TOC entry 3324 (class 2606 OID 265792)
-- Name: provisioning_tag_map_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY provisioning_tag_map
    ADD CONSTRAINT provisioning_tag_map_pkey PRIMARY KEY (id);


--
-- TOC entry 3322 (class 2606 OID 265794)
-- Name: provisioning_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY provisioning_tag
    ADD CONSTRAINT provisioning_tag_pkey PRIMARY KEY (id);


--
-- TOC entry 3331 (class 2606 OID 265796)
-- Name: purchase_order_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY purchase_order
    ADD CONSTRAINT purchase_order_pkey PRIMARY KEY (id);


--
-- TOC entry 3333 (class 2606 OID 265798)
-- Name: purchased_bundle_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY purchased_bundle
    ADD CONSTRAINT purchased_bundle_pkey PRIMARY KEY (id);


--
-- TOC entry 3335 (class 2606 OID 265800)
-- Name: purchased_bundle_product_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY purchased_bundle_product
    ADD CONSTRAINT purchased_bundle_product_pkey PRIMARY KEY (id);


--
-- TOC entry 3343 (class 2606 OID 265802)
-- Name: rate_dependee_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY rate_dependee
    ADD CONSTRAINT rate_dependee_pkey PRIMARY KEY (id);


--
-- TOC entry 3345 (class 2606 OID 265804)
-- Name: rate_dependency_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY rate_dependency_type
    ADD CONSTRAINT rate_dependency_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3340 (class 2606 OID 265806)
-- Name: rate_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY rate
    ADD CONSTRAINT rate_pkey PRIMARY KEY (id);


--
-- TOC entry 3348 (class 2606 OID 265808)
-- Name: rating_event_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY rating_event_type
    ADD CONSTRAINT rating_event_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3352 (class 2606 OID 265810)
-- Name: recent_item_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY recent_item
    ADD CONSTRAINT recent_item_pkey PRIMARY KEY (id);


--
-- TOC entry 3356 (class 2606 OID 265812)
-- Name: report_parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY report_parameter
    ADD CONSTRAINT report_parameter_pkey PRIMARY KEY (id);


--
-- TOC entry 3354 (class 2606 OID 265814)
-- Name: report_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY report
    ADD CONSTRAINT report_pkey PRIMARY KEY (id);


--
-- TOC entry 3358 (class 2606 OID 265816)
-- Name: report_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY report_type
    ADD CONSTRAINT report_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3360 (class 2606 OID 265818)
-- Name: reserved_amounts_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY reserved_amounts
    ADD CONSTRAINT reserved_amounts_pkey PRIMARY KEY (id);


--
-- TOC entry 3364 (class 2606 OID 265820)
-- Name: reset_password_code_base_user_id_key; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY reset_password_code
    ADD CONSTRAINT reset_password_code_base_user_id_key UNIQUE (base_user_id);


--
-- TOC entry 3366 (class 2606 OID 265822)
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- TOC entry 3368 (class 2606 OID 265824)
-- Name: route_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY route
    ADD CONSTRAINT route_pkey PRIMARY KEY (id);


--
-- TOC entry 3370 (class 2606 OID 265826)
-- Name: rum_map_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY rum_map
    ADD CONSTRAINT rum_map_pkey PRIMARY KEY (id);


--
-- TOC entry 3372 (class 2606 OID 265828)
-- Name: rum_type_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY rum_type
    ADD CONSTRAINT rum_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3378 (class 2606 OID 265830)
-- Name: schedule_action_param_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY schedule_action_param
    ADD CONSTRAINT schedule_action_param_pkey PRIMARY KEY (id);


--
-- TOC entry 3376 (class 2606 OID 265832)
-- Name: schedule_action_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY schedule_action
    ADD CONSTRAINT schedule_action_pkey PRIMARY KEY (id);


--
-- TOC entry 3374 (class 2606 OID 265834)
-- Name: schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (id);


--
-- TOC entry 3380 (class 2606 OID 265836)
-- Name: scheduler_status_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY scheduler_status
    ADD CONSTRAINT scheduler_status_pkey PRIMARY KEY (id);


--
-- TOC entry 3384 (class 2606 OID 265838)
-- Name: service_alias_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY service_alias
    ADD CONSTRAINT service_alias_pkey PRIMARY KEY (id);


--
-- TOC entry 3388 (class 2606 OID 265840)
-- Name: service_feature_info_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY service_feature_info
    ADD CONSTRAINT service_feature_info_pkey PRIMARY KEY (id);


--
-- TOC entry 3386 (class 2606 OID 265842)
-- Name: service_feature_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY service_feature
    ADD CONSTRAINT service_feature_pkey PRIMARY KEY (id);


--
-- TOC entry 3382 (class 2606 OID 265844)
-- Name: service_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY service
    ADD CONSTRAINT service_pkey PRIMARY KEY (id);


--
-- TOC entry 3390 (class 2606 OID 265846)
-- Name: service_site_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY service_site
    ADD CONSTRAINT service_site_pkey PRIMARY KEY (id);


--
-- TOC entry 3392 (class 2606 OID 265848)
-- Name: shortcut_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY shortcut
    ADD CONSTRAINT shortcut_pkey PRIMARY KEY (id);


--
-- TOC entry 3394 (class 2606 OID 265850)
-- Name: support_ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY support_ticket
    ADD CONSTRAINT support_ticket_pkey PRIMARY KEY (id);


--
-- TOC entry 3396 (class 2606 OID 265852)
-- Name: sure_tax_txn_log_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY sure_tax_txn_log
    ADD CONSTRAINT sure_tax_txn_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3400 (class 2606 OID 265854)
-- Name: tab_configuration_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY tab_configuration
    ADD CONSTRAINT tab_configuration_pkey PRIMARY KEY (id);


--
-- TOC entry 3402 (class 2606 OID 265856)
-- Name: tab_configuration_tab_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY tab_configuration_tab
    ADD CONSTRAINT tab_configuration_tab_pkey PRIMARY KEY (id);


--
-- TOC entry 3398 (class 2606 OID 265858)
-- Name: tab_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY tab
    ADD CONSTRAINT tab_pkey PRIMARY KEY (id);


--
-- TOC entry 3404 (class 2606 OID 265860)
-- Name: ticket_details_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY ticket_details
    ADD CONSTRAINT ticket_details_pkey PRIMARY KEY (id);


--
-- TOC entry 3406 (class 2606 OID 265862)
-- Name: ticket_status_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY ticket_status
    ADD CONSTRAINT ticket_status_pkey PRIMARY KEY (id);


--
-- TOC entry 3408 (class 2606 OID 265864)
-- Name: uploadcdr_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY uploadcdr
    ADD CONSTRAINT uploadcdr_pkey PRIMARY KEY (id);


--
-- TOC entry 3422 (class 2606 OID 265866)
-- Name: user_balance_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY user_balance
    ADD CONSTRAINT user_balance_pkey PRIMARY KEY (id);


--
-- TOC entry 3426 (class 2606 OID 265868)
-- Name: user_code_link_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY user_code_link
    ADD CONSTRAINT user_code_link_pkey PRIMARY KEY (id);


--
-- TOC entry 3424 (class 2606 OID 265870)
-- Name: user_code_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY user_code
    ADD CONSTRAINT user_code_pkey PRIMARY KEY (id);


--
-- TOC entry 3429 (class 2606 OID 265872)
-- Name: user_device_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY user_device
    ADD CONSTRAINT user_device_pkey PRIMARY KEY (id);


--
-- TOC entry 3431 (class 2606 OID 265874)
-- Name: user_password_map_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY user_password_map
    ADD CONSTRAINT user_password_map_pkey PRIMARY KEY (id);


--
-- TOC entry 3433 (class 2606 OID 265876)
-- Name: user_role_map_compositekey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY user_role_map
    ADD CONSTRAINT user_role_map_compositekey PRIMARY KEY (user_id, role_id);


--
-- TOC entry 3436 (class 2606 OID 265878)
-- Name: user_status_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY user_status
    ADD CONSTRAINT user_status_pkey PRIMARY KEY (id);


--
-- TOC entry 3438 (class 2606 OID 265880)
-- Name: validation_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY validation_rule
    ADD CONSTRAINT validation_rule_pkey PRIMARY KEY (id);


--
-- TOC entry 3440 (class 2606 OID 265882)
-- Name: voucher_pkey; Type: CONSTRAINT; Schema: public; Owner: openbrm_demo; Tablespace: 
--

ALTER TABLE ONLY voucher
    ADD CONSTRAINT voucher_pkey PRIMARY KEY (id);


--
-- TOC entry 2975 (class 1259 OID 265883)
-- Name: asset_reservation_end_date_index; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX asset_reservation_end_date_index ON asset_reservation USING btree (end_date);


--
-- TOC entry 3304 (class 1259 OID 265884)
-- Name: bp_pm_index_total; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX bp_pm_index_total ON process_run_total_pm USING btree (process_run_total_id);


--
-- TOC entry 3098 (class 1259 OID 265885)
-- Name: charge_rate_id; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX charge_rate_id ON event_type_rate_map USING btree (charge_rate_id, event_type_id);


--
-- TOC entry 3021 (class 1259 OID 265886)
-- Name: contact_i_del; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX contact_i_del ON contact USING btree (deleted);


--
-- TOC entry 3247 (class 1259 OID 265887)
-- Name: create_datetime; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX create_datetime ON payment_authorization USING btree (create_datetime);


--
-- TOC entry 3044 (class 1259 OID 265888)
-- Name: currency_entity_map_i_2; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX currency_entity_map_i_2 ON currency_entity_map USING btree (currency_id, entity_id);


--
-- TOC entry 3346 (class 1259 OID 265889)
-- Name: entity_id; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX entity_id ON rating_event_type USING btree (entity_id, event_name);


--
-- TOC entry 3409 (class 1259 OID 265890)
-- Name: id; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX id ON usage_monitor USING btree (id);


--
-- TOC entry 3165 (class 1259 OID 265891)
-- Name: id_key; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX id_key ON mediation_record USING btree (id_key, status_id);


--
-- TOC entry 3336 (class 1259 OID 265892)
-- Name: idx_ir_destination; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX idx_ir_destination ON rate USING btree (destination);


--
-- TOC entry 3337 (class 1259 OID 265893)
-- Name: idx_ir_prefix; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX idx_ir_prefix ON rate USING btree (prefix);


--
-- TOC entry 3338 (class 1259 OID 265894)
-- Name: idx_ir_valid_from; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX idx_ir_valid_from ON rate USING btree (valid_from);


--
-- TOC entry 3413 (class 1259 OID 265895)
-- Name: idx_ub_active_since; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX idx_ub_active_since ON user_balance USING btree (active_since);


--
-- TOC entry 3414 (class 1259 OID 265896)
-- Name: idx_ub_order_id; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX idx_ub_order_id ON user_balance USING btree (order_id);


--
-- TOC entry 3415 (class 1259 OID 265897)
-- Name: idx_ub_order_line_id; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX idx_ub_order_line_id ON user_balance USING btree (order_line_id);


--
-- TOC entry 3416 (class 1259 OID 265898)
-- Name: idx_ub_user_id; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX idx_ub_user_id ON user_balance USING btree (user_id);


--
-- TOC entry 3112 (class 1259 OID 265899)
-- Name: international_description_i_2; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX international_description_i_2 ON international_description USING btree (table_id, foreign_id, language_id);


--
-- TOC entry 2984 (class 1259 OID 265900)
-- Name: ix_base_user_un; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_base_user_un ON base_user USING btree (entity_id, user_name);


--
-- TOC entry 3005 (class 1259 OID 265901)
-- Name: ix_blacklist_entity_type; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_blacklist_entity_type ON blacklist USING btree (entity_id, type);


--
-- TOC entry 3006 (class 1259 OID 265902)
-- Name: ix_blacklist_user_type; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_blacklist_user_type ON blacklist USING btree (user_id, type);


--
-- TOC entry 3038 (class 1259 OID 265903)
-- Name: ix_cc_number; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_cc_number ON credit_card USING btree (cc_number_plain);


--
-- TOC entry 3039 (class 1259 OID 265904)
-- Name: ix_cc_number_encrypted; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_cc_number_encrypted ON credit_card USING btree (cc_number);


--
-- TOC entry 3024 (class 1259 OID 265905)
-- Name: ix_contact_address; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_contact_address ON contact USING btree (street_addres1, city, postal_code, street_addres2, state_province, country_code);


--
-- TOC entry 3025 (class 1259 OID 265906)
-- Name: ix_contact_fname; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_contact_fname ON contact USING btree (first_name);


--
-- TOC entry 3026 (class 1259 OID 265907)
-- Name: ix_contact_fname_lname; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_contact_fname_lname ON contact USING btree (first_name, last_name);


--
-- TOC entry 3027 (class 1259 OID 265908)
-- Name: ix_contact_lname; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_contact_lname ON contact USING btree (last_name);


--
-- TOC entry 3028 (class 1259 OID 265909)
-- Name: ix_contact_orgname; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_contact_orgname ON contact USING btree (organization_name);


--
-- TOC entry 3029 (class 1259 OID 265910)
-- Name: ix_contact_phone; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_contact_phone ON contact USING btree (phone_phone_number, phone_area_code, phone_country_code);


--
-- TOC entry 3093 (class 1259 OID 265911)
-- Name: ix_el_main; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_el_main ON event_log USING btree (module_id, message_id, create_datetime);


--
-- TOC entry 3117 (class 1259 OID 265912)
-- Name: ix_invoice_date; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_invoice_date ON invoice USING btree (create_datetime);


--
-- TOC entry 3118 (class 1259 OID 265913)
-- Name: ix_invoice_due_date; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_invoice_due_date ON invoice USING btree (user_id, due_date);


--
-- TOC entry 3119 (class 1259 OID 265914)
-- Name: ix_invoice_number; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_invoice_number ON invoice USING btree (user_id, public_number);


--
-- TOC entry 3120 (class 1259 OID 265915)
-- Name: ix_invoice_ts; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_invoice_ts ON invoice USING btree (create_timestamp, user_id);


--
-- TOC entry 3121 (class 1259 OID 265916)
-- Name: ix_invoice_user_id; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_invoice_user_id ON invoice USING btree (user_id, deleted);


--
-- TOC entry 3132 (class 1259 OID 265917)
-- Name: ix_item_ent; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_item_ent ON item USING btree (entity_id, internal_number);


--
-- TOC entry 3222 (class 1259 OID 265918)
-- Name: ix_order_process_in; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_order_process_in ON order_process USING btree (invoice_id);


--
-- TOC entry 3049 (class 1259 OID 265919)
-- Name: ix_parent_customer_id; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_parent_customer_id ON customer USING btree (parent_id);


--
-- TOC entry 3313 (class 1259 OID 265920)
-- Name: ix_promotion_code; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_promotion_code ON promotion USING btree (code);


--
-- TOC entry 3327 (class 1259 OID 265921)
-- Name: ix_purchase_order_date; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_purchase_order_date ON purchase_order USING btree (user_id, create_datetime);


--
-- TOC entry 3223 (class 1259 OID 265922)
-- Name: ix_uq_order_process_or_bp; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_uq_order_process_or_bp ON order_process USING btree (order_id, billing_process_id);


--
-- TOC entry 3224 (class 1259 OID 265923)
-- Name: ix_uq_order_process_or_in; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_uq_order_process_or_in ON order_process USING btree (order_id, invoice_id);


--
-- TOC entry 3257 (class 1259 OID 265924)
-- Name: ix_uq_payment_inv_map_pa_in; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX ix_uq_payment_inv_map_pa_in ON payment_invoice USING btree (payment_id, invoice_id);


--
-- TOC entry 3155 (class 1259 OID 265925)
-- Name: mediation_cfg_fk_1; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX mediation_cfg_fk_1 ON mediation_cfg USING btree (pluggable_task_id);


--
-- TOC entry 3160 (class 1259 OID 265926)
-- Name: mediation_order_map_fk_1; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX mediation_order_map_fk_1 ON mediation_order_map USING btree (mediation_process_id);


--
-- TOC entry 3161 (class 1259 OID 265927)
-- Name: mediation_order_map_fk_2; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX mediation_order_map_fk_2 ON mediation_order_map USING btree (order_id);


--
-- TOC entry 3162 (class 1259 OID 265928)
-- Name: mediation_process_fk_1; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX mediation_process_fk_1 ON mediation_process USING btree (configuration_id);


--
-- TOC entry 3166 (class 1259 OID 265929)
-- Name: mediation_record_fk_1; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX mediation_record_fk_1 ON mediation_record USING btree (mediation_process_id);


--
-- TOC entry 3167 (class 1259 OID 265930)
-- Name: mediation_record_fk_2; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX mediation_record_fk_2 ON mediation_record USING btree (status_id);


--
-- TOC entry 3170 (class 1259 OID 265931)
-- Name: mediation_record_line_fk_1; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX mediation_record_line_fk_1 ON mediation_record_line USING btree (mediation_record_id);


--
-- TOC entry 3182 (class 1259 OID 265932)
-- Name: notification_config_FK_1; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX "notification_config_FK_1" ON notification_config USING btree (event_id);


--
-- TOC entry 3183 (class 1259 OID 265933)
-- Name: notification_config_FK_2; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX "notification_config_FK_2" ON notification_config USING btree (message_id);


--
-- TOC entry 3209 (class 1259 OID 265934)
-- Name: order_change_idx_order_line; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX order_change_idx_order_line ON order_change USING btree (order_line_id);


--
-- TOC entry 3206 (class 1259 OID 265935)
-- Name: order_id_idx; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX order_id_idx ON ob_rated_cdr_record USING btree (order_id);


--
-- TOC entry 3173 (class 1259 OID 265936)
-- Name: order_line_id; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX order_line_id ON mediation_record_line USING btree (order_line_id);


--
-- TOC entry 3243 (class 1259 OID 265937)
-- Name: payment_i_2; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX payment_i_2 ON payment USING btree (user_id, create_datetime);


--
-- TOC entry 3244 (class 1259 OID 265938)
-- Name: payment_i_3; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX payment_i_3 ON payment USING btree (user_id, balance);


--
-- TOC entry 3278 (class 1259 OID 265939)
-- Name: permission_id; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX permission_id ON permission_user USING btree (permission_id, user_id);


--
-- TOC entry 3279 (class 1259 OID 265940)
-- Name: permission_user_fk_1; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX permission_user_fk_1 ON permission_user USING btree (user_id);


--
-- TOC entry 3318 (class 1259 OID 265941)
-- Name: promotion_user_map_i_2; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX promotion_user_map_i_2 ON promotion_user_map USING btree (user_id, promotion_id);


--
-- TOC entry 3328 (class 1259 OID 265942)
-- Name: purchase_order_i_notif; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX purchase_order_i_notif ON purchase_order USING btree (active_until, notification_step);


--
-- TOC entry 3329 (class 1259 OID 265943)
-- Name: purchase_order_i_user; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX purchase_order_i_user ON purchase_order USING btree (user_id, deleted);


--
-- TOC entry 3341 (class 1259 OID 265944)
-- Name: rate_dependee_FK1; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX "rate_dependee_FK1" ON rate_dependee USING btree (currency_id);


--
-- TOC entry 3410 (class 1259 OID 265945)
-- Name: resource_id_idx; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX resource_id_idx ON usage_monitor USING btree (resource_id);


--
-- TOC entry 3101 (class 1259 OID 265946)
-- Name: role_id; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX role_id ON event_type_rate_map USING btree (event_type_id);


--
-- TOC entry 3250 (class 1259 OID 265947)
-- Name: transaction_id; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX transaction_id ON payment_authorization USING btree (transaction_id);


--
-- TOC entry 3417 (class 1259 OID 265948)
-- Name: user_balance_fk_1; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX user_balance_fk_1 ON user_balance USING btree (currency_id);


--
-- TOC entry 3418 (class 1259 OID 265949)
-- Name: user_balance_fk_2; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX user_balance_fk_2 ON user_balance USING btree (user_id);


--
-- TOC entry 3419 (class 1259 OID 265950)
-- Name: user_balance_fk_3; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX user_balance_fk_3 ON user_balance USING btree (order_line_id);


--
-- TOC entry 3420 (class 1259 OID 265951)
-- Name: user_balance_fk_4; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX user_balance_fk_4 ON user_balance USING btree (order_id);


--
-- TOC entry 3427 (class 1259 OID 265952)
-- Name: user_credit_card_map_i_2; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX user_credit_card_map_i_2 ON user_credit_card_map USING btree (user_id, credit_card_id);


--
-- TOC entry 3056 (class 1259 OID 265953)
-- Name: user_id; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX user_id ON customer_docs USING btree (user_id);


--
-- TOC entry 3434 (class 1259 OID 265954)
-- Name: user_role_map_i_2; Type: INDEX; Schema: public; Owner: openbrm_demo; Tablespace: 
--

CREATE INDEX user_role_map_i_2 ON user_role_map USING btree (user_id, role_id);


--
-- TOC entry 3445 (class 2606 OID 265955)
-- Name: account_type_currency_id_FK; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY account_type
    ADD CONSTRAINT "account_type_currency_id_FK" FOREIGN KEY (currency_id) REFERENCES currency(id);


--
-- TOC entry 3444 (class 2606 OID 265960)
-- Name: account_type_entity_id_FK; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY account_type
    ADD CONSTRAINT "account_type_entity_id_FK" FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3443 (class 2606 OID 265965)
-- Name: account_type_language_id_FK; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY account_type
    ADD CONSTRAINT "account_type_language_id_FK" FOREIGN KEY (language_id) REFERENCES language(id);


--
-- TOC entry 3442 (class 2606 OID 265970)
-- Name: account_type_main_subscription_period_FK; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY account_type
    ADD CONSTRAINT "account_type_main_subscription_period_FK" FOREIGN KEY (main_subscript_order_period_id) REFERENCES order_period(id);


--
-- TOC entry 3446 (class 2606 OID 265975)
-- Name: ach_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY ach
    ADD CONSTRAINT ach_fk_1 FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3447 (class 2606 OID 265980)
-- Name: ageing_entity_step_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY ageing_entity_step
    ADD CONSTRAINT ageing_entity_step_fk_2 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3453 (class 2606 OID 265985)
-- Name: asset_assignment_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset_assignment
    ADD CONSTRAINT asset_assignment_fk_1 FOREIGN KEY (asset_id) REFERENCES asset(id);


--
-- TOC entry 3452 (class 2606 OID 265990)
-- Name: asset_assignment_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset_assignment
    ADD CONSTRAINT asset_assignment_fk_2 FOREIGN KEY (order_line_id) REFERENCES order_line(id);


--
-- TOC entry 3455 (class 2606 OID 265995)
-- Name: asset_entity_map_fk1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset_entity_map
    ADD CONSTRAINT asset_entity_map_fk1 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3454 (class 2606 OID 266000)
-- Name: asset_entity_map_fk2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset_entity_map
    ADD CONSTRAINT asset_entity_map_fk2 FOREIGN KEY (asset_id) REFERENCES asset(id);


--
-- TOC entry 3451 (class 2606 OID 266005)
-- Name: asset_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset
    ADD CONSTRAINT asset_fk_1 FOREIGN KEY (item_id) REFERENCES item(id);


--
-- TOC entry 3450 (class 2606 OID 266010)
-- Name: asset_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset
    ADD CONSTRAINT asset_fk_2 FOREIGN KEY (order_line_id) REFERENCES order_line(id);


--
-- TOC entry 3449 (class 2606 OID 266015)
-- Name: asset_fk_3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset
    ADD CONSTRAINT asset_fk_3 FOREIGN KEY (status_id) REFERENCES asset_status(id);


--
-- TOC entry 3448 (class 2606 OID 266020)
-- Name: asset_fk_4; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset
    ADD CONSTRAINT asset_fk_4 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3457 (class 2606 OID 266025)
-- Name: asset_meta_field_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset_meta_field_map
    ADD CONSTRAINT asset_meta_field_map_fk_1 FOREIGN KEY (asset_id) REFERENCES asset(id);


--
-- TOC entry 3456 (class 2606 OID 266030)
-- Name: asset_meta_field_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset_meta_field_map
    ADD CONSTRAINT asset_meta_field_map_fk_2 FOREIGN KEY (meta_field_value_id) REFERENCES meta_field_value(id);


--
-- TOC entry 3460 (class 2606 OID 266035)
-- Name: asset_reservation_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset_reservation
    ADD CONSTRAINT asset_reservation_fk_1 FOREIGN KEY (creator_user_id) REFERENCES base_user(id);


--
-- TOC entry 3459 (class 2606 OID 266040)
-- Name: asset_reservation_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset_reservation
    ADD CONSTRAINT asset_reservation_fk_2 FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3458 (class 2606 OID 266045)
-- Name: asset_reservation_fk_3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset_reservation
    ADD CONSTRAINT asset_reservation_fk_3 FOREIGN KEY (asset_id) REFERENCES asset(id);


--
-- TOC entry 3461 (class 2606 OID 266050)
-- Name: asset_status_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset_status
    ADD CONSTRAINT asset_status_fk_1 FOREIGN KEY (item_type_id) REFERENCES item_type(id);


--
-- TOC entry 3466 (class 2606 OID 266055)
-- Name: asset_transition_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset_transition
    ADD CONSTRAINT asset_transition_fk_1 FOREIGN KEY (assigned_to_id) REFERENCES base_user(id);


--
-- TOC entry 3465 (class 2606 OID 266060)
-- Name: asset_transition_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset_transition
    ADD CONSTRAINT asset_transition_fk_2 FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3464 (class 2606 OID 266065)
-- Name: asset_transition_fk_3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset_transition
    ADD CONSTRAINT asset_transition_fk_3 FOREIGN KEY (asset_id) REFERENCES asset(id);


--
-- TOC entry 3463 (class 2606 OID 266070)
-- Name: asset_transition_fk_4; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset_transition
    ADD CONSTRAINT asset_transition_fk_4 FOREIGN KEY (new_status_id) REFERENCES asset_status(id);


--
-- TOC entry 3462 (class 2606 OID 266075)
-- Name: asset_transition_fk_5; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY asset_transition
    ADD CONSTRAINT asset_transition_fk_5 FOREIGN KEY (previous_status_id) REFERENCES asset_status(id);


--
-- TOC entry 3470 (class 2606 OID 266080)
-- Name: base_user_fk_3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY base_user
    ADD CONSTRAINT base_user_fk_3 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3469 (class 2606 OID 266085)
-- Name: base_user_fk_4; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY base_user
    ADD CONSTRAINT base_user_fk_4 FOREIGN KEY (language_id) REFERENCES language(id);


--
-- TOC entry 3468 (class 2606 OID 266090)
-- Name: base_user_fk_5; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY base_user
    ADD CONSTRAINT base_user_fk_5 FOREIGN KEY (currency_id) REFERENCES currency(id);


--
-- TOC entry 3467 (class 2606 OID 266095)
-- Name: base_user_fk_6; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY base_user
    ADD CONSTRAINT base_user_fk_6 FOREIGN KEY (status_id) REFERENCES user_status(id);


--
-- TOC entry 3471 (class 2606 OID 266100)
-- Name: batch_process_info_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY batch_process_info
    ADD CONSTRAINT batch_process_info_fk_1 FOREIGN KEY (process_id) REFERENCES billing_process(id);


--
-- TOC entry 3476 (class 2606 OID 266105)
-- Name: billing_proc_configtn_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY billing_process_configuration
    ADD CONSTRAINT billing_proc_configtn_fk_1 FOREIGN KEY (period_unit_id) REFERENCES period_unit(id);


--
-- TOC entry 3475 (class 2606 OID 266110)
-- Name: billing_proc_configtn_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY billing_process_configuration
    ADD CONSTRAINT billing_proc_configtn_fk_2 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3478 (class 2606 OID 266115)
-- Name: billing_process_failed_user_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY billing_process_failed_user
    ADD CONSTRAINT billing_process_failed_user_fk_1 FOREIGN KEY (batch_process_id) REFERENCES batch_process_info(id);


--
-- TOC entry 3477 (class 2606 OID 266120)
-- Name: billing_process_failed_user_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY billing_process_failed_user
    ADD CONSTRAINT billing_process_failed_user_fk_2 FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3474 (class 2606 OID 266125)
-- Name: billing_process_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY billing_process
    ADD CONSTRAINT billing_process_fk_1 FOREIGN KEY (period_unit_id) REFERENCES period_unit(id);


--
-- TOC entry 3473 (class 2606 OID 266130)
-- Name: billing_process_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY billing_process
    ADD CONSTRAINT billing_process_fk_2 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3472 (class 2606 OID 266135)
-- Name: billing_process_fk_3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY billing_process
    ADD CONSTRAINT billing_process_fk_3 FOREIGN KEY (paper_invoice_batch_id) REFERENCES paper_invoice_batch(id);


--
-- TOC entry 3481 (class 2606 OID 266140)
-- Name: blacklist_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY blacklist
    ADD CONSTRAINT blacklist_fk_1 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3480 (class 2606 OID 266145)
-- Name: blacklist_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY blacklist
    ADD CONSTRAINT blacklist_fk_2 FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3479 (class 2606 OID 266150)
-- Name: blacklist_fk_4; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY blacklist
    ADD CONSTRAINT blacklist_fk_4 FOREIGN KEY (meta_field_value_id) REFERENCES meta_field_value(id);


--
-- TOC entry 3575 (class 2606 OID 266155)
-- Name: category_id_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY notification_message_type
    ADD CONSTRAINT category_id_fk_1 FOREIGN KEY (category_id) REFERENCES notification_category(id);


--
-- TOC entry 3485 (class 2606 OID 266160)
-- Name: contact_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY contact_map
    ADD CONSTRAINT contact_map_fk_1 FOREIGN KEY (table_id) REFERENCES jbilling_table(id);


--
-- TOC entry 3484 (class 2606 OID 266165)
-- Name: contact_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY contact_map
    ADD CONSTRAINT contact_map_fk_2 FOREIGN KEY (type_id) REFERENCES contact_type(id);


--
-- TOC entry 3483 (class 2606 OID 266170)
-- Name: contact_map_fk_3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY contact_map
    ADD CONSTRAINT contact_map_fk_3 FOREIGN KEY (contact_id) REFERENCES contact(id);


--
-- TOC entry 3486 (class 2606 OID 266175)
-- Name: contact_type_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY contact_type
    ADD CONSTRAINT contact_type_fk_1 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3488 (class 2606 OID 266180)
-- Name: currency_entity_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY currency_entity_map
    ADD CONSTRAINT currency_entity_map_fk_1 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3487 (class 2606 OID 266185)
-- Name: currency_entity_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY currency_entity_map
    ADD CONSTRAINT currency_entity_map_fk_2 FOREIGN KEY (currency_id) REFERENCES currency(id);


--
-- TOC entry 3489 (class 2606 OID 266190)
-- Name: currency_exchange_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY currency_exchange
    ADD CONSTRAINT currency_exchange_fk_1 FOREIGN KEY (currency_id) REFERENCES currency(id);


--
-- TOC entry 3497 (class 2606 OID 266195)
-- Name: customer_account_info_type_timeline_account_info_type_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY customer_account_info_type_timeline
    ADD CONSTRAINT customer_account_info_type_timeline_account_info_type_id_fk FOREIGN KEY (account_info_type_id) REFERENCES meta_field_group(id);


--
-- TOC entry 3496 (class 2606 OID 266200)
-- Name: customer_account_info_type_timeline_customer_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY customer_account_info_type_timeline
    ADD CONSTRAINT customer_account_info_type_timeline_customer_id_fk FOREIGN KEY (customer_id) REFERENCES customer(id);


--
-- TOC entry 3495 (class 2606 OID 266205)
-- Name: customer_account_info_type_timeline_meta_field_value_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY customer_account_info_type_timeline
    ADD CONSTRAINT customer_account_info_type_timeline_meta_field_value_id_fk FOREIGN KEY (meta_field_value_id) REFERENCES meta_field_value(id);


--
-- TOC entry 3494 (class 2606 OID 266210)
-- Name: customer_account_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_account_type_fk FOREIGN KEY (account_type_id) REFERENCES account_type(id);


--
-- TOC entry 3493 (class 2606 OID 266215)
-- Name: customer_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_fk_1 FOREIGN KEY (invoice_delivery_method_id) REFERENCES invoice_delivery_method(id);


--
-- TOC entry 3492 (class 2606 OID 266220)
-- Name: customer_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_fk_2 FOREIGN KEY (partner_id) REFERENCES partner(id);


--
-- TOC entry 3491 (class 2606 OID 266225)
-- Name: customer_fk_3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_fk_3 FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3490 (class 2606 OID 266230)
-- Name: customer_main_subscription_period_FK; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT "customer_main_subscription_period_FK" FOREIGN KEY (main_subscript_order_period_id) REFERENCES order_period(id);


--
-- TOC entry 3499 (class 2606 OID 266235)
-- Name: customer_meta_field_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY customer_meta_field_map
    ADD CONSTRAINT customer_meta_field_map_fk_1 FOREIGN KEY (customer_id) REFERENCES customer(id);


--
-- TOC entry 3498 (class 2606 OID 266240)
-- Name: customer_meta_field_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY customer_meta_field_map
    ADD CONSTRAINT customer_meta_field_map_fk_2 FOREIGN KEY (meta_field_value_id) REFERENCES meta_field_value(id);


--
-- TOC entry 3502 (class 2606 OID 266245)
-- Name: customer_notes_customer_id_FK; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY customer_notes
    ADD CONSTRAINT "customer_notes_customer_id_FK" FOREIGN KEY (customer_id) REFERENCES customer(id);


--
-- TOC entry 3501 (class 2606 OID 266250)
-- Name: customer_notes_entity_id_FK; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY customer_notes
    ADD CONSTRAINT "customer_notes_entity_id_FK" FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3500 (class 2606 OID 266255)
-- Name: customer_notes_user_id_FK; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY customer_notes
    ADD CONSTRAINT "customer_notes_user_id_FK" FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3504 (class 2606 OID 266260)
-- Name: data_table_query_entry_next_FK; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY data_table_query_entry
    ADD CONSTRAINT "data_table_query_entry_next_FK" FOREIGN KEY (next_entry_id) REFERENCES data_table_query_entry(id);


--
-- TOC entry 3503 (class 2606 OID 266265)
-- Name: data_table_query_next_FK; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY data_table_query
    ADD CONSTRAINT "data_table_query_next_FK" FOREIGN KEY (root_entry_id) REFERENCES data_table_query_entry(id);


--
-- TOC entry 3506 (class 2606 OID 266270)
-- Name: discount_attr_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY discount_attribute
    ADD CONSTRAINT discount_attr_id_fk FOREIGN KEY (discount_id) REFERENCES discount(id);


--
-- TOC entry 3505 (class 2606 OID 266275)
-- Name: discount_entity_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY discount
    ADD CONSTRAINT discount_entity_id_fk FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3510 (class 2606 OID 266280)
-- Name: discount_line_discount_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY discount_line
    ADD CONSTRAINT discount_line_discount_id_fk FOREIGN KEY (discount_id) REFERENCES discount(id);


--
-- TOC entry 3509 (class 2606 OID 266285)
-- Name: discount_line_item_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY discount_line
    ADD CONSTRAINT discount_line_item_id_fk FOREIGN KEY (item_id) REFERENCES item(id);


--
-- TOC entry 3508 (class 2606 OID 266290)
-- Name: discount_line_order_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY discount_line
    ADD CONSTRAINT discount_line_order_id_fk FOREIGN KEY (order_id) REFERENCES purchase_order(id);


--
-- TOC entry 3507 (class 2606 OID 266295)
-- Name: discount_line_order_line_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY discount_line
    ADD CONSTRAINT discount_line_order_line_id_fk FOREIGN KEY (discount_order_line_id) REFERENCES order_line(id);


--
-- TOC entry 3515 (class 2606 OID 266300)
-- Name: entity_delivry_methd_map_fk1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY entity_delivery_method_map
    ADD CONSTRAINT entity_delivry_methd_map_fk1 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3514 (class 2606 OID 266305)
-- Name: entity_delivry_methd_map_fk2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY entity_delivery_method_map
    ADD CONSTRAINT entity_delivry_methd_map_fk2 FOREIGN KEY (method_id) REFERENCES invoice_delivery_method(id);


--
-- TOC entry 3513 (class 2606 OID 266310)
-- Name: entity_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY entity
    ADD CONSTRAINT entity_fk_1 FOREIGN KEY (currency_id) REFERENCES currency(id);


--
-- TOC entry 3512 (class 2606 OID 266315)
-- Name: entity_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY entity
    ADD CONSTRAINT entity_fk_2 FOREIGN KEY (language_id) REFERENCES language(id);


--
-- TOC entry 3511 (class 2606 OID 266320)
-- Name: entity_fk_3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY entity
    ADD CONSTRAINT entity_fk_3 FOREIGN KEY (parent_id) REFERENCES entity(id);


--
-- TOC entry 3517 (class 2606 OID 266325)
-- Name: entity_payment_method_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY entity_payment_method_map
    ADD CONSTRAINT entity_payment_method_map_fk_1 FOREIGN KEY (payment_method_id) REFERENCES payment_method(id);


--
-- TOC entry 3516 (class 2606 OID 266330)
-- Name: entity_payment_method_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY entity_payment_method_map
    ADD CONSTRAINT entity_payment_method_map_fk_2 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3520 (class 2606 OID 266335)
-- Name: enumeration_values_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY enumeration_values
    ADD CONSTRAINT enumeration_values_fk_1 FOREIGN KEY (enumeration_id) REFERENCES enumeration(id);


--
-- TOC entry 3526 (class 2606 OID 266340)
-- Name: event_log_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY event_log
    ADD CONSTRAINT event_log_fk_1 FOREIGN KEY (module_id) REFERENCES event_log_module(id);


--
-- TOC entry 3525 (class 2606 OID 266345)
-- Name: event_log_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY event_log
    ADD CONSTRAINT event_log_fk_2 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3524 (class 2606 OID 266350)
-- Name: event_log_fk_3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY event_log
    ADD CONSTRAINT event_log_fk_3 FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3523 (class 2606 OID 266355)
-- Name: event_log_fk_4; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY event_log
    ADD CONSTRAINT event_log_fk_4 FOREIGN KEY (table_id) REFERENCES jbilling_table(id);


--
-- TOC entry 3522 (class 2606 OID 266360)
-- Name: event_log_fk_5; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY event_log
    ADD CONSTRAINT event_log_fk_5 FOREIGN KEY (message_id) REFERENCES event_log_message(id);


--
-- TOC entry 3521 (class 2606 OID 266365)
-- Name: event_log_fk_6; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY event_log
    ADD CONSTRAINT event_log_fk_6 FOREIGN KEY (affected_user_id) REFERENCES base_user(id);


--
-- TOC entry 3668 (class 2606 OID 266370)
-- Name: fk_reservations_session; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY reserved_amounts
    ADD CONSTRAINT fk_reservations_session FOREIGN KEY (session_id) REFERENCES charge_sessions(id);


--
-- TOC entry 3482 (class 2606 OID 266375)
-- Name: fk_sessions_user; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY charge_sessions
    ADD CONSTRAINT fk_sessions_user FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3528 (class 2606 OID 266380)
-- Name: generic_status_entity_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY generic_status
    ADD CONSTRAINT generic_status_entity_id_fk FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3527 (class 2606 OID 266385)
-- Name: generic_status_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY generic_status
    ADD CONSTRAINT generic_status_fk_1 FOREIGN KEY (dtype) REFERENCES generic_status_type(id);


--
-- TOC entry 3529 (class 2606 OID 266390)
-- Name: international_description_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY international_description
    ADD CONSTRAINT international_description_fk_1 FOREIGN KEY (language_id) REFERENCES language(id);


--
-- TOC entry 3441 (class 2606 OID 266395)
-- Name: invoice_delivery_method_id_FK; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY account_type
    ADD CONSTRAINT "invoice_delivery_method_id_FK" FOREIGN KEY (invoice_delivery_method_id) REFERENCES invoice_delivery_method(id);


--
-- TOC entry 3533 (class 2606 OID 266400)
-- Name: invoice_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY invoice
    ADD CONSTRAINT invoice_fk_1 FOREIGN KEY (billing_process_id) REFERENCES billing_process(id);


--
-- TOC entry 3532 (class 2606 OID 266405)
-- Name: invoice_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY invoice
    ADD CONSTRAINT invoice_fk_2 FOREIGN KEY (paper_invoice_batch_id) REFERENCES paper_invoice_batch(id);


--
-- TOC entry 3531 (class 2606 OID 266410)
-- Name: invoice_fk_3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY invoice
    ADD CONSTRAINT invoice_fk_3 FOREIGN KEY (currency_id) REFERENCES currency(id);


--
-- TOC entry 3530 (class 2606 OID 266415)
-- Name: invoice_fk_4; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY invoice
    ADD CONSTRAINT invoice_fk_4 FOREIGN KEY (delegated_invoice_id) REFERENCES invoice(id);


--
-- TOC entry 3537 (class 2606 OID 266420)
-- Name: invoice_line_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY invoice_line
    ADD CONSTRAINT invoice_line_fk_1 FOREIGN KEY (invoice_id) REFERENCES invoice(id);


--
-- TOC entry 3536 (class 2606 OID 266425)
-- Name: invoice_line_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY invoice_line
    ADD CONSTRAINT invoice_line_fk_2 FOREIGN KEY (item_id) REFERENCES item(id);


--
-- TOC entry 3535 (class 2606 OID 266430)
-- Name: invoice_line_fk_3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY invoice_line
    ADD CONSTRAINT invoice_line_fk_3 FOREIGN KEY (type_id) REFERENCES invoice_line_type(id);


--
-- TOC entry 3534 (class 2606 OID 266435)
-- Name: invoice_line_fk_4; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY invoice_line
    ADD CONSTRAINT invoice_line_fk_4 FOREIGN KEY (order_id) REFERENCES purchase_order(id);


--
-- TOC entry 3539 (class 2606 OID 266440)
-- Name: invoice_meta_field_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY invoice_meta_field_map
    ADD CONSTRAINT invoice_meta_field_map_fk_1 FOREIGN KEY (invoice_id) REFERENCES invoice(id);


--
-- TOC entry 3538 (class 2606 OID 266445)
-- Name: invoice_meta_field_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY invoice_meta_field_map
    ADD CONSTRAINT invoice_meta_field_map_fk_2 FOREIGN KEY (meta_field_value_id) REFERENCES meta_field_value(id);


--
-- TOC entry 3543 (class 2606 OID 266450)
-- Name: item_dependency_fk1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_dependency
    ADD CONSTRAINT item_dependency_fk1 FOREIGN KEY (item_id) REFERENCES item(id);


--
-- TOC entry 3542 (class 2606 OID 266455)
-- Name: item_dependency_fk2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_dependency
    ADD CONSTRAINT item_dependency_fk2 FOREIGN KEY (dependent_item_id) REFERENCES item(id);


--
-- TOC entry 3541 (class 2606 OID 266460)
-- Name: item_dependency_fk3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_dependency
    ADD CONSTRAINT item_dependency_fk3 FOREIGN KEY (dependent_item_type_id) REFERENCES item_type(id);


--
-- TOC entry 3545 (class 2606 OID 266465)
-- Name: item_entity_map_fk1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_entity_map
    ADD CONSTRAINT item_entity_map_fk1 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3544 (class 2606 OID 266470)
-- Name: item_entity_map_fk2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_entity_map
    ADD CONSTRAINT item_entity_map_fk2 FOREIGN KEY (item_id) REFERENCES item(id);


--
-- TOC entry 3540 (class 2606 OID 266475)
-- Name: item_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_fk_1 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3547 (class 2606 OID 266480)
-- Name: item_meta_field_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_meta_field_map
    ADD CONSTRAINT item_meta_field_map_fk_1 FOREIGN KEY (item_id) REFERENCES item(id);


--
-- TOC entry 3546 (class 2606 OID 266485)
-- Name: item_meta_field_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_meta_field_map
    ADD CONSTRAINT item_meta_field_map_fk_2 FOREIGN KEY (meta_field_value_id) REFERENCES meta_field_value(id);


--
-- TOC entry 3549 (class 2606 OID 266490)
-- Name: item_price_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_price
    ADD CONSTRAINT item_price_fk_1 FOREIGN KEY (currency_id) REFERENCES currency(id);


--
-- TOC entry 3548 (class 2606 OID 266495)
-- Name: item_price_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_price
    ADD CONSTRAINT item_price_fk_2 FOREIGN KEY (item_id) REFERENCES item(id);


--
-- TOC entry 3553 (class 2606 OID 266500)
-- Name: item_type_entity_map_fk1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_type_entity_map
    ADD CONSTRAINT item_type_entity_map_fk1 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3552 (class 2606 OID 266505)
-- Name: item_type_entity_map_fk2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_type_entity_map
    ADD CONSTRAINT item_type_entity_map_fk2 FOREIGN KEY (item_type_id) REFERENCES item_type(id);


--
-- TOC entry 3555 (class 2606 OID 266510)
-- Name: item_type_exclude_item_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_type_exclude_map
    ADD CONSTRAINT item_type_exclude_item_id_fk FOREIGN KEY (item_id) REFERENCES item(id);


--
-- TOC entry 3554 (class 2606 OID 266515)
-- Name: item_type_exclude_type_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_type_exclude_map
    ADD CONSTRAINT item_type_exclude_type_id_fk FOREIGN KEY (type_id) REFERENCES item_type(id);


--
-- TOC entry 3551 (class 2606 OID 266520)
-- Name: item_type_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_type
    ADD CONSTRAINT item_type_fk_1 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3557 (class 2606 OID 266525)
-- Name: item_type_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_type_map
    ADD CONSTRAINT item_type_map_fk_1 FOREIGN KEY (item_id) REFERENCES item(id);


--
-- TOC entry 3556 (class 2606 OID 266530)
-- Name: item_type_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_type_map
    ADD CONSTRAINT item_type_map_fk_2 FOREIGN KEY (type_id) REFERENCES item_type(id);


--
-- TOC entry 3559 (class 2606 OID 266535)
-- Name: item_type_meta_field_def_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_type_meta_field_def_map
    ADD CONSTRAINT item_type_meta_field_def_map_fk_1 FOREIGN KEY (item_type_id) REFERENCES item_type(id);


--
-- TOC entry 3558 (class 2606 OID 266540)
-- Name: item_type_meta_field_def_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_type_meta_field_def_map
    ADD CONSTRAINT item_type_meta_field_def_map_fk_2 FOREIGN KEY (meta_field_id) REFERENCES meta_field_name(id);


--
-- TOC entry 3561 (class 2606 OID 266545)
-- Name: item_type_meta_field_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_type_meta_field_map
    ADD CONSTRAINT item_type_meta_field_type_fk FOREIGN KEY (item_type_id) REFERENCES item_type(id);


--
-- TOC entry 3560 (class 2606 OID 266550)
-- Name: item_type_meta_field_value_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_type_meta_field_map
    ADD CONSTRAINT item_type_meta_field_value_fk FOREIGN KEY (meta_field_value_id) REFERENCES meta_field_value(id);


--
-- TOC entry 3562 (class 2606 OID 266555)
-- Name: matching_field_route_id_FK; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY matching_field
    ADD CONSTRAINT "matching_field_route_id_FK" FOREIGN KEY (route_id) REFERENCES route(id);


--
-- TOC entry 3567 (class 2606 OID 266560)
-- Name: meta_field_entity_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY meta_field_name
    ADD CONSTRAINT meta_field_entity_id_fk FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3564 (class 2606 OID 266565)
-- Name: meta_field_group_account_type_FK2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY meta_field_group
    ADD CONSTRAINT "meta_field_group_account_type_FK2" FOREIGN KEY (account_type_id) REFERENCES account_type(id);


--
-- TOC entry 3563 (class 2606 OID 266570)
-- Name: meta_field_group_entity_FK1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY meta_field_group
    ADD CONSTRAINT "meta_field_group_entity_FK1" FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3566 (class 2606 OID 266575)
-- Name: meta_field_name_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY meta_field_name
    ADD CONSTRAINT meta_field_name_fk_1 FOREIGN KEY (default_value_id) REFERENCES meta_field_value(id);


--
-- TOC entry 3568 (class 2606 OID 266580)
-- Name: meta_field_value_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY meta_field_value
    ADD CONSTRAINT meta_field_value_fk_1 FOREIGN KEY (meta_field_name_id) REFERENCES meta_field_name(id);


--
-- TOC entry 3572 (class 2606 OID 266585)
-- Name: notif_mess_arch_line_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY notification_message_arch_line
    ADD CONSTRAINT notif_mess_arch_line_fk_1 FOREIGN KEY (message_archive_id) REFERENCES notification_message_arch(id);


--
-- TOC entry 3571 (class 2606 OID 266590)
-- Name: notification_message_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY notification_message
    ADD CONSTRAINT notification_message_fk_1 FOREIGN KEY (language_id) REFERENCES language(id);


--
-- TOC entry 3570 (class 2606 OID 266595)
-- Name: notification_message_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY notification_message
    ADD CONSTRAINT notification_message_fk_2 FOREIGN KEY (type_id) REFERENCES notification_message_type(id);


--
-- TOC entry 3569 (class 2606 OID 266600)
-- Name: notification_message_fk_3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY notification_message
    ADD CONSTRAINT notification_message_fk_3 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3573 (class 2606 OID 266605)
-- Name: notification_message_line_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY notification_message_line
    ADD CONSTRAINT notification_message_line_fk_1 FOREIGN KEY (message_section_id) REFERENCES notification_message_section(id);


--
-- TOC entry 3574 (class 2606 OID 266610)
-- Name: notification_msg_section_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY notification_message_section
    ADD CONSTRAINT notification_msg_section_fk_1 FOREIGN KEY (message_id) REFERENCES notification_message(id);


--
-- TOC entry 3600 (class 2606 OID 266615)
-- Name: ol_meta_field_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_line_meta_field_map
    ADD CONSTRAINT ol_meta_field_map_fk_1 FOREIGN KEY (order_line_id) REFERENCES order_line(id);


--
-- TOC entry 3599 (class 2606 OID 266620)
-- Name: ol_meta_field_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_line_meta_field_map
    ADD CONSTRAINT ol_meta_field_map_fk_2 FOREIGN KEY (meta_field_value_id) REFERENCES meta_field_value(id);


--
-- TOC entry 3602 (class 2606 OID 266625)
-- Name: ol_meta_fields_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_line_meta_fields_map
    ADD CONSTRAINT ol_meta_fields_map_fk_1 FOREIGN KEY (item_id) REFERENCES item(id);


--
-- TOC entry 3601 (class 2606 OID 266630)
-- Name: ol_meta_fields_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_line_meta_fields_map
    ADD CONSTRAINT ol_meta_fields_map_fk_2 FOREIGN KEY (meta_field_id) REFERENCES meta_field_name(id);


--
-- TOC entry 3587 (class 2606 OID 266635)
-- Name: order_change_asset_map_asset_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change_asset_map
    ADD CONSTRAINT order_change_asset_map_asset_id_fk FOREIGN KEY (asset_id) REFERENCES asset(id);


--
-- TOC entry 3586 (class 2606 OID 266640)
-- Name: order_change_asset_map_change_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change_asset_map
    ADD CONSTRAINT order_change_asset_map_change_id_fk FOREIGN KEY (order_change_id) REFERENCES order_change(id);


--
-- TOC entry 3585 (class 2606 OID 266645)
-- Name: order_change_item_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change
    ADD CONSTRAINT order_change_item_id_fk FOREIGN KEY (item_id) REFERENCES item(id);


--
-- TOC entry 3589 (class 2606 OID 266650)
-- Name: order_change_meta_field_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change_meta_field_map
    ADD CONSTRAINT order_change_meta_field_map_fk_1 FOREIGN KEY (order_change_id) REFERENCES order_change(id);


--
-- TOC entry 3588 (class 2606 OID 266655)
-- Name: order_change_meta_field_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change_meta_field_map
    ADD CONSTRAINT order_change_meta_field_map_fk_2 FOREIGN KEY (meta_field_value_id) REFERENCES meta_field_value(id);


--
-- TOC entry 3584 (class 2606 OID 266660)
-- Name: order_change_order_change_type_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change
    ADD CONSTRAINT order_change_order_change_type_id_fk FOREIGN KEY (order_change_type_id) REFERENCES order_change_type(id);


--
-- TOC entry 3583 (class 2606 OID 266665)
-- Name: order_change_order_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change
    ADD CONSTRAINT order_change_order_id_fk FOREIGN KEY (order_id) REFERENCES purchase_order(id);


--
-- TOC entry 3582 (class 2606 OID 266670)
-- Name: order_change_order_line_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change
    ADD CONSTRAINT order_change_order_line_id_fk FOREIGN KEY (order_line_id) REFERENCES order_line(id);


--
-- TOC entry 3581 (class 2606 OID 266675)
-- Name: order_change_order_status_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change
    ADD CONSTRAINT order_change_order_status_id_fk FOREIGN KEY (order_status_id) REFERENCES order_status(id);


--
-- TOC entry 3580 (class 2606 OID 266680)
-- Name: order_change_parent_order_change_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change
    ADD CONSTRAINT order_change_parent_order_change_fk FOREIGN KEY (parent_order_change_id) REFERENCES order_change(id);


--
-- TOC entry 3579 (class 2606 OID 266685)
-- Name: order_change_parent_order_line_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change
    ADD CONSTRAINT order_change_parent_order_line_id_fk FOREIGN KEY (parent_order_line_id) REFERENCES order_line(id);


--
-- TOC entry 3578 (class 2606 OID 266690)
-- Name: order_change_status_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change
    ADD CONSTRAINT order_change_status_id_fk FOREIGN KEY (status_id) REFERENCES generic_status(id);


--
-- TOC entry 3590 (class 2606 OID 266695)
-- Name: order_change_type_entity_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change_type
    ADD CONSTRAINT order_change_type_entity_id_fk FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3592 (class 2606 OID 266700)
-- Name: order_change_type_item_type_map_change_type_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change_type_item_type_map
    ADD CONSTRAINT order_change_type_item_type_map_change_type_id_fk FOREIGN KEY (order_change_type_id) REFERENCES order_change_type(id);


--
-- TOC entry 3591 (class 2606 OID 266705)
-- Name: order_change_type_item_type_map_item_type_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change_type_item_type_map
    ADD CONSTRAINT order_change_type_item_type_map_item_type_id_fk FOREIGN KEY (item_type_id) REFERENCES item_type(id);


--
-- TOC entry 3594 (class 2606 OID 266710)
-- Name: order_change_type_meta_field_map_change_type_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change_type_meta_field_map
    ADD CONSTRAINT order_change_type_meta_field_map_change_type_id_fk FOREIGN KEY (order_change_type_id) REFERENCES order_change_type(id);


--
-- TOC entry 3593 (class 2606 OID 266715)
-- Name: order_change_type_meta_field_map_meta_field_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change_type_meta_field_map
    ADD CONSTRAINT order_change_type_meta_field_map_meta_field_id_fk FOREIGN KEY (meta_field_id) REFERENCES meta_field_name(id);


--
-- TOC entry 3577 (class 2606 OID 266720)
-- Name: order_change_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change
    ADD CONSTRAINT order_change_user_id_fk FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3576 (class 2606 OID 266725)
-- Name: order_change_user_status_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_change
    ADD CONSTRAINT order_change_user_status_id_fk FOREIGN KEY (user_assigned_status_id) REFERENCES generic_status(id);


--
-- TOC entry 3598 (class 2606 OID 266730)
-- Name: order_line_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_line
    ADD CONSTRAINT order_line_fk_1 FOREIGN KEY (item_id) REFERENCES item(id);


--
-- TOC entry 3597 (class 2606 OID 266735)
-- Name: order_line_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_line
    ADD CONSTRAINT order_line_fk_2 FOREIGN KEY (order_id) REFERENCES purchase_order(id);


--
-- TOC entry 3596 (class 2606 OID 266740)
-- Name: order_line_fk_3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_line
    ADD CONSTRAINT order_line_fk_3 FOREIGN KEY (type_id) REFERENCES order_line_type(id);


--
-- TOC entry 3595 (class 2606 OID 266745)
-- Name: order_line_parent_line_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_line
    ADD CONSTRAINT order_line_parent_line_id_fk FOREIGN KEY (parent_line_id) REFERENCES order_line(id);


--
-- TOC entry 3604 (class 2606 OID 266750)
-- Name: order_meta_field_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_meta_field_map
    ADD CONSTRAINT order_meta_field_map_fk_1 FOREIGN KEY (order_id) REFERENCES purchase_order(id);


--
-- TOC entry 3603 (class 2606 OID 266755)
-- Name: order_meta_field_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_meta_field_map
    ADD CONSTRAINT order_meta_field_map_fk_2 FOREIGN KEY (meta_field_value_id) REFERENCES meta_field_value(id);


--
-- TOC entry 3606 (class 2606 OID 266760)
-- Name: order_period_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_period
    ADD CONSTRAINT order_period_fk_1 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3605 (class 2606 OID 266765)
-- Name: order_period_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_period
    ADD CONSTRAINT order_period_fk_2 FOREIGN KEY (unit_id) REFERENCES period_unit(id);


--
-- TOC entry 3664 (class 2606 OID 266770)
-- Name: order_primary_order_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY purchase_order
    ADD CONSTRAINT order_primary_order_fk_1 FOREIGN KEY (primary_order_id) REFERENCES purchase_order(id);


--
-- TOC entry 3607 (class 2606 OID 266775)
-- Name: order_process_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_process
    ADD CONSTRAINT order_process_fk_1 FOREIGN KEY (order_id) REFERENCES purchase_order(id);


--
-- TOC entry 3608 (class 2606 OID 266780)
-- Name: order_status_entity_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY order_status
    ADD CONSTRAINT order_status_entity_id_fk FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3550 (class 2606 OID 266785)
-- Name: parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY item_type
    ADD CONSTRAINT parent_id_fk FOREIGN KEY (parent_id) REFERENCES item_type(id);


--
-- TOC entry 3610 (class 2606 OID 266790)
-- Name: partner_commission_currency_id_FK; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY partner_commission
    ADD CONSTRAINT "partner_commission_currency_id_FK" FOREIGN KEY (currency_id) REFERENCES currency(id);


--
-- TOC entry 3609 (class 2606 OID 266795)
-- Name: partner_fk_4; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY partner
    ADD CONSTRAINT partner_fk_4 FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3612 (class 2606 OID 266800)
-- Name: partner_meta_field_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY partner_meta_field_map
    ADD CONSTRAINT partner_meta_field_map_fk_1 FOREIGN KEY (partner_id) REFERENCES partner(id);


--
-- TOC entry 3611 (class 2606 OID 266805)
-- Name: partner_meta_field_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY partner_meta_field_map
    ADD CONSTRAINT partner_meta_field_map_fk_2 FOREIGN KEY (meta_field_value_id) REFERENCES meta_field_value(id);


--
-- TOC entry 3613 (class 2606 OID 266810)
-- Name: partner_payout_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY partner_payout
    ADD CONSTRAINT partner_payout_fk_1 FOREIGN KEY (partner_id) REFERENCES partner(id);


--
-- TOC entry 3620 (class 2606 OID 266815)
-- Name: payment_authorization_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_authorization
    ADD CONSTRAINT payment_authorization_fk_1 FOREIGN KEY (payment_id) REFERENCES payment(id);


--
-- TOC entry 3619 (class 2606 OID 266820)
-- Name: payment_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment
    ADD CONSTRAINT payment_fk_1 FOREIGN KEY (ach_id) REFERENCES ach(id);


--
-- TOC entry 3618 (class 2606 OID 266825)
-- Name: payment_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment
    ADD CONSTRAINT payment_fk_2 FOREIGN KEY (currency_id) REFERENCES currency(id);


--
-- TOC entry 3617 (class 2606 OID 266830)
-- Name: payment_fk_3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment
    ADD CONSTRAINT payment_fk_3 FOREIGN KEY (payment_id) REFERENCES payment(id);


--
-- TOC entry 3616 (class 2606 OID 266835)
-- Name: payment_fk_4; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment
    ADD CONSTRAINT payment_fk_4 FOREIGN KEY (credit_card_id) REFERENCES credit_card(id);


--
-- TOC entry 3615 (class 2606 OID 266840)
-- Name: payment_fk_5; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment
    ADD CONSTRAINT payment_fk_5 FOREIGN KEY (result_id) REFERENCES payment_result(id);


--
-- TOC entry 3614 (class 2606 OID 266845)
-- Name: payment_fk_6; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment
    ADD CONSTRAINT payment_fk_6 FOREIGN KEY (method_id) REFERENCES payment_method(id);


--
-- TOC entry 3621 (class 2606 OID 266850)
-- Name: payment_info_cheque_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_info_cheque
    ADD CONSTRAINT payment_info_cheque_fk_1 FOREIGN KEY (payment_id) REFERENCES payment(id);


--
-- TOC entry 3623 (class 2606 OID 266855)
-- Name: payment_information_FK1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_information
    ADD CONSTRAINT "payment_information_FK1" FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3622 (class 2606 OID 266860)
-- Name: payment_information_FK2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_information
    ADD CONSTRAINT "payment_information_FK2" FOREIGN KEY (payment_method_id) REFERENCES payment_method_type(id);


--
-- TOC entry 3625 (class 2606 OID 266865)
-- Name: payment_information_meta_fields_map_FK1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_information_meta_fields_map
    ADD CONSTRAINT "payment_information_meta_fields_map_FK1" FOREIGN KEY (payment_information_id) REFERENCES payment_information(id);


--
-- TOC entry 3624 (class 2606 OID 266870)
-- Name: payment_information_meta_fields_map_FK2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_information_meta_fields_map
    ADD CONSTRAINT "payment_information_meta_fields_map_FK2" FOREIGN KEY (meta_field_value_id) REFERENCES meta_field_value(id);


--
-- TOC entry 3629 (class 2606 OID 266875)
-- Name: payment_instrument_info_FK1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_instrument_info
    ADD CONSTRAINT "payment_instrument_info_FK1" FOREIGN KEY (result_id) REFERENCES payment_result(id);


--
-- TOC entry 3628 (class 2606 OID 266880)
-- Name: payment_instrument_info_FK2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_instrument_info
    ADD CONSTRAINT "payment_instrument_info_FK2" FOREIGN KEY (method_id) REFERENCES payment_method(id);


--
-- TOC entry 3627 (class 2606 OID 266885)
-- Name: payment_instrument_info_FK3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_instrument_info
    ADD CONSTRAINT "payment_instrument_info_FK3" FOREIGN KEY (instrument_id) REFERENCES payment_information(id);


--
-- TOC entry 3626 (class 2606 OID 266890)
-- Name: payment_instrument_info_FK4; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_instrument_info
    ADD CONSTRAINT "payment_instrument_info_FK4" FOREIGN KEY (payment_id) REFERENCES payment(id);


--
-- TOC entry 3631 (class 2606 OID 266895)
-- Name: payment_invoice_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_invoice
    ADD CONSTRAINT payment_invoice_fk_1 FOREIGN KEY (invoice_id) REFERENCES invoice(id);


--
-- TOC entry 3630 (class 2606 OID 266900)
-- Name: payment_invoice_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_invoice
    ADD CONSTRAINT payment_invoice_fk_2 FOREIGN KEY (payment_id) REFERENCES payment(id);


--
-- TOC entry 3633 (class 2606 OID 266905)
-- Name: payment_meta_field_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_meta_field_map
    ADD CONSTRAINT payment_meta_field_map_fk_1 FOREIGN KEY (payment_id) REFERENCES payment(id);


--
-- TOC entry 3632 (class 2606 OID 266910)
-- Name: payment_meta_field_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_meta_field_map
    ADD CONSTRAINT payment_meta_field_map_fk_2 FOREIGN KEY (meta_field_value_id) REFERENCES meta_field_value(id);


--
-- TOC entry 3635 (class 2606 OID 266915)
-- Name: payment_method_account_type_map_FK1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_method_account_type_map
    ADD CONSTRAINT "payment_method_account_type_map_FK1" FOREIGN KEY (payment_method_id) REFERENCES payment_method_type(id);


--
-- TOC entry 3634 (class 2606 OID 266920)
-- Name: payment_method_account_type_map_FK2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_method_account_type_map
    ADD CONSTRAINT "payment_method_account_type_map_FK2" FOREIGN KEY (account_type_id) REFERENCES account_type(id);


--
-- TOC entry 3637 (class 2606 OID 266925)
-- Name: payment_method_meta_fields_map_FK1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_method_meta_fields_map
    ADD CONSTRAINT "payment_method_meta_fields_map_FK1" FOREIGN KEY (payment_method_id) REFERENCES payment_method_type(id);


--
-- TOC entry 3636 (class 2606 OID 266930)
-- Name: payment_method_meta_fields_map_FK2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_method_meta_fields_map
    ADD CONSTRAINT "payment_method_meta_fields_map_FK2" FOREIGN KEY (meta_field_id) REFERENCES meta_field_name(id);


--
-- TOC entry 3639 (class 2606 OID 266935)
-- Name: payment_method_template_meta_fields_map_FK1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_method_template_meta_fields_map
    ADD CONSTRAINT "payment_method_template_meta_fields_map_FK1" FOREIGN KEY (method_template_id) REFERENCES payment_method_template(id);


--
-- TOC entry 3638 (class 2606 OID 266940)
-- Name: payment_method_template_meta_fields_map_FK2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_method_template_meta_fields_map
    ADD CONSTRAINT "payment_method_template_meta_fields_map_FK2" FOREIGN KEY (meta_field_id) REFERENCES meta_field_name(id);


--
-- TOC entry 3641 (class 2606 OID 266945)
-- Name: payment_method_type_FK1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_method_type
    ADD CONSTRAINT "payment_method_type_FK1" FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3640 (class 2606 OID 266950)
-- Name: payment_method_type_FK2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY payment_method_type
    ADD CONSTRAINT "payment_method_type_FK2" FOREIGN KEY (template_id) REFERENCES payment_method_template(id);


--
-- TOC entry 3642 (class 2606 OID 266955)
-- Name: pluggable_task_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY pluggable_task
    ADD CONSTRAINT pluggable_task_fk_2 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3643 (class 2606 OID 266960)
-- Name: pluggable_task_parameter_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY pluggable_task_parameter
    ADD CONSTRAINT pluggable_task_parameter_fk_1 FOREIGN KEY (task_id) REFERENCES pluggable_task(id);


--
-- TOC entry 3644 (class 2606 OID 266965)
-- Name: pluggable_task_type_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY pluggable_task_type
    ADD CONSTRAINT pluggable_task_type_fk_1 FOREIGN KEY (category_id) REFERENCES pluggable_task_type_category(id);


--
-- TOC entry 3646 (class 2606 OID 266970)
-- Name: preference_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY preference
    ADD CONSTRAINT preference_fk_1 FOREIGN KEY (type_id) REFERENCES preference_type(id);


--
-- TOC entry 3645 (class 2606 OID 266975)
-- Name: preference_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY preference
    ADD CONSTRAINT preference_fk_2 FOREIGN KEY (table_id) REFERENCES jbilling_table(id);


--
-- TOC entry 3647 (class 2606 OID 266980)
-- Name: preference_type_vr_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY preference_type
    ADD CONSTRAINT preference_type_vr_fk_1 FOREIGN KEY (validation_rule_id) REFERENCES validation_rule(id);


--
-- TOC entry 3649 (class 2606 OID 266985)
-- Name: process_run_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY process_run
    ADD CONSTRAINT process_run_fk_1 FOREIGN KEY (process_id) REFERENCES billing_process(id);


--
-- TOC entry 3648 (class 2606 OID 266990)
-- Name: process_run_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY process_run
    ADD CONSTRAINT process_run_fk_2 FOREIGN KEY (status_id) REFERENCES generic_status(id);


--
-- TOC entry 3651 (class 2606 OID 266995)
-- Name: process_run_total_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY process_run_total
    ADD CONSTRAINT process_run_total_fk_1 FOREIGN KEY (currency_id) REFERENCES currency(id);


--
-- TOC entry 3650 (class 2606 OID 267000)
-- Name: process_run_total_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY process_run_total
    ADD CONSTRAINT process_run_total_fk_2 FOREIGN KEY (process_run_id) REFERENCES process_run(id);


--
-- TOC entry 3652 (class 2606 OID 267005)
-- Name: process_run_total_pm_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY process_run_total_pm
    ADD CONSTRAINT process_run_total_pm_fk_1 FOREIGN KEY (payment_method_id) REFERENCES payment_method(id);


--
-- TOC entry 3654 (class 2606 OID 267010)
-- Name: process_run_user_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY process_run_user
    ADD CONSTRAINT process_run_user_fk_1 FOREIGN KEY (process_run_id) REFERENCES process_run(id);


--
-- TOC entry 3653 (class 2606 OID 267015)
-- Name: process_run_user_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY process_run_user
    ADD CONSTRAINT process_run_user_fk_2 FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3655 (class 2606 OID 267020)
-- Name: promotion_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY promotion
    ADD CONSTRAINT promotion_fk_1 FOREIGN KEY (item_id) REFERENCES item(id);


--
-- TOC entry 3657 (class 2606 OID 267025)
-- Name: promotion_user_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY promotion_user_map
    ADD CONSTRAINT promotion_user_map_fk_1 FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3656 (class 2606 OID 267030)
-- Name: promotion_user_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY promotion_user_map
    ADD CONSTRAINT promotion_user_map_fk_2 FOREIGN KEY (promotion_id) REFERENCES promotion(id);


--
-- TOC entry 3663 (class 2606 OID 267035)
-- Name: purchase_order_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY purchase_order
    ADD CONSTRAINT purchase_order_fk_1 FOREIGN KEY (currency_id) REFERENCES currency(id);


--
-- TOC entry 3662 (class 2606 OID 267040)
-- Name: purchase_order_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY purchase_order
    ADD CONSTRAINT purchase_order_fk_2 FOREIGN KEY (billing_type_id) REFERENCES order_billing_type(id);


--
-- TOC entry 3661 (class 2606 OID 267045)
-- Name: purchase_order_fk_3; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY purchase_order
    ADD CONSTRAINT purchase_order_fk_3 FOREIGN KEY (period_id) REFERENCES order_period(id);


--
-- TOC entry 3660 (class 2606 OID 267050)
-- Name: purchase_order_fk_4; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY purchase_order
    ADD CONSTRAINT purchase_order_fk_4 FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3659 (class 2606 OID 267055)
-- Name: purchase_order_fk_5; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY purchase_order
    ADD CONSTRAINT purchase_order_fk_5 FOREIGN KEY (created_by) REFERENCES base_user(id);


--
-- TOC entry 3658 (class 2606 OID 267060)
-- Name: purchase_order_parent__order_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY purchase_order
    ADD CONSTRAINT purchase_order_parent__order_id_fk FOREIGN KEY (parent_order_id) REFERENCES purchase_order(id);


--
-- TOC entry 3665 (class 2606 OID 267065)
-- Name: rating_unit_entity_id_FK; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY rating_unit
    ADD CONSTRAINT "rating_unit_entity_id_FK" FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3519 (class 2606 OID 267070)
-- Name: report_map_entity_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY entity_report_map
    ADD CONSTRAINT report_map_entity_id_fk FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3518 (class 2606 OID 267075)
-- Name: report_map_report_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY entity_report_map
    ADD CONSTRAINT report_map_report_id_fk FOREIGN KEY (report_id) REFERENCES report(id);


--
-- TOC entry 3667 (class 2606 OID 267080)
-- Name: reseller_entityid_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY reseller_entityid_map
    ADD CONSTRAINT reseller_entityid_map_fk_1 FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3666 (class 2606 OID 267085)
-- Name: reseller_entityid_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY reseller_entityid_map
    ADD CONSTRAINT reseller_entityid_map_fk_2 FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3669 (class 2606 OID 267090)
-- Name: role_entity_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_entity_id_fk FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- TOC entry 3670 (class 2606 OID 267095)
-- Name: tab_configuration_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY tab_configuration
    ADD CONSTRAINT tab_configuration_fk_1 FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3672 (class 2606 OID 267100)
-- Name: tab_configuration_tab_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY tab_configuration_tab
    ADD CONSTRAINT tab_configuration_tab_fk_1 FOREIGN KEY (tab_id) REFERENCES tab(id);


--
-- TOC entry 3671 (class 2606 OID 267105)
-- Name: tab_configuration_tab_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY tab_configuration_tab
    ADD CONSTRAINT tab_configuration_tab_fk_2 FOREIGN KEY (tab_configuration_id) REFERENCES tab_configuration(id);


--
-- TOC entry 3674 (class 2606 OID 267110)
-- Name: user_role_map_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY user_role_map
    ADD CONSTRAINT user_role_map_fk_1 FOREIGN KEY (role_id) REFERENCES role(id);


--
-- TOC entry 3673 (class 2606 OID 267115)
-- Name: user_role_map_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY user_role_map
    ADD CONSTRAINT user_role_map_fk_2 FOREIGN KEY (user_id) REFERENCES base_user(id);


--
-- TOC entry 3565 (class 2606 OID 267120)
-- Name: validation_rule_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY meta_field_name
    ADD CONSTRAINT validation_rule_fk_1 FOREIGN KEY (validation_rule_id) REFERENCES validation_rule(id);


--
-- TOC entry 3675 (class 2606 OID 267125)
-- Name: validation_rule_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: openbrm_demo
--

ALTER TABLE ONLY validation_rule_attributes
    ADD CONSTRAINT validation_rule_fk_2 FOREIGN KEY (validation_rule_id) REFERENCES validation_rule(id);


--
-- TOC entry 4032 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-10-29 14:58:59

--
-- PostgreSQL database dump complete
--

