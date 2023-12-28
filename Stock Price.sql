# CONTENT OF THE TABLE
SELECT *
FROM toheebdb.`stock`;

# WHAT DATE SAW THE LARGEST OVERALL TRADING VOLUME
SELECT symbol, 
        date, 
        volume
FROM stock 
WHERE volume = 
      (select max(volume) from stock);
# 2014-02-24 was the day that had the largest overall tradng volume and VZ was the company that had the largest volume at 618237630


# WHICH 2 STOCKS THAT WERE TRADED MOST ON DAY THAT HAS THE LARGEST OVERALL TRADING VOLUME
SELECT symbol,
       volume
fROM stock
WHERE date = "2014-02-24"
ORDER BY volume desc
LIMIT 2;
# VZ has the largest volume at 618237630 closly followed by BAC at 103039579 


# WHICH DAY OF THE WEEK DOES VOLUME TEND TO BE HIGHEST
SELECT dayname(date) as day, 
       volume
FROM stock
WHERE volume = 
        (select max(volume) from stock);
# Monday was the day of the week that has the highest volume at 618237630

#WHICH DAY OF THE WEEK DOES VOLUME TEND TO BE LOWEST
SELECT dayname(date) as day,
       volume
FROM stock
WHERE volume =
       (select min(volume) from stock);
# Tuesday has the lowest volume at 7932



# THE HIGHEST VOLATILITY 
SELECT date,
        symbol,
        ROUND(high - low) AS highest_volatility
FROM stock
ORDER BY highest_volatility DESC
LIMIT 1;
# The highest volatility was at 72 which was by PCLN on 2014-04-04


# THE LOWEST VOLATILITY
SELECT date,
       symbol, 
       ROUND(high - low) AS lowest_volatility
FROM stock
HAVING lowest_volatility <> 0
ORDER BY lowest_volatility ASC;
# The lowest volatility was at 1 by different companies 


# WHICH DATE DID AMAZON(AMZN) SEE THE MOST VOLATILITY 
SELECT date,
	symbol, 
    ROUND(high - low,2) AS most_volatility
FROM stock 
WHERE symbol = "AMZN" 
ORDER BY most_volatility DESC
LIMIT 1;
# The date Amazon has the most volatility was on 2014-06-05 at 21.04


# THE PERCENTAGE GAIN OF EACH STOCK FROM THE START DATE TO THE END DATE USING THE OPEN PRICE
SELECT symbol, 
	ROUND(((s2015.open - s2014.open) / s2014.open )* 100, 2) AS percentage_difference
FROM (select distinct symbol as symbol , open, date from stock where date like "2014%") s2014
JOIN (select distinct symbol as symbol, open , date from stock where date like "2015%") s2015
USING (symbol)
GROUP BY symbol
ORDER BY percentage_difference DESC;
# If i was to advice anyone to buy a stock , i would advice to go for SWKS because they had the most percentage gain at 156.98 over the course of this years in this dataset followed by EA at 108.81 and LUV at 105.24



