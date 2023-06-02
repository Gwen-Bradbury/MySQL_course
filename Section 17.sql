CREATE DATABASE ig_clone;
USE ig_clone;
CREATE TABLE users (
	id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);
SELECT * FROM users;
DESC users;
INSERT INTO users (username) 
	VALUES ('BlueTheCat'),
		   ('CharlieBrown'),
           ('ColtSteele');
           
CREATE TABLE photos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);
SHOW TABLES;
DESC photos;
SELECT * FROM users;
INSERT INTO photos (image_url, user_id) 
	VALUES ('/alskjd76', 1),
		   ('/bkugbh89', 2),
           ('/90cesdtf', 2);
SELECT * FROM photos;
SELECT * FROM photos
JOIN users ON users.id = photos.user_id;
SELECT photos.image_url, users.username FROM photos
JOIN users ON users.id = photos.user_id;

CREATE TABLE comments (
	id INT AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id)
);
DESC comments;
SHOW tables;
INSERT INTO comments (comment_text, user_id, photo_id)
	VALUES ('Meow', 1, 2),
		   ('Amazing Shot!', 3, 2),
           ('I <3 This!', 2, 1);
SELECT * FROM comments;

CREATE TABLE likes (
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    PRIMARY KEY(user_id, photo_id) -- makes sure that you can only make one like with that user_id and photo_id combination.
);
DESC likes;
SHOW TABLES;
INSERT INTO likes (user_id, photo_id) 
	VALUES (1, 1),
           (2, 1),
           (1, 2),
           (1, 3),
           (3, 3);
SELECT * FROM likes;
INSERT INTO likes (user_id, photo_id) 
	VALUES (1, 1); -- Error Code: 1062. Duplicate entry.

CREATE TABLE follows (
	follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);
SHOW TABLES;
DESC follows;
INSERT INTO follows (follower_id, followee_id)
	VALUES (1, 2),
		   (1, 3),
           (3, 1),
           (2, 3);
SELECT * FROM follows;
INSERT INTO follows (follower_id, followee_id)
	VALUES (1, 3); -- Error Code: 1062. Duplicate entry.
INSERT INTO follows (follower_id, followee_id)
	VALUES (2, 1); -- It will only error when the number order is exactly the same order that went in before. eg (1, 2) was already in and it allowed us to insert (2, 1).

CREATE TABLE tags (
	id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE photo_tags (
	photo_id INT NOT NULL,
	tag_id INT NOT NULL,
    FOREIGN KEY (photo_id) REFERENCES photos(id),
    FOREIGN KEY (tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
);
SHOW TABLES;
INSERT INTO tags (tag_name)
	VALUES ('adorable'),
		   ('cute'),
           ('sunrise');
SELECT * FROM tags;
INSERT INTO photo_tags (photo_id, tag_id)
	VALUES (1, 1),
		   (1, 2),
           (2, 3),
           (3, 2);
SELECT * FROM photo_tags;
INSERT INTO photo_tags (photo_id, tag_id)
	VALUES (1, 1); -- Error Code: 1062. Duplicate entry.
