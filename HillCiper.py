from numpy import *;

# 3x3 encryption decryption
keyMatrix1 = mat([[4, 5, 6], [1, 2, 3], [7, 8, 10]])
print("3x3 matrix for encryption:\n", keyMatrix1)
print("------------")
det1 = linalg.det(keyMatrix1)
# print(det1)

detManual = 4*2*10 + 5*3*7 + 1*8*6 - 1*5*10 - 4*8*3 - 7*2*6
# print("det = ", detManual)

m2 = keyMatrix1.I * detManual
# print("matrix1.I : \n", m2)

a = 0;
for i in range(26):
    if i*detManual % 26 == 1:
        a = i;
        print("mode1Factor = ", a)

print("------------\n3x3 matrix for decryption:")
m3 = m2 * a % 26
print(m3)
print("------------")
plainText = "zho"
print("plain text:", plainText)
for c in plainText:
    print(ord(c) - ord('a'))
message1 = mat([[25], [7], [14]])

ciperText1 = keyMatrix1 * message1 % 26

# mm = keyMatrix1*m3
#
# print("----------\n", mm)
# print(130 % 27)

print("------------\nciper text1 :")
print(ciperText1)

print("after decryption:")
print(m3 * ciperText1 % 26)

print("---------------------4x4 encryption decryption--------------------")
# 4x4 encryption decryption
keyMatrix4 = mat([[1, 2, 3, 4], [5, 6, 7, 8], [9, 0, 11, 12], [13, 14, 15, 17]])
print("4x4 matrix for encryption:\n", keyMatrix4)
print("------------")
det4 = linalg.det(keyMatrix4) % 27
print("matrix det = ", det4)

m4 = keyMatrix4.I * det4
# print("Matrix4.I :\n", m4)

m5 = mat([[14, -98, 4, 40], [-8, 16, -8, 0], [-186, 342, 4, -120], [160, -240, 0, 80]])*-1 % 27
print("------------\n3x3 matrix for decryption:\n", m5)

# print("-------------\n", (keyMatrix4 * m5) % 27 )

plaintext4 = "zhou"
print("------------\nplain text: ", plaintext4)
for c in plaintext4:
    print(ord(c) - ord('a'))
message4 = mat([[25], [7], [14], [20]])
ciperText4 = keyMatrix4 * message4 % 27;
print("cilper text:\n", ciperText4)
print("after decryption:")
print(m5 * ciperText4 % 27)