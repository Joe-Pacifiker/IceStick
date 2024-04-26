file = open('gba_intro_hex.hex','r')
Lines = file.readlines()

file1 = open('gba_intro_hex_riffStrip.hex','a')

lineArray = []

counter = 0 #Used to count the first 11 words

for line in Lines:
 lineArray = (line.strip()).split(" ")
 for elem in lineArray:
  counter = counter + 1;
  if(counter > 11):
   file1.write(elem+" ");
 file1.write("\n");
