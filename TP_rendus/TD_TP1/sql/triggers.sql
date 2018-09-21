/*
* @brief Creates the triggers for some tables of the database
* @author Bachar RIMA
* @author Joseph SABA
*/

CREATE OR REPLACE TRIGGER album_inheritance_trigger
BEFORE INSERT OR UPDATE ON Album
FOR EACH ROW
BEGIN
  for gallery in (SELECT gallery_id
  FROM Gallery) loop
    if :new.album_id = gallery.gallery_id THEN
      RAISE_APPLICATION_ERROR(-20505, 'album_id is already used as a gallery_id');
    END IF;
  END loop;
END;
/

CREATE OR REPLACE TRIGGER gallery_inheritance_trigger
BEFORE INSERT OR UPDATE ON Gallery
FOR EACH ROW
BEGIN
  for album in (SELECT album_id
  FROM Album) loop
    if :new.gallery_id = album.album_id THEN
      RAISE_APPLICATION_ERROR(-20506, 'gallery_id is already used as an album_id');
    END IF;
  END loop;
END;
/

CREATE OR REPLACE TRIGGER photo_inheritance_trigger
BEFORE INSERT OR UPDATE ON Photo
FOR EACH ROW
BEGIN
  for comment in (SELECT id
  FROM Commentaire) loop
    if :new.id = comment.id THEN
      RAISE_APPLICATION_ERROR(-20507, 'photo_id is already used as a commentaire_id');
    END IF;
  END loop;
END;
/

CREATE OR REPLACE TRIGGER commentaire_inheritance_trigger
BEFORE INSERT OR UPDATE ON Commentaire
FOR EACH ROW
BEGIN
  for photo in (SELECT id
  FROM Photo) loop
    if :new.id = photo.id THEN
      RAISE_APPLICATION_ERROR(-20508, 'commentaire_id is already used as a photo_id');
    END IF;
  END loop;
END;
/

CREATE OR REPLACE TRIGGER suit_trigger
BEFORE INSERT OR UPDATE ON Suit
FOR EACH ROW
BEGIN
  IF :new.id_utilisateur1 = :new.id_utilisateur2 THEN
    RAISE_APPLICATION_ERROR(-20509, 'users must have different ids: a user cannot follow the publications of himself');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER range_album_trigger
BEFORE INSERT OR UPDATE ON Range_album
FOR EACH ROW
DECLARE
  owner_id varchar(50);
BEGIN
  SELECT utilisateur_id INTO owner_id
  FROM ContenuNumerique
  WHERE contenu_id = :new.id_photo;
  IF :new.id_utilisateur <> owner_id THEN
    RAISE_APPLICATION_ERROR(-20510, 'the owner of the album is not the owner of the photo with id_photo');
  END IF;
END;
/
