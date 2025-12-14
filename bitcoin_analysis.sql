-- Bitcoin Data Analysis
-- Simple analysis of Bitcoin price and trading volume

-- Create table for Bitcoin data
CREATE TABLE IF NOT EXISTS bitcoin_data (
  id INT PRIMARY KEY,
  date DATE NOT NULL,
  price_usd DECIMAL(15, 2),
  volume_btc DECIMAL(15, 4),
  volume_usd DECIMAL(18, 2),
  market_cap_usd DECIMAL(18, 2)
);

-- Insert sample Bitcoin data (2025 data)
INSERT INTO bitcoin_data (id, date, price_usd, volume_btc, volume_usd, market_cap_usd) VALUES
(1, '2025-01-01', 42500.00, 25000.00, 1062500000.00, 850000000000.00),
(2, '2025-01-02', 43200.00, 28000.00, 1209600000.00, 865000000000.00),
(3, '2025-01-03', 42800.00, 26500.00, 1134200000.00, 858000000000.00),
(4, '2025-01-04', 44500.00, 31000.00, 1379500000.00, 892000000000.00),
(5, '2025-01-05', 45000.00, 29000.00, 1305000000.00, 900000000000.00),
(6, '2025-01-06', 44200.00, 27500.00, 1215500000.00, 885000000000.00),
(7, '2025-01-07', 46000.00, 32000.00, 1472000000.00, 920000000000.00),
(8, '2025-01-08', 45500.00, 30000.00, 1365000000.00, 910000000000.00);

-- Query 1: Daily price statistics
SELECT 
  date,
  price_usd,
  volume_btc,
  volume_usd,
  ROUND(volume_usd / volume_btc, 2) as avg_price_per_btc
FROM bitcoin_data
ORDER BY date;

-- Query 2: Price trend analysis
SELECT 
  DATE_TRUNC('day', date) as trading_day,
  MIN(price_usd) as low_price,
  MAX(price_usd) as high_price,
  AVG(price_usd) as avg_price,
  SUM(volume_usd) as total_volume_usd
FROM bitcoin_data
GROUP BY DATE_TRUNC('day', date)
ORDER BY trading_day;

-- Query 3: Market cap analysis
SELECT 
  date,
  market_cap_usd,
  ROUND(market_cap_usd / 1000000000, 2) as market_cap_billions,
  price_usd,
  ROUND((market_cap_usd / price_usd), 0) as implied_btc_supply
FROM bitcoin_data
WHERE market_cap_usd > 0
ORDER BY date;

-- Query 4: Price volatility and volume correlation
SELECT 
  date,
  price_usd,
  LAG(price_usd) OVER (ORDER BY date) as prev_price,
  ROUND(((price_usd - LAG(price_usd) OVER (ORDER BY date)) / LAG(price_usd) OVER (ORDER BY date) * 100), 2) as price_change_pct,
  volume_usd
FROM bitcoin_data
ORDER BY date;
