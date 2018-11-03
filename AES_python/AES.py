
# coding: utf-8

# In[6]:


def getWord(key):
    one = ord(key[0])
    one <<= 24
    two = ord(key[1])
    two <<= 16
    three = ord(key[2])
    three <<= 8
    four = ord(key[3])
    return one|two|three|four


# In[65]:


def splitInt(n):
    array = [0]*4
    for i in range(4):
        array[i] = (n >> (3-i)*8)& 0x000000ff
    return array


# In[8]:


def leftShift(array, step):
    temp = [0]*4
    for i in range(4):
        temp[i] = array[i]
    for i in range(4):
        array[i] = temp[(i+step)%4]
    return array


# In[9]:


S = [[0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76],
     [0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0, 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0],
     [0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15],
     [0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75],
     [0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0, 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84],
     [0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf],
     [0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8],
     [0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5, 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2],
     [0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73],
     [0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb],
     [0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c, 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79],
     [0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08],
     [0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a],
     [0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e, 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e],
     [0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf],
     [0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16]]

def getFromBox(n, S):
    row = (n & 0x000000f0) >> 4
    col = n & 0x0000000f
    return S[row][col]


# In[10]:


def convertToInt(array):
    one = array[0] << 24
    two = array[1] << 16
    three = array[2] << 8
    four = array[3]
    return one | two | three | four


# In[11]:


Rcon = [0x01000000, 0x02000000, 0x04000000, 0x08000000,0x10000000, 0x20000000, 0x40000000, 0x80000000, 0x1b000000, 0x36000000]

def T(w, j):
    array = splitInt(w)
    array = leftShift(array, 1)
    for i in range(4):
        array[i] = getFromBox(array[i], S)
    res = convertToInt(array)
    return res ^ Rcon[j]


# In[12]:


def expandKey(key):
    w = [0]*44
    for i in range(4):
        w[i] = getWord(key[i*4:i*4+4])
    j = 0
    for i in range(4, 44):
        if i % 4 == 0:
            w[i] = w[i-4] ^ T(w[i-1], j)
            j += 1
        else:
            w[i] = w[i-4] ^ w[i-1]
    return w


# In[59]:


def convertToState(p):
    res = [[0 for i in range(4)]for i in range(4)]
    k = 0
    for i in range(4):
        for j in range(4):
            res[j][i] = ord(p[k])
            k += 1
    return res


# In[14]:


def addRoundKey(s, w, round):
    for i in range(4):
        word = splitInt(w[round*4 + i])
        for j in range(4):
            s[j][i] ^= word[j]


# In[15]:


def subBytes(s):
    for i in range(4):
        for j in range(4):
            s[i][j] = getFromBox(s[i][j], S)


# In[53]:


def convertToString(s):
    res = ''
    for i in range(4):
        for j in range(4):          
            res += chr(s[j][i])
    return res


# In[46]:


def shiftRows(s):
    temp = s[1][0]
    for i in range(3):
        s[1][i] = s[1][i+1]
    s[1][3] = temp
    temp = s[2][0]
    temp2 = s[2][1]
    s[2][0] = s[2][2]
    s[2][1] = s[2][3]
    s[2][2] = temp
    s[2][3] = temp2

    temp = s[3][3]
    for i in [3, 2, 1]:
        s[3][i] = s[3][i-1]
    s[3][0] = temp
    return s




colM = [[2, 3, 1, 1],
    [1, 2, 3, 1],
    [1, 1, 2, 3],
    [3, 1, 1, 2]];

def GFMul2(s) :
    result = s << 1
    a7 = result & 0x00000100

    if(a7 != 0) :
        result = result & 0x000000ff
        result = result ^ 0x1b

    return result

def GFMul3(s) :
    return GFMul2(s) ^ s

def GFMul4(s) :
    return GFMul2(GFMul2(s))

def GFMul8(s) :
    return GFMul2(GFMul4(s))

def GFMul9(s):
    return GFMul8(s) ^ s

def GFMul11(s):
    return GFMul9(s) ^ GFMul2(s)

def GFMul12(s):
    return GFMul8(s) ^ GFMul4(s)

def GFMul13(s) :
    return GFMul12(s) ^ s

def GFMul14(s):
    return GFMul12(s) ^ GFMul2(s)

def GFMul(n, s):
    if(n == 1) :
        result = s
    elif(n == 2) :
        result = GFMul2(s);
    elif(n == 3) :
        result = GFMul3(s);
    elif(n == 0x9) :
        result = GFMul9(s);
    elif(n == 0xb) :
        result = GFMul11(s);
    elif(n == 0xd):
        result = GFMul13(s)
    elif(n == 0xe):
        result = GFMul14(s)

    return result;

def mixColumns(array) :
    tempArray = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
    for i in range(4):
        for j in range(4):
            tempArray[i][j] = array[i][j]

    for i in range(4):
        for j in range(4):
            array[i][j] = GFMul(colM[i][0],tempArray[0][j]) ^ GFMul(colM[i][1],tempArray[1][j]) ^ GFMul(colM[i][2],tempArray[2][j]) ^ GFMul(colM[i][3], tempArray[3][j]);

    return array


# In[63]:


def aesEncryptor(plaintext, key):
    w = expandKey(key)
    state = convertToState(plaintext)
    addRoundKey(state, w, 0)
    for i in range(1, 10):
        subBytes(state)
        shiftRows(state)
        mixColumns(state)
        addRoundKey(state, w, i)
    subBytes(state)
    shiftRows(state)
    addRoundKey(state, w, 10)
    cyphertext = convertToString(state)
    return cyphertext


# In[66]:


plaintext = 'helloworld123456'
key = 'qwertyqwerty1234'
aesEncryptor(plaintext, key)

