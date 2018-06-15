#6/9/18
#ARIMA time series modeling (for airlines)

start <- as.Date("2016-01-01")
end <- as.Date("2018-06-14")

#get Delta's data 
library(quantmod)
getSymbols("EZJ", src = "yahoo", from = start, to = end)
class(DAL)

#plot time series 
head(DAL)
plot(DAL[,"DAL.Close"],main="Delta's Closing Price") 

#create a time series object 
delta=subset(DAL,select=c("DAL.Close"),frequency=365)

#log time series (if random fluctuations incease with the level of the time series) 
delta_log=log(delta)
plot(delta_log)

#decompose time series (trend, irregular, and seasonal components)
library(TTR)
library(forecast)
library(tseries)

#create a 15 day moving average 
delta_ma15=SMA(delta,n=15)
plot(delta_ma15)

#decompose time series (account for seasonal pattern and trend components)
delta_seasonal=stl(delta,s.window="periodic") #error here 

#7 day and 30 day moving average time series
delta7 = ma(delta$DAL.Close, order=7) 
delta30 = ma(delta$DAL.Close, order=30)

plot(delta7)
plot(delta30)

#decompose time series 
delta30_clean= ts(na.omit(delta30), frequency=30) #30 day moving average 
decomp=stl(delta30_clean,s.window="periodic")
decomp1=seasadj(decomp)
plot(decomp) 

#check stationarity (adf)
adf.test(delta30_clean,alternative = "stationary") #p=0.1369 (series is still non-stationary)

#acf and pacf 
Acf(delta30_clean,main='')
Pacf(delta30_clean,main='') #start with d=1 (d=difference)

delta30_clean_d1=diff(delta30_clean,differences=1)
delta30_clean_d1
plot(delta30_clean_d1)
adf.test(delta30_clean_d1,alternative="stationary") #series is now stationary? p<0.05??

#differenced series (for p or q)
Acf(delta30_clean_d1, main='ACF for Differenced Series')
Pacf(delta30_clean_d1, main='PACF for Differenced Series') #spikes at lag 30,60 

#fit the model
fit1=auto.arima(delta30_clean_d1, seasonal=FALSE)

# Y=1.67Y(t-1)+E

#evaluate time series fit 
fit_ts=auto.arima(delta30_clean_d1,seasonal=FALSE)
tsdisplay(residuals(fit_ts),lag.max=30,main='(3,0,0) Model Residuals') 

#second model 
fit2=arima(delta30_clean,order=c(1,1,1))
fit2 #Y=0.96Y(t-1)+1e(t-1)+E

#90 day forecast  
forecast_ts=forecast(fit2,h=90) #forecast 90 days ahead 
forecast_ts 
mean(forecast_ts$mean) #52.95 mean, upper
mean(forecast_ts$upper) #54.78
mean(forecast_ts$lower) #51.12
plot(forecast_ts)






