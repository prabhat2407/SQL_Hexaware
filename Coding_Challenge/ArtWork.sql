CREATE DATABASE VirtualArtGallery;

USE VirtualArtGallery;

CREATE TABLE Users(
userID INT PRIMARY KEY,
username VARCHAR(50),
password VARCHAR(20),
email VARCHAR(30),
firstName VARCHAR(50),
lastName VARCHAR(50),
DOB DATE,
profilePic BIT
);

CREATE TABLE Artist(
artistID INT PRIMARY KEY,
name VARCHAR(50),
biography VARCHAR(50),
DOB DATE,
nationality VARCHAR(20),
website VARCHAR(30),
phone VARCHAR(20),
email VARCHAR(50)
);

CREATE TABLE ArtWork(
artworkID INT PRIMARY KEY,
title VARCHAR(50),
description VARCHAR(50),
creationDate Date,
medium Varchar(50),
imageURL VARCHAR(255),
artistID INT,
FOREIGN KEY (artistID) REFERENCES Artist(artistID) ON DELETE CASCADE
);

CREATE TABLE Gallery(
galleryID INT PRIMARY KEY,
name VARCHAR(50),
location VARCHAR(50),
openingHours DATETIME,
closingHours DATETIME,
curatorArtistID INT,
FOREIGN KEY (curatorArtistID) REFERENCES artist(artistID) ON DELETE CASCADE
);

CREATE TABLE UserFavoriteArtwork(
userID INT ,
artworkID INT,
FOREIGN KEY(userID) REFERENCES Users(userID) ON DELETE CASCADE,
FOREIGN KEY (artworkID) REFERENCES ArtWork(artworkID) ON DELETE CASCADE
);

CREATE TABLE ArtWorkGallery(
artworkID INT,
galleryID INT,
FOREIGN KEY(artworkID) REFERENCES ArtWork(artworkID) ON DELETE NO ACTION,
FOREIGN KEY(galleryID) REFERENCES Gallery(galleryID) ON DELETE CASCADE
);

INSERT INTO Users (userID, username, password, email, firstName, lastName, DOB, profilePic) VALUES
(1, 'user1', 'password1', 'user1@example.com', 'John', 'Doe', '1990-05-15', 1),
(2, 'user2', 'password2', 'user2@example.com', 'Jane', 'Smith', '1985-08-22', 0),
(3, 'user3', 'password3', 'user3@example.com', 'Robert', 'Johnson', '1993-02-10', 1),
(4, 'user4', 'password4', 'user4@example.com', 'Emily', 'Williams', '1988-11-30', 0),
(5, 'user5', 'password5', 'user5@example.com', 'Michael', 'Brown', '1995-07-18', 1),
(6, 'user6', 'password6', 'user6@example.com', 'Sarah', 'Miller', '1992-04-05', 0),
(7, 'user7', 'password7', 'user7@example.com', 'Daniel', 'Taylor', '1987-09-12', 1),
(8, 'user8', 'password8', 'user8@example.com', 'Olivia', 'Davis', '1998-01-25', 0),
(9, 'user9', 'password9', 'user9@example.com', 'Christopher', 'Clark', '1991-06-08', 1),
(10, 'user10', 'password10', 'user10@example.com', 'Sophia', 'Moore', '1989-03-14', 0);


INSERT INTO Artist (artistID, name, biography, DOB, nationality, website, phone, email) VALUES
(1, 'Leonardo da Vinci', 'Italian polymath of the Renaissance', '1452-04-15', 'Italian', 'www.leonardodavinci.com', '+39 123 456789', 'leo.davinci@example.com'),
(2, 'Vincent van Gogh', 'Dutch Post-Impressionist painter', '1853-03-30', 'Dutch', 'www.vangoghgallery.com', '+31 987 654321', 'vincent.van.gogh@example.com'),
(3, 'Pablo Picasso', 'Spanish painter and sculptor', '1881-10-25', 'Spanish', 'www.picasso.fr', '+34 555 123456', 'pablo.picasso@example.com'),
(4, 'Georgia O Keeffe', 'American modernist artist', '1887-11-15', 'American', 'www.okeeffemuseum.org', '+1 505 7890123', 'georgia.okeeffe@example.com'),
(5, 'Frida Kahlo', 'Mexican painter known for her self-portraits', '1907-07-06', 'Mexican', 'www.fridakahlo.org', '+52 55 4567890', 'frida.kahlo@example.com'),
(6, 'Salvador Dalí', 'Surrealist artist from Spain', '1904-05-11', 'Spanish', 'www.salvadordali.org', '+34 666 987654', 'salvador.dali@example.com'),
(7, 'Claude Monet', 'French Impressionist painter', '1840-11-14', 'French', 'www.claudemonet.org', '+33 1 23456789', 'claude.monet@example.com'),
(8, 'Edvard Munch', 'Norwegian painter', '1863-12-12', 'Norwegian', 'www.edvardmunch.org', '+47 22 345678', 'edvard.munch@example.com'),
(9, 'Rene Magritte', 'Belgian surrealist artist', '1898-11-21', 'Belgian', 'www.renemagritte.be', '+32 2 5556789', 'rene.magritte@example.com'),
(10, 'Jackson Pollock', 'American abstract expressionist painter', '1912-01-28', 'American', 'www.jacksonpollock.org', '+1 212 3456789', 'jackson.pollock@example.com');

