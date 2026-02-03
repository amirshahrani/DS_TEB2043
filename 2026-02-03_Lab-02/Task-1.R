# 1. Get input from the user
weight <- as.numeric(readline(prompt = "Enter weight (in kg): "))
height <- as.numeric(readline(prompt = "Enter height (in m): "))

# 2. Calculate BMI
# Formula: BMI = weight / (height squared)
bmi <- weight / (height ^ 2)

# 3. Check against categories and print Boolean status
# Check for Underweight (<= 18.4)
cat("Underweight:", bmi <= 18.4, "\n")

# Check for Normal (18.5 - 24.9)
cat("Normal:", bmi >= 18.5 & bmi <= 24.9, "\n")

# Check for Overweight (25.0 - 39.9)
cat("Overweight:", bmi >= 25.0 & bmi <= 39.9, "\n")

# Check for Obese (>= 40.0)
cat("Obese:", bmi >= 40.0, "\n")