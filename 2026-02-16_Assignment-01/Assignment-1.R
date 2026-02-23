# STEP 1: SETUP AND READ THE RAW DATA

library(tools)

input_file <- "./2026-02-16_Assignment-01/Unclean_Dataset.csv"
output_file <- "./2026-02-16_Assignment-01/Cleaned_Dataset.csv"

# Read the file line-by-line into a list of texts.
raw_lines <- readLines(input_file, warn = FALSE, encoding = "latin1")
clean_lines <- iconv(raw_lines, from = "latin1", to = "UTF-8", sub = "")

# Grab the very first line (the header), split it by commas, and trim extra spaces
header_row <- strsplit(clean_lines[1], ",")[[1]]
header_row <- trimws(header_row)

# Create an empty list. We will store each cleaned student record here.
cleaned_list <- list()

# STEP 2: LOOP THROUGH EACH ROW AND PARSE THE COLUMNS

# Start from 2 because line 1 is the header
for (row_index in 2:length(clean_lines)) {
  
  current_line <- trimws(clean_lines[row_index])
  
  # If the row is completely empty, skip it and move to the next row
  if (current_line == "") next
  
  # Setup empty buckets for this specific student
  student_id <- NA; first_name <- NA; last_name <- NA; age <- NA
  gender <- NA; course <- NA; enroll_date <- NA; total_payment <- NA
  
  # --- SCENARIO A: The row uses pipe "|" separators ---
  if (grepl("\\|", current_line)) {
    
    # Split the text by the pipe symbol
    parts <- strsplit(current_line, "\\|")[[1]]
    parts <- trimws(parts)
    
    # NEAT TRICK: Force the 'parts' list to have exactly 8 items. 
    # If the row was missing data at the end, R automatically fills it with NA!
    length(parts) <- 8 
    
    student_id  <- parts[1]
    first_name  <- parts[2]
    last_name   <- parts[3]
    age         <- parts[4]
    gender      <- parts[5]
    course      <- parts[6]
    enroll_date <- parts[7]
    
    # The payment column has extra garbage at the end (like trailing commas). 
    # We split by comma and keep only the first part.
    if (!is.na(parts[8])) {
      total_payment <- strsplit(parts[8], ",")[[1]][1] 
    }
    
  } 
  # --- SCENARIO B: The row uses comma "," separators (The messy rows) ---
  else {
    # Because some numbers have commas inside them (like "60,500"), splitting by 
    # a simple comma breaks the data. We use read.csv to safely read the single line.
    parsed_row <- tryCatch(
      read.csv(text = current_line, header = FALSE, stringsAsFactors = FALSE, strip.white = TRUE),
      error = function(e) NULL
    )
    
    # If it read successfully and has at least 7 columns of data
    if (!is.null(parsed_row) && ncol(parsed_row) >= 7) {
      
      student_id <- NA # These messy rows didn't come with IDs
      first_name <- as.character(parsed_row[1, 1])
      last_name  <- if(ncol(parsed_row) >= 3) as.character(parsed_row[1, 3]) else NA
      
      # Sometimes the first name actually contains the full name (e.g., "John Smith")
      # and the last name is blank. Split them if there's a space.
      if ((is.na(last_name) || last_name == "") && grepl(" ", first_name)) {
        name_parts <- strsplit(first_name, " ")[[1]]
        first_name <- name_parts[1]
        last_name  <- paste(name_parts[-1], collapse = " ")
      }
      
      age           <- if(ncol(parsed_row) >= 4) as.character(parsed_row[1, 4]) else NA
      gender        <- if(ncol(parsed_row) >= 5) as.character(parsed_row[1, 5]) else NA
      course        <- if(ncol(parsed_row) >= 6) as.character(parsed_row[1, 6]) else NA
      enroll_date   <- if(ncol(parsed_row) >= 7) as.character(parsed_row[1, 7]) else NA
      total_payment <- if(ncol(parsed_row) >= 8) as.character(parsed_row[1, 8]) else NA
    }
  }
  
  # STEP 3: CLEAN THE INDIVIDUAL PIECES OF DATA
  
  # 1. Clean Names and IDs (Convert blank strings "" to official NA)
  if (!is.na(student_id) && student_id == "") student_id <- NA
  if (!is.na(first_name) && first_name == "") first_name <- NA
  if (!is.na(last_name)  && last_name == "")  last_name  <- NA
  
  # 2. Fix the "Age mixed into Gender" problem (e.g., Gender = "F 24")
  if (!is.na(age)) age <- gsub("\\*", "", trimws(age)) # Remove weird asterisks
  if (!is.na(gender)) gender <- trimws(gender)
  
  # If Age is missing, but Gender contains numbers (0-9), extract the numbers!
  if ((is.na(age) || age == "") && !is.na(gender) && grepl("[0-9]", gender)) {
    age <- gsub("[^0-9]", "", gender)       # Keep only numbers
    gender <- gsub("[0-9\\s]", "", gender)  # Keep only letters
  }
  
  # 3. Standardize Gender to just "M" or "F"
  if (!is.na(gender)) {
    gender <- toupper(substr(trimws(gender), 1, 1)) # Grab the very first letter and capitalize
    if (!gender %in% c("M", "F")) gender <- NA      # If it's not M or F, mark as NA
  }
  
  # 4. Filter impossible Ages (must be between 15 and 100)
  age_numeric <- suppressWarnings(as.numeric(age))
  if (!is.na(age_numeric) && (age_numeric < 15 || age_numeric > 100)) {
    age_numeric <- NA
  }
  age <- age_numeric
  
  # 5. Fix misspelled Course names using keyword searches (grepl)
  if (is.na(course) || course == "" || grepl("^[0-9]+$", course)) {
    course <- NA 
  } else {
    course <- trimws(course)
    if (grepl("Learnin", course, ignore.case = TRUE))       course <- "Machine Learning"
    else if (grepl("Develop", course, ignore.case = TRUE))  course <- "Web Development"
    else if (grepl("Analy", course, ignore.case = TRUE))    course <- "Data Analysis"
    else if (grepl("Science", course, ignore.case = TRUE))  course <- "Data Science"
    else if (grepl("Cyber", course, ignore.case = TRUE))    course <- "Cyber Security"
  }
  
  # 6. Clean Enrollment Dates
  if (is.na(enroll_date) || trimws(enroll_date) %in% c("NA", "")) {
    enroll_date <- NA
  } else {
    enroll_date <- trimws(enroll_date)
  }
  
  # 7. Clean Total Payments (Scrub all letters/symbols, leave only numbers and decimals)
  if (!is.na(total_payment)) {
    total_payment <- gsub("[^0-9.]", "", total_payment) 
    total_payment <- suppressWarnings(as.numeric(total_payment))
  }
  
  # Finally, package this cleaned student into a Data Frame row and save it to our list
  cleaned_list[[row_index]] <- data.frame(
    Student_ID = student_id, 
    First_Name = first_name, 
    Last_Name = last_name, 
    Age = age, 
    Gender = gender, 
    Course = course, 
    Enrollment_Date = enroll_date, 
    Total_Payments = total_payment, 
    stringsAsFactors = FALSE
  )
}

