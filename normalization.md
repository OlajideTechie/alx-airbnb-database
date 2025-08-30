# Airbnb Database Normalization – Up to 3NF

## Objective
Apply normalization principles to ensure the Airbnb database schema is in **Third Normal Form (3NF)**, removing redundancies and ensuring data integrity.

---

## Final Adjusted Schema (3NF)

### **User**
- `id` (PK)  
- `first_name`  
- `last_name`  
- `email`  
- `phone_number`  
- `created_at`  
- `updated_at`  

### **Location** (NEWLY ADDED TABLE)
- `id` (PK)  
- `address`  
- `city`  
- `state`  
- `country`  

### **Property**
- `id` (PK)  
- `owner_id` (FK → User.id)  
- `location_id` (FK → Location.id)  
- `title`  
- `description`  
- `price_per_night`  
- `created_at`  
- `updated_at`  

### **Booking**
- `id` (PK)  
- `user_id` (FK → User.id)  
- `property_id` (FK → Property.id)  
- `check_in_date`  
- `check_out_date`  
- `status`  
- `created_at`  
- `updated_at`  

### **Review**
- `id` (PK)  
- `user_id` (FK → User.id)  
- `property_id` (FK → Property.id)  
- `rating`  
- `comment`  
- `created_at`  

### **Payment**
- `id` (PK)  
- `booking_id` (FK → Booking.id)  
- `amount`  
- `payment_date`  
- `status`  