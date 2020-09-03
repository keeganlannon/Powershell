<#
.SYNOPSIS
Menu for a system or security administrator to execute common commands needed in those positions, and save the outputs. 
.DESCRIPTION
The script will prompt the user to select sys or security admin and in each field will let the user chose which command they would like to run. Once a command is ran the output of the command will be saved in a single html file for the given menu. There will then be an option for the user to view the results in the file, to check the results, and check which outputs are in the file. 
#>
function mainMenu {
    #clear the screen 
    clear
    # create our menus
    write-host "1. System Admin Tasks"
    write-host "2. Security Admin Tasks"
    write-host "[E]xit"
    $u_select = read-host -prompt "Please select one of the options above."
    # process the user response 
    if ($u_select -eq 1) {
        #call the sysadmin function 
        sysadmin
    } elseif ($u_select -eq 2) {
        #call the secadmin function
        secAdmin
    }
    elseif ($u_select -eq "E") {
    
        exit
    }
    
    else { 
        write-host "Invalid value"
        exit
    }
}
# This function will provide a prompt to the use to hit Enter when they are done reviewing the results and take them back to the menu they were in
function allDone {
    read-host -prompt "Press [enter] when done."
}
 
# Process sys admin tasks 
# create menu for sys admin
# create options for the user to select commands that are common sys admin commands
# Commands chosen are saved into a single html file for the user to see the data saved from these commands 
# Create an option for user to view data in the saved file while still in the program, check their progress
function sysadmin ($u_select) {
    #clear the screen 
    clear
    #Build our menu
    write-host "When running these commands, the outputs will be saved to one html file named sysadmin1.html"
    write-host -BackgroundColor Green -ForegroundColor DarkRed "System Admin Menu"
    write-host "1. List all running process"
    write-host "2. List all Services"
    write-host "3. List only running services"
    write-host "4. List event logs"
    write-host "5. List volume objects"
    write-host "6. View file of outputs"
    write-host "[R]eturn to Main Menu"
    #prompt the user
    $sysAdminTask = read-host -Prompt "Please select a task above:"
    switch ($sysAdminTask) {
    
    1 { ps | out-file -append C:\users\keegan\sys320\sysadmin1.html ; break }
    2 { get-service | out-file -append C:\users\keegan\sys320\sysadmin1.html ; break }
    3 { Get-Service | where {$_.Status -eq "Running"} | out-file -append C:\users\keegan\sys320\sysadmin1.html ; break }
    4 { Get-EventLog -List | out-file -append C:\users\keegan\sys320\sysadmin1.html ; break }
    5 { Get-Volume | out-file -append C:\users\keegan\sys320\sysadmin1.html ; break }
    6 { cat C:\users\keegan\sys320\sysadmin1.html ; break }
    
    "R" { mainMenu}
    default {
    
        write-host -BackgroundColor Red "Invalid option."
        #pause for 2 seconds 
        sleep 2 
        #show the main sysadmin menu
        sysAdmin
    
    }
    }
    #allow the user to review the results 
    allDone
    #call the sys admin menu so the user can return to the menu 
    sysAdmin
   } #closing switch
# create sec admin menu 
# create options for users to run common security admin commands and have the outpus saved to a file 
# Commands chosen are saved into a single html file for the user to see the data saved from these commands 
# Create an option for user to view data in the saved file while still in the program, check their progress
function secAdmin {
#clear the screen 
clear 
#Build our menu 
write-host "When running these commands, the outputs will be saved to one html file named secadmin1.html"
write-host -BackgroundColor Blue -ForegroundColor Cyan "Security Admin Menu"
write-host "1. List all Users."
write-host "2. List all services, including path"
write-host "3. List only running services, including path"
write-host "4. List of access control entries"
write-host "5. List of VPN connections"
write-host "6. View file of outputs." 
write-host "[R]eturn to Main Menu"
    #prompt the user 
    $secAdminTask = read-host -prompt "Please select a task above" 
    switch ($secAdminTask){
    1 { Get-WmiObject -Class Win32_UserAccount | out-file -append C:\users\keegan\sys320\secadmin1.html ; break }
    2 { Get-WmiObject -Class Win32_Service | select Name,PathName | out-file -append C:\users\keegan\sys320\secadmin1.html ; break}
    3 { Get-Service | where {$_.Status -eq "Running"} | out-file -append C:\users\keegan\sys320\secadmin1.html; break }
    4 { Get-Acl | out-file -append C:\users\keegan\sys320\secadmin1.html; break }
    5 { Get-VpnConnection | out-file -append C:\users\keegan\sys320\secadmin1.html; break }
    6 { cat C:\Users\Keegan\sys320\secadmin1.html ; break }
    R {mainMenu ; break}
}
        allDone
        secAdmin
    }
mainMenu
