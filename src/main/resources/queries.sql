-- Como usuário, quando seleciono "Cidades" quero ver a lista de cidades.
select  *
  from cities
 order by name;

-- Como usuário, quando seleciono uma cidade quero ver a lista de filmes.
select m.id,
       m."name",
       m.duration,
       s.start_date,
       s.end_date,
       cn."name",
       ct."name"
  from movies m
 inner join sessions s
    on m.id = s.movie_id
 inner join cinemas cn
    on cn.id = s.cinema_id
 inner join cities ct
    on ct.id = cn.city_id
   and ct.id = 1
 order by m."name";

-- Como usuário, quando seleciono um filme quero ver a lista de cinemas.
select cn.id,
       cn."name",
       ct."name"
  from movies m
 inner join sessions s
    on m.id = s.movie_id
   and m.id = 1
 inner join cinemas cn
    on cn.id = s.cinema_id
 inner join cities ct
    on ct.id = cn.city_id
 order by cn."name" ;

-- Como usuário, quando seleciono um cinema quero ver a lista de horários.

select c."name",
       s.id,
       s.start_date,
       s.end_date
  from cinemas c
 inner join sessions s
    on s.cinema_id = c.id
   and c.id = 1
 order by s.start_date,
       s.end_date;

-- Como usuário, quando seleciono um horário e informo o número de assentos quero ver os assentos disponíveis.

select s.start_date,
       s.end_date,
       r."name",
       r."type",
       st.id,
       st.description,
       st."order",
       st."row",
       st."type"
  from sessions s
 inner join rooms r
    on r.id = s.room_id
   and s.id = 1
 inner join seats st
    on st.room_id = r.id
   and not exists (select sub_t.seat_id
                     from sessions sub_s
                    inner join tickets sub_t
                       on sub_t.session_id = sub_s.id
                      and sub_s.id = 1
                      and st.id = sub_t.seat_id)
 order by st."row",
       st."order" ;

-- Como usuário, quando seleciono o(s) assento(s) quero ver o preço total.

select sum(se.price) total
  from seats s
 inner join rooms r
    on r.id = s.room_id
   and s.id in (1,2,3)
 inner join sessions se
    on se.room_id = r.id;

-- Como usuário, quando seleciono "Concluir Compra" quero ser redirecionado a um gateway de pagamento.

insert into tickets (
    price,
    session_id,
    seat_id,
    user_id
) (
    select s.price,
           s.id,
           st.id,
           1
      from sessions s
     inner join rooms r
        on r.id = s.room_id
       and s.id = 2
     inner join seats st
        on st.room_id = r.id
       and st.id =8
);

-- Como usuário, quando realizo o pagamento quero receber o(s) ingresso(s) por e-mail.