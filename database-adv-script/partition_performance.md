# Database Queries, Indexing, Performance Optimization, and Partitioning

This document demonstrates SQL queries for users, bookings, properties, and reviews, identifies high-usage columns for indexing, performs performance analysis and query optimization, and implements table partitioning.

---

## 1. Identify High-Usage Columns

High-usage columns are typically used in:

- **JOINs**: `bookings.user_id`, `bookings.property_id`  
- **WHERE filters**: `users.email`, `bookings.booking_date`, `properties.location`  
- **ORDER BY / GROUP BY**: `bookings.booking_date`, `properties.name`  

| Table      | Column                  | Usage                     |
|------------|------------------------|---------------------------|
| users      | user_id (PK)           | JOIN with bookings        |
| users      | email                  | WHERE filter              |
| bookings   | booking_id (PK)        | PRIMARY KEY               |
| bookings   | user_id                | JOIN with users           |
| bookings   | property_id            | JOIN with properties      |
| bookings   | booking_date           | WHERE / ORDER BY          |
| properties | property_id (PK)       | PRIMARY KEY / JOIN        |
| properties | name                   | ORDER BY                  |
| properties | location               | WHERE filter              |

> **Comment:** Identifying these columns helps determine where indexes will improve query performance.

---

## 2. Creating Indexes

Save these commands in `database_index.sql`.

```sql
-- Users table
CREATE INDEX idx_users_email ON users(email); -- Speeds up WHERE queries on email

-- Bookings table
CREATE INDEX idx_bookings_user_id ON bookings(user_id); -- Optimizes JOIN with users
CREATE INDEX idx_bookings_property_id ON bookings(property_id); -- Optimizes JOIN with properties
CREATE INDEX idx_bookings_booking_date ON bookings(booking_date); -- Optimizes filtering and ordering

-- Properties table
CREATE INDEX idx_properties_name ON properties(name); -- Optimizes ORDER BY queries
CREATE INDEX idx_properties_location ON properties(location); -- Optimizes filtering by location



SELECT 
    b.booking_id,
    b.property_id,
    u.user_id,
    u.name AS user_name
FROM 
    bookings b
INNER JOIN 
    users u ON b.user_id = u.user_id;



SELECT 
    p.property_id,
    p.name AS property_name,
    r.review_id,
    r.review_text
FROM 
    properties p
LEFT JOIN 
    reviews r ON p.property_id = r.property_id;



SELECT 
    u.user_id,
    u.name AS user_name,
    b.booking_id,
    b.property_id
FROM 
    users u
FULL OUTER JOIN 
    bookings b ON u.user_id = b.user_id;


SELECT *
FROM properties p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM reviews r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);


SELECT *
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3;


SELECT 
    u.user_id,
    u.name,
    COUNT(b.booking_id) AS total_bookings
FROM 
    users u
LEFT JOIN 
    bookings b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.name;


SELECT
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM 
    properties p
LEFT JOIN 
    bookings b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name
ORDER BY 
    booking_rank;


-- Retrieve all bookings with user, property, and payment details
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


-- Step 1: Create partitioned bookings table
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    booking_date TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_property FOREIGN KEY (property_id) REFERENCES properties(property_id)
) PARTITION BY RANGE (start_date);

-- Step 2: Create monthly partitions for 2025
CREATE TABLE bookings_2025_01 PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE bookings_2025_02 PARTITION OF bookings
    FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

CREATE TABLE bookings_2025_03 PARTITION OF bookings
    FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');

-- Step 3: Create indexes on partitions
CREATE INDEX idx_bookings_2025_01_start_date ON bookings_2025_01(start_date);
CREATE INDEX idx_bookings_2025_02_start_date ON bookings_2025_02(start_date);
CREATE INDEX idx_bookings_2025_03_start_date ON bookings_2025_03(start_date);

