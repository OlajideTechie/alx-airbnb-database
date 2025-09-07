CREATE INDEX idx_users_email ON users(email);

-- Bookings table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_booking_date ON bookings(booking_date);

-- Properties table
CREATE INDEX idx_properties_name ON properties(name);
CREATE INDEX idx_properties_location ON properties(location);