﻿#todo- 


# Variables
## Change on use

## Globals
$runsize = 1024
#$runsize = 10240
#$runsize - 20480

# Script Prep 

## Get script Name
$scriptName = $MyInvocation.MyCommand.Name


# Begin Script __main__

# Create event to mark start script
Start-Sleep -Seconds 60

Create-Event -LogSourceName $scriptName -EventID 42001 -EventMessage "General script begins now."

# Do stuff
## Get Size of disk
    $disksize = DiskSize
    Write-Output "disksize  $($disksize)"
    $runs = $disksize[3]
    Write-Output "runs is $($runs)"
    $disksize[0]
    $disksize[1]
    $disksize[2]
    $disksize[3]

    $blocksize = $disksize[2] * $runsize 
    $blocksize


## Determine maximum dd run length


    

## Create runs
        ## need function to do run
        Create-Run -NumberofRuns 200 -numofblocks 1 
        #Create-Run -NumberofRuns $runs -numofblocks $blocksize


# Loop to find number of dd running

    Start-Sleep -Seconds 5
    $numofdd = Get-NumofProcesses -exename "dd"
    Write-Output "number of dd running is: $($numofdd)"

    Start-Sleep -Seconds 5
    $numofdd = Get-NumofProcesses -exename "dd"
    Write-Output "number of dd running is: $($numofdd)"

    Start-Sleep -Seconds 5
    $numofdd = Get-NumofProcesses -exename "dd"
    Write-Output "number of dd running is: $($numofdd)"



    while ($numofdd -gt 0) {

        Start-Sleep -Seconds 3
        $result= Get-NumofProcesses -exename "dd"
        $numofdd = $result
        $result
    } 



# Create event on exit
Create-Event -LogSourceName $scriptName -EventID 42999 -EventMessage "General script ends now."





# ----------------------------------------------------------------------------------------------------------------
#
#--------------------------     Functions      -------------------------------------------------------------------
#
#-----------------------------------------------------------------------------------------------------------------


#-----Create windows log events -------------------------------------------------------------------

    if (!($LogSourceNameExist = Test-Path "HKLM:\SYSTEM\CurrentControlSet\Services\EventLog\Application\$LogSourceName"))
    {
    New-EventLog -Source $LogSourceName -LogName Application
    }
        -Message $EventMessage 
#-----Determine disk size -------------------------------------------------------------------

function DiskSize {
    #$arglist="if=\\.\PHYSICALDRIVE0 of=nul bs=1M --progress --size skip=0 count=$totalblocks"
    
    ### Get disk info and total size
    $partitionInfo = Get-Partition -DiskNumber 0
    #Write-Output " partitioninfo is: $($partitionInfo)"
    $Size = $partitionInfo.Size
    #Write-Output "partitionsize is:  $($Size)"
    
    ### total blocks is size devided by offset
    $totalBlocks = $Size/$partitionInfo.Offset
    #Write-Output "offset is: $($partitionInfo.Offset)"

    ### number of runs
    $fnruns = $totalBlocks / $runsize
    $fnruns = [int]$fnruns
    Write-Output "fnruns is:   $($fnruns)"

    #dd.exe if=\\.\PHYSICALDRIVE0 of=nul bs=1M --progress --size skip=0 count=2048
    
    $disksize[2]
    $totalblocks = $disksize[2]

        $arglist

        Start-Process -Filepath dd.exe -ArgumentList $arglist
        #$arglist

        $numofdd = Get-NumofProcesses -exename "dd"
        Write-Output "number of dd running is: $($numofdd)"

        # create log event for end of loop
        #Create-Event -LogSourceName init-disk-AWS-PerLoop -EventID 42019 -EventMessage "Ending Loop number $($i) of block size $($numofblocks) now."
    }
    $result = $getnum