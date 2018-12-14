# creates a report of licenses for each client and emails them to the client or Integrity: 
# Found on https://4sysops.com/archives/manage-office-365-licenses-with-powershell/


#enter Office 365 admin credential
$UserCredential = Get-Credential

    #creates new session in office 365 online
    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
                         
        #imports session 
        Import-PSSession $Session


$customformat = @{expr={$_.AccountSkuID};label="AccountSkuId"},
         @{expr={$_.ActiveUnits};label="Total"},
         @{expr={$_.ConsumedUnits};label="Assigned"},
        @{expr={$_.activeunits-$_.consumedunits};label="Unassigned"},
        @{expr={$_.WarningUnits};label="Warning"}
Get-MsolAccountSku | sort activeunits -desc | select $customformat | Export-CSV "\\its-fp2\users\mfaber\Desktop\Licenses_Report.csv" -NoTypeInformation
