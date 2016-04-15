CREATE DATABASE omdb;

\c omdb

CREATE TABLE movies (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(100),
  year VARCHAR(50),
  rated VARCHAR(50),
  released VARCHAR(50),
  runtime VARCHAR(50),
  genre VARCHAR(200),
  director VARCHAR(500),
  writer VARCHAR(500),
  actors VARCHAR(500),
  plot VARCHAR(5000),
  language VARCHAR(50),
  country VARCHAR(100),
  awards VARCHAR(500),
  poster VARCHAR(5000),
  metascore VARCHAR(5000),
  imdbrating VARCHAR(50),
  imdbvotes VARCHAR(5000),
  imdbid VARCHAR(50),
  type VARCHAR(50),
  response VARCHAR(50)
);
