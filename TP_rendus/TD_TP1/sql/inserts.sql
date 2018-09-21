INSERT INTO AppareilPhoto VALUES ('D850', 'Nikon', '28','18.0-105.0 mm');
INSERT INTO AppareilPhoto VALUES ('EOS 5D Mark IV', 'Canon','32','61-point AF, 41');
INSERT INTO AppareilPhoto VALUES ('D500', 'Nikon', 31,'153-point AF, 99');
INSERT INTO AppareilPhoto VALUES ('T 260', 'Aigo', 23,'15.0-96.0 mm');
INSERT INTO AppareilPhoto VALUES ('X320', 'Sony', 30,'19.0-115.0 mm');

INSERT INTO Configuration VALUES (1, 5.3, '1/40', 1, 62);
INSERT INTO Configuration VALUES (2, 6.1, '1/10', 0, 58);
INSERT INTO Configuration VALUES (3, 6.3, '1/25', 0, 64);
INSERT INTO Configuration VALUES (4, 5.7, '1/5', 1, 61);
INSERT INTO Configuration VALUES (5, 5.9, '1/30', 1, 55);

INSERT INTO Licence VALUES (1,'tous droits réservés');
INSERT INTO Licence VALUES (2,'utilisation commerciale autorisée');
INSERT INTO Licence VALUES (3,'modifications de l''image autorisées');

INSERT INTO Utilisateur VALUES (1,'Saba', 'Joseph', 'joseph.saba','joseph.saba@gmail.com','01-OCT-1993','05-NOV-18', 'LIBAN');
INSERT INTO Utilisateur VALUES (2,'RIMA', 'BACHAR', 'bachar.rima','bachar.rima@gmail.com','13-JUN-1992','12-JAN-12', 'LIBAN');
INSERT INTO Utilisateur VALUES (3,'MUSTAPHA', 'DIMA', 'dima.m','dima.m@gmail.com','23-AUG-1995','09-MAR-16', 'FRANCE');
INSERT INTO Utilisateur VALUES (4,'PANGARY', 'Pratyusha', 'ppangari','ppamgari@gmail.com','23-JUL-1994','15-JAN-17', 'INDE');
INSERT INTO Utilisateur VALUES (5,'KHOURY', 'Jill', 'jillkhoury','jillkhoury@gmail.com','26-JUL-1988','19-MAY-15', 'AUSTRALIE');

INSERT INTO ContenuNumerique VALUES (1, 1, '10-NOV-18');
INSERT INTO ContenuNumerique VALUES (2, 1, '11-NOV-18');
INSERT INTO ContenuNumerique VALUES (3, 1, '16-NOV-18');
INSERT INTO ContenuNumerique VALUES (4, 2, '10-OCT-17');
INSERT INTO ContenuNumerique VALUES (5, 3, '01-JUL-18');
INSERT INTO ContenuNumerique VALUES (6, 2, '11-NOV-18');
INSERT INTO ContenuNumerique VALUES (7, 4, '11-OCT-17');
INSERT INTO ContenuNumerique VALUES (8, 5, '12-JAN-18');
INSERT INTO ContenuNumerique VALUES (9, 2, '01-FEB-18');
INSERT INTO ContenuNumerique VALUES (10, 3, '11-JUL-18');

INSERT INTO Photo VALUES (1, 'LIBAN', 'https://c1.staticflickr.com/9/8768/27869512383_ce5deed625_b.jpg', 538, 'EOS 5D Mark IV', 1, 1);
INSERT INTO Photo VALUES (2, 'FRANCE', 'https://c2.staticflickr.com/4/3668/10089150975_13c3dbb0ca_b.jpg', 3893, 'T 260', 2, 2);
INSERT INTO Photo VALUES (3, 'FRANCE', 'https://c2.staticflickr.com/8/7487/15532262769_3fd027f319_b.jpg', 13744, 'D500', 1, 2);
INSERT INTO Photo VALUES (4, 'BRASIL', 'https://c2.staticflickr.com/4/3844/32846030723_9ff438c689_b.jpg', 124, 'EOS 5D Mark IV', 3, 4);
INSERT INTO Photo VALUES (5, 'Brasil', 'https://c2.staticflickr.com/6/5523/9098371098_fbaf434821_b.jpg', 2857, 'D850', 1, 5);

