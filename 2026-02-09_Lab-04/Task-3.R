# 1. Create Array 1: 4 columns, 2 rows, 3 tables
# Data: 1 to 24 (calculated from 4*2*3 = 24 elements)
Array1 <- array(1:24, dim = c(2, 4, 3))

# 2. Create Array 2: 2 columns, 3 rows, 5 tables
# Data: 25 to 54 (starts after Array1, 3*2*5 = 30 elements)
Array2 <- array(25:54, dim = c(3, 2, 5))

# 3. Print the second row of the second matrix (table) of Array 1
print("Second row of the second matrix of Array 1:")
print(Array1[2, , 2])

# 4. Print the element in the 3rd row and 3rd column of the 1st matrix of Array 2
print("Element in 3rd row, 2nd column of 1st matrix of Array 2:")
print(Array2[3, 2, 1])