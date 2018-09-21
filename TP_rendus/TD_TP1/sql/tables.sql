/*
* @brief Creates the tables of the database without filling them
* @author Bachar RIMA
* @author Joseph SABA
*/

CREATE TABLE AppareilPhoto (
  model varchar2(50) not null constraint appareilphoto_pk primary key,
  type varchar2(50) not null,
  resolution_x number,
  lens varchar2(50)
);

CREATE TABLE License (
  license_id number not null constraint license_pk primary key,
  droits varchar2(40) unique not null CHECK (droits in ('tous droits réservés','utilisation commerciale autorisée','modifications de l\’image autorisées'))
);

CREATE TABLE Configuration (
  conf_id number not null constraint configuration_pk primary key,
  ouverture_focale number,
  temps_exposition varchar2(10),
  flash number(1) not null,
  distance_focale number
);

CREATE TABLE Utilisateur (
  utilisateur_id varchar2(50) not null constraint utilisateur_pk primary key,
  nom varchar2(50) not null,
  prenom varchar2(50) not null,
  username varchar2(50) not null unique,
  email varchar2(50) not null unique,
  date_naissance date,
  date_inscription date default sysdate not null,
  pays varchar2(50)
);

CREATE TABLE ContenuNumerique(
  contenu_id number primary key,
  utilisateur_id varchar2(50) NOT NULL,
  date_publication DATE default sysdate not null,
  constraint fk_contenunumerique FOREIGN KEY(utilisateur_id) references Utilisateur(UTILISATEUR_ID) ON DELETE CASCADE
);

CREATE TABLE PhotoCollection (
  photo_collection_id number constraint photo_collection_pk primary key,
  nom varchar2(50) not null,
  utilisateur_id varchar2(50),
  date_creation date default sysdate not null,
  constraint FK_PhotoCollection FOREIGN KEY(utilisateur_id) REFERENCES Utilisateur(utilisateur_id) ON DELETE CASCADE
);

CREATE TABLE Album (
  album_id number,
  constraint pk_album primary key(album_id),
  constraint fk_album foreign key(album_id) references PhotoCollection(photo_collection_id) ON DELETE CASCADE
);

CREATE TABLE Gallery (
  gallery_id number,
  constraint pk_gallery primary key(gallery_id),
  constraint fk_gallery foreign key(gallery_id) references PhotoCollection(photo_collection_id) ON DELETE CASCADE
);

CREATE TABLE Photo(
  id number primary key,
  lieu varchar2(50) NOT NULL,
  chemin varchar2(200) NOT NULL,
  nb_views number,
  id_appareil varchar2(50),
  id_licence number NOT NULL,
  id_configuration number,
  constraint fk_photoid_fk FOREIGN KEY(id) references ContenuNumerique(CONTENU_ID),
  constraint fk_appareilid_fk FOREIGN KEY(id_appareil) references APPAREILPHOTO(MODEL),
  constraint fk_licenseid_fk FOREIGN KEY(id_licence) references LICENSE(LICENSE_ID),
  constraint fk_configurationid_fk FOREIGN KEY(id_configuration) references CONFIGURATION(CONF_ID)
);

CREATE TABLE Discussion(
  id number primary key,
  id_photo number not null,
  constraint discussionphoto_fk FOREIGN KEY(id_photo) REFERENCES Photo(id)
);

CREATE TABLE Commentaire(
id number primary key,
contenu varchar2(500),
id_discussion number NOT NULL,
constraint commentairdiscussion_fk FOREIGN KEY(id_discussion) REFERENCES Discussion(id)
);

CREATE TABLE Aime(
id_utilisateur varchar(50),
id_photo number,
constraint aime_pk primary key (id_utilisateur,id_photo),
constraint idutilisateur_fk FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(UTILISATEUR_ID),
constraint idphoto_fk FOREIGN KEY(id_photo) REFERENCES Photo(ID)
);

CREATE TABLE Tag (
  tag_id number not null constraint tag_pk primary key,
  contenu varchar2(50) not null
);

CREATE TABLE Range_gallery(
  id_gallery number,
  id_utilisateur varchar2(50),
  id_photo number,
  CONSTRAINT PK_RANGE_GALLERY
    PRIMARY KEY(id_gallery, id_utilisateur, id_photo),
  CONSTRAINT FK_RANGE_GALLERY_GALLERY
    FOREIGN KEY(id_gallery) REFERENCES Gallery(gallery_id) ON DELETE CASCADE,
  CONSTRAINT FK_RANGE_GALLERY_UTILISATEUR
    FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(utilisateur_id) ON DELETE CASCADE,
  CONSTRAINT FK_RANGE_GALLERY_PHOTO
    FOREIGN KEY(id_photo) REFERENCES Photo(id) ON DELETE CASCADE
);

CREATE TABLE Range_album(
  id_album number,
  id_utilisateur varchar2(50),
  id_photo number,
  CONSTRAINT PK_RANGE_ALBUM
    PRIMARY KEY(id_album, id_utilisateur, id_photo),
  CONSTRAINT FK_RANGE_ALBUM_ALBUM
    FOREIGN KEY(id_album) REFERENCES Album(album_id) ON DELETE CASCADE,
  CONSTRAINT FK_RANGE_ALBUM_UTILISATEUR
    FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(utilisateur_id) ON DELETE CASCADE,
  CONSTRAINT FK_RANGE_ALBUM_PHOTO
    FOREIGN KEY(id_photo) REFERENCES Photo(id) ON DELETE CASCADE
);

CREATE TABLE Suit(
  id_utilisateur1 varchar2(50),
  id_utilisateur2 varchar2(50),
  constraint suitPK primary key (id_utilisateur1,id_utilisateur2),
  constraint fk_suit1 FOREIGN KEY(id_utilisateur1) references Utilisateur(UTILISATEUR_ID) ON DELETE CASCADE,
  constraint fk_suit2 FOREIGN KEY(id_utilisateur2) references Utilisateur(UTILISATEUR_ID) ON DELETE CASCADE
);

CREATE TABLE Marque(
  id_tag number,
  id_photo number,
  constraint marquePK primary key (id_tag, id_photo),
  constraint fk_marque1 FOREIGN KEY(id_tag) references Tag(tag_id) ON DELETE CASCADE,
  constraint fk_marque2 FOREIGN KEY(id_photo) references Photo(id) ON DELETE CASCADE
);
/
