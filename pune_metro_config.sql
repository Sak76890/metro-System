-- =============================================================
-- PUNE METRO MANAGEMENT SYSTEM DATABASE SCHEMA
-- Configuration File - DDL (Data Definition Language)
-- =============================================================

-- Create database
CREATE DATABASE IF NOT EXISTS pune_metro_management;
USE pune_metro_management;

-- =============================================================
-- TABLE: stations
-- Stores all metro stations information
-- =============================================================
CREATE TABLE stations (
    station_id INT PRIMARY KEY AUTO_INCREMENT,
    station_name VARCHAR(100) NOT NULL UNIQUE,
    station_code VARCHAR(10) NOT NULL UNIQUE,
    line_color VARCHAR(50) NOT NULL,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    zone VARCHAR(50),
    is_interchange BOOLEAN DEFAULT FALSE,
    is_operational BOOLEAN DEFAULT TRUE,
    opening_time TIME DEFAULT '06:00:00',
    closing_time TIME DEFAULT '23:00:00',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =============================================================
-- TABLE: metro_lines
-- Stores metro line information
-- =============================================================
CREATE TABLE metro_lines (
    line_id INT PRIMARY KEY AUTO_INCREMENT,
    line_name VARCHAR(100) NOT NULL,
    line_color VARCHAR(50) NOT NULL UNIQUE,
    total_stations INT DEFAULT 0,
    total_distance DECIMAL(6, 2),
    is_operational BOOLEAN DEFAULT TRUE,
    inauguration_date DATE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================
-- TABLE: routes
-- Stores route connections between stations
-- =============================================================
CREATE TABLE routes (
    route_id INT PRIMARY KEY AUTO_INCREMENT,
    line_id INT NOT NULL,
    from_station_id INT NOT NULL,
    to_station_id INT NOT NULL,
    distance_km DECIMAL(5, 2) NOT NULL,
    travel_time_minutes INT NOT NULL,
    station_order INT NOT NULL,
    FOREIGN KEY (line_id) REFERENCES metro_lines(line_id) ON DELETE CASCADE,
    FOREIGN KEY (from_station_id) REFERENCES stations(station_id) ON DELETE CASCADE,
    FOREIGN KEY (to_station_id) REFERENCES stations(station_id) ON DELETE CASCADE,
    UNIQUE KEY unique_route (line_id, from_station_id, to_station_id)
);

-- =============================================================
-- TABLE: smart_cards
-- Stores smart card information for passengers
-- =============================================================
CREATE TABLE smart_cards (
    card_id INT PRIMARY KEY AUTO_INCREMENT,
    card_number VARCHAR(20) NOT NULL UNIQUE,
    passenger_name VARCHAR(100) NOT NULL,
    passenger_phone VARCHAR(15),
    passenger_email VARCHAR(100),
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    address TEXT,
    card_balance DECIMAL(8, 2) DEFAULT 0.00,
    card_status ENUM('Active', 'Blocked', 'Expired') DEFAULT 'Active',
    issue_date DATE DEFAULT (CURRENT_DATE),
    expiry_date DATE DEFAULT (DATE_ADD(CURRENT_DATE, INTERVAL 10 YEAR)),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =============================================================
-- TABLE: fare_structure
-- Stores fare calculation rules
-- =============================================================
CREATE TABLE fare_structure (
    fare_id INT PRIMARY KEY AUTO_INCREMENT,
    distance_from DECIMAL(5, 2) NOT NULL,
    distance_to DECIMAL(5, 2) NOT NULL,
    base_fare DECIMAL(6, 2) NOT NULL,
    discount_percentage DECIMAL(5, 2) DEFAULT 0.00,
    card_type ENUM('Regular', 'Student', 'Senior', 'Special') DEFAULT 'Regular',
    is_active BOOLEAN DEFAULT TRUE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================
-- TABLE: journey_transactions
-- Stores all metro journey transactions
-- =============================================================
CREATE TABLE journey_transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    card_id INT NOT NULL,
    entry_station_id INT NOT NULL,
    exit_station_id INT,  -- NULL until passenger exits
    entry_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    exit_time TIMESTAMP NULL,
    distance_traveled DECIMAL(5, 2) DEFAULT 0.00,
    fare_charged DECIMAL(6, 2) DEFAULT 0.00,
    balance_before DECIMAL(8, 2) NOT NULL,
    balance_after DECIMAL(8, 2),
    journey_status ENUM('In_Progress', 'Completed', 'Incomplete') DEFAULT 'In_Progress',
    payment_method ENUM('Smart_Card', 'Cash', 'UPI') DEFAULT 'Smart_Card',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (card_id) REFERENCES smart_cards(card_id) ON DELETE CASCADE,
    FOREIGN KEY (entry_station_id) REFERENCES stations(station_id),
    FOREIGN KEY (exit_station_id) REFERENCES stations(station_id)
);

-- =============================================================
-- TABLE: card_recharge_history
-- Stores smart card recharge transaction history
-- =============================================================
CREATE TABLE card_recharge_history (
    recharge_id INT PRIMARY KEY AUTO_INCREMENT,
    card_id INT NOT NULL,
    recharge_amount DECIMAL(8, 2) NOT NULL,
    balance_before DECIMAL(8, 2) NOT NULL,
    balance_after DECIMAL(8, 2) NOT NULL,
    payment_method ENUM('Cash', 'Card', 'UPI', 'Net_Banking') NOT NULL,
    transaction_reference VARCHAR(100),
    recharge_location VARCHAR(100),
    recharge_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (card_id) REFERENCES smart_cards(card_id) ON DELETE CASCADE
);

-- =============================================================
-- TABLE: metro_trains
-- Stores metro train information
-- =============================================================
CREATE TABLE metro_trains (
    train_id INT PRIMARY KEY AUTO_INCREMENT,
    train_number VARCHAR(20) NOT NULL UNIQUE,
    line_id INT NOT NULL,
    capacity INT NOT NULL,
    train_type ENUM('6_Coach', '3_Coach') DEFAULT '3_Coach',
    is_operational BOOLEAN DEFAULT TRUE,
    manufacture_year YEAR,
    last_maintenance_date DATE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (line_id) REFERENCES metro_lines(line_id)
);

-- =============================================================
-- TABLE: train_schedule
-- Stores train schedule information
-- =============================================================
CREATE TABLE train_schedule (
    schedule_id INT PRIMARY KEY AUTO_INCREMENT,
    train_id INT NOT NULL,
    station_id INT NOT NULL,
    arrival_time TIME NOT NULL,
    departure_time TIME NOT NULL,
    direction ENUM('Up', 'Down') NOT NULL,
    is_peak_hour BOOLEAN DEFAULT FALSE,
    day_type ENUM('Weekday', 'Weekend', 'Holiday') DEFAULT 'Weekday',
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (train_id) REFERENCES metro_trains(train_id) ON DELETE CASCADE,
    FOREIGN KEY (station_id) REFERENCES stations(station_id)
);

-- =============================================================
-- TABLE: admin_users
-- Stores admin user credentials and information
-- =============================================================
CREATE TABLE admin_users (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    role ENUM('Super_Admin', 'Station_Manager', 'Operator') DEFAULT 'Operator',
    is_active BOOLEAN DEFAULT TRUE,
    last_login TIMESTAMP NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =============================================================
-- CREATE INDEXES FOR BETTER PERFORMANCE
-- =============================================================

CREATE INDEX idx_stations_line_color ON stations(line_color);
CREATE INDEX idx_stations_operational ON stations(is_operational);
CREATE INDEX idx_smart_cards_number ON smart_cards(card_number);
CREATE INDEX idx_smart_cards_status ON smart_cards(card_status);
CREATE INDEX idx_journey_card_date ON journey_transactions(card_id, created_date);
CREATE INDEX idx_journey_status ON journey_transactions(journey_status);
CREATE INDEX idx_routes_line_stations ON routes(line_id, from_station_id, to_station_id);

-- =============================================================
-- CREATE STORED PROCEDURES
-- =============================================================

DELIMITER //

-- Procedure to calculate fare between two stations
CREATE PROCEDURE CalculateFare(
    IN from_station INT,
    IN to_station INT,
    IN card_type_param VARCHAR(20),
    OUT calculated_fare DECIMAL(6,2),
    OUT distance DECIMAL(5,2)
)
BEGIN
    DECLARE total_distance DECIMAL(5,2) DEFAULT 0;
    DECLARE fare DECIMAL(6,2) DEFAULT 0;

    -- Calculate distance (simplified - in real scenario would need complex routing)
    SELECT ABS(r1.station_order - r2.station_order) * 1.3 INTO total_distance
    FROM routes r1, routes r2 
    WHERE r1.from_station_id = from_station 
    AND r2.from_station_id = to_station
    AND r1.line_id = r2.line_id
    LIMIT 1;

    -- Get fare based on distance and card type
    SELECT base_fare INTO fare
    FROM fare_structure 
    WHERE distance_from <= total_distance 
    AND distance_to >= total_distance 
    AND card_type = card_type_param
    AND is_active = TRUE
    ORDER BY distance_from DESC
    LIMIT 1;

    SET calculated_fare = IFNULL(fare, 10.00);
    SET distance = IFNULL(total_distance, 1.0);
END //

-- Procedure to process metro entry (swipe in)
CREATE PROCEDURE ProcessMetroEntry(
    IN card_number_param VARCHAR(20),
    IN station_id_param INT,
    OUT result_status VARCHAR(50),
    OUT current_balance DECIMAL(8,2)
)
BEGIN
    DECLARE card_id_val INT;
    DECLARE balance DECIMAL(8,2);
    DECLARE card_status_val VARCHAR(20);
    DECLARE min_balance DECIMAL(6,2) DEFAULT 10.00;

    -- Get card details
    SELECT card_id, card_balance, card_status 
    INTO card_id_val, balance, card_status_val
    FROM smart_cards 
    WHERE card_number = card_number_param;

    -- Check if card exists
    IF card_id_val IS NULL THEN
        SET result_status = 'CARD_NOT_FOUND';
        SET current_balance = 0.00;
    ELSEIF card_status_val != 'Active' THEN
        SET result_status = 'CARD_BLOCKED';
        SET current_balance = balance;
    ELSEIF balance < min_balance THEN
        SET result_status = 'INSUFFICIENT_BALANCE';
        SET current_balance = balance;
    ELSE
        -- Check if already has an active journey
        IF EXISTS(SELECT 1 FROM journey_transactions WHERE card_id = card_id_val AND journey_status = 'In_Progress') THEN
            SET result_status = 'JOURNEY_IN_PROGRESS';
            SET current_balance = balance;
        ELSE
            -- Create new journey transaction
            INSERT INTO journey_transactions (card_id, entry_station_id, balance_before)
            VALUES (card_id_val, station_id_param, balance);

            SET result_status = 'SUCCESS';
            SET current_balance = balance;
        END IF;
    END IF;
END //

DELIMITER ;

-- =============================================================
-- CREATE VIEWS FOR COMMON QUERIES
-- =============================================================

-- View for active smart cards with passenger details
CREATE VIEW active_cards_view AS
SELECT 
    sc.card_id,
    sc.card_number,
    sc.passenger_name,
    sc.passenger_phone,
    sc.passenger_email,
    sc.card_balance,
    sc.issue_date,
    sc.expiry_date
FROM smart_cards sc
WHERE sc.card_status = 'Active';

-- View for station details with line information
CREATE VIEW station_details_view AS
SELECT 
    s.station_id,
    s.station_name,
    s.station_code,
    s.line_color,
    ml.line_name,
    s.zone,
    s.is_interchange,
    s.is_operational,
    s.opening_time,
    s.closing_time
FROM stations s
JOIN metro_lines ml ON s.line_color = ml.line_color
WHERE s.is_operational = TRUE;

-- View for journey history with station names
CREATE VIEW journey_history_view AS
SELECT 
    jt.transaction_id,
    sc.card_number,
    sc.passenger_name,
    es.station_name AS entry_station,
    xs.station_name AS exit_station,
    jt.entry_time,
    jt.exit_time,
    jt.distance_traveled,
    jt.fare_charged,
    jt.journey_status
FROM journey_transactions jt
JOIN smart_cards sc ON jt.card_id = sc.card_id
JOIN stations es ON jt.entry_station_id = es.station_id
LEFT JOIN stations xs ON jt.exit_station_id = xs.station_id
ORDER BY jt.entry_time DESC;

-- =============================================================
-- DATABASE SCHEMA CONFIGURATION COMPLETED
-- =============================================================
-- Total Tables: 10
-- Total Views: 3
-- Total Procedures: 2
-- Total Indexes: 7
-- =============================================================
