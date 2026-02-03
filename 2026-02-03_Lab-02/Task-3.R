# 1. Get input from user
name <- readline(prompt = "Enter your name: ")
phone <- readline(prompt = "Enter your phone number: ")

# 2. Process the name (Convert to Uppercase)
name_upper <- toupper(name)

# 3. Process the phone number (Masking)
first_part <- substr(phone, 1, 3)
last_part <- substr(phone, nchar(phone) - 3, nchar(phone))

# 4. Display the final output
cat("Hi,", name_upper, ". A verification code has been sent to", first_part, "-xxxxx", last_part, "\n")