INSERT INTO ArtWork (artworkID, title, description, creationDate, medium, imageURL, artistID) VALUES
(1, 'Mona Lisa', 'Famous portrait by Leonardo da Vinci', '1503-01-01', 'Oil on poplar panel', 'www.example.com/monalisa.jpg', 1),
(2, 'Starry Night', 'Iconic painting by Vincent van Gogh', '1889-06-01', 'Oil on canvas', 'www.example.com/starrynight.jpg', 2),
(3, 'Guernica', 'Pablo Picassos powerful anti-war painting', '1937-09-01', 'Oil on canvas', 'www.example.com/guernica.jpg', 3),
(4, 'Jimson Weed/White Flower No. 1', 'Well-known work by Georgia O Keeffe', '1936-01-01', 'Oil on canvas', 'www.example.com/jimsonweed.jpg', 4),
(5, 'The Two Fridas', 'Symbolic self-portrait by Frida Kahlo', '1939-07-01', 'Oil on canvas', 'www.example.com/twofridas.jpg', 5),
(6, 'The Persistence of Memory', 'Famous melting clocks by Salvador Dalí', '1931-01-01', 'Oil on canvas', 'www.example.com/persistenceofmemory.jpg', 6),
(7, 'Water Lilies', 'Series of paintings by Claude Monet', '1914-01-01', 'Oil on canvas', 'www.example.com/waterlilies.jpg', 7),
(8, 'The Scream', 'Expressionist masterpiece by Edvard Munch', '1893-01-01', 'Oil, tempera, and pastel on cardboard', 'www.example.com/thescream.jpg', 8),
(9, 'The Son of Man', 'Surrealist work by René Magritte', '1964-01-01', 'Oil on canvas', 'www.example.com/sonofman.jpg', 9),
(10, 'No. 5, 1948', 'Famous drip painting by Jackson Pollock', '1948-01-01', 'Oil and enamel on canvas', 'www.example.com/no51948.jpg', 10);

INSERT INTO Gallery (galleryID, name, location, openingHours, closingHours, curatorArtistID) VALUES
(1, 'Louvre Museum', 'Paris, France', '2023-01-01 09:00:00', '2023-01-01 18:00:00', 1),
(2, 'Museum of Modern Art (MoMA)', 'New York, USA', '2023-01-01 10:00:00', '2023-01-01 17:30:00', 2),
(3, 'Prado Museum', 'Madrid, Spain', '2023-01-01 10:00:00', '2023-01-01 20:00:00', 3),
(4, 'National Gallery', 'London, UK', '2023-01-01 09:30:00', '2023-01-01 18:00:00', 4),
(5, 'Frida Kahlo Museum', 'Mexico City, Mexico', '2023-01-01 11:00:00', '2023-01-01 17:00:00', 5),
(6, 'Dalí Theatre and Museum', 'Figueres, Spain', '2023-01-01 10:30:00', '2023-01-01 18:00:00', 6),
(7, 'Musée d Orsay', 'Paris, France', '2023-01-01 09:30:00', '2023-01-01 18:00:00', 7),
(8, 'The Munch Museum', 'Oslo, Norway', '2023-01-01 11:00:00', '2023-01-01 17:00:00', 8),
(9, 'Magritte Museum', 'Brussels, Belgium', '2023-01-01 10:00:00', '2023-01-01 18:00:00', 9),
(10, 'Pollock-Krasner House and Study Center', 'East Hampton, USA', '2023-01-01 10:00:00', '2023-01-01 16:00:00', 10);

INSERT INTO UserFavoriteArtwork (userID, artworkID) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 5),
(4, 8),
(5, 10),
(6, 4),
(7, 7),
(8, 9),
(10, 6);

INSERT INTO ArtWorkGallery (artworkID, galleryID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

