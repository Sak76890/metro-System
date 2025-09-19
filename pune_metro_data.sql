-- =============================================================
-- PUNE METRO MANAGEMENT SYSTEM DATABASE DATA
-- Data File - DML (Data Manipulation Language)
-- Sample/Initial Data Insertion
-- =============================================================

-- Note: Run this file AFTER executing pune_metro_config.sql
-- Make sure database exists and USE pune_metro_management; is active

USE pune_metro_management;

-- =============================================================
-- INSERT SAMPLE DATA
-- =============================================================

-- Insert metro lines
INSERT IGNORE INTO metro_lines (line_name, line_color, total_stations, total_distance, is_operational, inauguration_date) VALUES
('Pune Metro Line 1 (Aqua)', 'Aqua', 12, 16.59, TRUE, '2017-12-01'),
('Pune Metro Line 2 (Purple)', 'Purple', 14, 14.66, TRUE, '2022-03-06'),
('Pune Metro Line 3 (Orange)', 'Orange', 23, 23.33, FALSE, '2025-12-31');

-- Insert stations for Line 1 (Aqua Line)
INSERT IGNORE INTO stations (station_name, station_code, line_color, latitude, longitude, zone, is_interchange) VALUES
('PCMC', 'PCMC', 'Aqua', 18.6186, 73.8037, 'North', FALSE),
('Sant Tukaram Nagar', 'STN', 'Aqua', 18.6156, 73.8012, 'North', FALSE),
('Bhosari', 'BHO', 'Aqua', 18.6145, 73.8456, 'North', FALSE),
('Kasarwadi', 'KAS', 'Aqua', 18.6012, 73.8234, 'North', FALSE),
('Phugewadi', 'PHU', 'Aqua', 18.5934, 73.8123, 'North', FALSE),
('Dapodi', 'DAP', 'Aqua', 18.5845, 73.8234, 'North', FALSE),
('Bopodi', 'BOP', 'Aqua', 18.5678, 73.8345, 'Central', FALSE),
('Khadki', 'KHA', 'Aqua', 18.5567, 73.8456, 'Central', FALSE),
('Range Hills', 'RAN', 'Aqua', 18.5456, 73.8567, 'Central', FALSE),
('Shivaji Nagar', 'SHI', 'Aqua', 18.5345, 73.8678, 'Central', TRUE),
('Civil Court', 'CIV', 'Aqua', 18.5234, 73.8789, 'Central', FALSE),
('Vanaz', 'VAN', 'Aqua', 18.5123, 73.8890, 'West', FALSE);

-- Insert stations for Line 2 (Purple Line)
INSERT IGNORE INTO stations (station_name, station_code, line_color, latitude, longitude, zone, is_interchange) VALUES
('Vanaz2', 'VAN2', 'Purple', 18.5123, 73.8890, 'West', TRUE),
('Anand Nagar', 'ANA', 'Purple', 18.5012, 73.8901, 'West', FALSE),
('Ideal Colony', 'IDE', 'Purple', 18.4901, 73.9012, 'West', FALSE),
('Nal Stop', 'NAL', 'Purple', 18.4790, 73.9123, 'West', FALSE),
('Garware College', 'GAR', 'Purple', 18.4679, 73.9234, 'West', FALSE),
('Deccan Gymkhana', 'DEC', 'Purple', 18.4568, 73.9345, 'Central', FALSE),
('Chhatrapati Sambhaji Udyan', 'CSU', 'Purple', 18.4457, 73.9456, 'Central', FALSE),
('PMC', 'PMC', 'Purple', 18.4346, 73.9567, 'Central', TRUE),
('Mangalwar Peth', 'MAN', 'Purple', 18.4235, 73.9678, 'Central', FALSE),
('Pune Railway Station', 'PRS', 'Purple', 18.4124, 73.9789, 'Central', TRUE),
('Ruby Hall Clinic', 'RUB', 'Purple', 18.4013, 73.9890, 'South', FALSE),
('Bund Garden', 'BUN', 'Purple', 18.3902, 74.0001, 'South', FALSE),
('Yerawada', 'YER', 'Purple', 18.3791, 74.0112, 'East', FALSE),
('Kalyani Nagar', 'KAL', 'Purple', 18.3680, 74.0223, 'East', FALSE);

