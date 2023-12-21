CREATE DATABASE ArtGallery;

USE ArtGallery;

CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Biography TEXT,
    Nationality VARCHAR(100)
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE Artworks (
    ArtworkID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ArtistID INT,
    CategoryID INT,
    Year INT,
    Description TEXT,
    ImageURL VARCHAR(255),
    FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID),
    FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID)
);

CREATE TABLE Exhibitions (
    ExhibitionID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    Description TEXT
);

CREATE TABLE ExhibitionArtworks (
    ExhibitionID INT,
    ArtworkID INT,
    PRIMARY KEY (ExhibitionID, ArtworkID),
    FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID),
    FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID)
);

INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES
    (1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
    (2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
    (3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');

INSERT INTO Categories (CategoryID, Name) VALUES
    (1, 'Painting'),
    (2, 'Sculpture'),
    (3, 'Photography');

INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES
    (1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'),
    (2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'),
    (3, 'Guernica', 1, 1, 1937, 'Pablo Picassos powerful anti-war mural.', 'guernica.jpg');

INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES
    (1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
    (2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');

INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 2);

/*Q1.Retrieve the names of all artists along with the number of artworks they have in the gallery, and list them in 
descending order of the number of artworks.*/
SELECT A.Name, COUNT(*) AS artworkCount FROM Artists AS A LEFT JOIN Artworks AS AW ON A.ArtistID = AW.ArtistID GROUP BY A.Name
ORDER BY artworkCount DESC;

/*2.List the titles of artworks created by artists from 'Spanish' and 'Dutch' nationalities, and order them by the year 
in ascending order.*/
SELECT AW.Title FROM Artworks AS AW INNER JOIN Artists AS A ON AW.ArtistID = A.ArtistID WHERE A.Nationality IN ('Spanish', 'Dutch')
ORDER BY AW.Year ASC;

/*Q3.Find the names of all artists who have artworks in the 'Painting' category, and the number of artworks they have 
in this category.*/
SELECT A.Name, COUNT(*) AS artworkCount FROM Artists AS A INNER JOIN Artworks AS AW ON A.ArtistID = AW.ArtistID INNER JOIN 
Categories AS C ON AW.CategoryID = C.CategoryID WHERE C.Name = 'Painting' GROUP BY A.Name;

--Q4.List the names of artworks from the 'Modern Art Masterpieces' exhibition, along with their artists and categories.
SELECT AW.Title, A.Name AS ArtistName, C.Name AS CategoryName FROM Artworks AS AW INNER JOIN ExhibitionArtworks AS EA ON 
AW.ArtworkID = EA.ArtworkID INNER JOIN Exhibitions AS E ON EA.ExhibitionID = E.ExhibitionID INNER JOIN Artists AS A ON 
AW.ArtistID = A.ArtistID INNER JOIN Categories AS C ON AW.CategoryID = C.CategoryID WHERE E.Title = 'Modern Art Masterpieces';

--Q5.Find the artists who have more than two artworks in the gallery.
SELECT A.Name FROM Artists AS A INNER JOIN Artworks AS AW ON A.ArtistID = AW.ArtistID GROUP BY A.Name HAVING COUNT(*) > 2;

--Q6.Find the titles of artworks that were exhibited in both 'Modern Art Masterpieces' and 'Renaissance Art' exhibitions
SELECT AW.Title FROM Artworks AS AW INNER JOIN ExhibitionArtworks AS EA ON AW.ArtworkID = EA.ArtworkID INNER JOIN Exhibitions AS E 
ON EA.ExhibitionID = E.ExhibitionID WHERE E.Title IN ('Modern Art Masterpieces', 'Renaissance Art') GROUP BY AW.Title 
HAVING COUNT(DISTINCT E.ExhibitionID) = 2;

--Q7.Find the total number of artworks in each category.
SELECT C.Name AS categoryName, COUNT(*) AS artworkCount FROM Categories AS C LEFT JOIN Artworks AS AW ON 
C.CategoryID = AW.CategoryID GROUP BY C.Name;

--Q8.List artists who have more than 3 artworks in the gallery.
SELECT A.Name FROM Artists AS A INNER JOIN Artworks AS AW ON A.ArtistID = AW.ArtistID GROUP BY A.Name HAVING COUNT(*) > 3;

--Q9.Find the artworks created by artists from a specific nationality (e.g., Spanish).
SELECT AW.Title, A.Name AS ArtistName FROM Artworks AS AW INNER JOIN Artists AS A ON AW.ArtistID = A.ArtistID 
WHERE A.Nationality = 'Spanish';

--Q10.List exhibitions that feature artwork by both Vincent van Gogh and Leonardo da Vinci.
SELECT E.Title FROM Exhibitions AS E INNER JOIN ExhibitionArtworks AS EA ON E.ExhibitionID = EA.ExhibitionID INNER JOIN 
Artworks AS AW ON EA.ArtworkID = AW.ArtworkID INNER JOIN Artists AS A ON AW.ArtistID = A.ArtistID WHERE A.Name IN 
('Vincent van Gogh', 'Leonardo da Vinci') GROUP BY E.Title HAVING COUNT(DISTINCT A.Name) = 2;

--Q11.Find all the artworks that have not been included in any exhibition.
SELECT AW.Title FROM Artworks AS AW LEFT JOIN ExhibitionArtworks AS EA ON AW.ArtworkID = EA.ArtworkID WHERE EA.ArtworkID IS NULL;

--Q12.List artists who have created artworks in all available categories.
SELECT A.Name FROM Artists AS A INNER JOIN Artworks AS AW ON A.ArtistID = AW.ArtistID INNER JOIN Categories C ON 
AW.CategoryID = C.CategoryID GROUP BY A.Name HAVING COUNT(DISTINCT C.CategoryID) = (SELECT COUNT(*) FROM Categories);

--Q13.List the total number of artworks in each category.
SELECT C.Name AS CategoryName, COUNT(*) AS artworkCount FROM Categories AS C INNER JOIN Artworks AS AW ON 
C.CategoryID = AW.CategoryID GROUP BY C.Name;

--Q14.Find the artists who have more than 2 artworks in the gallery.
SELECT A.Name FROM Artists AS A INNER JOIN Artworks AS AW ON A.ArtistID = AW.ArtistID GROUP BY A.Name HAVING COUNT(*) > 2;

--Q15.List the categories with the average year of artworks they contain, only for categories with more than 1 artwork.
SELECT C.Name AS categoryName, AVG(AW.Year) AS averageYear FROM Categories AS C INNER JOIN Artworks AS AW ON 
C.CategoryID = AW.CategoryID GROUP BY C.Name HAVING COUNT(*) > 1;

--Q16.Find the artworks that were exhibited in the 'Modern Art Masterpieces' exhibition.
SELECT AW.Title FROM Artworks AS AW INNER JOIN ExhibitionArtworks AS EA ON AW.ArtworkID = EA.ArtworkID INNER JOIN Exhibitions AS E 
ON EA.ExhibitionID = E.ExhibitionID WHERE E.Title = 'Modern Art Masterpieces';

--Q17.Find the categories where the average year of artworks is greater than the average year of all artworks.
SELECT C.CategoryID,C.Name FROM Artworks AS AW INNER JOIN Categories AS C ON C.CategoryID=AW.CategoryID GROUP BY 
C.CategoryID,C.Name HAVING AVG(AW.Year)>(SELECT AVG(YEAR) FROM Artworks)

--Q18.List the artworks that were not exhibited in any exhibition.
SELECT AW.Title FROM Artworks AS AW LEFT JOIN ExhibitionArtworks AS EA ON AW.ArtworkID = EA.ArtworkID WHERE EA.ArtworkID IS NULL;

--Q19.Show artists who have artworks in the same category as "Mona Lisa."
SELECT DISTINCT A.Name FROM Artists AS A INNER JOIN Artworks AS AW ON A.ArtistID = AW.ArtistID INNER JOIN Categories AS C 
ON AW.CategoryID = C.CategoryID WHERE AW.Title = 'Mona Lisa';

--Q20.List the names of artists and the number of artworks they have in the gallery.
SELECT A.Name, COUNT(*) AS artworkCount FROM Artists AS A LEFT JOIN Artworks AS AW ON A.ArtistID = AW.ArtistID GROUP BY A.Name
ORDER BY artworkCount;