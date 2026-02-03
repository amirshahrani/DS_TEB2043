# 1. Create a data frame with the records
student_data <- data.frame(
  Name = c("Robert", "Hemsworth", "Scarlett", "Evans", "Pratt", 
           "Larson", "Holland", "Paul", "Simu", "Renner"),
  Chemistry = c(59, 71, 83, 68, 65, 57, 62, 92, 92, 59),
  Physics = c(89, 86, 65, 52, 60, 67, 40, 77, 90, 61)
)

# 2. Count failures (Score <= 49)
# We check each column and sum the TRUE values
chem_fail <- sum(student_data$Chemistry <= 49)
phys_fail <- sum(student_data$Physics <= 49)

# 3. Identify the highest scores for both subjects
max_chem <- max(student_data$Chemistry)
max_phys <- max(student_data$Physics)

# 4. Find the names of the top students
top_chem_students <- student_data$Name[student_data$Chemistry == max_chem]
top_phys_students <- student_data$Name[student_data$Physics == max_phys]

# 5. Output Results
cat("--- Subject Statistics ---\n")
cat("Chemistry Fails (<=49):", chem_fail, "\n")
cat("Physics Fails (<=49):", phys_fail, "\n\n")

cat("Highest Chemistry Score:", max_chem, "by", paste(top_chem_students, collapse = ", "), "\n")
cat("Highest Physics Score:", max_phys, "by", paste(top_phys_students, collapse = ", "), "\n")