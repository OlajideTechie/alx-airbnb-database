-- performance.sql

-- ========================================
-- Step 1: Initial Query with Filters
-- Retrieve all bookings along with:
--   - User details
--   - Property details
--   - Payment details
-- Apply WHERE and AND clauses for filtering
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
INNER JOIN payments pay ON b.booking_id = pay.booking_id
WHERE b.booking_date >= '2025-01-01'  -- Filter bookings starting from Jan 1, 2025
  AND b.booking_date < '2025-02-01'   -- Filter bookings before Feb 1, 2025
  AND u.user_id = 123;                 -- Example: filter for a specific user

-- ========================================
-- Step 2: Analyze Performance
-- Use EXPLAIN or EXPLAIN ANALYZE to identify inefficiencies.
-- ========================================

EXPLAIN ANALYZE
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
INNER JOIN payments pay ON b.booking_id = pay.booking_id
WHERE b.booking_date >= '2025-01-01'
  AND b.booking_date < '2025-02-01'
  AND u.user_id = 123;

-- ========================================
-- Step 3: Refactor Query for Performance
-- Possible optimizations:
--   1. Select only necessary columns
--   2. Ensure indexes exist on:
--        - bookings.booking_date
--        - bookings.user_id
--        - bookings.property_id
--        - payments.booking_id
-- ========================================

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
  AND b.booking_date < '2025-02-01'
  AND u.user_id = 123;

-- ========================================
-- Step 4: Measure Performance After Refactor
-- Compare execution time and rows scanned using EXPLAIN ANALYZE.
-- ========================================
