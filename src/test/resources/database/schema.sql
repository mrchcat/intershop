DROP TABLE IF EXISTS order_item CASCADE;
DROP TABLE IF EXISTS cart_item CASCADE;
DROP TABLE IF EXISTS items CASCADE;
DROP TABLE IF EXISTS carts CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  email VARCHAR(256) NOT NULL,
  name VARCHAR(256) NOT NULL
);

CREATE TABLE IF NOT EXISTS items(
  id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  article_number uuid NOT NULL UNIQUE,
  name VARCHAR(256) NOT NULL CHECK(name<>''),
  description TEXT NOT NULL CHECK(name<>''),
  picture_path VARCHAR(1000),
  price NUMERIC(14,2) CHECK(price>=0),
  unit VARCHAR(256) NOT NULL CHECK(name<>'')
);

CREATE TABLE orders (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  number VARCHAR(256) CHECK(number<>''),
  user_id BIGINT REFERENCES users(id) NOT NULL,
  created TIMESTAMP,
  total_sum NUMERIC(14,2) CHECK(total_sum>=0)
);

CREATE TABLE order_item (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  order_id BIGINT REFERENCES orders(id) NOT NULL,
  item_id BIGINT REFERENCES items(id) NOT NULL,
  quantity BIGINT NOT NULL CHECK(quantity>0),
  unit VARCHAR(256) NOT NULL,
  price NUMERIC(14,2) NOT NULL CHECK(price>=0),
  sum NUMERIC(14,2) NOT NULL CHECK(price>=0),
  UNIQUE (order_id, item_id)
);

CREATE TABLE carts(
  id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  user_id BIGINT REFERENCES users(id) NOT NULL
);

CREATE TABLE cart_item (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  cart_id BIGINT REFERENCES carts(id) NOT NULL,
  item_id BIGINT REFERENCES items(id) NOT NULL,
  quantity BIGINT NOT NULL
);
