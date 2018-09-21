/*
* @brief Creates the tables of the database without filling them
* @author Bachar RIMA
* @author Joseph SABA
*/

CREATE TABLE AppareilPhoto (
  model VARCHAR2(50),
  type VARCHAR2(50) NOT NULL,
  resolution_x NUMBER,
  lens VARCHAR2(50),
  CONSTRAINT PK_APPAREIL_PHOTO
    PRIMARY KEY(model)
);

CREATE TABLE Licence (
  licence_id NUMBER,
  droits VARCHAR2(40) UNIQUE NOT NULL CHECK (
    droits in ('tous droits réservés', 'utilisation commerciale autorisée', 'modifications de l''image autorisées')),
  CONSTRAINT PK_LICENCE
    PRIMARY KEY(licence_id)
);

CREATE TABLE Configuration (
  conf_id NUMBER,
  ouverture_focale NUMBER,
  temps_exposition VARCHAR2(10),
  flash NUMBER(1) NOT NULL,
  distance_focale NUMBER,
  CONSTRAINT PK_CONFIGURATION
    PRIMARY KEY(conf_id)
);

CREATE TABLE Utilisateur (
  utilisateur_id VARCHAR2(50),
  nom VARCHAR2(50) NOT NULL,
  prenom VARCHAR2(50) NOT NULL,
  username VARCHAR2(50) NOT NULL UNIQUE,
  email VARCHAR2(50) NOT NULL UNIQUE,
  date_naissance DATE,
  date_inscription DATE DEFAULT SYSDATE NOT NULL,
  pays VARCHAR2(50),
  CONSTRAINT PK_UTILISATEUR
    PRIMARY KEY(utilisateur_id)
);

CREATE TABLE ContenuNumerique (
  contenu_id NUMBER,
  utilisateur_id VARCHAR2(50) NOT NULL,
  date_publication DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT PK_CONTENU_NUMERIQUE
    PRIMARY KEY(contenu_id),
  CONSTRAINT FK_CONTENU_NUMERIQUE_UTILISATEUR
    FOREIGN KEY(utilisateur_id) REFERENCES Utilisateur(utilisateur_id) ON DELETE CASCADE
);

CREATE TABLE PhotoCollection (
  photo_collection_id NUMBER,
  nom VARCHAR2(50) NOT NULL,
  utilisateur_id VARCHAR2(50) NOT NULL,
  date_creation DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT PK_PHOTO_COLLECTION
    PRIMARY KEY(photo_collection_id),
  CONSTRAINT FK_PHOTO_COLLECTION
    FOREIGN KEY(utilisateur_id) REFERENCES Utilisateur(utilisateur_id) ON DELETE CASCADE
);

CREATE TABLE Album (
  album_id NUMBER,
  CONSTRAINT PK_ALBUM
    PRIMARY KEY(album_id),
  CONSTRAINT FK_ALBUM_PHOTO_COLLECTION
    FOREIGN KEY(album_id) REFERENCES PhotoCollection(photo_collection_id) ON DELETE CASCADE
);

CREATE TABLE Gallery (
  gallery_id NUMBER,
  CONSTRAINT PK_GALLERY
    PRIMARY KEY(gallery_id),
  CONSTRAINT FK_GALLERY_PHOTO_COLLECTION
    FOREIGN KEY(gallery_id) REFERENCES PhotoCollection(photo_collection_id) ON DELETE CASCADE
);

CREATE TABLE Photo (
  photo_id NUMBER,
  lieu VARCHAR2(50) NOT NULL,
  chemin VARCHAR2(200) NOT NULL,
  nb_views NUMBER DEFAULT 0,
  model_appareil VARCHAR2(50),
  licence_id NUMBER,
  conf_id NUMBER,
  CONSTRAINT PK_PHOTO
    PRIMARY KEY(photo_id),
  CONSTRAINT FK_PHOTO_CONTENU_NUMERIQUE
    FOREIGN KEY(photo_id) REFERENCES ContenuNumerique(contenu_id) ON DELETE CASCADE,
  CONSTRAINT FK_PHOTO_APPAREIL_PHOTO
    FOREIGN KEY(model_appareil) REFERENCES AppareilPhoto(model) ON DELETE SET NULL,
  CONSTRAINT FK_PHOTO_LICENCE
    FOREIGN KEY(licence_id) REFERENCES Licence(licence_id) ON DELETE SET NULL,
  CONSTRAINT FK_PHOTO_CONFIGURATION
    FOREIGN KEY(conf_id) REFERENCES Configuration(conf_id) ON DELETE SET NULL
);

