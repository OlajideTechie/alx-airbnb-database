# SQL Query Performance Monitoring and Optimization

This document demonstrates how to monitor query performance, identify bottlenecks, implement improvements, and report the results.

---

## 1. Monitor Query Performance

### Example 1: Using `EXPLAIN ANALYZE` (PostgreSQL)

```sql
EXPLAIN ANALYZE
SELECT b.booking_id, b.start_date, u.name AS user_name, p.name AS property_name
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
WHERE b.start_date >= '2025-01-01'
  AND b.start_date < '2025-02-01';


SET profiling = 1;

SELECT b.booking_id, b.start_date, u.name AS user_name, p.name AS property_name
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
WHERE b.start_date >= '2025-01-01'
  AND b.start_date < '2025-02-01';

SHOW PROFILE FOR QUERY 1;


CREATE INDEX idx_bookings_start_date ON bookings(start_date);
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);


SELECT 
    b.booking_id,
    b.start_date,
    u.name AS user_name,
    p.name AS property_name
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
WHERE b.start_date >= '2025-01-01'
  AND b.start_date < '2025-02-01';


SELECT booking_id, start_date, user_id, property_id
FROM bookings
WHERE start_date >= '2025-01-01'
  AND start_date < '2025-02-01';
