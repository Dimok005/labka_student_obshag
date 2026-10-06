-- Student Dormitory System: Деректер қорының схемасы (lab 6)
-- Негізделген: Class Diagram (ЗС №4)

PRAGMA foreign_keys = ON;

-- Dormitory
CREATE TABLE dormitories (
    dormitory_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    rooms_count INTEGER NOT NULL CHECK (rooms_count >= 0)
);

-- Room
CREATE TABLE rooms (
    room_id INTEGER PRIMARY KEY,
    dormitory_id INTEGER NOT NULL,
    number TEXT NOT NULL,
    capacity INTEGER NOT NULL CHECK (capacity > 0),
    occupied INTEGER NOT NULL DEFAULT 0 CHECK (occupied >= 0),
    status TEXT NOT NULL DEFAULT 'free',
    FOREIGN KEY (dormitory_id) REFERENCES dormitories(dormitory_id)
);

-- Student
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    iin TEXT NOT NULL UNIQUE,
    phone TEXT,
    status TEXT NOT NULL DEFAULT 'active'
);

-- Application
CREATE TABLE applications (
    application_id INTEGER PRIMARY KEY,
    student_id INTEGER NOT NULL,
    date TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending',
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Administrator
CREATE TABLE administrators (
    admin_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    login TEXT NOT NULL UNIQUE
);

-- Registration
CREATE TABLE registrations (
    registration_id INTEGER PRIMARY KEY,
    student_id INTEGER NOT NULL,
    room_id INTEGER NOT NULL,
    admin_id INTEGER,
    date TEXT NOT NULL,
    start_date TEXT,
    end_date TEXT,
    status TEXT NOT NULL DEFAULT 'active',
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id),
    FOREIGN KEY (admin_id) REFERENCES administrators(admin_id)
);

-- Payment
CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    registration_id INTEGER NOT NULL,
    amount REAL NOT NULL CHECK (amount > 0),
    date TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'paid',
    FOREIGN KEY (registration_id) REFERENCES registrations(registration_id)
);

-- INSERT
INSERT INTO dormitories (dormitory_id, name, address, rooms_count) VALUES
(1, 'Obshaga №1', 'Abaya 10', 20),
(2, 'Obshaga №2', 'Satpayev 45', 15);

INSERT INTO rooms (room_id, dormitory_id, number, capacity, occupied, status) VALUES
(101, 1, '101', 2, 1, 'occupied'),
(102, 1, '102', 3, 0, 'free'),
(201, 2, '201', 2, 2, 'full');

INSERT INTO students (student_id, full_name, iin, phone, status) VALUES
(1, 'Aydar Serik', '030101500123', '87011112233', 'active'),
(2, 'Aru Bolat', '040202600456', '87014445566', 'active');

INSERT INTO applications (application_id, student_id, date, status) VALUES
(1, 1, '2026-09-01', 'approved'),
(2, 2, '2026-09-02', 'pending'),
(3, 2, '2026-09-03', 'rejected');

INSERT INTO administrators (admin_id, full_name, login) VALUES
(1, 'Dana Admin', 'admin1');

INSERT INTO registrations (registration_id, student_id, room_id, admin_id, date, start_date, end_date, status) VALUES
(1, 1, 101, 1, '2026-09-05', '2026-09-10', '2027-06-30', 'active');

INSERT INTO payments (payment_id, registration_id, amount, date, status) VALUES
(1, 1, 15000.0, '2026-09-06', 'paid'),
(2, 1, 5000.0, '2026-09-07', 'cancelled');

-- UPDATE
UPDATE rooms SET occupied = 2, status = 'full' WHERE room_id = 101;
UPDATE applications SET status = 'approved' WHERE application_id = 2;

-- DELETE
DELETE FROM payments WHERE payment_id = 2;
DELETE FROM applications WHERE application_id = 3;
