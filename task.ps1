Get-WinEvent -LogName Microsoft-Windows-TaskScheduler/Operational -MaxEvents 5 | Format-List *
Get-WinEvent -LogName Microsoft-Windows-TaskScheduler/Operational -MaxEvents 5 | Format-List Id,Task,TimeCreated,Message,MachineName,TaskDisplayName | Where-Object Id -Match 102
Get-WinEvent -LogName Microsoft-Windows-TaskScheduler/Operational | Format-List * | Where-Object TaskDisplayName -Match "Task completed"
Get-WinEvent -LogName Microsoft-Windows-TaskScheduler/Operational -FilterHastable @{TaskDisplayName='Task completed'} -MaxEvents 20


Get-WinEvent -LogName "Microsoft-Windows-TaskScheduler/Operational" -FilterXPath "*[System[Task=102 and TimeCreated[timediff(@SystemTime) <= 2592000000]]]" -MaxEvents 5 | Where-Object { $_.TaskName -Match 'Copy_dump_to_bucket-NEW' } | Select-Object -Property TimeCreated, Id, Task, TaskDisplayName, LevelDisplayName, Message

#################################################################################


Get-WinEvent -LogName "Microsoft-Windows-TaskScheduler/Operational" |
    Where-Object { $_.Message -like "*Copy_dump_to_bucket-NEW*" } |
    Select-Object -Property TimeCreated, Id, Task, TaskDisplayName, LevelDisplayName, Message 



Get-WinEvent -LogName "Microsoft-Windows-TaskScheduler/Operational" |
    Where-Object { $_.Message -like "*Copy_dump_to_bucket-NEW*" -AND $_.TimeCreated -gt [datetime]::today } |
    Select-Object -Property TimeCreated, Id, Task, OpcodeDisplayName, TaskDisplayName |
    Format-Table -AutoSize




#################################################################################
###########################  Copy_dump_to_bucket-NEW  ###########################

Get-WinEvent -LogName "Microsoft-Windows-TaskScheduler/Operational" -FilterXPath "*[System[Task=102]]" |
    Where-Object { $_.Message -like "*Copy_dump_to_bucket-NEW*" } |
        Select-Object -Property TimeCreated, Id, Task, TaskDisplayName, LevelDisplayName, Message

Get-WinEvent -LogName "Microsoft-Windows-TaskScheduler/Operational" |
    Where-Object { $_.Message -like "*Copy_dump_to_bucket-NEW*" -AND $_.TimeCreated -gt [datetime]::today } |
    Select-Object -Property TimeCreated, Id, Task, TaskDisplayName |
    Format-Table -AutoSize

#################################################################################
#############################  Check-Disk-SendMail  #############################

Get-WinEvent -LogName "Microsoft-Windows-TaskScheduler/Operational" -FilterXPath "*[System[Task=102]]"  -MaxEvents 5 |
    Where-Object { $_.Message -like "*Check-Disk-SendMail*" } |
        Select-Object -Property TimeCreated, Id, Task, TaskDisplayName, LevelDisplayName, Message
