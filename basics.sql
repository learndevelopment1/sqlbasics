sawal ek

SELECT rc.name, rc.themeParkID, rc.length, rc.maximumSpeed
FROM coasters.rollercoaster rc
WHERE rc.length > 600 AND rc.maximumSpeed >= 100;

sawal do

SELECT tp.name, tp.themeParkID, tp.parentCompanyID
FROM coasters.themePark tp
LEFT JOIN coasters.parentCompany pc ON tp.parentCompanyID = pc.parentCompanyID
WHERE DAY(tp.openingDate) BETWEEN 1 AND 15;

sawal tin

SELECT tp.name, REPLACE(REPLACE(SUBSTRING(tp.website, INSTR(tp.website, '://') + 3), 'www.', ''), '/', '') AS simplified_website, YEAR(tp.openingDate) AS opening_year
FROM coasters.themePark tp
WHERE tp.countryID <> (
SELECT countryID
FROM coasters.country
WHERE ISOCode = 'BE'
)
AND tp.themeParkID IN (
SELECT themeParkID
FROM coasters.rollercoaster
WHERE materialID IN (
SELECT materialID
FROM coasters.material
WHERE name = 'Wood'
)
);

sawal char
SELECT m.name AS manufacturer_name, m.countryID, c.name AS country_name
FROM coasters.manufacturer m
JOIN coasters.country c ON m.countryID = c.countryID
WHERE m.manufacturerID IN (
SELECT manufacturerID
FROM coasters.rollercoaster
WHERE openingDate >= '2020-01-01'
GROUP BY manufacturerID
HAVING COUNT(*) < 3
);

sawal pach

SELECT DISTINCT tp.name AS themePark_name, pc.name AS parentCompany_name,
(SELECT SUM(rc.length) FROM coasters.rollercoaster rc WHERE rc.themeParkID = tp.themeParkID) AS total_length
FROM coasters.themePark tp
LEFT JOIN coasters.parentCompany pc ON tp.parentCompanyID = pc.parentCompanyID
ORDER BY pc.name, tp.name
LIMIT 28;
