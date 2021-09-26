# Copyright (c) 2021 Microsoft Corporation
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT
$resourceGroupName = ${Env:resourceGroupName}
$dnsCname = ${Env:dnsCname}
$dnsZoneName = ${Env:dnsZoneName}
$dnsCnameAlias = ${Env:dnsCnameAlias}
Connect-AzAccount -Identity
New-AzDnsRecordSet -Name $dnsCname -RecordType CNAME -ZoneName $dnsZoneName -ResourceGroupName $resourceGroupName -Ttl 3600 -DnsRecords (New-AzDnsRecordConfig -Cname $dnsCnameAlias)
$RecordSet = Get-AzDnsRecordSet -Name $dnsCname -RecordType CNAME -ResourceGroupName $resourceGroupName -ZoneName $dnsZoneName
$RecordSet