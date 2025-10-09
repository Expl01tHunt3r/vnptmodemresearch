#!/usr/bin/env python3
import sys, os
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad

# --- CẤU HÌNH KEY/IV CHO CÁC DÒNG ---
CONFIGS = {
    "H": {
        "key_hex": "774257516156556C4B6D62354E774171394E47325634414D5A41454478513D3D",
        "iv": b"+fVtNT2QBqHMZzOP",
        "algo": "EVP_aes_256_cbc"
    },
    "NS": {
        "key_hex": "2f52536c386d4d70373073554a506a7841327a54773152377272752f6e673d3d",
        "iv_hex": "3530397a30567641743057452f573745",
        "algo": "EVP_aes_256_cbc"
    }
}

BLOCK_SIZE = AES.block_size  # 16
CHUNK_SIZE = 0x400           # 1024


# --- HÀM MÃ HÓA / GIẢI MÃ ---
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
    decrypted = cipher.decrypt(buffer)
    fout.write(unpad(decrypted, BLOCK_SIZE))


def process_file(path, encrypt: bool, key: bytes, iv: bytes, algo_name: str):
    out_ext = ".enc" if encrypt else ".dec"
    out_path = path + out_ext

    # Kiểm tra trước khi decrypt
    if not encrypt:
        size = os.path.getsize(path)
        if size % BLOCK_SIZE != 0:
            print(f"ERROR: Ciphertext length ({size}) is not a multiple of {BLOCK_SIZE}.")
            sys.exit(1)

    try:
        with open(path, "rb") as fin, open(out_path, "wb") as fout:
            print(f"Algorithm: {algo_name}")
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


# --- MAIN ---
def main():
    try:
        # --- CHỌN DÒNG ---
        model = input("Use for model H or NS? ").strip().upper()
        if model not in CONFIGS:
            print("ERROR: Invalid choice (must be 'H' or 'NS').")
            sys.exit(1)

        conf = CONFIGS[model]

        # --- CHUẨN BỊ KEY/IV ---
        key = bytes.fromhex(conf["key_hex"])
        iv = conf["iv"] if "iv" in conf else bytes.fromhex(conf["iv_hex"])
        algo = conf["algo"]

        # --- HỎI FILE & CHẾ ĐỘ ---
        path = input("Enter path to file: ").strip()
        if not os.path.isfile(path):
            print("ERROR: Not a file or does not exist.")
            sys.exit(1)

        mode = input("Enter 0 to decrypt, 1 to encrypt: ").strip()
        if mode not in ("0", "1"):
            print("ERROR: Invalid choice (must be 0 or 1).")
            sys.exit(1)

        process_file(path, encrypt=(mode == "1"), key=key, iv=iv, algo_name=algo)

    except KeyboardInterrupt:
        print("\nOperation cancelled by user.")
        sys.exit(1)


if __name__ == "__main__":
    main()
