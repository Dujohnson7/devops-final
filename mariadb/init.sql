-- MariaDB initialization script for the CRUD application
-- This script will be executed when the MariaDB container starts for the first time

-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS crud_app;

-- Use the database
USE crud_app;

-- Create the users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert some sample data (optional)
INSERT IGNORE INTO users (name, email) VALUES 
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com'),
('Bob Johnson', 'bob.johnson@example.com');

-- Show the created table structure
DESCRIBE users;

-- Show the sample data
SELECT * FROM users;
