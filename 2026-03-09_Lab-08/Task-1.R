library(dplyr)

# 1. Import and clean the dataset (Using the optimized method from Lab 7)
titanic <- read.csv("./2026-03-02_Lab-07/titanic.csv", na.strings = c("", "NA"))
titanic_cleaned <- titanic %>% select(-Cabin) %>% na.omit()

# --- PLOT 1: Stacked Bar Chart (Survival Count by Passenger Class) ---
# Preparing data matrix for the stacked bar chart
class_survival_matrix <- table(titanic_cleaned$Survived, titanic_cleaned$Pclass)

barplot(class_survival_matrix, 
        main = "Titanic Survival by Passenger Class", 
        xlab = "Passenger Class (1 = First, 2 = Second, 3 = Third)", 
        ylab = "Number of Passengers", 
        col = c("tomato", "lightgreen"),
        legend = c("Did Not Survive", "Survived"),
        args.legend = list(x = "topleft", cex = 0.9))

# --- PLOT 2: Histogram (Distribution of Passenger Ages) ---
hist(titanic_cleaned$Age,
     main = "Age Distribution of Titanic Passengers",
     xlab = "Age (Years)",
     ylab = "Frequency (Number of Passengers)",
     col = "skyblue",
     border = "black",
     breaks = 20) # 'breaks = 20' makes the histogram more granular

# --- PLOT 3: Pie Chart (Embarkation Ports) ---
# Count passengers per port
port_counts <- table(titanic_cleaned$Embarked)
port_labels <- c("Cherbourg", "Queenstown", "Southampton")
# Add percentages to labels
port_percentages <- round(100 * port_counts / sum(port_counts), 1)
port_labels <- paste(port_labels, "-", port_percentages, "%")

pie(port_counts, 
    labels = port_labels, 
    main = "Proportion of Passengers by Embarkation Port",
    col = c("lightpink", "lightyellow", "lightblue"))