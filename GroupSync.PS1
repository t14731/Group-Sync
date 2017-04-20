$pdcefrom = (Get-ADDomainController -Server "DC in forest where you want to sync from" -Filter {OperationMasterRoles -like 'PDCEmulator'}).hostname
$pdceto = (Get-ADDomainController -Server "DC in forest where you want to sync to" -Filter {OperationMasterRoles -like 'PDCEmulator'}).hostname

$credentialForestFrom = (Get-Credential)
$credentialForestTo = (Get-Credential)

$groups = (get-adgroup -SearchBase "OU DN of location of groups you want to sync" -Filter * -server $pdcefrom -Credential $credentialForestFrom)

foreach($group in $groups){
$group = $group.Name

$members = (Get-ADGroupMember -Identity $group -server $pdcefrom -Credential $credentialForestFrom)




foreach($member in $members){

$member = $member.SamAccountName



Add-ADGroupMember $group -Members $member -Server $pdceto -Credential $credentialForestTo  -ErrorAction SilentlyContinue


}


}
