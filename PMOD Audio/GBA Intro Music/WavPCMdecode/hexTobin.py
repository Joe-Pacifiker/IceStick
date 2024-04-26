file = open('gba_intro_hex_riffStrip.hex','r')
Lines = file.readlines()

file1 = open('gba_intro_binPCM.hex','a')

lineArray = []

for line in Lines:
 lineArray = (line.strip()).split(" ") 
 for elem in lineArray:
  if(elem != ""):
   file1.write("".join(['{0:016b}'.format(int(elem, 16)).zfill(16)])) #Just write them and try sending it first
  file1.write("\n")
