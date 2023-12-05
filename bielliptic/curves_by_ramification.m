/*

find ./ -type f | grep txt | perl -ne 'chomp;s/\.\///;print "magma -b InputFileName:=$_ ../../curves_by_ramification.m &\n"' > RUN
emacs -nw RUN
add #!/bin/sh
chmod u+x RUN
./RUN

*/

OutputFileName := InputFileName;



quit;