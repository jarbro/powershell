<#
Gartner 2020 - Jared Brodsky - jared.brodsky@cyberark.com - 3/11/2020
Scenario 2 (j): Run the following test and benchmark the time it takes to execute: A very simple program on Windows that, when run, 
appends one line to one local file, another line to a different local file, changes one registry entry to a simple value of your choosing,
and changes another registry entry to another simple value. Execute this program 1,000 times in a loop as a local administrator 
(NOT using your PEDM / Windows least privilege agent). Note the number of seconds that this iteration of 1,000 executions took. Now,
configure your agent-based PEDM solution to: 
(1) allow running this executable under elevated permissions, 
(2) allow the writing to the first file 
(3) disallow writing to the second file, 
(4) allow the change to the first registry entry and 
(5) disallow the change to the second registry entry. 
Run the program again for 1,000 times, ensuring that privilege elevation (and filtering of the respective file/registry operations) take place. 
Time how long this took, and attach the results here. NOTE: If your solution is unable to filter specific file/registry entries, please note that fact. 
#>
Set-ExecutionPolicy -force bypass
$loopcount = 1000
# create stopwatch
$stopWatch = New-Object -TypeName System.Diagnostics.Stopwatch
$results = "$HOME\Gartner\results.txt"
#create file and set text loop for 1000x
$file1 = "$HOME\Gartner\file1.txt"
#begin loop
$stopWatch.Start()
$i=1
for ($i=1;$i -le $loopcount;$i++)
{
    Add-Content -Path $file1 -value 'Gartner File 1'
    Write-Host "File 1 Loops run" $i;
}
"File 1",$stopwatch | Out-file -Append $results

$stopwatch.stop()
$stopWatch.reset()

#create second file and set text, loop 1000x

$file2 = "$HOME\Gartner\file2.txt"
#begin loop
$stopWatch.Start()
$i=1
for ($i=1;$i -le $loopcount;$i++)
{
    Add-Content -Path $file2 -value 'Gartner File 2' -ErrorAction SilentlyContinue
    Write-Host "File 2 Loops run" $i;
}
"File 2",$stopwatch | Out-file -Append $results

$stopwatch.stop()
$stopWatch.reset()

#set registry, loop 1000x
#begin loop for first reg value
$stopWatch.Start()
$i=1
for ($i=1;$i -le $loopcount;$i++)
{
    Set-ItemProperty -Path "HKLM:\Software\Gartner2020\Key1" -Name "RunCount-1" -Value $i
    Write-Host "Reg 1 Loops run" $i;
}
"Registry 1",$stopwatch | Out-file -Append $results

$stopwatch.stop()
$stopWatch.reset()
#begin loop for second reg value
$stopWatch.Start()
$i=1
for ($i=1;$i -le $loopcount;$i++)
{
    Set-ItemProperty -Path "HKLM:\Software\Gartner2020\Key2" -Name "RunCount-2" -Value $i -ErrorAction SilentlyContinue
    Write-Host "Reg 2 Loops run" $i;
}

"Registry 2",$stopwatch | Out-file -Append $results
$stopwatch.stop()

pause
