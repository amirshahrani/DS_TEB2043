# 1. Importing the dataset
titanic <- read.csv("./2026-03-02_Lab-07/titanic.csv")

# 2. Identifying and Managing NA values
# Count NA in each column to see where data is missing
print(sapply(titanic, function(x) sum(is.na(x))))

# Remove rows with any NA values
titanic_cleaned <- na.omit(titanic)

# Check dimensions before and after cleaning
dim(titanic)          # Original: 891 rows, 12 columns
dim(titanic_cleaned)  # Cleaned: 183 rows, 12 columns

# 3. Import dplyr for filtering and arranging
library(dplyr)

# 4. Extracting Insights (Filtering & Grouping)
# Note: Using dplyr's group_by and summarize to get survival percentages
insights_sex <- titanic_cleaned %>%
  group_by(Sex) %>%
  summarize(Survival_Rate = mean(Survived) * 100)
print(insights_sex)

insights_class <- titanic_cleaned %>%
  group_by(Pclass) %>%
  summarize(Survival_Rate = mean(Survived) * 100)
print(insights_class)

insights_embarked <- titanic_cleaned %>%
  group_by(Embarked) %>%
  summarize(Survival_Rate = mean(Survived) * 100)
print(insights_embarked)

# 5. Exporting final filtered/arranged data
# Let's arrange female survivors who paid high fares and export it
titanic_high_priority <- titanic_cleaned %>%
  filter(Sex == 'female', Survived == 1) %>%
  arrange(desc(Fare))

write.csv(titanic_high_priority, "./2026-03-02_Lab-07/titanic_female_survivors.csv")