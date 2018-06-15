# airlines_time_series
Forecasting the stock prices of airlines 

Here are some benchmarks of a good time series analysis.

ARIMA time series models use previous lags in the time series to model the behavior of each airline’s stock prices. An ARIMA model has three parameters: auto-regression (p), difference (d), and moving average (q). 

The auto regression term p is the number of lags used in the model and the moving average term q tells us the error count as a combination of the previous error terms. 

We also need to test if the time series is stationary or not. Differencing removes trends and cycles in a time series and can help make a series more stationary. For reference, a stationary time series exhibits a constant mean, low variance, and decreased seasonal effects. 

Further, a Dickey-Fuller test can be used for checking for time series stationarity. The Dickey-Fuller null hypothesis assumes that the time series is non-stationary. If the p-value of the Dickey-Fuller drops below 0.05 we can say that the time series is more or less stationary.

Finally, auto-correlation and partial auto-correlation plots can be used for examining time series model residuals. Our goal is to pick a time series model (with parameters p,d, and q) that have no significant autocorrelations present, which also suggests that the series has limited trends, skewness, or other patterns. 

We first forecasted Delta Airline's (Atlanta hub) stock prices using this methodology (90 days into the future from June 14th). According to our model, Delta's 90-day stock price is around $52.7 with an upper estimate of $58.2 and a lower estimate of $46.7. We will alsoupdate the forecasted stock prices of other airlines. 