-- Insert fare structure
INSERT IGNORE INTO fare_structure (distance_from, distance_to, base_fare, card_type) VALUES
(0.0, 2.0, 10.00, 'Regular'),
(2.1, 5.0, 15.00, 'Regular'),
(5.1, 10.0, 20.00, 'Regular'),
(10.1, 15.0, 25.00, 'Regular'),
(15.1, 25.0, 30.00, 'Regular'),
(25.1, 50.0, 35.00, 'Regular'),
(0.0, 2.0, 8.00, 'Student'),
(2.1, 5.0, 12.00, 'Student'),
(5.1, 10.0, 16.00, 'Student'),
(10.1, 15.0, 20.00, 'Student'),
(15.1, 25.0, 24.00, 'Student'),
(25.1, 50.0, 28.00, 'Student');

-- Insert sample routes for Line 1
INSERT IGNORE INTO routes (line_id, from_station_id, to_station_id, distance_km, travel_time_minutes, station_order) VALUES
(1, 1, 2, 1.2, 2, 1),
(1, 2, 3, 1.5, 3, 2),
(1, 3, 4, 1.3, 2, 3),
(1, 4, 5, 1.1, 2, 4),
(1, 5, 6, 1.4, 3, 5),
(1, 6, 7, 1.6, 3, 6),
(1, 7, 8, 1.2, 2, 7),
(1, 8, 9, 1.3, 2, 8),
(1, 9, 10, 1.4, 3, 9),
(1, 10, 11, 1.1, 2, 10),
(1, 11, 12, 1.5, 3, 11);

-- Insert sample smart cards
INSERT IGNORE INTO smart_cards (card_number, passenger_name, passenger_phone, passenger_email, date_of_birth, gender, address, card_balance, card_status) VALUES
('PMC001234567890', 'Rajesh Kumar', '9876543210', 'rajesh.kumar@email.com', '1985-05-15', 'Male', 'Shivaji Nagar, Pune', 150.00, 'Active'),
('PMC001234567891', 'Priya Sharma', '9876543211', 'priya.sharma@email.com', '1992-08-22', 'Female', 'Kothrud, Pune', 200.00, 'Active'),
('PMC001234567892', 'Amit Patil', '9876543212', 'amit.patil@email.com', '1988-12-10', 'Male', 'Hadapsar, Pune', 75.50, 'Active'),
('PMC001234567893', 'Sneha Joshi', '9876543213', 'sneha.joshi@email.com', '1995-03-18', 'Female', 'Baner, Pune', 300.00, 'Active'),
('PMC001234567894', 'Vikram Singh', '9876543214', 'vikram.singh@email.com', '1987-07-25', 'Male', 'Pimpri, Pune', 125.75, 'Active');

-- Insert sample admin users
INSERT IGNORE INTO admin_users (username, password_hash, full_name, email, phone, role) VALUES
('admin', SHA2('admin123', 256), 'System Administrator', 'admin@punemetro.com', '9999999999', 'Super_Admin'),
('station_mgr', SHA2('station123', 256), 'Station Manager', 'station@punemetro.com', '9999999998', 'Station_Manager'),
('operator1', SHA2('operator123', 256), 'Metro Operator', 'operator@punemetro.com', '9999999997', 'Operator');

-- Insert sample metro trains
INSERT IGNORE INTO metro_trains (train_number, line_id, capacity, train_type, manufacture_year) VALUES
('PMT-A001', 1, 975, '3_Coach', 2017),
('PMT-A002', 1, 975, '3_Coach', 2017),
('PMT-A003', 1, 975, '3_Coach', 2018),
('PMT-P001', 2, 975, '3_Coach', 2022),
('PMT-P002', 2, 975, '3_Coach', 2022),
('PMT-P003', 2, 975, '3_Coach', 2022);

-- =============================================================
-- SAMPLE DATA INSERTION COMPLETED
-- =============================================================

-- Optional: Verify data insertion
SELECT 'Metro Lines' as Entity, COUNT(*) as Count FROM metro_lines
UNION ALL
SELECT 'Stations', COUNT(*) FROM stations
UNION ALL
SELECT 'Routes', COUNT(*) FROM routes
UNION ALL
SELECT 'Smart Cards', COUNT(*) FROM smart_cards
UNION ALL
SELECT 'Admin Users', COUNT(*) FROM admin_users
UNION ALL
SELECT 'Metro Trains', COUNT(*) FROM metro_trains
UNION ALL
SELECT 'Fare Structure', COUNT(*) FROM fare_structure;
