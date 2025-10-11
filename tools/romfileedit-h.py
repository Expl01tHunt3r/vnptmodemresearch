#!/usr/bin/env python3
"""
romfile_crypto.py

Usage:
  Encrypt: python3 romfileedit-h.py /path/to/file 1
  Decrypt: python3 romfileedit-h.py /path/to/file 0

Notes:
 - Algorithm: AES-256-CBC
 - Key  (hex): 774257516156556C4B6D62354E774171394E47325634414D5A41454478513D3D
 - IV   (hex): 2b6656744e5432514271484d5a7a4f50
 - Encryption processes plaintext in chunks of 0x400 (1024) bytes,
   each chunk encrypted independently with the same key & IV.
 - Decryption reads ciphertext chunks (up to 0x410 bytes) and decrypts
   each independently; PKCS#7 unpad is applied only to the final chunk.
Requirements:
  pip install pycryptodome
"""
import os
import sys
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad

# --- Config from analysis ---
KEY_HEX = "774257516156556C4B6D62354E774171394E47325634414D5A41454478513D3D"
IV_HEX  = "2b6656744e5432514271484d5a7a4f50"

KEY = bytes.fromhex(KEY_HEX)
IV  = bytes.fromhex(IV_HEX)

PLAINTEXT_CHUNK = 0x400  # 1024 bytes read for encrypt
MAX_CIPHER_CHUNK = 0x410 # max ciphertext chunk size read for decrypt (may be smaller for last chunk)

# --- Helpers ---
def validate_key_iv():
    if len(KEY) != 32:
        raise SystemExit("ERROR: key length != 32 bytes.")
    if len(IV) != 16:
        raise SystemExit("ERROR: iv length != 16 bytes.")

def encrypt_stream(fin, fout):
    """Read plaintext in chunks and write ciphertext (each chunk encrypted independently)."""
    while True:
        plain = fin.read(PLAINTEXT_CHUNK)
        if not plain:
            break
        cipher = AES.new(KEY, AES.MODE_CBC, IV)
        ct = cipher.encrypt(pad(plain, AES.block_size))
        fout.write(ct)

def decrypt_stream_chunked(fin, fout):
    """
    Decrypt chunked ciphertext when each encrypted chunk was produced independently
    with the same IV. We don't know chunk boundaries exactly beforehand, so we use
    a 2-buffer approach: read current chunk and peek next chunk to decide if current
    is last. Unpad only the final decrypted chunk.
    """
    # Read first chunk
    cur = fin.read(MAX_CIPHER_CHUNK)
    if not cur:
        return  # empty input

    while True:
        nxt = fin.read(MAX_CIPHER_CHUNK)
        # decrypt current
        cipher = AES.new(KEY, AES.MODE_CBC, IV)
        plain = cipher.decrypt(cur)
        if nxt:
            # not the last chunk; write raw decrypted bytes (should be full blocks)
            fout.write(plain)
            cur = nxt
            continue
        else:
            # cur is the last encrypted chunk -> attempt unpad
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

    # atomic replace
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
        out = atomic_process(inp, encrypt_stream, "encrypt")
    else:
        print(f"Decrypting '{inp}' -> '{inp}.dec' (chunked AES-256-CBC)")
        out = atomic_process(inp, decrypt_stream_chunked, "decrypt")

    print("Done. Output:", out)

if __name__ == "__main__":
    main()
