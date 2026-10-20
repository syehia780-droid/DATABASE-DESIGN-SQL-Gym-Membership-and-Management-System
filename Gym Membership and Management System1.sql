-- 1. Members
CREATE TABLE MEMBER (
    member_id NUMBER PRIMARY KEY,
    full_name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100),
    phone VARCHAR2(20),
    join_date DATE,
    city VARCHAR2(50)
);

-- 2. Membership Plans
CREATE TABLE MEMBERSHIP_PLAN (
    plan_id NUMBER PRIMARY KEY,
    plan_name VARCHAR2(50) NOT NULL,
    duration_months NUMBER,
    price NUMBER(8,2)
);

-- 3. Memberships
CREATE TABLE MEMBERSHIP (
    membership_id NUMBER PRIMARY KEY,
    member_id NUMBER,
    plan_id NUMBER,
    start_date DATE,
    end_date DATE,
    membership_status VARCHAR2(20),

    CONSTRAINT fk_membership_member
        FOREIGN KEY (member_id)
        REFERENCES MEMBER(member_id),

    CONSTRAINT fk_membership_plan
        FOREIGN KEY (plan_id)
        REFERENCES MEMBERSHIP_PLAN(plan_id)
);

-- 4. Trainers
CREATE TABLE TRAINER (
    trainer_id NUMBER PRIMARY KEY,
    full_name VARCHAR2(100) NOT NULL,
    specialization VARCHAR2(100),
    hire_date DATE
);

-- 5. Fitness Classes
CREATE TABLE FITNESS_CLASS (
    class_id NUMBER PRIMARY KEY,
    class_name VARCHAR2(100),
    trainer_id NUMBER,
    capacity NUMBER,
    scheduled_at TIMESTAMP,

    CONSTRAINT fk_class_trainer
        FOREIGN KEY (trainer_id)
        REFERENCES TRAINER(trainer_id)
);

-- 6. Class Bookings
CREATE TABLE CLASS_BOOKING (
    booking_id NUMBER PRIMARY KEY,
    member_id NUMBER,
    class_id NUMBER,
    booking_date DATE,
    attendance_status VARCHAR2(20),

    CONSTRAINT fk_booking_member
        FOREIGN KEY (member_id)
        REFERENCES MEMBER(member_id),

    CONSTRAINT fk_booking_class
        FOREIGN KEY (class_id)
        REFERENCES FITNESS_CLASS(class_id)
);

-- 7. Payments
CREATE TABLE PAYMENT (
    payment_id NUMBER PRIMARY KEY,
    membership_id NUMBER,
    payment_date DATE,
    amount NUMBER(8,2),
    payment_method VARCHAR2(30),
    payment_status VARCHAR2(20),

    CONSTRAINT fk_payment_membership
        FOREIGN KEY (membership_id)
        REFERENCES MEMBERSHIP(membership_id)
);


INSERT INTO MEMBER VALUES
(1, 'Ahmed Ali', 'ahmed@gmail.com', '01012345678',
 DATE '2026-01-10', 'Cairo');

INSERT INTO MEMBER VALUES
(2, 'Mona Hassan', 'mona@gmail.com', '01112345678',
 DATE '2026-02-15', 'Giza');

INSERT INTO MEMBER VALUES
(3, 'Omar Mohamed', 'omar@gmail.com', '01212345678',
 DATE '2026-03-20', 'Fayoum');

INSERT INTO MEMBER VALUES
(4, 'Sara Mahmoud', 'sara@gmail.com', '01512345678',
 DATE '2026-04-05', 'Cairo');

INSERT INTO MEMBER VALUES
(5, 'Ali Samir', 'ali@gmail.com', '01098765432',
 DATE '2026-05-01', 'Alexandria');
 
 
 
 INSERT INTO MEMBERSHIP_PLAN VALUES
(1, 'Basic', 1, 300);

INSERT INTO MEMBERSHIP_PLAN VALUES
(2, 'Standard', 3, 750);

INSERT INTO MEMBERSHIP_PLAN VALUES
(3, 'Premium', 6, 1200);

INSERT INTO MEMBERSHIP_PLAN VALUES
(4, 'VIP', 12, 2000);



INSERT INTO MEMBERSHIP VALUES
(101, 1, 1, DATE '2026-01-10',
 DATE '2026-02-10', 'EXPIRED');

