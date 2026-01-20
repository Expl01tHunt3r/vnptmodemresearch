#!/usr/bin/env python3
"""
RomFileTool-H.py
Copyright © 2025-2026 Expl01tHunt3r, collaborators and contributors.

Note: pip install pycryptodome
"""
import os
import sys
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad

KEY = bytes.fromhex("774257516156556C4B6D62354E774171394E47325634414D5A41454478513D3D")
IV  = bytes.fromhex("2b6656744e5432514271484d5a7a4f50")
PLAINTEXT_CHUNK = 0x400 
MAX_CIPHER_CHUNK = 0x410

def validate_key_iv():
    if len(KEY) != 32:
        raise SystemExit("ERROR: key length != 32 bytes.")
    if len(IV) != 16:
        raise SystemExit("ERROR: iv length != 16 bytes.")

def encrypt_stream_chunked(fin, fout):
    cur = fin.read(MAX_CIPHER_CHUNK)
    if len(cur) == 0:
        return
    while True:
        nxt = fin.read(MAX_CIPHER_CHUNK)
        cipher = AES.new(KEY, AES.MODE_CBC, IV)
        if nxt:
            if len(cur) % AES.block_size != 0:
                raise ValueError(f"Input stream error: Intermediate chunk size ({len(cur)}) is not block-aligned.")
            ciphertext = cipher.encrypt(cur)
            fout.write(ciphertext)
            cur = nxt
            continue
        else:
            padded_data = pad(cur, AES.block_size)
            ciphertext = cipher.encrypt(padded_data)
            fout.write(ciphertext)
            break

def decrypt_stream_chunked(fin, fout):
    cur = fin.read(MAX_CIPHER_CHUNK)
    if not cur:
        return
    while True:
        nxt = fin.read(MAX_CIPHER_CHUNK)
        cipher = AES.new(KEY, AES.MODE_CBC, IV)
        plain = cipher.decrypt(cur)
        if nxt:

            fout.write(plain)
            cur = nxt
            continue
        else:
            try:
                plain = unpad(plain, AES.block_size)
            except ValueError as e:
                raise SystemExit(f"ERROR: PKCS#7 unpad failed on final chunk: {e}")
            fout.write(plain)
            break

def atomic_process(inp_path, func, mode_label):
    dirname = os.path.dirname(inp_path) or "."
    basename = os.path.basename(inp_path)
    out_name = basename + (".enc" if mode_label == "encrypt" else ".dec")
    out_path = os.path.join(dirname, out_name)
    tmp_path = out_path + ".tmp"
    
    with open(inp_path, "rb") as fin, open(tmp_path, "wb") as fout:
        func(fin, fout)
        
    os.replace(tmp_path, out_path)
    return out_path

def main():
    if len(sys.argv) != 3:
        print("Usage: python3 romfileedit-h.py /path/to/file <mode>")
        print(" mode: 1 = encrypt   0 = decrypt")
        sys.exit(1)

    inp = sys.argv[1]
    mode = sys.argv[2]

    if not os.path.isfile(inp):
        print("ERROR: input file does not exist or is not a regular file.")
        sys.exit(1)

    if mode not in ("0", "1"):
        print("ERROR: mode must be '1' (encrypt) or '0' (decrypt).")
        sys.exit(1)

    validate_key_iv()

    if mode == "1":
        print(f"Encrypting '{inp}' -> '{inp}.enc' (chunked AES-256-CBC)")
        out = atomic_process(inp, encrypt_stream_chunked, "encrypt")
    else:
        print(f"Decrypting '{inp}' -> '{inp}.dec' (chunked AES-256-CBC)")
        out = atomic_process(inp, decrypt_stream_chunked, "decrypt")

    print("Done. Output:", out)

if __name__ == "__main__":
    main()
