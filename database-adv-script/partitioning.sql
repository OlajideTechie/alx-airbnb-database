-- partitioning.sql

-- ========================================
-- Step 1: Create a new partitioned Booking table
-- Partitioning based on start_date using RANGE partitioning
-- ========================================

-- Drop the existing table if necessary (CAUTION: Data loss if not backed up)
-- DROP TABLE IF EXISTS bookings;

-- Create the main partitioned table
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    booking_date TIMESTAMP DEFAULT NOW(),
    -- Other columns...
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_property FOREIGN KEY (property_id) REFERENCES properties(property_id)
) PARTITION BY RANGE (start_date);

-- ========================================
-- Step 2: Create partitions for specific ranges
-- Example: monthly partitions for 2025
-- ========================================

CREATE TABLE bookings_2025_01 PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE bookings_2025_02 PARTITION OF bookings
    FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

CREATE TABLE bookings_2025_03 PARTITION OF bookings
    FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');

-- Add more partitions as needed for other months/years

-- ========================================
-- Step 3: Optional - Create indexes on partitions
-- Indexes can speed up queries on individual partitions
-- ========================================

CREATE INDEX idx_bookings_2025_01_start_date ON bookings_2025_01(start_date);
CREATE INDEX idx_bookings_2025_02_start_date ON bookings_2025_02(start_date);
CREATE INDEX idx_bookings_2025_03_start_date ON bookings_2025_03(start_date);

-- ========================================
-- Step 4: Verify partitioning
-- You can check the partitions using:
-- \d+ bookings   (PostgreSQL psql command)
-- ========================================

-- ========================================
-- Step 5: Notes
-- - Queries on bookings with a start_date filter will automatically use only relevant partitions.
-- - This reduces I/O and improves query performance on large tables.
-- - Consider creating a default partition for future dates or unknown ranges.
-- ========================================



