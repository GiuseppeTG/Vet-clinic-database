/* Database schema to keep the structure of entire database. */

--animals table--

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL,
    species VARCHAR(100)
);

--species_id column--

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals
ADD species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species_id FOREIGN KEY(species_id) REFERENCES species(id);

--owner_id column--

ALTER TABLE animals
ADD owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_owner_id FOREIGN KEY(owner_id) REFERENCES owners(id);

--owners table--

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (id)
);

--species table--

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    PRIMARY KEY (id)
);