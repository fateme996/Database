
-- 1. Department
CREATE TABLE department (
    department_name VARCHAR(100) PRIMARY KEY,
    building_nr INTEGER
);

-- 2. Employee
CREATE TABLE employee (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    phone_nr VARCHAR(20),

    department_name VARCHAR(100),
    start_date DATE,

    -- Self-referencing relationship: Employee mentors Employee
    -- UNIQUE means one mentor can be assigned to at most one employee.
    -- NULL means no mentor is assigned.
    mentor_id INTEGER UNIQUE,


-- The department must exist in the department table.
    FOREIGN KEY (department_name)
        REFERENCES department(department_name),

    FOREIGN KEY (mentor_id)
        REFERENCES employee(id),

-- An employee cannot be their own mentor
    CHECK (mentor_id IS NULL OR mentor_id <> id)
);

-- 3. Doctor
CREATE TABLE doctor (
    id INTEGER PRIMARY KEY,
    specialization VARCHAR(100),
    room_nr INTEGER,

    FOREIGN KEY (id)
        REFERENCES employee(id)
);

-- 4. Nurse
CREATE TABLE nurse (
    id INTEGER PRIMARY KEY,
    degree VARCHAR(100),

    FOREIGN KEY (id)
        REFERENCES employee(id)
);

-- 5. Patient
CREATE TABLE patient (
    id INTEGER PRIMARY KEY,
    diagnoses TEXT,
    age INTEGER,
    name VARCHAR(100)
);

-- 6. Treating relationship
CREATE TABLE treating (
    doctor_id INTEGER NOT NULL,
    patient_id INTEGER NOT NULL,

    PRIMARY KEY (doctor_id, patient_id),

    FOREIGN KEY (doctor_id)
        REFERENCES doctor(id),

    FOREIGN KEY (patient_id)
        REFERENCES patient(id)
);
