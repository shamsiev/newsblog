CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE users
  ( user_id uuid
      NOT NULL DEFAULT gen_random_uuid()
      PRIMARY KEY
  , user_name TEXT NOT NULL
  , user_surname TEXT NOT NULL
  , user_avatar TEXT NOT NULL
  , user_created_at TIMESTAMP NOT NULL
  , user_is_admin BOOLEAN NOT NULL
  , user_password TEXT NOT NULL
  );

CREATE TABLE authors
  ( author_id uuid PRIMARY KEY
  , author_name TEXT NOT NULL
  , author_description TEXT NOT NULL
  );

CREATE TABLE categories
  ( category_id INT PRIMARY KEY
  , category_name TEXT NOT NULL
  , category_parent_id INT
      REFERENCES categories (category_id)
      ON UPDATE CASCADE ON DELETE NO ACTION
  );

CREATE TABLE tags
  ( tag_id INT PRIMARY KEY
  , tag_name TEXT NOT NULL
  );

CREATE TABLE articles
  ( article_id INT PRIMARY KEY
  , article_author_id uuid
      REFERENCES authors (author_id)
      ON UPDATE CASCADE ON DELETE SET NULL
  , article_name TEXT NOT NULL
  , article_text TEXT NOT NULL
  , article_created_at TIMESTAMP NOT NULL
  , article_category_id INT
    REFERENCES categories (category_id)
    ON UPDATE CASCADE ON DELETE NO ACTION
  );

CREATE TABLE comments
  ( comment_id INT PRIMARY KEY
  , comment_article_id INT NOT NULL
    REFERENCES articles (article_id)
    ON UPDATE CASCADE ON DELETE CASCADE
  , comment_user_id uuid
    REFERENCES users (user_id)
    ON UPDATE CASCADE ON DELETE SET NULL
  , comment_text TEXT NOT NULL
  , comment_created_at TIMESTAMP NOT NULL
  , comment_edited_at TIMESTAMP
  );
