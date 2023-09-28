-- Create the database
CREATE DATABASE IF NOT EXISTS logistics_management;

-- Switch to the new database
USE logistics_management;

-- Create the Countries table
CREATE TABLE Countries(
    country_code INT PRIMARY KEY,
    country_name VARCHAR(50)
);

-- Create the Cities table
CREATE TABLE Cities (
    city_code INT PRIMARY KEY,
    city_name VARCHAR(50),
    country INT,
    FOREIGN KEY (country) REFERENCES Countries(coutnry_code)
);


-- Create the Truck table
CREATE TABLE Trucks (
    truck_id INT PRIMARY KEY AUTO_INCREMENT,
    numbers VARCHAR(5),
    status ENUM('OK', 'NOK'),
    current_city INT,
    current_country INT,
    FOREIGN KEY (current_country) REFERENCES Countries(coutnry_code),
    FOREIGN KEY (current_city) REFERENCES Cities(city_code)
);

-- Create the Trailer table
CREATE TABLE Trailers (
    trailer_id INT PRIMARY KEY AUTO_INCREMENT,
    numbers VARCHAR(5),
    capacity DECIMAL(5,2),
    x_size DECIMAL(5,1), 
    y_size DECIMAL(5,1),
    z_size DECIMAL(5,1),
    status ENUM('OK', 'NOK'),
    current_truck_id INT,
    current_city INT,
    current_country INT,
    FOREIGN KEY (current_country) REFERENCES Countries(coutnry_code),
    FOREIGN KEY (current_truck_id) REFERENCES Trucks(truck_id),
    FOREIGN KEY (current_city) REFERENCES Cities(city_code)
);

-- Create the Driver table
CREATE TABLE Driver (
    driver_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    surname VARCHAR(50),
    personal_number VARCHAR(10) UNIQUE,
    working_hours DECIMAL(3,2),
    status ENUM('rest', 'driving'),
    current_city INT,
    current_country INT,
    home_city INT,
    home_country INT,
    current_truck INT,
    FOREIGN KEY (current_city) REFERENCES Cities(city_code),
    FOREIGN KEY (home_city) REFERENCES Cities(city_code),
    FOREIGN KEY (current_country) REFERENCES Countries(coutnry_code),
    FOREIGN KEY (home_country) REFERENCES Countries(coutnry_code),
    FOREIGN KEY (current_truck) REFERENCES Trucks(truck_id)
);

-- Create the Customer table
CREATE TABLE Customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    surname VARCHAR(50),
    personal_number VARCHAR(10) UNIQUE,
    city INT,
    country INT,
    address VARCHAR(100),
    FOREIGN KEY (city) REFERENCES Cities(city_code),
    FOREIGN KEY (country) REFERENCES Countries(coutnry_code)
);

-- Create the Order table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    unique_number VARCHAR(20) UNIQUE,
    sender_id INT,
    reciever_id INT,
    completed ENUM('yes', 'no'),
    FOREIGN KEY (sender_id) REFERENCES Customer(id),
    FOREIGN KEY (receiver_id) REFERENCES Customer(id)
);

-- Create the Cargo table
CREATE TABLE Cargoes (
    cargo_id INT PRIMARY KEY AUTO_INCREMENT,
    unique_number VARCHAR(20) UNIQUE,
    order_id INT,
    name VARCHAR(50),
    weight DECIMAL(10,2),
    x_size DECIMAL(5,1), 
    y_size DECIMAL(5,1),
    z_size DECIMAL(5,1),
    sender_id INT,
    reciever_id INT,
    trailer_id INT,
    FOREIGN KEY (sender_id) REFERENCES Customers(id),
    FOREIGN KEY (receiver_id) REFERENCES Customers(id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (trailer_id) REFERENCES Trailers(trailer_id),
    status ENUM('ready', 'shipped', 'delivered')
);


-- Create the Distances table
CREATE TABLE Distances (
    from_city INT,
    from_country INT,
    to_city INT,
    to_country INT,
    distance INT,
    PRIMARY KEY (from_city, from_country, to_city, to_country),
    FOREIGN KEY (from_city) REFERENCES Cities(city_code),
    FOREIGN KEY (to_city) REFERENCES Cities(city_code),
    FOREIGN KEY (from_country) REFERENCES Countries(coutnry_code),
    FOREIGN KEY (to_country) REFERENCES Countries(coutnry_code)
);


