-- ============================================================
--   LOST & FOUND CAMPUS PORTAL — DATABASE SETUP SCRIPT
--   Run this in MySQL Workbench or phpMyAdmin before starting
-- ============================================================

CREATE DATABASE IF NOT EXISTS lostfound_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE lostfound_db;

-- Drop tables if already exist (for clean reinstall)
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS claims;
DROP TABLE IF EXISTS item_images;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS admin;
SET FOREIGN_KEY_CHECKS = 1;

-- Users table
CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(100) NOT NULL,
  phone VARCHAR(15),
  roll_no VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Items table
CREATE TABLE items (
  item_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  type ENUM('lost', 'found') NOT NULL,
  title VARCHAR(150) NOT NULL,
  description TEXT,
  category VARCHAR(50),
  location VARCHAR(100),
  date_reported DATE,
  status VARCHAR(20) DEFAULT 'open',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Item images table
CREATE TABLE item_images (
  image_id INT AUTO_INCREMENT PRIMARY KEY,
  item_id INT,
  image_path VARCHAR(255),
  FOREIGN KEY (item_id) REFERENCES items(item_id) ON DELETE CASCADE
);

-- Claims table
CREATE TABLE claims (
  claim_id INT AUTO_INCREMENT PRIMARY KEY,
  item_id INT,
  claimant_id INT,
  proof_description TEXT,
  status VARCHAR(20) DEFAULT 'pending',
  claimed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  verified_by INT DEFAULT NULL,
  FOREIGN KEY (item_id) REFERENCES items(item_id) ON DELETE CASCADE,
  FOREIGN KEY (claimant_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Admin table
CREATE TABLE admin (
  admin_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  password VARCHAR(50) NOT NULL
);

-- Default admin: username=admin, password=admin123
INSERT INTO admin (username, password) VALUES ('admin', 'admin123');

-- Sample users (password: password123)
INSERT INTO users (name, email, password, phone, roll_no) VALUES
('Rahul Sharma', 'rahul@gmail.com', 'password123', '9876543210', 'TE-2024-01'),
('Priya Patil', 'priya@gmail.com', 'password123', '9876543211', 'TE-2024-02'),
('Amit Desai', 'amit@gmail.com', 'password123', '9876543212', 'TE-2024-03');

-- Sample items
INSERT INTO items (user_id, type, title, description, category, location, date_reported, status) VALUES
(1, 'lost', 'Black iPhone 13', 'Black colored iPhone 13 with cracked screen protector. Has a red case with initials RS.', 'Electronics', 'Main Canteen', '2026-03-25', 'open'),
(2, 'found', 'Blue Engineering Bag', 'Found a blue Wildcraft bag near library. Contains notebooks and a geometry box.', 'Bags', 'Library Block', '2026-03-26', 'open'),
(3, 'lost', 'College ID Card', 'Lost my ID card near the sports ground. Name: Amit Desai, Roll No: TE-2024-03', 'ID Card', 'Sports Ground', '2026-03-27', 'open'),
(1, 'found', 'Set of Keys', 'Found a set of 3 keys with a small Ganpati keychain near the parking area.', 'Keys', 'Parking Area', '2026-03-28', 'open');

-- Sample claim
INSERT INTO claims (item_id, claimant_id, proof_description, status) VALUES
(2, 1, 'The bag belongs to me. It has a red pen mark on the zipper and contains my engineering drawing sheets with my name on them.', 'pending');

SELECT 'Database setup complete! You can now run the application.' AS Message;
