## Purpose: Pull Linux credential from vault for Demo.
## Jared Brodsky - 9/30/2019

$userpass = & 'C:\Program Files (x86)\CyberArk\ApplicationPasswordSdk\clipasswordsdk.exe' getpassword /p AppDescs.AppID=CLIapp /p Query="safe=Linux_Admin_Accounts;folder=root;Username=penguin" /o PassProps.Username,password,PassProps.Address,PassProps.PolicyID,PassProps.LastSuccessChange
convertfrom-csv $userpass -Header Username, Password,"Host Name",PolicyID,"Last Change (Epoch)" | format-table 

