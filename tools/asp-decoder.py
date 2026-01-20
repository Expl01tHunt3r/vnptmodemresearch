#!/usr/bin/env python3
import sys
import os

def invert_file(input_path, output_path):
    """Đảo bit từng byte (b ^ 0xFF) — tự giải mã hoặc mã hóa."""
    with open(input_path, "rb") as fin, open(output_path, "wb") as fout:
        while True:
            chunk = fin.read(1024)
            if not chunk:
                break
            fout.write(bytes((b ^ 0xFF) for b in chunk))

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: asp-decoder.py <input_file> <output_file>")
        sys.exit(1)

    inp, out = sys.argv[1], sys.argv[2]

    if not os.path.exists(inp):
        print(f"Error: File '{inp}' not found.")
        sys.exit(1)

    invert_file(inp, out)
    print(f"[+] Done. Output saved to: {out}")
