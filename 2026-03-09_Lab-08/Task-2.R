data(BJsales)

# 1. Line Graph (Sales Trend Over Time)
plot(BJsales, 
     type = "o", 
     col = "darkblue", 
     main = "Quarterly Sales Performance Review",
     xlab = "Time Period", 
     ylab = "Sales Volume (Units)",
     lwd = 2, pch = 16)
abline(lm(BJsales ~ time(BJsales)), col = "red", lty = 2, lwd = 2)
legend("topleft", legend=c("Actual Sales", "Overall Trend"),
       col=c("darkblue", "red"), lty=c(1,2), lwd=2, pch=c(16, NA))

data(mtcars)

# 2. Histogram (Distribution of Engine Horsepower in the Market)
hist(mtcars$hp,
     main = "Market Analysis: Competitor Horsepower Distribution",
     xlab = "Engine Horsepower (HP)",
     ylab = "Frequency (Number of Vehicles)",
     col = "lightcoral", border = "black", breaks = 10)

# 3. Scatterplot (Weight vs. Fuel Efficiency)
plot(mtcars$wt, mtcars$mpg, 
     main = "Impact of Vehicle Weight on Fuel Efficiency",
     xlab = "Vehicle Weight (1000 lbs)",
     ylab = "Miles Per Gallon (MPG)",
     col = "darkgreen", pch = 19, cex = 1.5)
# Adding a trendline to the scatterplot
abline(lm(mpg ~ wt, data = mtcars), col = "black", lwd = 2, lty = 2)

# 4. Boxplot (Fuel Efficiency by Cylinder Count)
boxplot(mpg ~ cyl, data = mtcars,
        main = "Fuel Efficiency vs. Engine Cylinders",
        xlab = "Number of Engine Cylinders",
        ylab = "Miles Per Gallon (MPG)",
        col = c("lightblue", "lightgreen", "lightyellow"))

# 5. Bar Chart (Average Horsepower by Cylinder Count)
# Calculate the averages first
avg_hp_by_cyl <- tapply(mtcars$hp, mtcars$cyl, mean)

barplot(avg_hp_by_cyl, 
        main = "Average Horsepower by Engine Size", 
        xlab = "Number of Cylinders", 
        ylab = "Average Horsepower (HP)", 
        col = c("skyblue", "orange", "tomato"),
        border = "black")

# 6. Pie Chart (Market Share of Engine Types)
cyl_counts <- table(mtcars$cyl)
pie_labels <- paste(names(cyl_counts), "Cylinders -", 
                    round(100 * cyl_counts/sum(cyl_counts), 1), "%")

pie(cyl_counts, 
    labels = pie_labels, 
    main = "Market Share by Engine Type",
    col = c("lightblue", "lightgreen", "lightyellow"))