-- Drop tables if they already exist (optional for re-runs)
DROP TABLE IF EXISTS Billing, Prescription, Appointment, Patient, Doctor;

-- Table: Patient
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address TEXT
);

-- Table: Doctor
CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Table: Appointment
CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- Table: Prescription
CREATE TABLE Prescription (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medication_name VARCHAR(100) NOT NULL,
    dosage VARCHAR(50),
    instructions TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

-- Table: Billing
CREATE TABLE Billing (
    billing_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    billing_date DATE NOT NULL,
    payment_status ENUM('Paid', 'Unpaid', 'Pending') DEFAULT 'Pending',
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);
