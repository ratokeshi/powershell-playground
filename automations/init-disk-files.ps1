param (
    $myFolder
)


$rootPath = "C:"
$rootpath
$rootPathWin = "C:\Windows"
$rootPathWin
$rootPathPF = "c:\Progra~1"
$rootPathPF
$rootPathPF86 = "c:\Progra~2"
$rootPathPF86



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

function Get-NumofProcesses {
    param (
        [Parameter(Mandatory=$true)]
        [string]$exename
    )

    $getnum = (Get-Process | Where-Object {$_.Name -eq ‘powershell'}).count
    $result = $getnum
    return $result
}




## Get script Name
$scriptLocation = $MyInvocation.MyCommand.Name
$scriptLocation
$scriptName = Split-Path -Path $scriptLocation -Leaf
$scriptName



if (-not $myFolder) {
    $myFolder = "C:"

    Start-Process -Filepath powershell.exe -ArgumentList "$($scriptName) -myFolder `"$($rootPath)`""

    #test
    Write-Output $scriptName
    Write-Output $rootPath
    Write-Output $PSScriptRoot


    
    $loc1 = "$($env:SystemRoot)\system32\WindowsPowerShell\v1.0\powershell.exe $($PSScriptRoot)\$($scriptName) -myFolder `"$($rootPath)`""
    "$($loc1)"
    Start-Process -Filepath powershell.exe -ArgumentList $($loc1)


    $loc2 = "$($env:SystemRoot)\system32\WindowsPowerShell\v1.0\powershell.exe $($PSScriptRoot)\$($scriptName) -myFolder `"$($rootPathWin)`""
    "$($loc2)"
    Start-Process -Filepath powershell.exe -ArgumentList $($loc2)

    
    $loc3 = "$($env:SystemRoot)\system32\WindowsPowerShell\v1.0\powershell.exe $($PSScriptRoot)\$($scriptName) -myFolder `"`"$($rootPathPF)`"`""
    "$($loc3)"
    Start-Process -Filepath powershell.exe -ArgumentList $($loc3)

    $loc4 = "$($env:SystemRoot)\system32\WindowsPowerShell\v1.0\powershell.exe $($PSScriptRoot)\$($scriptName) -myFolder `"$($rootPathPF86)`""
    #$loc4 = "$($env:SystemRoot)\system32\WindowsPowerShell\v1.0\powershell.exe $($PSScriptRoot)\$($scriptName) -myFolder $($env:ProgramFiles(x86))"
    "$($loc4)"
    Start-Process -Filepath powershell.exe -ArgumentList $($loc4)

    

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


    # Loop to find number of powershell running

    Start-Sleep -Seconds 5
    $numofdd = Get-NumofProcesses -exename "powershell"
    Write-Output "number of dd running is: $($numofdd)"

    Start-Sleep -Seconds 5
    $numofdd = Get-NumofProcesses -exename "powershell"
    Write-Output "number of dd running is: $($numofdd)"

    Start-Sleep -Seconds 5
    $numofdd = Get-NumofProcesses -exename "powershell"
    Write-Output "number of dd running is: $($numofdd)"



    while ($numofdd -gt 1) {

        Start-Sleep -Seconds 3
        $result= Get-NumofProcesses -exename "powershell"
        $numofdd = $result
        $result
    } 


    Create-Event -LogSourceName $scriptName -EventID 42555 -EventMessage "General script ends now."

}

    # Loop to find number of powershell running

    Start-Sleep -Seconds 5
    $numofdd = Get-NumofProcesses -exename "powershell"
    Write-Output "number of dd running is: $($numofdd)"

    Start-Sleep -Seconds 5
    $numofdd = Get-NumofProcesses -exename "powershell"
    Write-Output "number of dd running is: $($numofdd)"

    Start-Sleep -Seconds 5
    $numofdd = Get-NumofProcesses -exename "powershell"
    Write-Output "number of dd running is: $($numofdd)"



    while ($numofdd -gt 1 ) {

        Start-Sleep -Seconds 3
        $result= Get-NumofProcesses -exename "powershell"
        $numofdd = $result
        $result
    } 

Create-Event -LogSourceName $scriptName -EventID 42999 -EventMessage "post powershell check script ends now."