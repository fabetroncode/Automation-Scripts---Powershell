﻿

do {
#variable for the response
$response = @()

    #connect to office 365
    $UserCredential = Get-Credential

        $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

            Import-PSSession $Session

                #sets auditing to true on office 365 mailbox
                Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -eq "UserMailbox" -or RecipientTypeDetails -eq "SharedMailbox" -or RecipientTypeDetails -eq "RoomMailbox" -or RecipientTypeDetails -eq "DiscoveryMailbox"} | Set-Mailbox -AuditEnabled $true -AuditLogAgeLimit 180 -AuditAdmin Update, MoveToDeletedItems, SoftDelete, HardDelete, SendAs, SendOnBehalf, Create, UpdateFolderPermission -AuditDelegate Update, SoftDelete, HardDelete, SendAs, Create, Move, UpdateFolderPermissions, MoveToDeletedItems, SendOnBehalf -AuditOwner UpdateFolderPermission, MailboxLogin, Create, Move, SoftDelete, HardDelete, Update, MoveToDeletedItems, UpdateCalendarDelegation 
                    
                    #prints out results of above script
                    Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -eq "UserMailbox"} | FL Name,Audit*
                        
                        #ends the office 365 session
                        remove-pssession $Session
                            
                            #prompts users for a response
                            $response = (Read-host -Prompt 'Do you want to continue? Y or N.')

                            cls

      } while($response -eq "Y"){

}