DROP DATABASE IF EXISTS item2;

CREATE DATABASE item2;

\c item2

CREATE TABLE items(
  id SERIAL PRIMARY KEY,
  title VARCHAR(255)
);

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  username VARCHAR(64),
  password_digest VARCHAR(256)
);


