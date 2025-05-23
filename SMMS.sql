
create database userdb;
use userdb;

CREATE TABLE users (
    fname VARCHAR(30),
    lname VARCHAR(30),
    email VARCHAR(100),
    userid VARCHAR(10) PRIMARY KEY,
    password VARCHAR(255)
);
alter table users add phn_num varchar(10);
select *from users;
insert into users values ('pruthvi','m y','pruthvi@gmail.com','my','my123','9632587410');

CREATE TABLE stocks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    symbol VARCHAR(10),
    name VARCHAR(50),
    price FLOAT,
    price_change FLOAT,
    market_cap VARCHAR(20),
    volume VARCHAR(20),
    last_traded TIME,
    sector VARCHAR(20),
    available_quantity INT
);


INSERT INTO stocks (symbol, name, price, price_change, market_cap, volume, last_traded, sector, available_quantity) VALUES
('PLTR', 'Palantir Technologies Inc.', 25.50, 1.25, '50B', '10M', '15:30:00', 'Technology', 1000),
('NVDA', 'Nvidia Corporation', 600.00, 15.00, '1.5T', '12M', '15:40:00', 'Semiconductors', 1200),
('TSLA', 'Tesla Inc.', 900.00, 20.00, '900B', '8M', '15:45:00', 'Automotive', 500),
('AMZN', 'Amazon.com Inc.', 3500.00, 50.00, '1.7T', '7M', '15:50:00', 'E-commerce', 600),
('META', 'Meta Platforms Inc.', 280.00, 5.00, '800B', '6M', '15:55:00', 'Technology', 700),
('AAPL', 'Apple Inc.', 150.00, 3.00, '2.5T', '5M', '16:00:00', 'Technology', 800),
('MSFT', 'Microsoft Corporation', 320.00, 4.50, '2.3T', '9M', '16:05:00', 'Technology', 900),
('GOOGL', 'Alphabet Inc.', 2800.00, 35.00, '1.8T', '4M', '16:10:00', 'Technology', 400),
('INTU', 'Intuit Inc.', 500.00, 10.00, '150B', '3M', '16:15:00', 'Software', 300),
('ADBE', 'Adobe Inc.', 450.00, 9.00, '200B', '2.5M', '16:20:00', 'Software', 350);
select*from stocks;

CREATE TABLE investments (
    investment_id INT AUTO_INCREMENT PRIMARY KEY,
    userid VARCHAR(10),
    id INT,
    quantity INT NOT NULL,
    investment_amount DECIMAL(15, 2) NOT NULL,
    investment_strategy VARCHAR(50),
    investment_rate VARCHAR(50) NOT NULL,
    investment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'completed',
    FOREIGN KEY (userid) REFERENCES users(userid) ON DELETE CASCADE,
    FOREIGN KEY (id) REFERENCES stocks(id)
);
select *from investments;

CREATE TABLE purchases (
    Pid INT AUTO_INCREMENT PRIMARY KEY,
    userid VARCHAR(10) NOT NULL,
    id INT NOT NULL,
    quantity INT NOT NULL,
    total_cost DECIMAL(10, 2) NOT NULL,
    purchase_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id) REFERENCES stocks(id),
    FOREIGN KEY (userid) REFERENCES users(userid) ON DELETE CASCADE
);
select *from purchases;

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(10) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(50) NOT NULL,
    transaction_id VARCHAR(255) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(userid) ON DELETE CASCADE
);
select *from payments;

CREATE TABLE transactions (
    transaction_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(10) NOT NULL,
    stock_id INT NOT NULL,
    quantity INT NOT NULL,
    strategy VARCHAR(255) NOT NULL,
    rate VARCHAR(255) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    transaction_status VARCHAR(50) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_details VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(userid) ON DELETE CASCADE,
    FOREIGN KEY (stock_id) REFERENCES stocks(id)
);
select *from transactions;
DESCRIBE transactions;
ALTER TABLE transactions
MODIFY COLUMN strategy VARCHAR(255) NOT NULL DEFAULT '-';
ALTER TABLE transactions
MODIFY COLUMN rate VARCHAR(255) NOT NULL DEFAULT '0';  -- or any default value like 'N/A'

ALTER TABLE transactions
DROP FOREIGN KEY transactions_ibfk_2;




ALTER TABLE transactions
MODIFY COLUMN transaction_status VARCHAR(50) DEFAULT 'Completed';

/*admin block */
CREATE TABLE admins (
    adminid INT AUTO_INCREMENT PRIMARY KEY,
    fname VARCHAR(30) NOT NULL,
    lname VARCHAR(30) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);
select*from admins;
CREATE TABLE contact (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
select * from contact;

