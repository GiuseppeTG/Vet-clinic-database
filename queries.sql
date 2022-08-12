/*Queries that provide answers to the questions from all projects.*/

-- DAY 1 -- 

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' and '2019-01-01';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- DAY 2 --

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, AVG(escape_attempts) AS average_escapes FROM animals GROUP BY neutered;
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';

-- DAY 3 --

SELECT name FROM animals INNER JOIN owners ON owner_id = owners.id WHERE full_name = 'Melody Pond';
SELECT animals.name FROM animals INNER JOIN species ON species_id = species.id WHERE species.name = 'Pokemon';
SELECT animals.name, owners.full_name FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;
SELECT COUNT(*), species.name AS species FROM animals JOIN species ON species_id = species.id GROUP BY species.name;
SELECT animals.name AS digimons_name, owners.full_name AS owner_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE animals.species_id = 2 AND owners.full_name = 'Jennifer Orwell';
SELECT animals.name, owners.full_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';
SELECT full_name, COUNT(full_name) AS owns FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY full_name ORDER BY owns DESC LIMIT 1;

-- DAY 4 --

SELECT * FROM visits WHERE vet_id = 1 ORDER BY visit_date DESC LIMIT 1;

SELECT COUNT(*) AS different_animals FROM (
  SELECT DISTINCT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id WHERE visits.vet_id = (
    SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'
  )
) AS sq;

SELECT vets.name, specializations.species_id FROM vets LEFT JOIN specializations ON vet_id = vets.id;

SELECT name  AS visit_mendez_apr_to_aug_2020 FROM animals WHERE animals.id IN (
  SELECT animal_id FROM visits WHERE vet_id = (
    SELECT id FROM vets WHERE name = 'Stephanie Mendez'
  ) AND visit_date BETWEEN '2020-04-01' AND '2020-08-30'
);

SELECT animals.name FROM animals WHERE animals.id = (
  SELECT animal_id FROM (
    SELECT animal_id, COUNT(*) AS count FROM visits GROUP BY animal_id ORDER BY count DESC LIMIT 1
  ) top_visit
);

SELECT animals.name AS Smith_first_visitor FROM animals WHERE animals.id = (
  SELECT animal_id FROM visits WHERE vet_id = (
    SELECT id FROM vets WHERE name = 'Maisy Smith'
  ) ORDER BY visit_date LIMIT 1
);

SELECT visit_date, 
animal_id, 
animals.name AS animal_name, 
date_of_birth, 
escape_attempts, 
neutered, 
weight_kg, 
animals.species_id, 
owner_id,
full_name AS owner_name,
vets.id AS vet_id,
vets.name AS vet_name,
specializations.species_id AS specialty_id,
vets.age,
date_of_graduation
FROM visits
  JOIN animals ON visits.animal_id = animals.id
  JOIN vets ON visits.vet_id = vets.id
  JOIN specializations ON visits.vet_id = specializations.vet_id
  JOIN owners ON owners.id = owner_id
ORDER BY visit_date DESC
LIMIT 1;

SELECT * FROM visits
  JOIN vets ON visits.vet_id = vets.id
  JOIN animals ON visits.animal_id = animals.id
  LEFT JOIN specializations ON vets.id = specializations.vet_id
WHERE specializations.vet_id IS NULL OR animals.species_id != specializations.species_id AND vet_id != 3;

SELECT COUNT(*) FROM visits
  JOIN vets ON visits.vet_id = vets.id
  JOIN animals ON visits.animal_id = animals.id
  LEFT JOIN specializations ON vets.id = specializations.vet_id
WHERE vets.id != (
  SELECT id FROM vets WHERE name = 'Stephanie Mendez'
  )
AND specializations.species_id != animals.species_id
OR specializations.species_id IS NULL;

SELECT species.name, COUNT(species_id) as count FROM visits
  JOIN vets ON visits.vet_id = vets.id
  JOIN animals ON animals.id = visits.animal_id
  JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name ORDER BY count DESC LIMIT 1;