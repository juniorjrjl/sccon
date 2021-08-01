create table cities(
	id BIGSERIAL not null primary key,
	"name" varchar(150) not null
);

create table cinemas(
	id BIGSERIAL not null primary key,
	"name" varchar(150) not null,
	city_id bigint not null,
	CONSTRAINT fk_cinema_city FOREIGN KEY (city_id) REFERENCES cities (id)
);

create table films(
	id BIGSERIAL not null primary key,
	"name" varchar(150) not null,
	duration smallint not null
);

create table users(
	id BIGSERIAL not null primary key,
	"name" varchar(150) not null,
	email varchar(150) not null
);

create type room_type as ENUM('NORMAL','3D');

create table rooms(
	id BIGSERIAL not null primary key,
	"name" varchar(150) not null,
	"type" room_type not null
);

create type seat_type as ENUM('NORMAL', 'WHEELCHAIR_USER', 'OBESE');

create table seats(
	id BIGSERIAL not null primary key,
	description varchar(150) not null,
	"order" smallint not null,
	"row" char(1) not null,
	"type" seat_type not null,
	room_id int8 NULL,
	CONSTRAINT fk_room_seat FOREIGN KEY (room_id) REFERENCES rooms(id)
);

create table sessions(
	id BIGSERIAL not null primary key,
	"name" varchar(150) not null,
	start_date TIMESTAMP not null,
	end_date TIMESTAMP not null,
	price numeric(12, 2) NOT NULL,
	room_id bigint not null,
	film_id bigint not null,
	cinema_id bigint not null,
	CONSTRAINT fk_session_room FOREIGN KEY (room_id) REFERENCES rooms (id),
	CONSTRAINT fk_session_film FOREIGN KEY (film_id) REFERENCES films (id),
	CONSTRAINT fk_session_cinema FOREIGN KEY (cinema_id) REFERENCES cinemas (id)
);

create table tickets(
	id BIGSERIAL not null primary key,
	price decimal(12,2) not null,
	user_id bigint not null,
	session_id bigint not null,
	seat_id int8 NULL,
	CONSTRAINT fk_user_ticket FOREIGN KEY (user_id) REFERENCES users (id),
	CONSTRAINT fk_ticket_seat FOREIGN KEY (seat_id) REFERENCES public.seats(id),
	CONSTRAINT fk_session_ticket FOREIGN KEY (session_id) REFERENCES sessions (id)
);