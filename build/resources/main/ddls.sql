create table cities(
	id BIGSERIAL not null primary key,
	"name" varchar(150) not null
);

comment on table cities is 'Holds information about cities';
comment on column cities.id is 'Primary key table';
comment on column cities."name" is 'City name';

create table cinemas(
	id BIGSERIAL not null primary key,
	"name" varchar(150) not null,
	city_id bigint not null,
	CONSTRAINT fk_cinema_city FOREIGN KEY (city_id) REFERENCES cities (id)
);

comment on table cinemas is 'Holds information about cinemas';
comment on column cinemas.id is 'Primary key table';
comment on column cinemas."name" is 'Cinema name';
comment on column cinemas.city_id is 'Reference to city whom cinema belongs';

create table movies(
	id BIGSERIAL not null primary key,
	"name" varchar(150) not null,
	duration smallint not null
);

comment on table movies is 'Holds information about movies';
comment on column movies.id is 'Primary key table';
comment on column movies."name" is 'Movie name';
comment on column movies.duration is 'Movie duration in minutes';

create table users(
	id BIGSERIAL not null primary key,
	"name" varchar(150) not null,
	email varchar(150) not null
);

comment on table users is 'Holds information about users';
comment on column users.id is 'Primary key table';
comment on column users."name" is 'User name';
comment on column users.email is 'User email';

create type room_type as ENUM('NORMAL','3D');

create table rooms(
	id BIGSERIAL not null primary key,
	"name" varchar(150) not null,
	"type" room_type not null
);

comment on table rooms is 'Holds information about rooms';
comment on column rooms.id is 'Primary key table';
comment on column rooms."name" is 'Room name';
comment on column rooms."type" is 'Say about room features ex.: 3D';

create type seat_type as ENUM('NORMAL', 'WHEELCHAIR_USER', 'OBESE');

create table seats(
	id BIGSERIAL not null primary key,
	description varchar(150) not null,
	"order" smallint not null,
	"row" char(1) not null,
	"type" seat_type not null,
	room_id bigint not null,
	CONSTRAINT fk_room_seat FOREIGN KEY (room_id) REFERENCES rooms(id)
);

comment on table seats is 'Holds information about seats in rooms';
comment on column seats.id is 'Primary key table';
comment on column seats.description is 'Seat description';
comment on column seats."order" is 'Seat position in row';
comment on column seats."row" is 'Row whom a seat belongs';
comment on column seats."type" is 'Say if a seat is a standard or adapted';
comment on column seats.room_id is 'Room whom seat belongs';

create table sessions(
	id BIGSERIAL not null primary key,
	"name" varchar(150) not null,
	start_date TIMESTAMP not null,
	end_date TIMESTAMP not null,
	price numeric(12, 2) NOT NULL,
	room_id bigint not null,
	movie_id bigint not null,
	cinema_id bigint not null,
	CONSTRAINT fk_session_room FOREIGN KEY (room_id) REFERENCES rooms (id),
	CONSTRAINT fk_session_movie FOREIGN KEY (movie_id) REFERENCES movies (id),
	CONSTRAINT fk_session_cinema FOREIGN KEY (cinema_id) REFERENCES cinemas (id)
);

comment on table sessions is 'Holds information about sessions';
comment on column sessions.id is 'Primary key table';
comment on column sessions."name" is 'Session name' ;
comment on column sessions.start_date is 'when the session start' ;
comment on column sessions.end_date is  'when the session finish' ;
comment on column sessions.price is 'Cost for watch a session' ;
comment on column sessions.room_id is 'Room where the movie will be shown ' ;
comment on column sessions.movie_id is 'Movie whom will be shown' ;
comment on column sessions.cinema_id is 'Cinema where session is shown' ;

create table tickets(
	id BIGSERIAL not null primary key,
	price decimal(12,2) not null,
	user_id bigint not null,
	session_id bigint not null,
	seat_id bigint not null,
	CONSTRAINT fk_user_ticket FOREIGN KEY (user_id) REFERENCES users (id),
	CONSTRAINT fk_ticket_seat FOREIGN KEY (seat_id) REFERENCES public.seats(id),
	CONSTRAINT fk_session_ticket FOREIGN KEY (session_id) REFERENCES sessions (id)
);

comment on table tickets is 'Holds information about tickets';
comment on column tickets.id is 'Primary key table';
comment on column tickets.price is 'Cost spent in a ticket' ;
comment on column tickets.user_id is 'User whom bought a ticket' ;
comment on column tickets.session_id is 'Session whom ticket allow user watch' ;
comment on column tickets.seat_id is 'Seat choice by user' ;