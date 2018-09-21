/*
* @brief Creates the triggers for some tables of the database
* @author Bachar RIMA
* @author Joseph SABA
*/

/*
Album is not a gallery
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

/*
Gallery is not an album
*/
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

/*
photo is not a comment
*/
CREATE OR REPLACE TRIGGER photo_inheritance_trigger
BEFORE INSERT OR UPDATE ON Photo
FOR EACH ROW
BEGIN
  for comment in (SELECT comment_id
  FROM Commentaire) loop
    if :new.photo_id = comment.comment_id THEN
      RAISE_APPLICATION_ERROR(-20507, 'photo_id is already used as a comment_id');
    END IF;
  END loop;
END;
/

/*
comment is not a photo
*/
CREATE OR REPLACE TRIGGER commentaire_inheritance_trigger
BEFORE INSERT OR UPDATE ON Commentaire
FOR EACH ROW
BEGIN
  for photo in (SELECT photo_id
  FROM Photo) loop
    if :new.comment_id = photo.photo_id THEN
      RAISE_APPLICATION_ERROR(-20508, 'comment_id is already used as a photo_id');
    END IF;
  END loop;
END;
/

/*
Users can't follow their own account
*/
CREATE OR REPLACE TRIGGER suit_trigger
BEFORE INSERT OR UPDATE ON Suit
FOR EACH ROW
BEGIN
  IF :new.utilisateur_id1 = :new.utilisateur_id2 THEN
    RAISE_APPLICATION_ERROR(-20509, 'users must have different ids: a user cannot follow the publications of himself');
  END IF;
END;
/

/*
Any photo of an album must belong to the album's owner
*/
CREATE OR REPLACE TRIGGER range_album_trigger
BEFORE INSERT OR UPDATE ON Range_album
FOR EACH ROW
DECLARE
  owner_id varchar(50);
BEGIN
  SELECT utilisateur_id INTO owner_id
  FROM ContenuNumerique
  WHERE contenu_id = :new.photo_id;
  IF :new.utilisateur_id <> owner_id THEN
    RAISE_APPLICATION_ERROR(-20510, 'the owner of the album is not the owner of the photo having photo_id');
  END IF;
END;
/
