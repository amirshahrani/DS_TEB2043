library(caret)

# Load the mtcars dataset
data("mtcars")

# --- 1. Log Transformation ---
log_scaled <- log(mtcars)

# --- 2. Standard Scaling ---
std_scaled <- as.data.frame(scale(mtcars))

# --- 3. Min-Max Scaling ---
minmax_model <- preProcess(mtcars, method=c("range"))
minmax_scaled <- predict(minmax_model, mtcars)

# --- 4. Compare Summaries ---
print("--- RAW DATA SUMMARY ---")
print(summary(mtcars))

print("--- LOG TRANSFORMATION SUMMARY ---")
print(summary(log_scaled))

print("--- STANDARD SCALING SUMMARY ---")
print(summary(std_scaled))

print("--- MIN-MAX SCALING SUMMARY ---")
print(summary(minmax_scaled))