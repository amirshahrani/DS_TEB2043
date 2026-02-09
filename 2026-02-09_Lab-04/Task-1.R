# 1. Define the vector
age = c(55,57,56,52,51,59,58,53,59,55,60,60,60,60,52,55,56,51,60,
        52,54,56,52,57,54,56,58,53,53,50,55,51,57,60,57,55,51,50,57,58)

# 2. Find the levels of factor
age_factor <- factor(age)
print("Levels of age factor:")
print(levels(age_factor))

# 3. Create the first summary table (Staff Age vs Total Number)
age_table <- table(age_factor)
print("Table 1: Staff Age Count")
print(age_table)

# 4. Divide levels into 5 ranges (50-52, 52-54, etc.)
# We use cut() to create ranges. 
# right=FALSE ensures ranges are [50,52), [52,54), etc. 
breaks <- seq(50, 60, by=2)
age_ranges <- cut(age, breaks=breaks, right=FALSE, include.lowest=TRUE, 
                  labels=c("50-52", "52-54", "54-56", "56-58", "58-60"))

# 5. Insight/Conclusion based on ranges
range_table <- table(age_ranges)
print("Table 2: Age Range Count")
print(range_table)

# Insight:
max_range <- names(which.max(range_table))
cat("\nInsight: The age range with the highest number of staff is", max_range, "with", max(range_table), "staffs.")