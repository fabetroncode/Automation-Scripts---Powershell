#print out admins
net localgroup administrators

#############################Disable and change local account passwords###############################################
 
 $accountDisablePH = @()
 $accountDisablePH = (read-host -Prompt 'How Many accounts do you need to disable?')

 foreach($j in $accountDisablePH){ 
    $BadAdmin = @()
   
    $BadAdmin = (read-host -Prompt "Please input the admin account")     
    
    net user $BadAdmin /active:no
    
    $j + 1
 }
 #change password for local accounts or domain accounts

 $accountChanges = @()

 $accountChanges = (read-host -Prompt 'How many accounts do you want to change passwords for?')

 #this loops through how many times the $accountChanges variable is and changes the current accounts
 foreach($i in $accountChanges){
     $response = @()
     $userName = @()
     $password = @()


     $userName = (read-host -Prompt 'Please input the users User Name.')
     $password = (read-host -Prompt 'What would you like the new password for the account to be?')

     net user $username $password

     $i + 1
}













