######################################################################

Function Export-ProcessInfo {

    [CmdletBinding()]

    Param(

        [Parameter(Mandatory, valuefrompipeline)]  # Takes the name or ip of the targeted system, can be used within the pipeline.
        [string]$TargetSystem,

        [Parameter(Mandatory)]
        [ValidateSet("CSV","JSON")]                # only takes one of the specified data set.
        [String]$FormatType,

        [System.Management.Automation.Credential()]  # Prompts for the credentials.
        [PSCredential]$Cred,

        [Parameter()]                                # Default value is the current path with processinfo filename(no extensions).
        [string]$OutPutFile = "./processinfo"

        )

    Process {
        if ($FormatType -eq "CSV") {             # Checks for the type of data output provided.

            $Data_Output = Invoke-Command -ComputerName $TargetSystem -Credential $cred -ScriptBlock {get-process} # Uses cmdlet to run the script on the targeted system.

            $Data_Output | Export-Csv -Path "$($OutPutFile)_$(Get-Date -Format 'yyyyMMddTHHmmssZ').csv" -NoTypeInformation # Exports the data to specified folder or the default local folder.
        }

        elseif ($FormatType -eq "JSON") {       # Checks for the type of data output provided.

            $Data_Output = Invoke-Command -ComputerName $TargetSystem -Credential $Cred -ScriptBlock {get-process} # Uses cmdlet to run the script on the targeted system.

            $Data_Output | ConvertTo-Json | New-Item -Type File -Name "$($OutPutFile)_$(Get-Date -Format 'yyyyMMddTHHmmssZ').json" #Converts data to JSON data structure and creates a new file to store data.

        }
    }
}