INSERT INTO MEMBERSHIP VALUES
(102, 2, 2, DATE '2026-02-15',
 DATE '2026-05-15', 'EXPIRED');

INSERT INTO MEMBERSHIP VALUES
(103, 1, 3, DATE '2026-06-01',
 DATE '2026-12-01', 'ACTIVE');

INSERT INTO MEMBERSHIP VALUES
(104, 3, 2, DATE '2026-03-20',
 DATE '2026-06-20', 'EXPIRED');

INSERT INTO MEMBERSHIP VALUES
(105, 4, 3, DATE '2026-07-01',
 DATE '2027-01-01', 'ACTIVE');
 
 
 
 
 INSERT INTO TRAINER VALUES
(1, 'Mohamed Adel', 'Bodybuilding', DATE '2023-01-10');

INSERT INTO TRAINER VALUES
(2, 'Sara Ahmed', 'Yoga', DATE '2024-03-15');

INSERT INTO TRAINER VALUES
(3, 'Khaled Samy', 'Cardio', DATE '2022-06-01');

INSERT INTO TRAINER VALUES
(4, 'Nour Hassan', 'Pilates', DATE '2025-01-20');



INSERT INTO FITNESS_CLASS VALUES
(201, 'Strength Training', 1, 20,
 TIMESTAMP '2026-10-21 10:00:00');

INSERT INTO FITNESS_CLASS VALUES
(202, 'Morning Yoga', 2, 15,
 TIMESTAMP '2026-10-21 11:00:00');

INSERT INTO FITNESS_CLASS VALUES
(203, 'Cardio Blast', 3, 25,
 TIMESTAMP '2026-10-22 12:00:00');

INSERT INTO FITNESS_CLASS VALUES
(204, 'Open Gym', NULL, 30,
 TIMESTAMP '2026-10-22 15:00:00');
 
 
 
 INSERT INTO CLASS_BOOKING VALUES
(301, 1, 201, DATE '2026-10-19', 'ATTENDED');

INSERT INTO CLASS_BOOKING VALUES
(302, 2, 201, DATE '2026-10-19', 'BOOKED');

INSERT INTO CLASS_BOOKING VALUES
(303, 3, 202, DATE '2026-10-20', 'ATTENDED');



INSERT INTO PAYMENT VALUES
(401, 101, DATE '2026-01-10', 300, 'CASH', 'PAID');

INSERT INTO PAYMENT VALUES
(402, 102, DATE '2026-02-15', 750, 'CARD', 'PAID');

INSERT INTO PAYMENT VALUES
(403, 103, DATE '2026-06-01', 1200, 'CARD', 'PAID');

INSERT INTO PAYMENT VALUES
(404, 104, DATE '2026-03-20', 750, 'CASH', 'PENDING');

INSERT INTO PAYMENT VALUES
(405, 105, DATE '2026-07-01', 1200, 'ONLINE', 'PAID');

COMMIT;

--1. Membership details.
SELECT
    m.membership_id,
    mem.full_name AS member_name,
    p.plan_name,
    m.start_date,
    m.membership_status
FROM MEMBERSHIP m
INNER JOIN MEMBER mem
    ON m.member_id = mem.member_id
INNER JOIN MEMBERSHIP_PLAN p
    ON m.plan_id = p.plan_id;

--2. Members and memberships. 
 SELECT
    mem.member_id,
    mem.full_name,
    m.membership_id,
    m.start_date,
    m.membership_status
FROM MEMBER mem
LEFT JOIN MEMBERSHIP m
    ON mem.member_id = m.member_id;
    
 --3. Classes and bookings.   
 SELECT
    fc.class_id,
    fc.class_name,
    cb.booking_id,
    cb.member_id,
    cb.booking_date,
    cb.attendance_status
FROM CLASS_BOOKING cb
RIGHT JOIN FITNESS_CLASS fc
    ON cb.class_id = fc.class_id;
    
--4. Trainers and classes.    
 SELECT
    t.trainer_id,
    t.full_name AS trainer_name,
    t.specialization,
    fc.class_id,
    fc.class_name
FROM TRAINER t
LEFT JOIN FITNESS_CLASS fc
    ON t.trainer_id = fc.trainer_id;
    
 --5. Plans summary.   
 SELECT
    p.plan_name,
    COUNT(m.membership_id) AS total_memberships,
    AVG(p.price) AS average_plan_price