CREATE TABLE Discussion (
  discussion_id NUMBER,
  photo_id NUMBER NOT NULL,
  CONSTRAINT PK_DISCUSSION
    PRIMARY KEY(discussion_id),
  CONSTRAINT FK_DISCUSSION_PHOTO
    FOREIGN KEY(photo_id) REFERENCES Photo(photo_id) ON DELETE CASCADE
);

CREATE TABLE Commentaire (
  comment_id NUMBER,
  contenu VARCHAR2(500),
  discussion_id NUMBER NOT NULL,
  CONSTRAINT PK_COMMENTAIRE
    PRIMARY KEY(comment_id),
  CONSTRAINT FK_COMMENTAIRE_DISCUSSION
    FOREIGN KEY(discussion_id) REFERENCES Discussion(discussion_id) ON DELETE CASCADE
);

CREATE TABLE Aime (
  utilisateur_id varchar(50),
  photo_id NUMBER,
  CONSTRAINT PK_AIME
    PRIMARY KEY (utilisateur_id, photo_id),
  CONSTRAINT FK_AIME_UTILISATEUR
    FOREIGN KEY(utilisateur_id) REFERENCES Utilisateur(utilisateur_id) ON DELETE CASCADE,
  CONSTRAINT FK_AIME_PHOTO
    FOREIGN KEY(photo_id) REFERENCES Photo(photo_id) ON DELETE CASCADE
);

CREATE TABLE Tag (
  tag_id NUMBER,
  contenu VARCHAR2(50) NOT NULL,
  CONSTRAINT PK_TAG
    PRIMARY KEY(tag_id)
);

CREATE TABLE Range_gallery (
  gallery_id NUMBER,
  utilisateur_id VARCHAR2(50),
  photo_id NUMBER,
  CONSTRAINT PK_RANGE_GALLERY
    PRIMARY KEY(gallery_id, utilisateur_id, photo_id),
  CONSTRAINT FK_RANGE_GALLERY_GALLERY
    FOREIGN KEY(gallery_id) REFERENCES Gallery(gallery_id) ON DELETE CASCADE,
  CONSTRAINT FK_RANGE_GALLERY_UTILISATEUR
    FOREIGN KEY(utilisateur_id) REFERENCES Utilisateur(utilisateur_id) ON DELETE CASCADE,
  CONSTRAINT FK_RANGE_GALLERY_PHOTO
    FOREIGN KEY(photo_id) REFERENCES Photo(photo_id) ON DELETE CASCADE
);

CREATE TABLE Range_album (
  album_id NUMBER,
  utilisateur_id VARCHAR2(50),
  photo_id NUMBER,
  CONSTRAINT PK_RANGE_ALBUM
    PRIMARY KEY(album_id, utilisateur_id, photo_id),
  CONSTRAINT FK_RANGE_ALBUM_ALBUM
    FOREIGN KEY(album_id) REFERENCES Album(album_id) ON DELETE CASCADE,
  CONSTRAINT FK_RANGE_ALBUM_UTILISATEUR
    FOREIGN KEY(utilisateur_id) REFERENCES Utilisateur(utilisateur_id) ON DELETE CASCADE,
  CONSTRAINT FK_RANGE_ALBUM_PHOTO
    FOREIGN KEY(photo_id) REFERENCES Photo(photo_id) ON DELETE CASCADE
);

CREATE TABLE Suit (
  utilisateur_id1 VARCHAR2(50),
  utilisateur_id2 VARCHAR2(50),
  CONSTRAINT PK_SUIT
    PRIMARY KEY(utilisateur_id1, utilisateur_id2),
  CONSTRAINT FK_SUIT_UTILISATEUR1
    FOREIGN KEY(utilisateur_id1) REFERENCES Utilisateur(utilisateur_id) ON DELETE CASCADE,
  CONSTRAINT FK_SUIT_UTILISATEUR2
    FOREIGN KEY(utilisateur_id2) REFERENCES Utilisateur(utilisateur_id) ON DELETE CASCADE
);

CREATE TABLE Marque (
  tag_id NUMBER,
  photo_id NUMBER,
  CONSTRAINT PK_MARQUE
    PRIMARY KEY(tag_id, photo_id),
  CONSTRAINT FK_MARQUE_TAG
    FOREIGN KEY(tag_id) REFERENCES Tag(tag_id) ON DELETE CASCADE,
  CONSTRAINT FK_MARQUE_PHOTO
    FOREIGN KEY(photo_id) REFERENCES Photo(photo_id) ON DELETE CASCADE
);
/
