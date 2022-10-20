<powershell>
$ssmdocumentnmame="ssm_general_dsjoin"
$instanceId = (Get-EC2InstanceMetadata -Category InstanceId)
$instancetagname= (get-ec2tag -Filter @{Name="resource-type";values="instance"} | where-object resourceId -eq $instanceId | where-object Key -eq "Name").Value
if ([string]::IsNullOrEmpty($ComputerName)) {
  Write-Output "default computer name is $instancetagname"
  $ComputerName = $instancetagname
}
# force the computer name to whatever was provided and restart
if ($ComputerName -ne (hostname)) {
  Write-Output "rename instance $instanceId to $ComputerName"
  Rename-Computer -NewName $ComputerName -Force
  Restart-Computer -Force
  [Environment]::Exit(0)
}
# if not already domain joined, lets join and restart
if (!(Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain) {
  Write-Output "domain join instance $instanceId with name $env:COMPUTERNAME"
  Send-SSMCommand -InstanceId $instanceId -DocumentName $ssmdocumentnmame
  [Environment]::Exit(0)
}
</powershell>
<persist>true</persist>