FROM MEMBERSHIP_PLAN p
INNER JOIN MEMBERSHIP m
    ON p.plan_id = m.plan_id
GROUP BY
    p.plan_id,
    p.plan_name
HAVING COUNT(m.membership_id) >= 1
ORDER BY average_plan_price DESC;

--6. Member booking counts.
SELECT
    m.FULL_NAME,
    COUNT(b.BOOKING_ID) AS total_bookings
FROM member m
INNER JOIN class_booking b
    ON m.member_id = b.member_id
GROUP BY
   m.FULL_NAME 
ORDER BY total_bookings DESC , m.FULL_NAME ;

--7. Successful revenue by plan.
SELECT
    p.plan_name,
    SUM(pay.amount) AS total_revenue
FROM MEMBERSHIP_PLAN p
INNER JOIN MEMBERSHIP m
    ON p.plan_id = m.plan_id
INNER JOIN PAYMENT pay
    ON m.membership_id = pay.membership_id
WHERE pay.payment_status = 'PAID'
GROUP BY p.plan_name
ORDER BY total_revenue DESC;

--8. Class booking counts.
SELECT
    f.CLASS_NAME,
    COUNT(b.CLASS_ID) AS total_booking
FROM fitness_class f
LEFT JOIN  class_booking b
    ON f.CLASS_ID = b.CLASS_ID
GROUP BY
   f.CLASS_NAME
ORDER BY total_booking DESC;

--9. Membership status label.
SELECT
    membership_id,
    membership_status,
   CASE
   WHEN membership_status ='ACTIVE'
   THEN 'Active Membership'
    WHEN membership_status = 'EXPIRED'
            THEN 'Expired Membership'
    WHEN membership_status = 'Pending'
            THEN 'Pending Membership'        
      ELSE 'Unknown Status'
      END AS status_description
      FROM membership;
  
UPDATE member
SET phone=NULL
WHERE member_id=1;
COMMIT;
--10. Member contact value.
SELECT full_name,
       NVL(phone, NVL(email, 'No contact details')) AS contact_value
FROM MEMBER;

UPDATE payment
SET amount=NULL
WHERE payment_id=401;
COMMIT;
--11. Amount paid per membership.
SELECT
    MEMBERSHIP_ID,
    SUM(NVL(AMOUNT, 0)) AS total_amount
FROM PAYMENT
GROUP BY MEMBERSHIP_ID;


--12. Trainer class totals.
SELECT
    t.FULL_NAME,
    COUNT(f.TRAINER_ID) AS total_class
FROM trainer t 
LEFT JOIN fitness_class f
    ON f.TRAINER_ID = t.TRAINER_ID
GROUP BY
   t.FULL_NAME
ORDER BY total_class DESC;

         
--13. Payment status label.
SELECT
    p.PAYMENT_ID,
    msh.MEMBERSHIP_ID,
    p.PAYMENT_METHOD,
    p.AMOUNT,
    p.PAYMENT_DATE,
    case
    when p.PAYMENT_STATUS='PAID'
    then 'Completed'
    when p.PAYMENT_STATUS='PENDING'
    then 'NOT Completed'
    ELSE 'Unknown Status'
    end as status_description
FROM payment p 
INNER JOIN membership msh 
    ON p.MEMBERSHIP_ID = msh.MEMBERSHIP_ID
ORDER BY p.PAYMENT_DATE DESC;
 
 
 --14. Payment statistics.
 SELECT PAYMENT_METHOD ,
 sum(AMOUNT)as total_amount ,
 AVG(AMOUNT)as average_amount,
 MIN(AMOUNT)as minimum_amount,
 MAX(PAYMENT_ID)maximum_amount
 from payment
 GROUP BY PAYMENT_METHOD;
 
 --15. Members with multiple successful payments.
 SELECT
    m.FULL_NAME,
    count(pay.PAYMENT_ID) AS number_payment,
    SUM(pay.amount) AS total_revenue
FROM MEMBERSHIP msh
INNER JOIN MEMBER m
    ON msh.MEMBER_ID = m.MEMBER_ID
INNER JOIN PAYMENT pay
    ON msh.MEMBERSHIP_ID = pay.MEMBERSHIP_ID
WHERE pay.payment_status = 'PAID'
GROUP BY m.FULL_NAME 
HAVING count(pay.PAYMENT_ID) >1
ORDER BY total_revenue DESC;

 
 
 
 





 