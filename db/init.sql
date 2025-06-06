CREATE DATABASE IF NOT EXISTS exampledb;
USE exampledb;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO users (name, email)
VALUES ('Anna Nowak', 'anna@example.com'),
       ('Jan Kowalski', 'jan@example.com');
