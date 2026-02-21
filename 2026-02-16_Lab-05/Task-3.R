cat("Check whether an n digits number is Armstrong or not:\n")
cat("----------------------------------------------------\n")

# Read input from the user
num <- as.integer(readline(prompt="Input an integer: "))

temp <- num
sum <- 0

# Determine the number of digits (n)
n_digits <- nchar(as.character(num))

# Calculate the sum of the digits raised to the power of n
while(temp > 0) {
  digit <- temp %% 10
  sum <- sum + (digit ^ n_digits)
  temp <- temp %/% 10 # Integer division to remove the last digit
}

# Check if the sum matches the original number
if(sum == num) {
  cat(sprintf("%d is an Armstrong number.\n", num))
} else {
  cat(sprintf("%d is not an Armstrong number.\n", num))
}