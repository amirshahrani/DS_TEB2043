# Read input from the user
n <- as.integer(readline(prompt="Input an integer: "))

# Loop from 1 to the given integer
for (i in 1:n) {
  cube <- i^3
  cat(sprintf("Number is: %d and cube of the %d is :%d\n", i, i, cube))
}