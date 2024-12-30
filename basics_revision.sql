-- CREATE TABLE job_applied (
--     job_id INT ,
--     application_sent_date DATE,
--     custom_resume BOOLEAN,
--     resume_file_name VARCHAR(225),
--     cover_letter_sent BOOLEAN,
--     cover_letter_file_name VARCHAR(225),
--     status VARCHAR (50)


-- );

INSERT INTO job_applied (job_id ,
    application_sent_date ,
    custom_resume ,
    resume_file_name, 
    cover_letter_sent,
    cover_letter_file_name, 
    status 
) values (1,
             '2024-02-01',
             true,
             'resume_01.pdf',
             true,
             'cover_letter_01.pdf',
             'submitted'),
            (2,
             '2024-02-02',
             false,
             'resume_02.pdf',
             false,
             NULL,
             'interview scheduled'),
            (3,
             '2024-02-03',
             true,
             'resume_03.pdf',
             true,
             'cover_letter_03.pdf',
             'ghosted'),
            (4,
             '2024-02-04',
             true,
             'resume_04.pdf',
             false,
             NULL,
             'submitted'),
            (5,
             '2024-02-05',
             false,
             'resume_05.pdf',
             true,
             'cover_letter_05.pdf',
             'rejected');

SELECT * from job_applied;

-- alter function to add the row in to the table

ALTER table job_applied ADD contact varchar(50);

-- UPDATE / ADD THE NEW VALUES INTO THE NEW COLUMN

UPDATE job_applied SET contact = ' Erlich Bachman' where job_id = 1;
UPDATE job_applied SET contact = 'Dinesh Chugtai'where job_id =2;
UPDATE job_applied SET contact ='Bertram Gilfoyle' WHERE job_id=3;
UPDATE job_applied SET contact = 'Jian Yang' WHERE job_id = 4;
UPDATE job_applied SET contact = 'Big Head' WHERE job_id = 5;

-- Alter function also helps to rename the column name 

ALTER TABLE job_applied RENAME COLUMN contact TO  contact_name;

-- ALter function has ability to change the data type to different data type
ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

-- drop statement is used to drop particular column fro the specified table
ALTER TABLE job_applied
DROP COLUMN contact_name;

-- it drops the table / deletes the table

DROP TABLE job_applied;