
-- ================================
-- NON-CORRELATED SUBQUERY
-- ================================

SELECT *
FROM properties p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM reviews r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);

-- ================================
-- CORRELATED SUBQUERY
-- ================================

SELECT *
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3;
