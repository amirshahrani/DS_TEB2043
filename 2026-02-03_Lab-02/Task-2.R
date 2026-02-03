# 1. Get the two strings from the user
string1 <- readline(prompt = "Enter string 1: ")
string2 <- readline(prompt = "Enter string 2: ")

# 2. Compare the strings (Case-Insensitive)
is_similar <- toupper(string1) == toupper(string2)

# 3. Display the result in the specific format requested
cat("This program compare 2 strings. Both inputs are similar:", is_similar, "\n")