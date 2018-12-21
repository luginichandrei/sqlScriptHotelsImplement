

USE TESTAND;

CREATE TABLE hotels(
	id INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	[Name] NVARCHAR (255),
	[Foundation_year] INT,
	[Adress] NVARCHAR (255),
	[Is active] BIT NULL DEFAULT 0,
); 

CREATE TABLE rooms (
	[id] int IDENTITY (1,1) NOT NULL PRIMARY KEY,
	[Number] INT,
	[Price] INT,
	[Comfort_level] INT,
	[Capability] INT,
	[Hotels_id] INT,
	FOREIGN KEY (Hotels_id) REFERENCES hotels(id) 
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
);

CREATE TABLE users (
	[id] INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	[Name] NVARCHAR(255),
	[Email] NVARCHAR (255) 
);

CREATE TABLE checkouts (
	[id] INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	[user_id] INT  NOT NULL,
	[room_id] INT NOT NULL,
	[start_date] datetime,
	[end_date] datetime,
	FOREIGN KEY (user_id) REFERENCES users(id)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	FOREIGN KEY (room_id) REFERENCES rooms(id)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
);

INSERT INTO hotels VALUES ('Edelweiss', 1354, 'Chernivtsi', 1);
INSERT INTO hotels VALUES ('Kyiv', 2001, 'Chernivtsi', 1);
INSERT INTO hotels VALUES ('Bukovina', 1941, 'Chernivtsi', 1);

SELECT * FROM hotels;

UPDATE hotels 
SET 
	Foundation_year = 1937
WHERE
	 id = 1;

SELECT * FROM hotels;

DELETE FROM hotels
WHERE id=3;

SELECT * FROM hotels;
INSERT INTO users VALUES ('Kolia', 'k@k.ua');
INSERT INTO users VALUES ('Bohdan', 'b@b.ua');
INSERT INTO users VALUES ('Lesia', 'l@l.ua');
INSERT INTO users VALUES ('Misha', 'm@m.ua');
INSERT INTO users VALUES ('Steve', 's@s.ua');
INSERT INTO users VALUES ('Stepan', 'st@st.ua');
INSERT INTO users VALUES ('Mike', 'mk@mk.ua');
INSERT INTO users VALUES ('Roman', 'r@r.ua');
INSERT INTO users VALUES ('Anton', 'a@a.ua');
INSERT INTO users VALUES ('Andrew', 'an@an.ua');

SELECT * FROM users
ORDER BY Name;

INSERT INTO rooms VALUES( 101, 2,1, 1,1);
INSERT INTO rooms VALUES( 301, 23,2, 1,1);
INSERT INTO rooms VALUES( 102, 34,2, 1,1);
INSERT INTO rooms VALUES( 205, 12,1, 1,1);
INSERT INTO rooms VALUES( 206, 65,2, 1,1);
INSERT INTO rooms VALUES( 221, 787,2, 1,1);
INSERT INTO rooms VALUES( 211, 787,2, 1,1);
INSERT INTO rooms VALUES( 101, 787,2, 1,2);
INSERT INTO rooms VALUES( 201, 678,3, 1,2);
INSERT INTO rooms VALUES( 401, 456,4, 1,2);

SELECT * FROM rooms JOIN hotels
ON hotels.Name='Edelweiss'
ORDER BY PRICE;

SELECT Name FROM hotels JOIN rooms
ON hotels.id=rooms.Hotels_id
WHERE Comfort_level = 3;

SELECT hotels.Name, rooms.Number FROM hotels JOIN rooms
ON hotels.id=rooms.Hotels_id
WHERE Comfort_level = 1;

SELECT hotels.Name, COUNT(rooms.id) AS roomsCount
FROM hotels join rooms
ON hotels.id=rooms.Hotels_id
GROUP BY hotels.Name;



INSERT INTO checkouts VALUES( 1, 1, convert(datetime,'20-12-18 10:34:09 AM',5), convert(datetime,'22-12-18 10:34:09 AM',5));
INSERT INTO checkouts VALUES( 1, 4, convert(datetime,'21-12-18 10:34:09 AM',5), convert(datetime,'27-02-19 10:34:09 AM',5));
INSERT INTO checkouts VALUES( 1, 4, convert(datetime,'19-12-18 10:34:09 AM',5), convert(datetime,'25-12-18 10:34:09 AM',5));
INSERT INTO checkouts VALUES( 3, 2, convert(datetime,'22-12-18 10:34:09 AM',5), convert(datetime,'29-09-19 10:34:09 AM',5));
INSERT INTO checkouts VALUES( 3, 1, convert(datetime,'1-12-18 10:34:09 AM',5), convert(datetime,'12-12-18 10:34:09 AM',5));
INSERT INTO checkouts VALUES( 5, 2, convert(datetime,'3-12-18 10:34:09 AM',5), convert(datetime,'17-12-18 10:34:09 AM',5));
INSERT INTO checkouts VALUES( 2, 6, convert(datetime,'7-12-18 10:34:09 AM',5), convert(datetime,'22-04-19 10:34:09 AM',5));
INSERT INTO checkouts VALUES( 2, 8, convert(datetime,'3-12-18 10:34:09 AM',5), convert(datetime,'22-12-18 10:34:09 AM',5));
INSERT INTO checkouts VALUES( 8, 6, convert(datetime,'31-12-18 10:34:09 AM',5), convert(datetime,'02-02-19 10:34:09 AM',5));
INSERT INTO checkouts VALUES( 5, 6, convert(datetime,'6-12-18 10:34:09 AM',5), convert(datetime,'21-12-18 10:34:09 AM',5));



SELECT users.Name, rooms.Number, checkouts.start_date, checkouts.end_date
FROM users 
LEFT JOIN checkouts ON checkouts.user_id=users.id
LEFT JOIN rooms ON checkouts.room_id=rooms.id;

