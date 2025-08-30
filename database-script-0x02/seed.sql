-- ===================================================
-- Airbnb Database Seed Data
-- ===================================================

-- Insert Users
INSERT INTO users (first_name, last_name, email, phone_number)
VALUES
('John', 'Doe', 'john.doe@example.com', '+123456789'),
('Jane', 'Smith', 'jane.smith@example.com', '+987654321'),
('David', 'Lee', 'david.lee@example.com', '+112233445');

-- Insert Locations
INSERT INTO locations (address, city, state, country)
VALUES
('123 Main Street', 'New York', 'NY', 'USA'),
('456 Market Street', 'San Francisco', 'CA', 'USA'),
('789 Palm Avenue', 'Lagos', 'Lagos', 'Nigeria');

-- Insert Properties
INSERT INTO properties (owner_id, location_id, title, description, price_per_night)
VALUES
(1, 1, 'Cozy Apartment in NYC', 'A nice apartment near Central Park', 120.00),
(2, 2, 'Modern SF Loft', 'Spacious loft with city view', 200.00),
(3, 3, 'Beach House Lagos', 'Relaxing beach house in Lagos', 80.00);

-- Insert Bookings
INSERT INTO bookings (user_id, property_id, check_in_date, check_out_date, status)
VALUES
(2, 1, '2025-09-01', '2025-09-05', 'confirmed'),
(3, 2, '2025-09-10', '2025-09-12', 'pending'),
(1, 3, '2025-09-15', '2025-09-20', 'confirmed');

-- Insert Reviews
INSERT INTO reviews (user_id, property_id, rating, comment)
VALUES
(2, 1, 5, 'Amazing stay, highly recommended!'),
(3, 2, 4, 'Great place, but a bit noisy at night.'),
(1, 3, 5, 'Beautiful location and very clean.');

-- Insert Payments
INSERT INTO payments (booking_id, amount, payment_date, status)
VALUES
(1, 480.00, '2025-08-28 10:00:00', 'successful'),
(2, 400.00, '2025-08-29 15:30:00', 'pending'),
(3, 400.00, '2025-08-30 09:45:00', 'successful');
