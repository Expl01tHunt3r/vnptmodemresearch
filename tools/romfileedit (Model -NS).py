#!/usr/bin/env python3
import sys, os
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad

# --- CẤU HÌNH KEY & IV ---
KEY_HEX = "2f52536c386d4d70373073554a506a7841327a54773152377272752f6e673d3d"
IV = "3530397a30567641743057452f573745"
BLOCK_SIZE = AES.block_size  # 16
CHUNK_SIZE = 0x400           # 1024

def encrypt_stream(fin, fout, key, iv):
    cipher = AES.new(key, AES.MODE_CBC, iv)
    buffer = b""
    while True:
        chunk = fin.read(CHUNK_SIZE)
        if not chunk:
            break
        buffer += chunk
        while len(buffer) >= CHUNK_SIZE:
            fout.write(cipher.encrypt(buffer[:CHUNK_SIZE]))
            buffer = buffer[CHUNK_SIZE:]
    fout.write(cipher.encrypt(pad(buffer, BLOCK_SIZE)))

def decrypt_stream(fin, fout, key, iv):
    cipher = AES.new(key, AES.MODE_CBC, iv)
    buffer = b""
    while True:
        chunk = fin.read(CHUNK_SIZE)
        if not chunk:
            break
        buffer += chunk
        # Khi buffer có >= 2 blocks, giải mã phần trước, giữ lại 1 block chờ unpad
        while len(buffer) >= BLOCK_SIZE * 2:
            n = (len(buffer) // BLOCK_SIZE - 1) * BLOCK_SIZE
            fout.write(cipher.decrypt(buffer[:n]))
            buffer = buffer[n:]
    # Cuối buffer phải là N*BLOCK_SIZE
    decrypted = cipher.decrypt(buffer)
    fout.write(unpad(decrypted, BLOCK_SIZE))

def process_file(path, encrypt: bool):
    key = bytes.fromhex(KEY_HEX)
    iv = bytes.fromhex(IV)
    out_ext = ".enc" if encrypt else ".dec"
    out_path = path + out_ext

    # Với decrypt, kiểm tra file-size upfront
    if not encrypt:
        size = os.path.getsize(path)
        if size % BLOCK_SIZE != 0:
            print(f"ERROR: Ciphertext length ({size}) is not a multiple of {BLOCK_SIZE}.")
            print("Make sure you're pointing at the exact encrypted payload, or trim headers/footers.")
            sys.exit(1)

    try:
        with open(path, "rb") as fin, open(out_path, "wb") as fout:
            print("Encrypting..." if encrypt else "Decrypting...")
            if encrypt:
                encrypt_stream(fin, fout, key, iv)
            else:
                decrypt_stream(fin, fout, key, iv)
    except FileNotFoundError:
        print(f"ERROR: File not found: {path}")
        sys.exit(1)
    except PermissionError:
        print(f"ERROR: Permission denied reading/writing file.")
        sys.exit(1)
    except ValueError as e:
        print(f"ERROR: Crypto error: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"ERROR: Unexpected error: {e}")
        sys.exit(1)
    else:
        print(f"Output written to: {out_path}")

def main():
    print("ROM file encrypt/decryptor (for VNPT model -NS)")
    try:
        path = input("Enter path to file: ").strip()
        if not os.path.isfile(path):
            print("ERROR: Not a file or does not exist.")
            sys.exit(1)

        mode = input("Enter 0 to decrypt, 1 to encrypt: ").strip()
        if mode not in ("0", "1"):
            print("ERROR: Invalid choice (must be 0 or 1).")
            sys.exit(1)

        process_file(path, encrypt=(mode == "1"))
    except KeyboardInterrupt:
        print("\nOperation cancelled by user.")
        sys.exit(1)

if __name__ == "__main__":
    main()
