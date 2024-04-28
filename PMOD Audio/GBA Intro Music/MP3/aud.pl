use strict;
use warnings;

my $file = 'dat';
open(FH, '<', $file) or die $!;

my $counter = 0;

while(<FH>){
 print "memory[".$counter."]=8'b".$_;
 $counter = $counter + 1;
 if ($counter == 512) {
  $counter = 0;
 }
}

close(FH);
