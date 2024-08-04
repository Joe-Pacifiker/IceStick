# Parses the hex file generated with 'xxd' command
#  Takes each line, splits it on spaces
#  Removes null elements
#  Parses for hex values twice
#  Writes each hex value to an output file 
#
# Things I still need to do for this:
#  Create file before writing to it
#  Then erase its content before appending to it
#
#
#


#### Useful library imports #########

import string
import os
import sys
import math

#### End useful library funtions ####


#### Useful functions ########

def is_hex(s):
 try:
     int(s, 16)
     return True
 except ValueError:
     return False

def twos_complement(hexstr, bits):
 value = int(hexstr, 16)
 if value & (1 << (bits - 1)):
  value -= 1 << bits
 return value                     

#### End Useful functions ####

#### Open wav hexcode file and read lines ####

file = open('gba_intro.hex','r')
Lines = file.readlines()

#### End open wav and read lines ############

#### Remove all output files #######

os.remove('./gba_intro_hex.hex')
#os.remove('./gba_intro_quantizedPCM.hex')
os.remove('./gba_intro_hex_riffStrip.hex')
os.remove('./gba_intro_PCM16.hex')

#### End Remove all output files ###

#### Create the output file to send parsed hex pcm data to ####

file1 = []

if(os.path.exists('./gba_intro_hex.hex') == 0):
 print("Creating new 'gba_intro_hex.hex' file")
 file1 = open("gba_intro_hex.hex","x")
 file1.close()                                  

#### End Create output file to send parsed hex pcm data to ####

#### Erase the output file data #########

file1 = open('gba_intro_hex.hex','w')
file1.write("")
file1.close()                        

#### End Erase output file data #########

#### Open output file for append ########

file1 = open('gba_intro_hex.hex','a')

#### End open output file for append ####

#### Initialize line array variable ########

lineArray = []

#### End Initialize line array variable ####

#### Loop through each line one at a time ######

for line in Lines:
 
 #### Split line by spaces ########
 lineArray = (line.strip()).split(" ")
 #### End Split line by spaces #### 

 #### Remove null elements of array ########
 while("" in lineArray):
  lineArray.remove("")
 #### End Remove null elements of array ####

 #### Remove all null elements of array ######## 
 for elem in lineArray:
  if(is_hex(elem) == False):
   lineArray.remove(elem)
 for elem in lineArray:
  if(is_hex(elem) == False):
   lineArray.remove(elem)
 #### End Remove all null elements of array ####

 #### Write each hexcode to output file ####
 for elem in lineArray:
  file1.write(elem+" ");
 file1.write("\n");

file1.close()

#### End of Loop through each line of array ####


#### Remove the wav RIFF header ####

#### Open gba hexcode file and readlines #####
file = open('gba_intro_hex.hex','r')
Lines = file.readlines()
#### End read gba hexcode file lines #########

#### Create riff strip output file ##############
if(os.path.exists('./gba_intro_hex_riffStrip.hex') == 0):
 print("Creating new 'gba_intro_hex_riffStrip.hex' file")
 file1 = open("gba_intro_hex_riffStrip.hex","x")
 file1.close()                                 
#### End Create riff strip output file ##########

#### Erase content of riff strip file ###########

file1 = open('gba_intro_hex_riffStrip.hex','w')
file1.write("")
file1.close()                        

#### End erase content  of riff strip file #####

#### Open riff strip file for append #####
file1 = open('gba_intro_hex_riffStrip.hex','a')
#### End open riff strip file for append #

lineArray = []

counter = 0 #Used to count the first 11 words

for line in Lines:

 ##### Split line on spaces #########
 lineArray = (line.strip()).split(" ")
 ##### End split line on spaces #####

 ##### Remove 11 words / 44 bytes RIFF header ########
 for elem in lineArray:
  counter = counter + 1;
  if(counter > 11):
   file1.write(elem+" ");
 ##### End Remove 11 words / 44 bytes RIFF header ####
 file1.write("\n");                                     

# Convert hex PCM samples to 9 bit integer representation
#
# 512  -> '1'                   512  ->  '512'
# 0    -> '0'     I need ->     256  ->  '0'
# -512 -> '-1'			1    ->  '-512'
#
#

#### Open hexcode riff strip file ####
file = open('gba_intro_hex_riffStrip.hex','r')
Lines = file.readlines()
#### End hexcode riff strip file #####

#### Create quantized PCM output file ########

file1 = []

file2 = []

if(os.path.exists('./gba_intro_PCM16.hex') == 0):
 print("Creating new 'gba_intro_PCM16.hex' file")
 file1 = open("gba_intro_PCM16.hex","x")
 file1.close()                                           

#if(os.path.exists('./gba_intro_quantizedIntPCM.hex') == 0):
# print("Creating new 'gba_intro_quantizedIntPCM.hex' file")
# file2 = open("gba_intro_quantizedIntPCM.hex","x")
# file2.close()                                          


#### End create quantized PCM output file ####

#### Open quantized PCM output file for append ########
file2 = open('gba_intro_PCM16.hex','a')
#file1 = open('gba_intro_quantizedIntPCM.hex','a')
#### End open quantized PCM output file for append ####

#### Define and initialize temporary variables ########
#val = 0
#ratio = 0.0
#scale = 512
#lineArray = []
#### End Define and initialize temporary variables ####

#### Loop through each hexadecimal PCM sample #########
for line in Lines:
 
 #### Split line on spaces ########
 lineArray = (line.strip()).split(" ") 
 #### End split line on spaces ####

 #### Simply convert each PCM to binary and write it #########

 for elem in lineArray:
  if(elem != ""):
   print(elem)
   file2.write("".join(['{0:016b}'.format(int(elem,16)).zfill(16)]))
  file2.write("\n")
  #file1.write("\n")                                                          
 #### End Rescale each PCM value by a factor of 512 from ratio #####
 ####  Then derive the number of clock cycles for PWM ##############

#### End Loop through each hexadecimal PCM sample #####
