-- ================================
-- INNER JOIN
-- ================================

SELECT 
    b.booking_id,
    b.property_id,
    u.user_id,
    u.name AS user_name
FROM 
    bookings b
INNER JOIN 
    users u
ON 
    b.user_id = u.user_id;


-- ================================
-- LETT JOIN
-- ================================

SELECT 
    p.property_id,
    p.name AS property_name,
    r.review_id,
    r.review_text
FROM 
    properties p
LEFT JOIN 
    reviews r
ON 
    p.property_id = r.property_id;


-- ================================
-- OUTER JOIN
-- ================================
SELECT 
    u.user_id,
    u.name AS user_name,
    b.booking_id,
    b.property_id
FROM 
    users u
FULL OUTER JOIN 
    bookings b
ON 
    u.user_id = b.user_id;


