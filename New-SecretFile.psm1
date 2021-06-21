function New-SecretFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]
        $SecretName,

        [Parameter()]
        [string]
        $SecretPath,

        [Parameter()]
        [string]
        $Login,

        [Parameter()]
        [System.Security.SecureString]
        $Password
    )
    $scriptPath = $PsScriptRoot
    Write-Output "Path: $scriptPath"

    
    if ($Login -eq $null -or $Password -eq $null) {
        write-Output "Enter your ID and Secret"
        $Credentials = Get-Credential 
    }
    else{
        $Credentials = New-Object System.Management.Automation.PSCredential ($Login, $Password)

    }

    if($SecretPath){
        $SecretFolder = $SecretPath
    }
    else{
        $SecretFolder = "$scriptPath\Secrets"
    }

    if (!$(Test-Path $SecretFolder -PathType any)) {
        $null = New-Item -Path $SecretFolder -ItemType "directory"
    }

    $ResultPath = "$SecretFolder\$SecretName.xml"
    Write-Output "Result path: $Resultpath"
    $Credentials | Export-Clixml -Path $ResultPath -Confirm:$false

    
    Write-Output "Secret successfully generated. `nPath: $ResultPath" 
}