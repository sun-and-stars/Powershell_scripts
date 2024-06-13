Function Export-ProcessInfo {

    [CmdletBinding()]

    Param(

        [Parameter(Mandatory, valuefrompipeline)]
        [string]$TargetSystem,

        [Parameter(Mandatory)]
        [ValidateSet("CSV","JSON")]
        [String]$FormatType,

        [System.Management.Automation.Credential()]
        [PSCredential]$Cred,

        [Parameter()]
        [string]$OutPutFile = "./processinfo"

    )

    Process {
        if ($FormatType -eq "CSV") {

            $Data_Output = Invoke-Command -ComputerName $TargetSystem -Credential $cred -ScriptBlock {get-process}

            $Data_Output | Export-Csv -path "$($OutPutFile)_$(Get-Date -Format 'yyyyMMddTHHmmssZ').csv" -NoTypeInformation
        }

        elseif ($FormatType -eq "JSON") {

            $Data_Output = Invoke-Command -ComputerName $TargetSystem -Credential $Cred -ScriptBlock {get-process}
            $Data_Output | ConvertTo-Json | New-Item -Type File -Name "$($OutPutFile)_$(Get-Date -Format 'yyyyMMddTHHmmssZ').json"

        }
    }
}
