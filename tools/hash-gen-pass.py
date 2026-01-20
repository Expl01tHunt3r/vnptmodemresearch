import getpass

def rotl(value, shift):
    return ((value << shift) | (value >> (32 - shift))) & 0xFFFFFFFF

def custom_sha1(password):
    offset = 3  # Offset từ decompiled code
    pass_bytes = password.encode('ascii')
    effective_bytes = pass_bytes[offset:]
    effective_len = len(effective_bytes)
    if effective_len > 64:
        effective_bytes = effective_bytes[:64]
    pad = effective_bytes + b'\x00' * (64 - effective_len)
    
    W = [int.from_bytes(pad[i*4:(i+1)*4], 'big') for i in range(16)]
    
    for i in range(16, 80):
        temp = W[i-3] ^ W[i-8] ^ W[i-14] ^ W[i-16]
        W.append(rotl(temp, 1))
    
    a = 0x67452301
    b = 0xEFCDAB89
    c = 0x98BADCFE
    d = 0x10325476
    e = 0xC3D2E1F0
    
    for i in range(20):
        f = (b & c) | ((0xFFFFFFFF ^ b) & d)
        temp = (rotl(a, 5) + f + e + W[i] + 0x5A827999) & 0xFFFFFFFF
        e = d
        d = c
        c = rotl(b, 30)
        b = a
        a = temp
    
    for i in range(20, 40):
        f = b ^ c ^ d
        temp = (rotl(a, 5) + f + e + W[i] + 0x6ED9EBA1) & 0xFFFFFFFF
        e = d
        d = c
        c = rotl(b, 30)
        b = a
        a = temp
    
    for i in range(40, 60):
        f = (b & c) | (b & d) | (c & d)
        temp = (rotl(a, 5) + f + e + W[i] + 0x8F1BBCDC) & 0xFFFFFFFF
        e = d
        d = c
        c = rotl(b, 30)
        b = a
        a = temp
    
    for i in range(60, 80):
        f = b ^ c ^ d
        temp = (rotl(a, 5) + f + e + W[i] + 0xCA62C1D6) & 0xFFFFFFFF
        e = d
        d = c
        c = rotl(b, 30)
        b = a
        a = temp
    
    a = (a + 0x67452301) & 0xFFFFFFFF
    b = (b + 0xEFCDAB89) & 0xFFFFFFFF
    c = (c + 0x98BADCFE) & 0xFFFFFFFF
    d = (d + 0x10325476) & 0xFFFFFFFF
    e = (e + 0xC3D2E1F0) & 0xFFFFFFFF
    
    hash_str = f"$2${a:08x}{b:08x}{c:08x}{d:08x}{e:08x}"
    return hash_str

# Usage
password = getpass.getpass("Password: ")
print(custom_sha1(password))
