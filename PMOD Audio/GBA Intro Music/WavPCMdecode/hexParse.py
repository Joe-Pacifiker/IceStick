import string

def is_hex(s):
 try:
     int(s, 16)
     return True
 except ValueError:
     return False

file = open('gba_intro.hex','r')
Lines = file.readlines()

file1 = open('gba_intro_hex.hex','a')

lineArray = []

for line in Lines:
 lineArray = (line.strip()).split(" ") 
 while("" in lineArray):
  lineArray.remove("")
 print(lineArray)
 for elem in lineArray:
  if(is_hex(elem) == False):
   lineArray.remove(elem)
 for elem in lineArray:
  if(is_hex(elem) == False):
   lineArray.remove(elem)
 print(lineArray)
 for elem in lineArray:
  file1.write(elem+" ");
 file1.write("\n");
