CREATE DATABASE Shareoutwardz;
GO


USE Shareoutwardz


CREATE TABLE SHAREOUTWARDZ
(
	ShareoutwardzID int PRIMARY KEY,
    URL varchar(200) NOT NULL,
	ServerLocation varchar(300) NOT NULL,
    Partner varchar(200) NULL
);

CREATE TABLE [USER]
(
	UserID int IDENTITY(1, 1) PRIMARY KEY,
	URL varchar(50) NOT NULL,
	Name varchar(20) NOT NULL,
    Password varchar(50) NOT NULL,
    Email varchar(100) NOT NULL,
    Age int NOT NULL,
    Gender char(1) NOT NULL,
    Location varchar(50) NOT NULL,
    Description varchar(200) NULL,
    NbFollower int NULL DEFAULT 0,
    Rating int NULL DEFAULT 0
);

CREATE TABLE STREAM
(
	StreamID int IDENTITY(1, 1) PRIMARY KEY,
	Lifetime time NOT NULL,
    Language char(2) NOT NULL,
    Category varchar(20) NULL,
    [18+] bit NOT NULL
);

CREATE TABLE FOLLOWER
(
	UserID int PRIMARY KEY,
	Notification bit NOT NULL DEFAULT 0,
    FollowedPeople int NULL DEFAULT 0
);


CREATE TABLE PRIVATE_CONTENT
(
    UserID int NOT NULL FOREIGN KEY REFERENCES [USER](UserID),
    Price int NULL,
    VideoLink varchar(200) NULL,
    SocialsLink varchar(200) NULL,
    Privilege varchar(200) NULL
);

CREATE TABLE FOLLOWING_USER
(
	[User] int NOT NULL FOREIGN KEY REFERENCES [USER](UserID),
    Follower int NOT NULL FOREIGN KEY REFERENCES FOLLOWER(UserID),
);

CREATE TABLE STREAM_VIEWER
(
	Stream int NOT NULL FOREIGN KEY REFERENCES STREAM(StreamID),
    Viewer int NOT NULL FOREIGN KEY REFERENCES [USER](UserID),
    Moderator bit NULL,
    Mute bit NULL,
    Ban bit NULL
);

ALTER TABLE [USER]
	ADD ShareoutwardzID int FOREIGN KEY REFERENCES SHAREOUTWARDZ(ShareoutwardzID),
	CONSTRAINT Age CHECK (Age>=18);

ALTER TABLE STREAM
    ADD UserID int NOT NULL FOREIGN KEY REFERENCES [USER](UserID);

GO

INSERT INTO SHAREOUTWARDZ(ShareoutwardzID, URL, ServerLocation, Partner)
VALUES
(1, 'Shareoutwardz.com', 'New-York, Netherlands', 'Google');

INSERT INTO [USER](Name, URL, Password, Email, Age, Gender, Location, Description, Rating)
VALUES
('lily', '/NAME', 'azertyuop123', 'lily@hotmail.com', 21, 'F', 'USA', NULL, 4),
('muslim_candy', '/NAME', 'whatisapassword', 'muslim_candy@hotmail.com', 18, 'F', 'Brazil', NULL, 3),
('XxAnacondaxX', '/NAME', 'twentyonethings', 'georges.anaconda@gmail.fr', 26, 'H', 'French', 'Follow moi gratuitement!', 2),
('miss_charlotte1', '/NAME', 'pass123cuzbored', 'miss.charlotte1@hotmail.com', 18, 'F', 'Australia', NULL, 3),
('hardworkertn', '/NAME', 'thisisthefivethpass', 'hardworkertn32@live.com', 23, 'O', 'Iran', 'sabah alkhyr jamieanaan', 0),
('letizia_fulkers', '/NAME', 'ihavenomoreidea', 'letizia_fulkers@gmail.com', 21, 'O', 'Brazil', 'I love doing shopping!', 5),
('bugsbunny_', '/NAME', 'defaultpass', 'zek0limityz@gmail.com', 20, 'H', 'Belgium', NULL, NULL),
('gordon_ramkench', '/NAME', 'mangermangermanger', 'gordonramkench@hotmail.com', 21, 'H', 'UK', NULL, NULL),
('_izk_X', '/NAME', 'billieeilish', 'izklebestdu99@hotmail.fr', 19, 'H', 'French', NULL, NULL),
('lachèvredemonsieur', '/NAME', 'wtfsetttoplane', 'niceonedude@live.fr', 25, 'H', 'Belgium', NULL, NULL);

UPDATE [USER]
SET URL = '/' + Name

INSERT INTO PRIVATE_CONTENT(UserID, Price, VideoLink, SocialsLink, Privilege)
VALUES
(2, 9, 'www.videosharing.com/duie434z_fez.mp4', NULL, NULL),
(4, 2, NULL, '@NAME', NULL),
(7, 4, NULL, '@NAME', NULL),
(3, 15, NULL, NULL, 'Allow to send private messages'),
(10, 3, 'www.youtube.com/efhezifa', '@NAME', NULL);

