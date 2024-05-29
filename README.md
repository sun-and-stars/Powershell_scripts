# Powershell_scripts
#################USE AT YOUR OWN RISK############

This is a basic system info gatherer I wrote while learning powerhshell.
It is recommended to run the script as an administrator for better results.
This script is not thoroughly tested but runs well enough to provide some quick results.
This script has a function which tries to copy the swapfile,hiberfil.sys and pagefile.sys but it does not work at the moment.


The script tries to gather information about system global enviorment variables, users present on the system, shares connected to the system, commands which are run at system startup, processes running on the system, services running on the system, lists ports which are being utilised and tries to copy some system '.sys' files related to memory(not working at the moment).
A the results are intended to be exported to an txt file.
