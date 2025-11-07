#!/usr/bin/env python3
import sys
from collections import Counter

def count_vowels(file_path):
    vowels = "aeiou"
    counts = Counter()
    try:
        with open(file_path, "r", encoding="utf-8") as f:
            text = f.read().lower()
    except FileNotFoundError:
        print("ERROR: File not found", file=sys.stderr)
        sys.exit(2)

    for ch in text:
        if ch in vowels:
            counts[ch] += 1

    # Format output: a:10,e:5,i:2,o:0,u:3
    result = ",".join(f"{v}:{counts.get(v,0)}" for v in vowels)
    print(result)
    return 0

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: frequency.py <file_path>", file=sys.stderr)
        sys.exit(1)
    sys.exit(count_vowels(sys.argv[1]))
