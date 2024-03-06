import sys

count = 0

with open(sys.argv[1], 'rb') as f:
 for c in f.read():
  count = count + 1
  print(bin(c)[2:].zfill(8))

#print(count)
