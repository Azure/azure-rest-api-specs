import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Network;

@@clientName(Microsoft.Network, "PrivateDnsManagementClient", "javascript");
@@clientName(Microsoft.Network, "PrivateDnsManagementClient", "java");

// Add .NET SDK config
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Customize generated C# resource names for expanded Private DNS record-set resources."
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "Customize generated C# resource names for expanded Private DNS record-set resources."
@@clientOption(
  RecordSets.get,
  "resource-name",
  #{
    A: "PrivateDnsARecord",
    AAAA: "PrivateDnsAaaaRecord",
    CNAME: "PrivateDnsCnameRecord",
    MX: "PrivateDnsMXRecord",
    PTR: "PrivateDnsPtrRecord",
    SOA: "PrivateDnsSoaRecord",
    SRV: "PrivateDnsSrvRecord",
    TXT: "PrivateDnsTxtRecord",
  },
  "csharp"
);

@@clientName(PrivateZone, "PrivateDnsZone", "csharp");
@@clientName(RecordSet, "PrivateDnsRecord", "csharp");
@@clientName(RecordType, "PrivateDnsRecordType", "csharp");
@@clientName(RecordType.AAAA, "Aaaa", "csharp");
@@clientName(RecordType.CNAME, "Cname", "csharp");
@@clientName(RecordType.PTR, "Ptr", "csharp");
@@clientName(RecordType.SOA, "Soa", "csharp");
@@clientName(RecordType.SRV, "Srv", "csharp");
@@clientName(RecordType.TXT, "Txt", "csharp");
@@clientName(ProvisioningState, "PrivateDnsProvisioningState", "csharp");
@@clientName(ResolutionPolicy, "PrivateDnsResolutionPolicy", "csharp");
@@clientName(ARecord, "PrivateDnsARecordInfo", "csharp");
@@clientName(AaaaRecord, "PrivateDnsAaaaRecordInfo", "csharp");
@@clientName(CnameRecord, "PrivateDnsCnameRecordInfo", "csharp");
@@clientName(MxRecord, "PrivateDnsMXRecordInfo", "csharp");
@@clientName(PtrRecord, "PrivateDnsPtrRecordInfo", "csharp");
@@clientName(SoaRecord, "PrivateDnsSoaRecordInfo", "csharp");
@@clientName(SrvRecord, "PrivateDnsSrvRecordInfo", "csharp");
@@clientName(TxtRecord, "PrivateDnsTxtRecordInfo", "csharp");
@@clientName(RecordSetProperties, "PrivateDnsRecordSetProperties", "csharp");
@@clientName(
  PrivateZoneProperties.maxNumberOfRecordSets,
  "maxNumberOfRecords",
  "csharp"
);
@@clientName(
  PrivateZoneProperties.numberOfRecordSets,
  "numberOfRecords",
  "csharp"
);
@@clientName(
  PrivateZoneProperties.provisioningState,
  "PrivateDnsProvisioningState",
  "csharp"
);
@@clientName(
  VirtualNetworkLinkProperties.virtualNetwork,
  "VirtualNetworkId",
  "csharp"
);
@@clientName(
  VirtualNetworkLinkProperties.resolutionPolicy,
  "PrivateDnsResolutionPolicy",
  "csharp"
);
@@clientName(
  VirtualNetworkLinkProperties.provisioningState,
  "PrivateDnsProvisioningState",
  "csharp"
);
@@clientName(RecordSetProperties.ttl, "TtlInSeconds", "csharp");
@@clientName(RecordSetProperties.aRecords, "PrivateDnsARecords", "csharp");
@@clientName(
  RecordSetProperties.aaaaRecords,
  "PrivateDnsAaaaRecords",
  "csharp"
);
@@clientName(
  RecordSetProperties.cnameRecord,
  "PrivateDnsCnameRecord",
  "csharp"
);
@@clientName(RecordSetProperties.mxRecords, "PrivateDnsMXRecords", "csharp");
@@clientName(RecordSetProperties.ptrRecords, "PrivateDnsPtrRecords", "csharp");
@@clientName(RecordSetProperties.soaRecord, "PrivateDnsSoaRecord", "csharp");
@@clientName(RecordSetProperties.srvRecords, "PrivateDnsSrvRecords", "csharp");
@@clientName(RecordSetProperties.txtRecords, "PrivateDnsTxtRecords", "csharp");
@@clientName(ARecord.ipv4Address, "IPv4Address", "csharp");
@@clientName(AaaaRecord.ipv6Address, "IPv6Address", "csharp");
@@clientName(PtrRecord.ptrdname, "PtrDomainName", "csharp");
@@clientName(TxtRecord.value, "Values", "csharp");
@@clientName(SoaRecord.expireTime, "expireTimeInSeconds", "csharp");
@@clientName(SoaRecord.retryTime, "retryTimeInSeconds", "csharp");
@@clientName(SoaRecord.minimumTtl, "minimumTtlInSeconds", "csharp");
@@clientName(SoaRecord.refreshTime, "refreshTimeInSeconds", "csharp");
@@clientName(PrivateZones.recordSetsList, "GetRecords", "csharp");

@@alternateType(PrivateZone.etag, Azure.Core.eTag, "csharp");
@@alternateType(PrivateZone.location, Azure.Core.azureLocation, "csharp");
@@alternateType(VirtualNetworkLink.etag, Azure.Core.eTag, "csharp");
@@alternateType(
  VirtualNetworkLink.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(RecordSet.etag, Azure.Core.eTag, "csharp");
@@alternateType(ARecord.ipv4Address, Azure.Core.ipV4Address, "csharp");
@@alternateType(AaaaRecord.ipv6Address, Azure.Core.ipV6Address, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Microsoft.Network.PrivateZone,
  Azure.ResourceManager.CommonTypes.TrackedResource,
  "java"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the base type back to TrackedResource for C# backward compatibility with the shipped SDK."
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Microsoft.Network.PrivateZone,
  Azure.ResourceManager.CommonTypes.TrackedResource,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the base type back to TrackedResource for C# backward compatibility with the shipped SDK."
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Microsoft.Network.VirtualNetworkLink,
  Azure.ResourceManager.CommonTypes.TrackedResource,
  "csharp"
);
