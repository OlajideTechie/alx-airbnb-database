-- performance.sql

-- ========================================
-- Step 1: Initial Query
-- Retrieve all bookings along with:
--   - User details
--   - Property details
--   - Payment details
-- ========================================

SELECT 
    b.booking_id,
    b.booking_date,
    u.user_id,
    u.name AS user_name,
    u.email AS user_email,
    p.property_id,
    p.name AS property_name,
    p.location AS property_location,
    pay.payment_id,
    pay.amount,
    pay.payment_date
FROM 
    bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
INNER JOIN payments pay ON b.booking_id = pay.booking_id;

-- ========================================
-- Step 2: Analyze Performance
-- Use EXPLAIN or EXPLAIN ANALYZE to identify inefficiencies.
-- Example (PostgreSQL):
-- EXPLAIN ANALYZE
-- SELECT ...
-- Look for:
--   - Sequential scans on large tables
--   - High cost joins
--   - Unnecessary columns being fetched
-- ========================================

-- ========================================
-- Step 3: Refactor Query for Performance
-- Possible optimizations:
--   1. Only select columns you need (avoid SELECT *).
--   2. Add indexes on:
--        - bookings.user_id
--        - bookings.property_id
--        - payments.booking_id
--   3. Ensure proper join order (smaller tables first if possible)
--   4. Use LEFT JOIN if some relationships are optional and you don't need to filter them out.
-- ========================================

-- Example Refactored Query (fetch only necessary columns)
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
INNER JOIN payments pay ON b.booking_id = pay.booking_id;

-- ========================================
-- Step 4: Measure Performance After Refactor
-- Use EXPLAIN ANALYZE again and compare total execution time and rows scanned.
-- If performance is still slow:
--   - Ensure indexes exist on foreign key columns (user_id, property_id, booking_id)
--   - Consider adding composite indexes if filtering on multiple columns frequently
-- ========================================
