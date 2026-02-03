# 1. Store the 20 records in a vector
scores <- c(33, 24, 54, 94, 16, 89, 60, 6, 77, 61, 13, 44, 26, 24, 73, 73, 90, 39, 90, 54)

# 2. Count number of students based on grade
grade_categories <- cut(scores, 
                        breaks = c(-1, 49, 59, 69, 79, 89, 100), 
                        labels = c("F", "E", "D", "C", "B", "A"))

# Generate the count table
grade_counts <- table(grade_categories)

# 3. Check whether the student pass (>49)
pass_status <- scores > 49

# Output results
cat("Number of students per grade:\n")
print(grade_counts)

cat("\nPass Status (>49) for each student:\n")
print(pass_status)