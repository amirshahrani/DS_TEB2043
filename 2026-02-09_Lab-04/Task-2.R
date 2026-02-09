# 1. Create Matrix-1 using values from vector V1
V1 <- c(2,3,1,5,4,6,8,7,9)
Matrix1 <- matrix(V1, nrow=3, ncol=3)

# 2. Transpose Matrix-1 to create Matrix-2
Matrix2 <- t(Matrix1)

# 3. Rename columns and rows
rownames(Matrix2) <- c("Row1", "Row2", "Row3")
colnames(Matrix2) <- c("Col1", "Col2", "Col3")

print("Matrix-1:")
print(Matrix1)
print("Matrix-2 (Transposed):")
print(Matrix2)

# 4. Matrix Operations
print("Addition (Matrix1 + Matrix2):")
print(Matrix1 + Matrix2)

print("Subtraction (Matrix1 - Matrix2):")
print(Matrix1 - Matrix2)

print("Multiplication (Element-wise):")
print(Matrix1 * Matrix2)

print("Division (Element-wise):")
print(Matrix1 / Matrix2)