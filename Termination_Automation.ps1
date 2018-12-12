#--------------------------------------------Disable AD and Email Accounts------------------------------------------------#
#install azure AD module
Install-Module -Name AzureADPreview
Install-Module -Name MSOnline

do{ 
$userName = @()
$email = @()
$delegateName = @()
$UserCredential = @()
$Session = @()
$sessionrestart = @()

    #Gather username, required input and must not be empty or null
    $userName = (Read-Host -Prompt 'Please input the users User Name.')

        #Gather Email, required input and must not be empty or null
        $email = (Read-host -Prompt 'Please enter the users email address, with the domain.')
  
  	    #Gather Delegate Email, required input and must not be empty or null
            $delegateName = (Read-host -Prompt 'Please enter in the email of the person who needs delegate and forward access.')


#####################################Connect to Office 365, office 365 msol service,  and enter in office 365 credentials######################################
      
#enter Office 365 admin credential
$UserCredential = Get-Credential

    #creates new session in office 365 online
    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
                         
        #imports session 
        Import-PSSession $Session

            #Starts MSOL Session with same credentials as the O365 powershell script above. This will be needed when we implement the password-reset api         
	    Connect-MsolService -Credential $UserCredential    

                #Convert Email address to shared mailbox and remove license
                Set-Mailbox -Identity $email -Type Shared

                    #Enable Delegate Permissions on the mailbox
                    Add-MailboxPermission -Identity $delegateName -User $email -AccessRights FullAccess -InheritanceType All                 
                    
                            #Setup Forward permissions on mailbox
                            Set-Mailbox -Identity $email -ForwardingSMTPAddress $delegateName

                                #Block access to terminated email account
                                Set-MsolUser -UserPrincipalName $email -BlockCredential $true    

                                    #prove account is blocked
                                    Get-MsolUser -UserPrincipalName $email | Select DisplayName,BlockCredential

                                        #disables PSsession 
                                        Remove-PSSession $Session
                                        
                                            #restart script check
                                            $sessionrestart = (Read-Host -prompt "Do you want to start over? Y or N.")
    } 
    
        while($sessionrestart -eq "Y") {

    }

###########################################Disconnect from Office 365########################################################################################################

#Disable the User Active Directory Account
#Disable-ADAccount -Identity $userName



