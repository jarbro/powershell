## Renames computer to corrent naming convention
## Removes initial user from Admin group
## Prompts user and forces restart

start-sleep -seconds 150

$checkfile = Test-Path $env:USERPROFILE\\provisioned.txt
if($checkfile) {exit} else {

$user = whoami
#Remove-LocalGroupMember -Group "Administrators" -Member $user ##not working in v1903 8/20/2019

net localgroup "Administrators" $user /delete

$serial = Get-Ciminstance -classname win32_bios | select -expandproperty serialnumber
$computername = $serial
rename-computer -newname $computername -force


shutdown /r /t 15 /c "We need to restart your computer to finish setting up your account."

sc $env:USERPROFILE\provisioned.txt 'This file was created as part of the provisioning process.'

}
