CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE publishers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    publication_year INT,
    location VARCHAR(255),
    publisher_id INT,
    FOREIGN KEY (publisher_id) REFERENCES publishers(id)
);

CREATE TABLE book_authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (author_id) REFERENCES authors(id)
);

CREATE TABLE readers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    gender CHAR(1),
    education_level VARCHAR(100)
);

CREATE TABLE book_loans (
    id SERIAL PRIMARY KEY,
    book_id INT,
    reader_id INT,
    loan_date DATE,
    expected_return_date DATE,
    actual_return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (reader_id) REFERENCES readers(id)
);


ALTER TABLE authors 
ADD CONSTRAINT authors_name_check CHECK (first_name <> '' AND last_name <> '');

ALTER TABLE publishers 
ADD CONSTRAINT publishers_name_check CHECK (name <> '');

ALTER TABLE books 
ADD CONSTRAINT books_title_check CHECK (title <> '');

ALTER TABLE books 
ADD CONSTRAINT publication_year_check CHECK (publication_year > 0 AND publication_year <= EXTRACT(YEAR FROM CURRENT_DATE));

ALTER TABLE readers 
ADD CONSTRAINT readers_name_check CHECK (first_name <> '' AND last_name <> '');

ALTER TABLE readers 
ADD CONSTRAINT gender_check CHECK (gender IN ('M', 'F'));

ALTER TABLE readers 
ADD CONSTRAINT education_level_check CHECK (education_level <> '');

ALTER TABLE book_loans 
ADD CONSTRAINT loan_date_check CHECK (expected_return_date > loan_date AND (actual_return_date IS NULL OR actual_return_date >= loan_date));
