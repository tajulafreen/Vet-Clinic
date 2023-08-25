/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (1, 'Agumon', '2020-02-03', 0, TRUE, 10.23);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (2, 'Gabumon', '2018-11-15', 2, TRUE, 8.00);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (3, 'Pikachu', '2021-01-07', 1, FALSE, 15.04);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (4, 'Devimon', '2017-05-12', 5, TRUE, 11.00);

-- ALTER ANIMALS TABLE

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (5, 'Charmander', '2020-02-08', 0, FALSE, -11);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (6, 'Plantmon', '2021-11-15', 2, TRUE, -5.7);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (7, 'Squirtle', '1993-04-02', 3, FALSE, -12.13);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (8, 'Angemon', '2005-06-12', 1, TRUE, -45);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (9, 'Boarmon', '2005-06-07', 7, TRUE, 20.4);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (10, 'Blossom', '1998-10-13', 3, TRUE, 17);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (11, 'Ditto', '2022-05-14', 4, TRUE, 22);


-- Insert the following data into the owners table:

--     Sam Smith 34 years old.
--     Jennifer Orwell 19 years old.
--     Bob 45 years old.
--     Melody Pond 77 years old.
--     Dean Winchester 14 years old.
--     Jodie Whittaker 38 years old.

INSERT INTO owners (full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);


-- Insert the following data into the species table:

--     Pokemon
--     Digimon

INSERT INTO species (name)
VALUES
    ('Pokemon'),
    ('Digimon');


-- Modify your inserted animals so it includes the species_id value:

--     If the name ends in "mon" it will be Digimon
--     All other animals are Pokemon

UPDATE animals
SET species_id = CASE
    WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
    ELSE (SELECT id FROM species WHERE name = 'Pokemon')
END;


-- Modify your inserted animals to include owner information (owner_id):

--     Sam Smith owns Agumon.
--     Jennifer Orwell owns Gabumon and Pikachu.
--     Bob owns Devimon and Plantmon.
--     Melody Pond owns Charmander, Squirtle, and Blossom.
--     Dean Winchester owns Angemon and Boarmon.

UPDATE animals
SET owner_id = CASE
    WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
    WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
    WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
    WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
    WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
END;

-- Insert the following data for vets:

    --  Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
    --  Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
    --  Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
    --  Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.

INSERT INTO vets (name, age, date_of_graduation)
VALUES
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');


-- Insert the following data for specializations:

    --  Vet William Tatcher is specialized in Pokemon.
    INSERT INTO specializations (vet_id, species_id)
    VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), 1);

    --  Vet Stephanie Mendez is specialized in Digimon and Pokemon.
    INSERT INTO specializations (vet_id, species_id)
    VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 2);

    INSERT INTO specializations (vet_id, species_id)
    VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 1);

    --  Vet Jack Harkness is specialized in Digimon.
    INSERT INTO specializations (vet_id, species_id)
    VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'), 2);


-- Insert the following data for visits:

    --  Agumon visited William Tatcher on May 24th, 2020.
    --  Agumon visited Stephanie Mendez on Jul 22th, 2020.
    --  Gabumon visited Jack Harkness on Feb 2nd, 2021.
    --  Pikachu visited Maisy Smith on Jan 5th, 2020.
    --  Pikachu visited Maisy Smith on Mar 8th, 2020.
    --  Pikachu visited Maisy Smith on May 14th, 2020.
    --  Devimon visited Stephanie Mendez on May 4th, 2021.
    --  Charmander visited Jack Harkness on Feb 24th, 2021.
    --  Plantmon visited Maisy Smith on Dec 21st, 2019.
    --  Plantmon visited William Tatcher on Aug 10th, 2020.
    --  Plantmon visited Maisy Smith on Apr 7th, 2021.
    --  Squirtle visited Stephanie Mendez on Sep 29th, 2019.
    --  Angemon visited Jack Harkness on Oct 3rd, 2020.
    --  Angemon visited Jack Harkness on Nov 4th, 2020.
    --  Boarmon visited Maisy Smith on Jan 24th, 2019.
    --  Boarmon visited Maisy Smith on May 15th, 2019.
    --  Boarmon visited Maisy Smith on Feb 27th, 2020.
    --  Boarmon visited Maisy Smith on Aug 3rd, 2020.
    --  Blossom visited Stephanie Mendez on May 24th, 2020.
    --  Blossom visited William Tatcher on Jan 11th, 2021.

INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES
    ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Agumon'), '2020-05-24'),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Agumon'), '2020-07-22'),
    ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Gabumon'), '2021-02-02'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-01-05'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-03-08'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-05-14'),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Devimon'), '2021-05-04'),
    ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Charmander'), '2021-02-24'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2019-12-21'),
    ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2020-08-10'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2021-04-07'),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Squirtle'), '2019-09-29'),
    ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-10-03'),
    ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-11-04'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-01-24'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-05-15'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-02-27'),
    ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-08-03'),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Blossom'), '2020-05-24'),
    ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Blossom'), '2021-01-11');