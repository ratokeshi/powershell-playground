param (
    $myFolder
)



$rootPathWin = "C:\windows"
$rootPathPF = "C:\Program Files"
$rootPathPF86 = "C:\Program Files (x86)"
$rootPath = "C:\"


$eventLogName = "Application"
$source = "Disk Hydration"
$eventId = 42001
$entryType = "Information"
$message = "42001 disk hydration begins."
$messageend = "42999 disk hydration ends."


function Create-Event {
    param (
        [Parameter(Mandatory=$true)]
        [string]$LogSourceName,

        [Parameter(Mandatory=$true)]
        [int]$EventID,

        [Parameter(Mandatory=$true)]
        [string]$EventMessage

    )
    
    # Check Log Source and create if not exist
    $checksource = Get-ChildItem HKLM:\SYSTEM\CurrentControlSet\Services\EventLog\Application
    if (!($LogSourceNameExist = Test-Path "HKLM:\SYSTEM\CurrentControlSet\Services\EventLog\Application\$LogSourceName"))
    {
    New-EventLog -Source $LogSourceName -LogName Application
    }

    # create event
    Write-EventLog -Source $LogSourceName -LogName Application -EventID $EventID -EntryType Information `
        -Message $EventMessage 

}

# Function to process files recursively
function Process-FilesRecursively {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    # Get all files in the current directory
    $files = Get-ChildItem -Path $Path -File

    # Process each file
    foreach ($file in $files) {
        # Output the file path to nul
        $file.FullName | Out-Null
        write-host -nonewline '.'
    }

    # Get all directories in the current directory
    $directories = Get-ChildItem -Path $Path -Directory

    # Recursively process files in each directory
    foreach ($directory in $directories) {
        Process-FilesRecursively -Path $directory.FullName
        write-host -nonewline '.'
    }
}




## Get script Name
$scriptLocation = $MyInvocation.MyCommand.Name
$scriptLocation
$scriptName = Split-Path -Path $scriptLocation -Leaf
$scriptName



if (-not $myFolder) {
    $myFolder = "C:\"

    Start-Process -Filepath powershell.exe -ArgumentList "$($scriptName) -myFolder `"$($rootPath)`""

    #tesst
    Write-Output $scriptName
    Write-Output $rootPath
    Write-Output $PSScriptRoot


   Start-Process -Filepath powershell.exe -ArgumentList "$($env:SystemRoot)\system32\WindowsPowerShell\v1.0\powershell.exe $($PSScriptRoot)\$($scriptName) -myFolder `"$($rootPath)`\`""
   $testpath = "$($env:SystemRoot)\system32\WindowsPowerShell\v1.0\powershell.exe $($PSScriptRoot)\$($scriptName) -myFolder `"$($rootPath)`\`""
   $testpath


    Start-Process -Filepath powershell.exe -ArgumentList "$($env:SystemRoot)\system32\WindowsPowerShell\v1.0\powershell.exe $($PSScriptRoot)\$($scriptName) -myFolder `"$($rootPathWin)`""
    $loc = "$($env:SystemRoot)\system32\WindowsPowerShell\v1.0\powershell.exe $($PSScriptRoot)\$($scriptName) -myFolder `"$($rootPathWin)`""
    $loc

    Start-Process -Filepath powershell.exe -ArgumentList "$($env:SystemRoot)\system32\WindowsPowerShell\v1.0\powershell.exe $($PSScriptRoot)\$($scriptName)  `"$($rootPathPF)`\`""
    $loc = "$($env:SystemRoot)\system32\WindowsPowerShell\v1.0\powershell.exe $($PSScriptRoot)\$($scriptName) -myFolder `"$($rootPathPF)`\`""
    $loc

    Start-Process -Filepath powershell.exe -ArgumentList "$($env:SystemRoot)\system32\WindowsPowerShell\v1.0\powershell.exe $($PSScriptRoot)\$($scriptName) `"$($rootPathPF86)`\`""
    $loc = "$($env:SystemRoot)\system32\WindowsPowerShell\v1.0\powershell.exe $($PSScriptRoot)\$($scriptName) `"$($rootPathPF86)`\`""
    $loc

}
else {

    #Start-Process -Filepath powershell.exe -ArgumentList "$($LogSourceName) -myFolder $($myFolder)"




    ## Get script Name
    $scriptName = $MyInvocation.MyCommand.Name

    Create-Event -LogSourceName $scriptName -EventID 42001 -EventMessage "General script begins now."

    #test
    Write-Output $myFolder
    
    Process-FilesRecursively -Path "c:\Program Files"

    Process-FilesRecursively -Path $myFolder

    Process-FilesRecursively -Path "c:\Program Files"



    Create-Event -LogSourceName $scriptName -EventID 42999 -EventMessage "General script ends now."

}