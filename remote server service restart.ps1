$credential = Get-Credential
$myservice = Get-WmiObject -Class Win32_Service -ComputerName SERVER1 ` -Credential $credential -Filter "Name='spooler'"
Restart-service $myservice