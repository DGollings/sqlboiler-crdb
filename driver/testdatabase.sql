-- Don't forget to maintain order here, foreign keys!
drop view if exists user_videos;
drop table if exists video_tags;
drop table if exists tags;
drop table if exists videos;
drop table if exists sponsors;
drop table if exists comments;
drop table if exists posts;
drop table if exists users;
drop table if exists type_monsters;

drop type if exists workday;
create type workday as enum('monday', 'tuesday', 'wednesday', 'thursday', 'friday');

create table users (
	id serial primary key not null
);

create table posts (
	id serial primary key not null,
	user_id int null,
	content string null,

	foreign key (user_id) references users (id)
);

CREATE TABLE comments (
	user_id int null,
	post_id int null,
	content string null,

	primary key (user_id, post_id)
);

create table sponsors (
	id serial primary key not null
);

create table videos (
	id serial primary key not null,

	user_id int not null,
	sponsor_id int unique,

	foreign key (user_id) references users (id),
	foreign key (sponsor_id) references sponsors (id)
);

create table tags (
	id serial primary key not null
);

create table video_tags (
	video_id int not null,
	tag_id int not null,

	primary key (video_id, tag_id),
	foreign key (video_id) references videos (id),
	foreign key (tag_id) references tags (id)
);

create table type_monsters (
    id serial primary key not null,

    enum_use        workday not null,
    enum_nullable   workday,

    bool_zero   bool,
    bool_one    bool null,
    bool_two    bool not null,
    bool_three  bool null default false,
    bool_four   bool null default true,
    bool_five   bool not null default false,
    bool_six    bool not null default true,

    string_zero   varchar(1),
    string_one    varchar(1) null,
    string_two    varchar(1) not null,
    string_three  varchar(1) null default 'a',
    string_four   varchar(1) not null default 'b',
    string_five   varchar(1000),
    string_six    varchar(1000) null,
    string_seven  varchar(1000) not null,
    string_eight  varchar(1000) null default 'abcdefgh',
    string_nine   varchar(1000) not null default 'abcdefgh',
    string_ten    varchar(1000) null default '',
    string_eleven varchar(1000) not null default '',

    nonbyte_zero   char(1),
    nonbyte_one    char(1) null,
    nonbyte_two    char(1) not null,
    nonbyte_three  char(1) null default 'a',
    nonbyte_four   char(1) not null default 'b',
    nonbyte_five   char(1000),
    nonbyte_six    char(1000) null,
    nonbyte_seven  char(1000) not null,
    nonbyte_eight  char(1000) null default 'a',
    nonbyte_nine   char(1000) not null default 'b',

    byte_zero   "char",
    byte_one    "char" null,
    byte_two    "char" null default 'a',
    byte_three  "char" not null,
    byte_four   "char" not null default 'b',

    big_int_zero  bigint,
    big_int_one   bigint null,
    big_int_two   bigint not null,
    big_int_three bigint null default 111111,
    big_int_four  bigint not null default 222222,
    big_int_five  bigint null default 0,
    big_int_six   bigint not null default 0,

    int_zero  int,
    int_one   int null,
    int_two   int not null,
    int_three int null default 333333,
    int_four  int not null default 444444,
    int_five  int null default 0,
    int_six   int not null default 0,

    float_zero  decimal,
    float_one   numeric,
    float_two   numeric(2,1),
    float_three numeric(2,1),
    float_four  numeric(2,1) null,
    float_five  numeric(2,1) not null,
    float_six   numeric(2,1) null default 1.1,
    float_seven numeric(2,1) not null default 1.1,
    float_eight numeric(2,1) null default 0.0,
    float_nine  numeric(2,1) null default 0.0,

    bytea_zero  bytea,
    bytea_one   bytea null,
    bytea_two   bytea not null,
    bytea_three bytea not null default 'a',
    bytea_four  bytea null default 'b',
    bytea_five  bytea not null default 'abcdefghabcdefghabcdefgh',
    bytea_six   bytea null default 'hgfedcbahgfedcbahgfedcba',
    bytea_seven bytea not null default '',
    bytea_eight bytea not null default '',

    time_zero   timestamp,
    time_one    date,
    time_two    timestamp null default null,
    time_three  timestamp null,
    time_four   timestamp not null,
    time_five   timestamp null default '1999-01-08 04:05:06.789',
    time_six    timestamp null default '1999-01-08 04:05:06.789-8:00',
    time_seven  timestamp not null default '1999-01-08 04:05:06.789',
    time_eight  timestamp not null default '1999-01-08 04:05:06.789-8:00',
    time_nine   date null,
    time_ten    date      not null,
    time_eleven date null default '1999-01-08',
    time_twelve date      not null default '1999-01-08',

    uuid_zero  uuid,
    uuid_one   uuid null,
    uuid_two   uuid null default null,
    uuid_three uuid not null,
    uuid_four  uuid null default '6ba7b810-9dad-11d1-80b4-00c04fd430c8',
    uuid_five  uuid not null default '6ba7b810-9dad-11d1-80b4-00c04fd430c8',

    integer_default integer default '5'::integer,
    varchar_default varchar(1000) default 5::varchar,
    timestamp_notz  timestamp without time zone default (now()),
    timestamp_tz    timestamp with time zone default (now()),
    interval_nnull  interval not null default '21 days',
    interval_null   interval null default '23 hours',

    json_null   json null,
    json_nnull  json not null,
    jsonb_null  jsonb null,
    jsonb_nnull jsonb not null,

    double_prec_null  double precision null,
    double_prec_nnull double precision not null,

    inet_null  inet null,
    inet_nnull inet not null,

    intarr_null      integer[] null,
    intarr_nnull     integer[] not null,
    boolarr_null     boolean[] null,
    boolarr_nnull    boolean[] not null,
    varchararr_null  varchar[] null,
    varchararr_nnull varchar[] not null,
    decimalarr_null  decimal[] null,
    decimalarr_nnull decimal[] not null,
    byteaarr_null    bytea[] null,
    byteaarr_nnull   bytea[] not null,

    base text null,

    generated_nnull text NOT NULL GENERATED ALWAYS AS (UPPER(base)) STORED,
    generated_null text NULL GENERATED ALWAYS AS (UPPER(base)) STORED
);

create view user_videos as
select u.id user_id, v.id video_id, v.sponsor_id sponsor_id
from users u
inner join videos v on v.user_id = u.id;
