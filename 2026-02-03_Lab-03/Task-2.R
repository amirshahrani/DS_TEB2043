# 1. Store the student records in a named list
student_list <- list(
  Robert = 59, Hemsworth = 71, Scarlett = 83, Evans = 68,
  Pratt = 65, Larson = 57, Holland = 62, Paul = 92,
  Simu = 92, Renner = 59
)

# 2. Convert list to a numeric vector for calculation
scores <- unlist(student_list)

# 3. Calculate statistics
highest_score <- max(scores)
lowest_score  <- min(scores)
average_score <- mean(scores)

# 4. Find the names of students with highest and lowest scores
top_students <- names(scores)[scores == highest_score]
low_students <- names(scores)[scores == lowest_score]

# 5. Output the results
cat("Highest Score:", highest_score, "\n")
cat("Lowest Score:", lowest_score, "\n")
cat("Average Score:", average_score, "\n")
# paste() is used here to handle cases where multiple students have the same score
cat("Student with highest score:", paste(top_students, collapse = ", "), "\n")
cat("Student with lowest score:", paste(low_students, collapse = ", "), "\n")