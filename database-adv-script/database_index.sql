-- ========================================
-- Step 1: Create Indexes
-- ========================================

-- Users table
CREATE INDEX idx_users_email ON users(email);

-- Bookings table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_booking_date ON bookings(booking_date);

-- Properties table
CREATE INDEX idx_properties_name ON properties(name);
CREATE INDEX idx_properties_location ON properties(location);

-- ========================================
-- Step 2: Test Query Performance Using EXPLAIN ANALYZE
-- ========================================

-- Example 1: Fetch bookings for a date range
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.booking_date,
    u.name AS user_name,
    p.name AS property_name,
    pay.amount
FROM 
    bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
INNER JOIN payments pay ON b.booking_id = pay.booking_id
WHERE b.booking_date >= '2025-01-01'
  AND b.booking_date < '2025-02-01';

-- Example 2: Fetch bookings for a specific user
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.booking_date,
    u.name AS user_name,
    p.name AS property_name,
    pay.amount
FROM 
    bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
INNER JOIN payments pay ON b.booking_id = pay.booking_id
WHERE u.email = 'example@example.com';

-- Example 3: Aggregate total bookings per property
EXPLAIN ANALYZE
SELECT
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY total_bookings DESC;
