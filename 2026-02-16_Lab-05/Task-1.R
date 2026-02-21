# Read input from the user
year <- as.integer(readline(prompt="Input year: "))

# Leap year logic
if ((year %% 4 == 0 && year %% 100 != 0) || (year %% 400 == 0)) {
  cat(sprintf("Output: %d is a leap year.\n", year))
} else {
  # Matching the specific typo in the expected outcome "is a not leap year"
  cat(sprintf("Output: %d is a not leap year.\n", year)) 
}