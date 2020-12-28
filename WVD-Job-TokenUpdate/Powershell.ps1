if (Get-InstalledModule -Name AZ.DesktopVirtualization)
{
}
else
{
Install-Module Az.DesktopVirtualization -Force
}
$AzureKeyVaultName= "BuildDataForWVD"
$HostpoolTokenName = "HostPoolToken"
$HostpoolName = "serco-developers"
$ResourceGroup = "WVD-RG"
$Tokeninfo = Get-AzWvdRegistrationInfo -HostPoolName $HostpoolName -ResourceGroupName $resourcegroup
if ($Tokeninfo.Token -ne "")
{
Write-Host "Existing TOken will be used"
}
else
{
Write-Host "New TOken will be generated"
$Tokeninfo = New-AzWvdRegistrationInfo -HostPoolName $HostpoolName -ResourceGroupName $ResourceGroup 
}

$SecretToken = ConvertTo-SecureString -String $Tokeninfo.Token -AsPlainText -Force
Set-AzKeyVaultSecret -VaultName $AzureKeyVaultName -Name $HostpoolTokenName -SecretValue $SecretToken