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
