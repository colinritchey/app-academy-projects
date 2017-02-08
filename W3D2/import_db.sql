DROP TABLE if exists users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE if exists questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE if exists question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  question_id INTEGER,

  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE if exists replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  parent_id INTEGER,
  body TEXT NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);

DROP TABLE if exists question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Bob', 'Dole'),
  ('Hank', 'Hill'),
  ('Hank', 'Hill_v2');

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('Presidential', 'Why i didnt win?', (SELECT id From users where fname='Bob' and lname='Dole')),
  ('Propane', 'Why is Propane better?', (SELECT id From users where fname='Hank' and lname='Hill')),
  ('Son', 'Bobby why?', (SELECT id From users where fname='Hank' and lname='Hill_v2')),
  ('Boomhauer', 'Why can''t he speak?', (SELECT id From users where fname='Hank' and lname='Hill_v2'));

INSERT INTO
  question_follows(user_id, question_id)
VALUES
  (1, 2),
  (2, 3),
  (3, 1),
  (3, 2);

INSERT INTO
  replies(question_id, user_id, parent_id, body)
VALUES
  (1, 2, NULL, 'Because you aren''t from Texas'),
  (1, 3, 1, 'Yeah!'),
  (1, 1, 1, 'BOB DOLE'),
  (1, 3, NULL, 'Didn''t let robots vote'),
  (2, 1, NULL, 'BOB DOLE');

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  (2, 3),
  (3, 2),
  (1, 2),
  (3, 3),
  (1, 3);