# Combine our massive list of individual rows into one solid Data Frame table
cleaned_df <- do.call(rbind, cleaned_list)

# STEP 4: STRICT DELETION & DEDUPLICATION (QUALITY CONTROL)

# Rule 1: Drop "Garbage Rows" (If a row has more than 3 NA columns, it's useless)
cleaned_df <- cleaned_df[rowSums(is.na(cleaned_df)) <= 3, ]

# Rule 2: Strictly require the most important columns to NOT be NA
cleaned_df <- cleaned_df[
  !is.na(cleaned_df$Student_ID) & 
  !is.na(cleaned_df$First_Name) & 
  !is.na(cleaned_df$Course) & 
  !is.na(cleaned_df$Enrollment_Date), 
]

# Rule 3: Remove exact copy-paste duplicates
cleaned_df <- unique(cleaned_df)

# Rule 4: Fix "ID Collisions" (When two DIFFERENT students accidentally share an ID)
# We find all duplicate IDs, and loop through them to add a tag like "-DUP1"
duplicated_ids <- duplicated(cleaned_df$Student_ID)

if (any(duplicated_ids)) {
  
  collision_rows <- which(duplicated_ids) # Find the row numbers of the duplicates
  
  for (idx in 1:length(collision_rows)) {
    target_row <- collision_rows[idx]
    original_id <- cleaned_df$Student_ID[target_row]
    
    # Assign a new unique ID (e.g., 101 becomes 101-DUP1)
    cleaned_df$Student_ID[target_row] <- paste0(original_id, "-DUP", idx)
  }
}

# STEP 5: SAVE THE FINAL RESULT

write.csv(cleaned_df, output_file, row.names = FALSE, na = "")
cat("Cleaning completed. File successfully saved to:", output_file, "\n")