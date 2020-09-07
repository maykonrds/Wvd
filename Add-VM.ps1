# Add VM to Pools.
$Subs=Get-AzSubscription | Out-GridView -Title "Select the Subscription" -PassThru
Set-AzContext -Subscription $Subs

$Rg='rg-wvd'
$HostPoolName=(Get-AzWvdHostPool).Name | Out-GridView -Title "Select the HostPool Name" -PassThru


if(!(Get-AzWvdRegistrationInfo -ResourceGroupName $Rg -HostPoolName $HostPoolName).Token)
{
    Write-Host "You must create a Registration" -ForegroundColor Red
    $RegistrationToken=New-AzWvdRegistrationInfo -ResourceGroupName $Rg -HostPoolName $HostPoolName -ExpirationTime $((get-date).ToUniversalTime().AddDays(10).ToString('yyyy-MM-ddTHH:mm:ss.fffffffZ'))
}

Write-Host $RegistrationToken.Token -ForegroundColor Green

