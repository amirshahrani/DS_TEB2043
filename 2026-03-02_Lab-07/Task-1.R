library(dplyr)

# 1. Importing data (Ensuring blanks are correctly read as NA)
titanic <- read.csv("./2026-03-02_Lab-07/titanic.csv", na.strings = c("", "NA"))

# 2. Identifying NA/empty cells
cat("--- NA Value Counts ---\n")
cat("Total NA values in dataset:", sum(is.na(titanic)), "\n")
cat("NA values per column:\n")
print(sapply(titanic, function(x) sum(is.na(x))))
cat("\n")

# 3. Managing NA/empty cells (THE BETTER WAY)
titanic_cleaned <- titanic %>% 
  select(-Cabin) %>% 
  na.omit()

cat("--- Dimensions Before and After Cleaning ---\n")
cat("Original dimensions:", dim(titanic)[1], "rows,", dim(titanic)[2], "columns\n")
cat("Cleaned dimensions:", dim(titanic_cleaned)[1], "rows,", dim(titanic_cleaned)[2], "columns\n\n")

# 4-6. Arranging data (Sorting cleaned data by Fare in descending order)
titanic_final <- titanic_cleaned %>% 
  arrange(desc(Fare))

# 7. Exporting the optimally cleaned data
write.csv(titanic_final, "./2026-03-02_Lab-07/titanic_cleaned.csv", row.names = FALSE)
cat("SUCCESS: The optimally cleaned data has been exported to 'titanic_cleaned.csv'\n\n")

# ==============================================================================

# Dynamically calculating the statistics using our robust 712-row dataset
f_surv <- mean(titanic_cleaned$Survived[titanic_cleaned$Sex == 'female']) * 100
m_surv <- mean(titanic_cleaned$Survived[titanic_cleaned$Sex == 'male']) * 100

c_surv <- mean(titanic_cleaned$Survived[titanic_cleaned$Embarked == 'C']) * 100
s_surv <- mean(titanic_cleaned$Survived[titanic_cleaned$Embarked == 'S']) * 100
q_surv <- mean(titanic_cleaned$Survived[titanic_cleaned$Embarked == 'Q']) * 100

p1_surv <- mean(titanic_cleaned$Survived[titanic_cleaned$Pclass == 1]) * 100
p2_surv <- mean(titanic_cleaned$Survived[titanic_cleaned$Pclass == 2]) * 100
p3_surv <- mean(titanic_cleaned$Survived[titanic_cleaned$Pclass == 3]) * 100

# Printing the Report
cat("========================================================\n")
cat("              Titanic Dataset Analysis Report           \n")
cat("========================================================\n\n")

cat("Dataset: titanic.csv\n")
cat("Objective: To manage empty data frames and draw statistical insights on passenger survival rates.\n\n")

cat("### 1. Data Cleaning Observations ###\n")
cat(sprintf("* The original dataset contained %d passengers.\n", nrow(titanic)))
cat("* The 'Cabin' column was missing 687 entries (~77% of the dataset). Using a basic na.omit() on the entire\n")
cat("  dataframe would have caused unacceptable data loss.\n")
cat("* Best Practice applied: The 'Cabin' column was removed first. Then, na.omit() was applied to clean the\n")
cat(sprintf("  missing Age and Embarked rows. This successfully retained %d passengers for highly accurate analysis.\n\n", nrow(titanic_cleaned)))

cat("### 2. Key Survival Insights (Based on Optimally Cleaned Data) ###\n")
cat("By utilizing the dplyr library, the following survival trends were uncovered:\n\n")

cat("A. The 'Women and Children First' Protocol\n")
cat(sprintf("i. %.2f%% of the female passengers in this cleaned dataset survived the tragedy.\n", f_surv))
cat(sprintf("ii. In stark contrast, only %.2f%% of the male passengers survived.\n\n", m_surv))

cat("B. Impact of Embarkation Point\n")
cat(sprintf("i. Passengers who embarked from Cherbourg (C) had the highest survival rate at %.2f%%.\n", c_surv))
cat(sprintf("ii. Those boarding from Southampton (S) had a survival rate of %.2f%%.\n", s_surv))
cat(sprintf("iii. Queenstown (Q) passengers had the lowest survival rate at %.2f%%.\n\n", q_surv))

cat("C. Passenger Class (Socio-Economic Status)\n")
cat(sprintf("i. First Class (Pclass = 1) passengers had the highest survival rate at %.2f%%.\n", p1_surv))
cat(sprintf("ii. Second Class (Pclass = 2) passengers followed with a %.2f%% survival rate.\n", p2_surv))
cat(sprintf("iii. Third Class (Pclass = 3) passengers had the lowest survival odds at %.2f%%.\n\n", p3_surv))

cat("### Conclusion ###\n")
cat("The analysis successfully demonstrates that survival aboard the Titanic was strongly correlated to demographic factors.\n")
cat("Gender and socio-economic class were the strongest determining factors for survival.\n")
cat("Furthermore, optimizing our handling of missing variables (NA) by dropping the heavily empty Cabin column instead\n")
cat("of dropping rows allowed us to maintain a large, unbiased sample size. This corrected previous false insights\n")
cat("where lower-class passengers were disproportionately excluded from the analysis.\n")
cat("========================================================\n")