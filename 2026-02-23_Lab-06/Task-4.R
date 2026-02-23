# Change 'qualify' to a factor data type to get a better summary count
exam_data$qualify <- as.factor(exam_data$qualify)

# Display the structure of the data frame
print("--- Structure ---")
str(exam_data)

# Display the summary of the data frame
print("--- Summary ---")
print(summary(exam_data))

# Display the dimensions (rows and columns)
print("--- Dimensions ---")
cat("Number of rows:", nrow(exam_data), "\n")
cat("Number of columns:", ncol(exam_data), "\n")