-- 1 up
CREATE EXTENSION IF NOT EXISTS citext; 

-- 1 down
DROP EXTENSION citext;

-- 2 up
create table if not exists users (
  id    serial primary key,
  email citext not null UNIQUE,
  username citext,
  password  text not null
);

-- 2 down
drop table if exists users;