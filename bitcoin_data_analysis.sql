-- Bitcoin Data Analysis
-- This script analyzes Bitcoin price and trading data

-- Create table for Bitcoin data
CREATE TABLE IF NOT EXISTS bitcoin_data (
    id INT PRIMARY KEY,
    date DATE,
    open_price DECIMAL(10, 2),
    high_price DECIMAL(10, 2),
    low_price DECIMAL(10, 2),
    close_price DECIMAL(10, 2),
    volume BIGINT
);

-- Insert sample Bitcoin data
INSERT INTO bitcoin_data (id, date, open_price, high_price, low_price, close_price, volume) VALUES
(1, '2024-01-01', 42500.00, 43200.00, 42100.00, 42800.00, 25000000000),
(2, '2024-01-02', 42800.00, 44100.00, 42600.00, 43900.00, 28000000000),
(3, '2024-01-03', 43900.00, 45200.00, 43700.00, 44500.00, 32000000000),
(4, '2024-01-04', 44500.00, 44800.00, 43200.00, 43600.00, 27000000000),
(5, '2024-01-05', 43600.00, 45000.00, 43400.00, 44200.00, 30000000000),
(6, '2024-01-06', 44200.00, 46500.00, 44000.00, 46200.00, 35000000000),
(7, '2024-01-07', 46200.00, 47100.00, 45800.00, 46800.00, 33000000000),
(8, '2024-01-08', 46800.00, 48000.00, 46500.00, 47500.00, 38000000000),
(9, '2024-01-09', 47500.00, 49000.00, 47300.00, 48300.00, 40000000000),
(10, '2024-01-10', 48300.00, 50200.00, 48100.00, 49800.00, 42000000000);

-- Query 1: Daily price statistics
SELECT
    date,
    open_price,
    close_price,
    ROUND(((close_price - open_price) / open_price) * 100, 2) AS price_change_percent,
    high_price,
    low_price,
    volume
FROM bitcoin_data
ORDER BY date;

-- Query 2: Average statistics
SELECT
    ROUND(AVG(close_price), 2) AS avg_close_price,
    MIN(close_price) AS min_close_price,
    MAX(close_price) AS max_close_price,
    COUNT(*) AS num_days
FROM bitcoin_data;

-- Query 3: Volatility calculation (high - low)
SELECT
    date,
    ROUND((high_price - low_price), 2) AS daily_volatility,
    ROUND(((high_price - low_price) / open_price) * 100, 2) AS volatility_percent
FROM bitcoin_data
ORDER BY daily_volatility DESC;
