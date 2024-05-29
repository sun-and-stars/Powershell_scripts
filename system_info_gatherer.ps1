#################################
#### GLOBAL OUTPUT VARIABLE #####
#################################

$global_output_directory = Read-host "Please provide a path for where to store the memoryfiles" 
$global_output_file = Read-host "Please provide a path for the output file"

########################################
############# FUNCTIONS ################
########################################
## All Parameters inside the functions are commented out.###########################
## only reason they are in the script are for future upgradability of the script.###############
###############################################################

function get-osinfo {
    [cmdletbinding()]
    
    param (
      #  [parameter(mandatory=$true)]
     #   [string]$
    )
   
    $out =  get-ciminstance -classname win32_operatingsystem -property * 
    return $out >> $global_output_file
}
function get-userinfo {
    [cmdletbinding()]

    param (
        #[parameter(mandatory=$true)]
        #[string]$
    )

    $out = get-ciminstance -classname Win32_UserAccount -Property *
    return $out >> $global_output_file
}

function get-connectedshares{
    [CmdletBinding()]
    
    param (
         #[parameter(mandatory=$true)]
         #[string]$   
        )
    $out = get-ciminstance -classname Win32_share -Property * | select-object -Property Status,Type,Name,Description,Caption,InstallDate,AccessMask,AllowMaxium,Path,PsComputerName | format-list
    return $out >> $global_output_file
}

function get-startupcmds {
    [cmdletbinding()]

    param (
        #[parameter(mandatory=$true)]
        #[strings]$    
        )
    $out = get-ciminstance -classname Win32_StartupCommand 
    return $out >> $global_output_file
}

function get-processdetails {
    [cmdletbinding()]

    param (
        #[parameter(mandatory=$true)]
        #[strings]$
    )
    $out = get-ciminstance -classname Win32_Process -property * | select-object -Property ProcessName,Name,description,ProcessId,CreationDate,CSName,CommandLine,ExecutablePath,SessionId,ThreadCount,handlecount,WindowsVersion
    return $out >> $global_output_file
}

function get-servicedetails {
    [cmdletbinding()]
    param (
        #[parameter(mandatory=$true)]
        #[strings]$
    )
    $out = get-ciminstance -classname Win32_Service -Property * | where-object -Property ProcessId -ne 0 | select-object -Property Name,displayname,state,Status,delayedautostart,processid,pathname,caption,description,installdate,started,systemname
    return $out >> $global_output_file
}

function get-allports {
    [cmdletbinding()]
    param (
        #[parameter(mandatory=$true)]
        #[strings]$
    )
    $out = Get-NetTCPConnection | select-object -Property *
    return $out >> $global_output_file
}

function get-memoryfiles {
    [cmdletbinding()]
    param ( 
        #[parameter(mandatory=$true)]
        #[strings]$
    )
    try {
        $in_files = get-childitem -path "C:\" -hidden -filter "*.sys"
        foreach ($i in $in_files) {copy-item -Path "$i" -destination "$global_output_directory" }
        }
    
    catch {
        write-host 'The Memory files could not be find on the system please check the C: Drive, or check with the system admin for the possible file location'
          }
}

##################################
##### Functions execution ########
##################################
Write-host "THE SCRIPT IS RUNNING PLEASE WAIT ^_^ "
 get-osinfo
 get-userinfo
 get-connectedshares
 get-startupcmds
 get-processdetails
 get-servicedetails
 get-allports
 get-memoryfiles