-- ===================================================
-- Airbnb Database Schema with Indexes (3NF)
-- ===================================================

-- ================================
-- Drop tables if they exist (for clean re-run)
-- ================================
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS bookings CASCADE;
DROP TABLE IF EXISTS properties CASCADE;
DROP TABLE IF EXISTS locations CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- ================================
-- Users Table
-- ================================
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for Users
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_name ON users(last_name, first_name);

-- ================================
-- Locations Table
-- ================================
CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100)
);

-- Indexes for Locations
CREATE INDEX idx_locations_city ON locations(city);
CREATE INDEX idx_locations_state_country ON locations(state, country);

-- ================================
-- Properties Table
-- ================================
CREATE TABLE properties (
    id SERIAL PRIMARY KEY,
    owner_id INT NOT NULL,
    location_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    price_per_night DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_location FOREIGN KEY (location_id) REFERENCES locations(id) ON DELETE CASCADE
);

-- Indexes for Properties
CREATE INDEX idx_properties_owner ON properties(owner_id);
CREATE INDEX idx_properties_location ON properties(location_id);
CREATE INDEX idx_properties_price ON properties(price_per_night);

-- ================================
-- Bookings Table
-- ================================
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_booking_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_booking_property FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);

-- Indexes for Bookings
CREATE INDEX idx_bookings_user ON bookings(user_id);
CREATE INDEX idx_bookings_property ON bookings(property_id);
CREATE INDEX idx_bookings_dates ON bookings(check_in_date, check_out_date);
CREATE INDEX idx_bookings_status ON bookings(status);

-- ================================
-- Reviews Table
-- ================================
CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_review_property FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);

-- Indexes for Reviews
CREATE INDEX idx_reviews_user ON reviews(user_id);
CREATE INDEX idx_reviews_property ON reviews(property_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);

-- ================================
-- Payments Table
-- ================================
CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'successful',
    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE
);

-- Indexes for Payments
CREATE INDEX idx_payments_booking ON payments(booking_id);
CREATE INDEX idx_payments_status ON payments(status);
CREATE INDEX idx_payments_date ON payments(payment_date);