INSERT INTO Aime VALUES(1,1);
INSERT INTO Aime VALUES(2,3);
INSERT INTO Aime VALUES(1,2);
INSERT INTO Aime VALUES(4,3);

INSERT INTO Tag VALUES (1, 'flag');
INSERT INTO Tag VALUES (2, 'nature');
INSERT INTO Tag VALUES (3, 'country');
INSERT INTO Tag VALUES (4, 'views');
INSERT INTO Tag VALUES (5, 'rock');

INSERT INTO Discussion VALUES(1,1);
INSERT INTO Discussion VALUES(2,2);
INSERT INTO Discussion VALUES(3,3);
INSERT INTO Discussion VALUES(4,4);
INSERT INTO Discussion VALUES(5,5);

INSERT INTO Commentaire VALUES (6, 'nice photo', 1);
INSERT INTO Commentaire VALUES (7, 'where did you take this?', 2);
INSERT INTO Commentaire VALUES (8, 'amazing!', 3);
INSERT INTO Commentaire VALUES (9, 'follow my page', 4);
INSERT INTO Commentaire VALUES (10, 'nice photo', 5);

INSERT INTO PhotoCollection VALUES (1, 'ma collection', 1, '13-JAN-2018');
INSERT INTO PhotoCollection VALUES (2, 'été', 1, '19-OCT-2018');
INSERT INTO PhotoCollection VALUES (3, 'paysages', 2, '23-JUL-2018');
INSERT INTO PhotoCollection VALUES (4, 'pays', 3, '03-FEB-2018');
INSERT INTO PhotoCollection VALUES (5, 'album 2', 4, '03-JUN-2018');
INSERT INTO PhotoCollection VALUES (6, 'hiver', 5, '13-MAR-2017');
INSERT INTO PhotoCollection VALUES (7, 'maisons', 1, '18-MAY-2016');
INSERT INTO PhotoCollection VALUES (8, 'famille', 2, '13-JAN-2018');
INSERT INTO PhotoCollection VALUES (9, 'universite', 5, '11-AUG-2018');
INSERT INTO PhotoCollection VALUES (10, 'arbres', 4, '09-DEC-2017');

INSERT INTO Album VALUES(1);
INSERT INTO Album VALUES(2);
INSERT INTO Album VALUES(3);
INSERT INTO Album VALUES(4);
INSERT INTO Album VALUES(5);

INSERT INTO Gallery VALUES(6);
INSERT INTO Gallery VALUES(7);
INSERT INTO Gallery VALUES(8);
INSERT INTO Gallery VALUES(9);
INSERT INTO Gallery VALUES(10);

INSERT INTO Range_gallery VALUES(6,1,1);
INSERT INTO Range_gallery VALUES(6,1,2);
INSERT INTO Range_gallery VALUES(6,1,3);
INSERT INTO Range_gallery VALUES(7,2,4);
INSERT INTO Range_gallery VALUES(7,2,5);
INSERT INTO Range_gallery VALUES(8,3,1);
INSERT INTO Range_gallery VALUES(7,2,1);

INSERT INTO Range_album VALUES (1,1,1);
INSERT INTO Range_album VALUES (2,1,2);
INSERT INTO Range_album VALUES (3,1,3);
INSERT INTO Range_album VALUES (4,2,4);
INSERT INTO Range_album VALUES (5,3,5);

INSERT INTO Suit VALUES (1,2);
INSERT INTO Suit VALUES (1,3);
INSERT INTO Suit VALUES (2,3);
INSERT INTO Suit VALUES (3,4);
INSERT INTO Suit VALUES (3,5);

INSERT INTO Marque VALUES(1,2);
INSERT INTO Marque VALUES(2,1);
INSERT INTO Marque VALUES(3,5);
INSERT INTO Marque VALUES(1,3);
INSERT INTO Marque VALUES(2,3);
