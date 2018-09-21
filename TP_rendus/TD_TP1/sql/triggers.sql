/*
* @brief Creates the triggers for some tables of the database
* @author Bachar RIMA
* @author Joseph SABA
*/

CREATE OR REPLACE TRIGGER album_inheritance_trigger
BEFORE INSERT OR UPDATE ON Album
FOR EACH ROW
DECLARE
  error_message VARCHAR(500);
BEGIN
  IF album_id IN (SELECT gallery_id
  FROM Gallery) THEN
    RAISE_APPLICATION_ERROR(-20505, 'album_id is already used as a gallery_id');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER gallery_inheritance_trigger
BEFORE INSERT OR UPDATE ON Gallery
FOR EACH ROW
DECLARE
  error_message VARCHAR(500);
BEGIN
  IF new.gallery_id IN (SELECT album_id
  FROM Album) THEN
    RAISE_APPLICATION_ERROR(-20505, 'gallery_id is already used as an album_id');
  END IF;
END;
/
