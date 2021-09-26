$resourceGroupName = ${Env:resourceGroupName}
$dnsCNAME = ${Env:dnsCname}
$dnsZoneName = ${Env:dnsZoneName}

Connect-AzAccount -Identity

$RecordSet = Get-AzDnsRecordSet -Name $dnsCname -RecordType CNAME -ResourceGroupName $resourceGroupName -ZoneName $dnsZoneName
$Result = Remove-AzDnsRecordSet -RecordSet $RecordSet
$Result