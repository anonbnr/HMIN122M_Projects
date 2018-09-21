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
WHERE contenu_id = id
AND Utilisateur.utilisateur_id = ContenuNumerique.utilisateur_id
AND lieu LIKE '%FRANCE%';

/*les appareils utilisés pour prendre des photos de France*/
SELECT *
FROM AppareilPhoto, Photo
WHERE model = id_appareil
AND lieu LIKE '%FRANCE%';

/*les photos les plus appréciées avec la licence de distribution 'tous droits réservés'*/
SELECT id_photo, chemin, lieu, count(*) AS likes
FROM Photo, Aime, Licence
WHERE droits = 'tous droits réservés'
AND id_licence = licence_id
AND id = id_photo
GROUP BY id_photo
ORDER BY likes DESC;

/*les photos incluses dans le plus grand nombre de galeries*/
SELECT id_photo, chemin, lieu, count(*) AS nb_galleries
FROM Photo, Range_gallery
WHERE id = id_photo
GROUP BY id_photo
ORDER BY nb_galleries DESC;
