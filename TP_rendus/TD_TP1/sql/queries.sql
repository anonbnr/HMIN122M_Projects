/*
* @brief Queries to test the tables of the database
* @author Bachar RIMA
* @author Joseph SABA
*/

/*"les photos de France*/
SELECT *
FROM Photo
WHERE lieu LIKE '%FRANCE%';

/*les utilisateurs ayant pris des photos de France*/
SELECT *
FROM Utilisateur, Photo, ContenuNumerique
WHERE contenu_id = photo_id
AND Utilisateur.utilisateur_id = ContenuNumerique.utilisateur_id
AND lieu LIKE '%FRANCE%';

/*les appareils utilisés pour prendre des photos de France*/
SELECT *
FROM AppareilPhoto, Photo
WHERE model = model_appareil
AND lieu LIKE '%FRANCE%';

/*les photos les plus appréciées avec la licence de distribution 'tous droits réservés'*/
SELECT Aime.photo_id, chemin, lieu, count(*) AS likes
FROM Photo, Aime, Licence
WHERE droits = 'tous droits réservés'
AND Photo.licence_id = Licence.licence_id
AND Photo.photo_id = Aime.photo_id
GROUP BY Aime.photo_id, chemin, lieu
ORDER BY likes DESC;

/*les photos incluses dans le plus grand nombre de galeries*/
SELECT Range_gallery.photo_id, chemin, lieu, count(*) AS nb_galleries
FROM Photo, Range_gallery
WHERE Photo.photo_id = Range_gallery.photo_id
GROUP BY Range_gallery.photo_id, chemin, lieu
ORDER BY nb_galleries DESC;
