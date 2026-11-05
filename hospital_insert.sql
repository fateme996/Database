
-- 1. Department
INSERT INTO department (department_name, building_nr)
VALUES
    ('Cardiology', 1),
    ('Neurology', 2),
    ('Emergency', 3);


-- 2. Employee
-- Insert mentors first
INSERT INTO employee (
    id, name, phone_nr,
    department_name, start_date, mentor_id
)
VALUES
    (1, 'Anna Andersson', '0701111111',
     'Cardiology', '2022-01-10', NULL),

    (2, 'Erik Svensson', '0702222222',
     'Neurology', '2021-03-15', NULL);


-- Insert employees with mentors
INSERT INTO employee (
    id, name, phone_nr,
    department_name, start_date, mentor_id
)
VALUES
    (3, 'Sara Lind', '0703333333',
     'Cardiology', '2023-08-01', 1),

    (4, 'Johan Berg', '0704444444',
     'Emergency', '2024-02-20', 2);


-- 3. Doctor
INSERT INTO doctor (id, specialization, room_nr)
VALUES
    (1, 'Cardiology', 101),
    (2, 'Neurology', 202);


-- 4. Nurse
INSERT INTO nurse (id, degree)
VALUES
    (3, 'Bachelor of Nursing'),
    (4, 'Bachelor of Nursing');


-- 5. Patient
INSERT INTO patient (id, diagnoses, age, name)
VALUES
    (101, 'Heart disease', 65, 'Maria Karlsson'),
    (102, 'Migraine', 30, 'Oskar Nilsson'),
    (103, 'High blood pressure', 55, 'Emma Larsson');


-- 6. Treating relationship
INSERT INTO treating (doctor_id, patient_id)
VALUES
    (1, 101),
    (1, 103),
    (2, 102),
    (2, 103);
