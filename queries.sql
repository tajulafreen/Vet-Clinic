/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


/*The BEGIN statement starts a new transaction. The UPDATE statement updates all rows in the 'animals' table
by setting the 'species' column to 'unspecified'. The SELECT statement verifies that the change was made
by selecting all rows where the 'species' column is 'unspecified'. The ROLLBACK statement rolls back the transaction,
undoing the changes made by the UPDATE statement. The final SELECT statement verifies that the 'species' column
went back to its original state by selecting all rows where the 'species' column is not 'unspecified'.*/
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals; -- verify the change
ROLLBACK;

SELECT * FROM animals; --verify the change
/*The BEGIN statement starts a new transaction. The first UPDATE statement updates all rows in the 'animals'
table where the 'name' column ends with 'mon' by setting the 'species' column to 'digimon'.
The second UPDATE statement updates all rows in the 'animals' table where the 'species' column is
NULL (i.e., not already set) by setting the 'species' column to 'pokemon'.
The SELECT statement verifies that the changes were made by selecting all rows where the 'species'
column is either 'digimon' or 'pokemon'. The COMMIT statement commits the transaction, making the
changes permanent. Finally, the last SELECT statement verifies that the changes persist by selecting
all rows where the 'species' column is either 'digimon' or 'pokemon'.*/
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals WHERE species = 'digimon' OR species = 'pokemon'; -- verify the changes
COMMIT;
SELECT * FROM animals WHERE species = 'digimon' OR species = 'pokemon'; -- verify the changes persist

/* The BEGIN statement starts a new transaction. The DELETE statement deletes all rows from the 'animals' table.
The SELECT statement verifies that all records were deleted by counting the number of rows in the 'animals' table.
The ROLLBACK statement rolls back the transaction, undoing the deletion of all records. The final SELECT statement
verifies that all records still exist by counting the number of rows in the 'animals' table.*/
BEGIN;
DELETE FROM animals;
SELECT COUNT(*) FROM animals; -- verify that all records were deleted
ROLLBACK;
SELECT COUNT(*) FROM animals; -- verify that all records still exist


/*The BEGIN statement starts a new transaction. The DELETE statement deletes all rows from the 'animals' table
where the 'date_of_birth' column is after Jan 1st, 2022. The SAVEPOINT statement creates a savepoint named
'my_savepoint' in the transaction. The first UPDATE statement updates all rows in the 'animals' table by setting
the 'weight_kg' column to its current value multiplied by -1. The ROLLBACK TO statement rolls back the transaction
to the savepoint named 'my_savepoint', undoing the updates made by the first UPDATE statement. The second UPDATE
statement updates all rows in the 'animals' table where the 'weight_kg' column is negative by setting it to its
current value multiplied by -1. The COMMIT statement commits the transaction, making the changes permanent.*/
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT animals_born_after_Jan1st22;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO animals_born_after_Jan1st22;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;


SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;

/*This query groups the animals by their neutered status and sums up their 'escape_attempts'
column to get the total number of escape attempts for each group. It then orders the groups by
the total number of escape attempts in descending order and selects the first row (i.e., the group with the
highest number of escape attempts).*/
SELECT neutered, SUM(escape_attempts) AS total_attempts
FROM animals
GROUP BY neutered
ORDER BY total_attempts DESC
LIMIT 1;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

/*This query selects all animals born between Jan 1st, 1990 and Dec 31st, 2000, groups them by their type,
and calculates the average number of escape attempts for each group.*/
SELECT species, AVG(escape_attempts) AS avg_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;