
-- DD1368 LAB 1 - SAMPLE DATA

-- 1. USERS
INSERT INTO users (user_id, full_name) VALUES
(1, 'Harry Potter'),
(2, 'Hermione Granger'),
(3, 'Ron Weasley'),
(4, 'Minerva McGonagall'),
(5, 'Albus Dumbledore'),
(6, 'Severus Snape');


-- 2. STUDENTS
-- McGonagall is both a student and staff member
INSERT INTO students (user_id, programme, enrollment_year) VALUES
(1, 'Defence Against the Dark Arts', 2024),
(2, 'Charms', 2023),
(3, 'Herbology', 2025),
(4, 'Transfiguration', 2022);


-- 3. STAFF
-- Departments must match the allowed KTH values
INSERT INTO staff (user_id, department) VALUES
(4, 'EECS'),
(5, 'SCI'),
(6, 'ITM');


-- 4. FRIENDSHIPS
-- Each pair represents a mutual friendship
INSERT INTO friendship (user_id_1, user_id_2) VALUES
(1, 2),
(1, 3),
(1, 4),
(2, 5);


-- 5. POSTS
INSERT INTO posts
(post_url, user_id, title, timestamp, place, tags, body_text)
VALUES
(
    'post1',
    1,
    'Welcome to Hogwarts',
    '2026-10-20 10:00:00',
    'Hogwarts Castle',
    ARRAY['Hogwarts', 'Magic'],
    'Welcome to another magical school year!'
),
(
    'post2',
    2,
    'Hogwarts Library',
    '2026-10-21 12:30:00',
    'Hogwarts Library',
    ARRAY['Books', 'Study'],
    NULL
),
(
    'post3',
    3,
    'Quidditch Practice',
    '2026-10-22 15:00:00',
    'Quidditch Pitch',
    ARRAY['Quidditch', 'Sports'],
    'Our latest Quidditch training video!'
);


-- 6. LIKES
-- Each post has between 1 and 6 likes
INSERT INTO likes (user_id, post_url, timestamp) VALUES
(2, 'post1', '2026-10-20 11:00:00'),
(3, 'post1', '2026-10-20 11:30:00'),

(1, 'post2', '2026-10-21 13:00:00'),
(4, 'post2', '2026-10-21 13:10:00'),
(5, 'post2', '2026-10-21 13:20:00'),

(1, 'post3', '2026-10-22 16:00:00'),
(2, 'post3', '2026-10-22 16:10:00'),
(4, 'post3', '2026-10-22 16:20:00'),
(6, 'post3', '2026-10-22 16:30:00');


-- 7. ATTACHMENTS
-- Store metadata only, not actual image or video files
-- File sizes are in bytes
INSERT INTO attachments
(post_url, attachment_index, file_extension, file_size)
VALUES
('post2', 1, 'jpg', 2048000),
('post3', 1, 'mp4', 15000000);


-- 8. EVENTS
-- Harry Potter (user 1) hosts the event
-- Duration is calculated automatically
INSERT INTO events
(event_id, user_id, title, place, start_time, end_time)
VALUES
(
    1,
    1,
    'Hogwarts Study Night',
    'Great Hall',
    '2026-11-10 17:00:00',
    '2026-11-10 19:00:00'
);


-- 9. EVENT ATTENDEES
-- Only Harry's friends attend the event
INSERT INTO event_attendees (event_id, user_id) VALUES
(1, 2),
(1, 3),
(1, 4);


-- 10. SUBSCRIPTIONS
-- Each subscription lasts exactly 30 days
INSERT INTO subscriptions
(subscription_id, user_id, date_of_payment, payment_method, expiry_date)
VALUES
(1, 1, '2026-10-01 10:00:00', 'Swish',   '2026-10-31 10:00:00'),
(2, 2, '2026-10-02 10:00:00', 'Klarna',  '2026-11-01 10:00:00'),
(3, 3, '2026-10-03 10:00:00', 'Card',    '2026-11-02 10:00:00'),
(4, 4, '2026-10-04 10:00:00', 'Bitcoin', '2026-11-03 10:00:00'),
(5, 5, '2026-10-05 10:00:00', 'Swish',   '2026-11-04 10:00:00'),
(6, 6, '2026-10-06 10:00:00', 'Card',    '2026-11-05 10:00:00');
