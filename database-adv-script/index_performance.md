# Database Indexing Guide

This guide demonstrates how to identify high-usage columns in your tables, create appropriate indexes, and measure query performance before and after indexing.

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

---

## 2. Create Indexes

Save the following commands in `database_index.sql`:

```sql
-- Users table
CREATE INDEX idx_users_email ON users(email);

-- Bookings table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_booking_date ON bookings(booking_date);

-- Properties table
CREATE INDEX idx_properties_name ON properties(name);
CREATE INDEX idx_properties_location ON properties(location);


EXPLAIN ANALYZE
SELECT *
FROM bookings b
JOIN users u ON b.user_id = u.user_id
WHERE b.booking_date >= '2025-01-01';


