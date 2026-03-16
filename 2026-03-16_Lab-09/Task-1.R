library(ggcorrplot)

# Load the dataset
data("ToothGrowth")

# Filter for numeric columns only (length and dose)
tg_numeric <- ToothGrowth[, c("len", "dose")]

# Compute the correlation matrix
cor_matrix <- cor(tg_numeric)
print("Correlation Matrix:")
print(cor_matrix)

# Plot the correlation heatmap using ggcorrplot
ggcorrplot::ggcorrplot(cor_matrix, 
                       lab = TRUE, 
                       title = "Correlation Heatmap of ToothGrowth")