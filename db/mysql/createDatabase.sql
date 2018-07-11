DROP DATABASE IF EXISTS puzzle_game;
CREATE DATABASE IF NOT EXISTS puzzle_game;
USE puzzle_game;

DROP USER IF EXISTS 'puzzle_game_dba'@'localhost';
CREATE USER 'puzzle_game_dba'@'localhost' IDENTIFIED BY 'dba_pw';
GRANT ALL ON puzzle_game.* TO 'puzzle_game_dba'@'localhost';

DROP USER IF EXISTS 'puzzle_game_user'@'localhost';
CREATE USER 'puzzle_game_user'@'localhost' IDENTIFIED BY 'user_pw';
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON puzzle_game.* TO 'puzzle_game_user'@'localhost';
