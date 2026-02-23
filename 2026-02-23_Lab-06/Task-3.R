# 1. Create the data frame
exam_data <- data.frame(
  name = c("Anastasia", "Dima", "Michael", "Matthew", "Laura", "Kevin", "Jonas"),
  score = c(12.5, 9.0, 16.5, 12.0, 9.0, 8.0, 19.0),
  attempts = c(1, 3, 2, 3, 2, 1, 2)
)

# 2. Add the 'qualify' column
exam_data$qualify <- c("yes", "no", "yes", "no", "no", "no", "yes")

# 3. Create a new data frame for Emily and bind it to the existing data
new_row <- data.frame(
  name = "Emily",
  score = 14.5,
  attempts = 1,
  qualify = "yes"
)

exam_data <- rbind(exam_data, new_row)

print(exam_data)