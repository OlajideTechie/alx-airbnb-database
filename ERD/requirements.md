
---

# Airbnb Database ERD – Requirements

## Objective

Design an Entity-Relationship Diagram (ERD) for an Airbnb-like platform. The diagram should represent all entities, their attributes, and the relationships between them.

---

## Entities and Attributes

### **User**

* `user_id` (Primary Key)
* `first_name`
* `last_name`
* `email`
* `phone_number`
* `created_at`
* `updated_at`

### **Property**

* `property_id` (Primary Key)
* `owner_id` (Foreign Key → User.id)
* `title`
* `description`
* `address`
* `city`
* `state`
* `country`
* `price_per_night`
* `created_at`
* `updated_at`

### **Booking**

* `booking_id` (Primary Key)
* `user_id` (Foreign Key → User.id)
* `property_id` (Foreign Key → Property.id)
* `check_in_date`
* `check_out_date`
* `status` (pending, confirmed, cancelled)
* `created_at`
* `updated_at`

### **Review**

* `review_id` (Primary Key, UUID indexed)
* `user_id` (Foreign Key → User.id)
* `property_id` (Foreign Key → Property.id)
* `rating` (1–5)
* `comment` TEXT, NOT NULL
* `created_at` TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### **Payment**

* `payment_id` (Primary Key)
* `booking_id` (Foreign Key → Booking.id)
* `amount` DECIMAL, NOT NULL
* `payment_date` TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
* `status` (successful, failed, refunded)
* `payment_method` ENUM (credit_card, paypal, stripe), NOT NULL


---

## Relationships

* **User – Booking**: One user can make many bookings (**1 : M**)
* **Property – Booking**: One property can have many bookings (**1 : M**)
* **User – Property**: One user (host) can own many properties (**1 : M**)
* **User – Review**: One user can write many reviews (**1 : M**)
* **Property – Review**: One property can have many reviews (**1 : M**)
* **Booking – Payment**: One booking can have one or more payments (**1 : 1** or **1 : M**)

---

## Deliverables

* **Diagram**: A visual ERD created using [draw.io](https://app.diagrams.net/) or any ERD tool.
* **File format**:

  * `ERD/airbnb-erd.png` (exported diagram)
  * `ERD/requirements.md` (this document)


