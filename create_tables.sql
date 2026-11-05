CREATE TABLE users (
    user_id INT,
    full_name VARCHAR(100) NOT NULL,

    CONSTRAINT pk_users PRIMARY KEY (user_id)
);

CREATE TABLE students (
    user_id INT PRIMARY KEY,
    programme VARCHAR(100) NOT NULL,
    enrollment_year INT NOT NULL,

    -- Student must exist in users
    CONSTRAINT fk_students_users
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
);

CREATE TABLE staff (
    user_id INT PRIMARY KEY,
    department VARCHAR(10) NOT NULL
        CHECK (department IN ('ABE', 'EECS', 'ITM', 'CBH', 'SCI')),

    -- Staff must exist in users
    CONSTRAINT fk_staff_users
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
);

CREATE TABLE friendship (
    user_id_1 INT NOT NULL,
    user_id_2 INT NOT NULL,

    -- Each friendship is stored only once
    PRIMARY KEY (user_id_1, user_id_2),

    -- Both users must exist
    FOREIGN KEY (user_id_1) REFERENCES users(user_id),
    FOREIGN KEY (user_id_2) REFERENCES users(user_id),

    -- Avoid duplicate reverse pairs and self-friendships
    CHECK (user_id_1 < user_id_2)
);

CREATE TABLE posts (
    post_url VARCHAR(255) PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255),
    timestamp TIMESTAMP(0) NOT NULL,
    place VARCHAR(255),
    tags TEXT[],
    body_text TEXT,

    -- Post creator must exist in users
    FOREIGN KEY (user_id) REFERENCES users(user_id),

    -- A user can publish only one post per second
    UNIQUE (user_id, timestamp)
);

CREATE TABLE likes (
    user_id INT NOT NULL,
    post_url VARCHAR(255) NOT NULL,
    timestamp TIMESTAMP NOT NULL,

    -- One like per user for each post
    PRIMARY KEY (user_id, post_url),

    -- User and post must exist
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (post_url) REFERENCES posts(post_url)
);

CREATE TABLE attachments (
    post_url VARCHAR(255) NOT NULL,
    attachment_index INT NOT NULL CHECK (attachment_index >= 1),
    file_extension VARCHAR(3) NOT NULL
        CHECK (file_extension IN ('jpg', 'mp4', 'm4a', 'pdf')),
    file_size BIGINT NOT NULL,

    -- Attachment is unique within its post
    PRIMARY KEY (post_url, attachment_index),

    -- Each attachment belongs to an existing post
    FOREIGN KEY (post_url) REFERENCES posts(post_url)
);

CREATE TABLE events (
    event_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    place VARCHAR(255) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,

    -- Duration is calculated automatically
    duration INTERVAL GENERATED ALWAYS AS (end_time - start_time) STORED,

    -- Event host must exist in users
    FOREIGN KEY (user_id) REFERENCES users(user_id),

    -- Event cannot end before it starts
    CHECK (start_time <= end_time)
);

CREATE TABLE event_attendees (
    event_id INT NOT NULL,
    user_id INT NOT NULL,

    -- Each user can attend an event only once
    PRIMARY KEY (event_id, user_id),

    -- Event and attendee must exist
    FOREIGN KEY (event_id) REFERENCES events(event_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    date_of_payment TIMESTAMP NOT NULL,
    payment_method VARCHAR(10) NOT NULL
        CHECK (payment_method IN ('Klarna', 'Swish', 'Card', 'Bitcoin')),

    -- Subscription lasts 30 days
    expiry_date TIMESTAMP NOT NULL,

    -- Subscription owner must exist
    FOREIGN KEY (user_id) REFERENCES users(user_id),

    -- Expiry must be exactly 30 days after payment
    CHECK (expiry_date = date_of_payment + INTERVAL '30 days')

    --*** A user can only have one active subscription at a time.****
);
