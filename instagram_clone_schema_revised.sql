--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

-- Started on 2023-02-08 14:53:11 MST

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
-- TOC entry 3712 (class 1262 OID 16390)
-- Name: Instagram Clone; Type: DATABASE; Schema: -; Owner: jongauer
--

CREATE DATABASE "Instagram Clone" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';


ALTER DATABASE "Instagram Clone" OWNER TO jongauer;

\connect -reuse-previous=on "dbname='Instagram Clone'"

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
-- TOC entry 3713 (class 0 OID 0)
-- Dependencies: 3712
-- Name: DATABASE "Instagram Clone"; Type: COMMENT; Schema: -; Owner: jongauer
--

COMMENT ON DATABASE "Instagram Clone" IS 'Reverse-engineering the database structure of Instagram';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 229 (class 1259 OID 16519)
-- Name: caption_mentions; Type: TABLE; Schema: public; Owner: jongauer
--

CREATE TABLE public.caption_mentions (
    row_id integer NOT NULL,
    user_id integer,
    post_id integer,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.caption_mentions OWNER TO jongauer;

--
-- TOC entry 219 (class 1259 OID 16427)
-- Name: comments; Type: TABLE; Schema: public; Owner: jongauer
--

CREATE TABLE public.comments (
    comment_id integer NOT NULL,
    content character varying(280),
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.comments OWNER TO jongauer;

--
-- TOC entry 218 (class 1259 OID 16426)
-- Name: comments_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: jongauer
--

CREATE SEQUENCE public.comments_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_comment_id_seq OWNER TO jongauer;

--
-- TOC entry 3714 (class 0 OID 0)
-- Dependencies: 218
-- Name: comments_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jongauer
--

ALTER SEQUENCE public.comments_comment_id_seq OWNED BY public.comments.comment_id;


--
-- TOC entry 221 (class 1259 OID 16452)
-- Name: followers; Type: TABLE; Schema: public; Owner: jongauer
--

CREATE TABLE public.followers (
    row_id integer NOT NULL,
    followed_user_id integer NOT NULL,
    follower_id integer NOT NULL,
    CONSTRAINT followers_check CHECK ((follower_id <> followed_user_id))
);


ALTER TABLE public.followers OWNER TO jongauer;

--
-- TOC entry 220 (class 1259 OID 16451)
-- Name: followers_row_id_seq; Type: SEQUENCE; Schema: public; Owner: jongauer
--

CREATE SEQUENCE public.followers_row_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.followers_row_id_seq OWNER TO jongauer;

--
-- TOC entry 3715 (class 0 OID 0)
-- Dependencies: 220
-- Name: followers_row_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jongauer
--

ALTER SEQUENCE public.followers_row_id_seq OWNED BY public.followers.row_id;


--
-- TOC entry 225 (class 1259 OID 16495)
-- Name: hashtags; Type: TABLE; Schema: public; Owner: jongauer
--

CREATE TABLE public.hashtags (
    hashtag_id integer NOT NULL,
    hashtag_text character varying(50) NOT NULL
);


ALTER TABLE public.hashtags OWNER TO jongauer;

--
-- TOC entry 224 (class 1259 OID 16494)
-- Name: hashtags_hashtag_id_seq; Type: SEQUENCE; Schema: public; Owner: jongauer
--

CREATE SEQUENCE public.hashtags_hashtag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hashtags_hashtag_id_seq OWNER TO jongauer;

--
-- TOC entry 3716 (class 0 OID 0)
-- Dependencies: 224
-- Name: hashtags_hashtag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jongauer
--

ALTER SEQUENCE public.hashtags_hashtag_id_seq OWNED BY public.hashtags.hashtag_id;


--
-- TOC entry 223 (class 1259 OID 16472)
-- Name: likes; Type: TABLE; Schema: public; Owner: jongauer
--

CREATE TABLE public.likes (
    like_id integer NOT NULL,
    comment_id integer NOT NULL,
    liker_id integer NOT NULL,
    post_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT type_of_like CHECK (((COALESCE(((post_id)::boolean)::integer, 0) + COALESCE(((comment_id)::boolean)::integer, 0)) = 1))
);


ALTER TABLE public.likes OWNER TO jongauer;

--
-- TOC entry 222 (class 1259 OID 16471)
-- Name: likes_like_id_seq; Type: SEQUENCE; Schema: public; Owner: jongauer
--

CREATE SEQUENCE public.likes_like_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.likes_like_id_seq OWNER TO jongauer;

--
-- TOC entry 3717 (class 0 OID 0)
-- Dependencies: 222
-- Name: likes_like_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jongauer
--

ALTER SEQUENCE public.likes_like_id_seq OWNED BY public.likes.like_id;


--
-- TOC entry 228 (class 1259 OID 16518)
-- Name: mentions_row_id_seq; Type: SEQUENCE; Schema: public; Owner: jongauer
--

CREATE SEQUENCE public.mentions_row_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mentions_row_id_seq OWNER TO jongauer;

--
-- TOC entry 3718 (class 0 OID 0)
-- Dependencies: 228
-- Name: mentions_row_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jongauer
--

ALTER SEQUENCE public.mentions_row_id_seq OWNED BY public.caption_mentions.row_id;


--
-- TOC entry 231 (class 1259 OID 16537)
-- Name: photo_tags; Type: TABLE; Schema: public; Owner: jongauer
--

CREATE TABLE public.photo_tags (
    tag_id integer NOT NULL,
    x double precision,
    y double precision,
    tagged_user_id integer NOT NULL,
    post_id integer NOT NULL
);


ALTER TABLE public.photo_tags OWNER TO jongauer;

--
-- TOC entry 230 (class 1259 OID 16536)
-- Name: photo_tags_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: jongauer
--

CREATE SEQUENCE public.photo_tags_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photo_tags_tag_id_seq OWNER TO jongauer;

--
-- TOC entry 3719 (class 0 OID 0)
-- Dependencies: 230
-- Name: photo_tags_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jongauer
--

ALTER SEQUENCE public.photo_tags_tag_id_seq OWNED BY public.photo_tags.tag_id;


--
-- TOC entry 227 (class 1259 OID 16502)
-- Name: post_hashtags; Type: TABLE; Schema: public; Owner: jongauer
--

CREATE TABLE public.post_hashtags (
    row_id integer NOT NULL,
    hashtag_id integer NOT NULL,
    post_id integer NOT NULL
);


ALTER TABLE public.post_hashtags OWNER TO jongauer;

--
-- TOC entry 226 (class 1259 OID 16501)
-- Name: post_hashtags_row_id_seq; Type: SEQUENCE; Schema: public; Owner: jongauer
--

CREATE SEQUENCE public.post_hashtags_row_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_hashtags_row_id_seq OWNER TO jongauer;

--
-- TOC entry 3720 (class 0 OID 0)
-- Dependencies: 226
-- Name: post_hashtags_row_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jongauer
--

ALTER SEQUENCE public.post_hashtags_row_id_seq OWNED BY public.post_hashtags.row_id;


--
-- TOC entry 217 (class 1259 OID 16412)
-- Name: posts; Type: TABLE; Schema: public; Owner: jongauer
--

CREATE TABLE public.posts (
    post_id integer NOT NULL,
    caption character varying(280),
    url character varying(300) NOT NULL,
    lat numeric,
    lng numeric,
    user_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    CONSTRAINT latitude_in_range CHECK (((lat <= (90)::numeric) AND (lat >= ('-90'::integer)::numeric))),
    CONSTRAINT longitude_in_range CHECK (((lng <= (180)::numeric) AND (lng >= ('-180'::integer)::numeric)))
);


ALTER TABLE public.posts OWNER TO jongauer;

--
-- TOC entry 216 (class 1259 OID 16411)
-- Name: posts_post_id_seq; Type: SEQUENCE; Schema: public; Owner: jongauer
--

CREATE SEQUENCE public.posts_post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_post_id_seq OWNER TO jongauer;

--
-- TOC entry 3721 (class 0 OID 0)
-- Dependencies: 216
-- Name: posts_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jongauer
--

ALTER SEQUENCE public.posts_post_id_seq OWNED BY public.posts.post_id;


--
-- TOC entry 215 (class 1259 OID 16392)
-- Name: users; Type: TABLE; Schema: public; Owner: jongauer
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(25) NOT NULL,
    bio character varying(300),
    avatar character varying(300),
    phone character varying(18),
    email character varying(50),
    pw character varying(50) NOT NULL,
    status character varying(15),
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT users_check CHECK ((COALESCE(email, phone) IS NOT NULL))
);


ALTER TABLE public.users OWNER TO jongauer;

--
-- TOC entry 214 (class 1259 OID 16391)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: jongauer
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO jongauer;

--
-- TOC entry 3722 (class 0 OID 0)
-- Dependencies: 214
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jongauer
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 3512 (class 2604 OID 16522)
-- Name: caption_mentions row_id; Type: DEFAULT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.caption_mentions ALTER COLUMN row_id SET DEFAULT nextval('public.mentions_row_id_seq'::regclass);


--
-- TOC entry 3505 (class 2604 OID 16430)
-- Name: comments comment_id; Type: DEFAULT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.comments ALTER COLUMN comment_id SET DEFAULT nextval('public.comments_comment_id_seq'::regclass);


--
-- TOC entry 3507 (class 2604 OID 16455)
-- Name: followers row_id; Type: DEFAULT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.followers ALTER COLUMN row_id SET DEFAULT nextval('public.followers_row_id_seq'::regclass);


--
-- TOC entry 3510 (class 2604 OID 16498)
-- Name: hashtags hashtag_id; Type: DEFAULT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.hashtags ALTER COLUMN hashtag_id SET DEFAULT nextval('public.hashtags_hashtag_id_seq'::regclass);


--
-- TOC entry 3508 (class 2604 OID 16475)
-- Name: likes like_id; Type: DEFAULT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.likes ALTER COLUMN like_id SET DEFAULT nextval('public.likes_like_id_seq'::regclass);


--
-- TOC entry 3514 (class 2604 OID 16540)
-- Name: photo_tags tag_id; Type: DEFAULT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.photo_tags ALTER COLUMN tag_id SET DEFAULT nextval('public.photo_tags_tag_id_seq'::regclass);


--
-- TOC entry 3511 (class 2604 OID 16505)
-- Name: post_hashtags row_id; Type: DEFAULT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.post_hashtags ALTER COLUMN row_id SET DEFAULT nextval('public.post_hashtags_row_id_seq'::regclass);


--
-- TOC entry 3503 (class 2604 OID 16415)
-- Name: posts post_id; Type: DEFAULT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.posts ALTER COLUMN post_id SET DEFAULT nextval('public.posts_post_id_seq'::regclass);


--
-- TOC entry 3501 (class 2604 OID 16395)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 3529 (class 2606 OID 16470)
-- Name: followers combination_of_followed_and_follower_must_be_unique; Type: CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT combination_of_followed_and_follower_must_be_unique UNIQUE (followed_user_id, follower_id);


--
-- TOC entry 3527 (class 2606 OID 16433)
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (comment_id);


--
-- TOC entry 3531 (class 2606 OID 16458)
-- Name: followers followers_pkey; Type: CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT followers_pkey PRIMARY KEY (row_id);


--
-- TOC entry 3537 (class 2606 OID 16500)
-- Name: hashtags hashtags_pkey; Type: CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.hashtags
    ADD CONSTRAINT hashtags_pkey PRIMARY KEY (hashtag_id);


--
-- TOC entry 3533 (class 2606 OID 16478)
-- Name: likes likes_pkey; Type: CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (like_id);


--
-- TOC entry 3545 (class 2606 OID 16525)
-- Name: caption_mentions mentions_pkey; Type: CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.caption_mentions
    ADD CONSTRAINT mentions_pkey PRIMARY KEY (row_id);


--
-- TOC entry 3539 (class 2606 OID 16577)
-- Name: hashtags no_duplicate_hashtags; Type: CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.hashtags
    ADD CONSTRAINT no_duplicate_hashtags UNIQUE (hashtag_text);


--
-- TOC entry 3541 (class 2606 OID 16589)
-- Name: post_hashtags no_duplicate_hashtags_per_post; Type: CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.post_hashtags
    ADD CONSTRAINT no_duplicate_hashtags_per_post UNIQUE (hashtag_id, post_id);


--
-- TOC entry 3535 (class 2606 OID 16585)
-- Name: likes no_duplicate_likes; Type: CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT no_duplicate_likes UNIQUE (liker_id, comment_id, post_id);


--
-- TOC entry 3549 (class 2606 OID 16587)
-- Name: photo_tags no_duplicate_tags; Type: CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.photo_tags
    ADD CONSTRAINT no_duplicate_tags UNIQUE (tagged_user_id, post_id);


--
-- TOC entry 3551 (class 2606 OID 16542)
-- Name: photo_tags photo_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.photo_tags
    ADD CONSTRAINT photo_tags_pkey PRIMARY KEY (tag_id);


--
-- TOC entry 3543 (class 2606 OID 16507)
-- Name: post_hashtags post_hashtags_pkey; Type: CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.post_hashtags
    ADD CONSTRAINT post_hashtags_pkey PRIMARY KEY (row_id);


--
-- TOC entry 3525 (class 2606 OID 16425)
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (post_id);


--
-- TOC entry 3547 (class 2606 OID 16564)
-- Name: caption_mentions unique_user_and_post_values; Type: CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.caption_mentions
    ADD CONSTRAINT unique_user_and_post_values UNIQUE (user_id, post_id);


--
-- TOC entry 3521 (class 2606 OID 16410)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3523 (class 2606 OID 16399)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 3553 (class 2606 OID 16610)
-- Name: comments comments_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(post_id) ON DELETE CASCADE;


--
-- TOC entry 3554 (class 2606 OID 16605)
-- Name: comments comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 3555 (class 2606 OID 16625)
-- Name: followers followers_followed_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT followers_followed_user_id_fkey FOREIGN KEY (followed_user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 3556 (class 2606 OID 16630)
-- Name: followers followers_follower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT followers_follower_id_fkey FOREIGN KEY (follower_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 3557 (class 2606 OID 16640)
-- Name: likes likes_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comments(comment_id) ON DELETE CASCADE;


--
-- TOC entry 3558 (class 2606 OID 16635)
-- Name: likes likes_liker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_liker_id_fkey FOREIGN KEY (liker_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 3559 (class 2606 OID 16645)
-- Name: likes likes_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(post_id) ON DELETE CASCADE;


--
-- TOC entry 3561 (class 2606 OID 16615)
-- Name: caption_mentions mentions_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.caption_mentions
    ADD CONSTRAINT mentions_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(post_id) ON DELETE CASCADE;


--
-- TOC entry 3562 (class 2606 OID 16620)
-- Name: caption_mentions mentions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.caption_mentions
    ADD CONSTRAINT mentions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 3563 (class 2606 OID 16650)
-- Name: photo_tags photo_tags_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.photo_tags
    ADD CONSTRAINT photo_tags_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(post_id) ON DELETE CASCADE;


--
-- TOC entry 3564 (class 2606 OID 16655)
-- Name: photo_tags photo_tags_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.photo_tags
    ADD CONSTRAINT photo_tags_user_id_fkey FOREIGN KEY (tagged_user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 3560 (class 2606 OID 16665)
-- Name: post_hashtags post_hashtags_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.post_hashtags
    ADD CONSTRAINT post_hashtags_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(post_id) ON DELETE CASCADE;


--
-- TOC entry 3552 (class 2606 OID 16670)
-- Name: posts posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jongauer
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


-- Completed on 2023-02-08 14:53:11 MST

--
-- PostgreSQL database dump complete
--