UPDATE PRIVATE_CONTENT
SET SocialsLink = '@' + (SELECT Name
						 FROM [USER]
						 WHERE UserID = PRIVATE_CONTENT.UserID) WHERE SocialsLink='@NAME'

INSERT INTO FOLLOWER(UserID, Notification, FollowedPeople)
VALUES
(9, 1, 4),
(7, 0, 3),
(10, 0, 2),
(5, 1, 4);

INSERT INTO FOLLOWING_USER([User], Follower)
VALUES
(1, 9),
(2, 9),
(4, 9),
(6, 9),
(3, 7),
(1, 7),
(8, 7),
(2, 5),
(1, 5),
(1, 5),
(6, 5),
(5, 5),
(10, 5);

INSERT INTO STREAM(UserID, Lifetime, Language, Category, [18+])
VALUES
(1, '02:30:45', 'en', 'Dancing', 1),
(3, '00:12:23', 'fr', 'Cooking', 0),
(6, '08:07:54', 'br', 'Shopping', 1),
(7, '01:04:42', 'du', 'Dancing', 1),
(4, '13:32:12', 'sp', 'Singing', 0),
(5, '00:38:25', 'ru', 'Pool', 1),
(10, '1:11:11', 'fr', NULL, 0),
(5, '00:08:16', 'gr', 'Talking', 1);

INSERT INTO STREAM_VIEWER(Stream, Viewer, Moderator, Mute, Ban)
VALUES
(1, 8, NULL, 1, NULL),
(1, 2, 1, NULL, NULL),
(3, 4, NULL, NULL, 1),
(3, 9, 1, NULL, NULL),
(6, 10, 1, NULL, NULL),
(4, 1, 1, NULL, NULL),
(4, 3, NULL, 1, NULL),
(4, 8, NULL, NULL, 1),
(5, 3, NULL, 1, NULL),
(5, 6, NULL, NULL, 1);

GO

/* Retrieves streams in English or dutch, which are 18+ and where the theme of the stream is dancing */
SELECT
	UserID,
	StreamID,
	FORMAT(Lifetime, 'T') as Lifetime,
	Language,
	Category,
	[18+]
FROM STREAM 
WHERE Language LIKE 'en' 
or Language LIKE 'du' 
AND [18+] = 1 
AND Category LIKE 'Dancing'

/* Count the genders */
SELECT
	Gender,
	count(*) as Number
FROM [USER]
GROUP BY Gender

/* Sorted by oldest person */
SELECT
	Name,
	Age
FROM [USER]
GROUP BY Name, Age
ORDER BY AGE DESC

/* Make the average age */
SELECT
	AVG(Age) as Average_Age
FROM [USER]

/* Displays the url of the profiles */
SELECT
    Sh.URL,
    U.URL
FROM [USER] U, SHAREOUTWARDZ Sh

/* Who is banned from which stream? */
SELECT
    U.Name,
	U2.Name,
	SV.Ban,
	SV.Mute,
	SV.Moderator
FROM STREAM_VIEWER SV
INNER JOIN [USER] U
    ON U.UserID = SV.Viewer
INNER JOIN [USER] U2
	ON U2.UserID = SV.VIewer

/* Which stream has the most viewers? */
SELECT 
    U.Name,
    count(*) as Viewers
FROM STREAM S 
INNER JOIN STREAM_VIEWER SV
    ON SV.Stream = S.UserID
INNER JOIN [USER] U
    ON U.UserID = S.UserID
GROUP BY U.Name
ORDER BY Viewers DESC

/* Who is watching whose stream? */
SELECT 
    U.Name,
	U2.Name
FROM STREAM S 
INNER JOIN STREAM_VIEWER SV
    ON SV.Stream = S.UserID
INNER JOIN [USER] U
    ON U.UserID = S.UserID
INNER JOIN [USER] U2
	ON U2.UserID = SV.Viewer
GROUP BY U.Name, U2.Name

/* Who follow who? */
SELECT 
	U.Name, 
	U2.Name
FROM FOLLOWING_USER FU
INNER JOIN [USER] U 
	ON U.UserID = FU.[User]
INNER JOIN FOLLOWER F
	ON F.UserID = FU.Follower
INNER JOIN [USER] U2
	ON F.UserID = U2.UserID
ORDER BY U.Name, U2.Name

/* Get the private content values of a user */
SELECT
    Name, 
    Price, 
    VideoLink, 
    SocialsLink, 
    Privilege
FROM PRIVATE_CONTENT PC 
INNER JOIN [USER] U 
    ON PC.UserId = U.UserID

/* Displays the streams that are online with their lifetime, host name, language, category and age restriction */ 
SELECT 
    Name, 
    StreamID,
    FORMAT(Lifetime, 'T') as Lifetime, 
    Language,
	Category,
	[18+]
FROM STREAM S 
INNER JOIN [USER] U 
    ON S.UserID = U.UserID

GO