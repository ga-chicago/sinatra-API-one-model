DROP DATABASE IF EXISTS item2;

CREATE DATABASE item2;

\c item2

CREATE TABLE items(
  id SERIAL PRIMARY KEY,
  title VARCHAR(255)
);

CREATE TABLE users (id SERIAL PRIMARY KEY, username varchar(255), password_digest varchar(255));
