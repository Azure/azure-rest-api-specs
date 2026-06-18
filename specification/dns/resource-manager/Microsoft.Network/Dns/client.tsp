import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Network;

@@clientName(Microsoft.Network, "DnsManagementClient", "javascript");
@@clientName(Microsoft.Network, "DnsManagementClient", "java");

@@clientName(Microsoft.Network.RecordSetProperties.TTL, "ttl", "java");

// Add .NET SDK config
@@scope(Microsoft.Network.Zones.listAllByDnsZone, "!csharp");

#suppress "@azure-tools/typespec-client-generator-core/client-option" "Customize generated C# resource names for expanded DNS record-set resources."
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "Customize generated C# resource names for expanded DNS record-set resources."
@@clientOption(
  RecordSets.get,
  "resource-name",
  #{
    A: "DnsARecord",
    AAAA: "DnsAaaaRecord",
    CAA: "DnsCaaRecord",
    CNAME: "DnsCnameRecord",
    MX: "DnsMXRecord",
    NS: "DnsNSRecord",
    PTR: "DnsPtrRecord",
    SOA: "DnsSoaRecord",
    SRV: "DnsSrvRecord",
    TXT: "DnsTxtRecord",
    DS: "DnsDSRecord",
    TLSA: "DnsTlsaRecord",
    NAPTR: "DnsNaptrRecord",
  },
  "csharp"
);
@@clientName(RecordSetProperties.ARecords, "DnsARecords", "csharp");
@@clientName(RecordSetProperties.AAAARecords, "DnsAaaaRecords", "csharp");
@@clientName(RecordSetProperties.caaRecords, "DnsCaaRecords", "csharp");
@@clientName(RecordSetProperties.CNAMERecord, "DnsCnameRecord", "csharp");
@@clientName(RecordSetProperties.MXRecords, "DnsMXRecords", "csharp");
@@clientName(RecordSetProperties.NSRecords, "DnsNSRecords", "csharp");
@@clientName(RecordSetProperties.PTRRecords, "DnsPtrRecords", "csharp");
@@clientName(RecordSetProperties.SRVRecords, "DnsSrvRecords", "csharp");
@@clientName(RecordSetProperties.TXTRecords, "DnsTxtRecords", "csharp");
@@clientName(RecordSetProperties.DSRecords, "DnsDSRecords", "csharp");
@@clientName(RecordSetProperties.TLSARecords, "DnsTlsaRecords", "csharp");
@@clientName(RecordSetProperties.NAPTRRecords, "DnsNaptrRecords", "csharp");
@@clientName(RecordSetProperties.SOARecord, "DnsSoaRecord", "csharp");
@@clientName(RecordType, "DnsRecordType", "csharp");
@@clientName(RecordType.AAAA, "Aaaa", "csharp");
@@clientName(RecordType.CAA, "Caa", "csharp");
@@clientName(RecordType.CNAME, "Cname", "csharp");
@@clientName(RecordType.PTR, "Ptr", "csharp");
@@clientName(RecordType.SOA, "Soa", "csharp");
@@clientName(RecordType.SRV, "Srv", "csharp");
@@clientName(RecordType.TXT, "Txt", "csharp");
@@clientName(RecordType.TLSA, "Tlsa", "csharp");
@@clientName(RecordType.NAPTR, "Naptr", "csharp");
@@clientName(Digest, "DSRecordDigest", "csharp");
@@clientName(ARecord, "DnsARecordInfo", "csharp");
@@clientName(AaaaRecord, "DnsAaaaRecordInfo", "csharp");
@@clientName(MxRecord, "DnsMXRecordInfo", "csharp");
@@clientName(NsRecord, "DnsNSRecordInfo", "csharp");
@@clientName(PtrRecord, "DnsPtrRecordInfo", "csharp");
@@clientName(SrvRecord, "DnsSrvRecordInfo", "csharp");
@@clientName(TxtRecord, "DnsTxtRecordInfo", "csharp");
@@clientName(CnameRecord, "DnsCnameRecordInfo", "csharp");
@@clientName(SoaRecord, "DnsSoaRecordInfo", "csharp");
@@clientName(CaaRecord, "DnsCaaRecordInfo", "csharp");
@@clientName(DsRecord, "DnsDSRecordInfo", "csharp");
@@clientName(TlsaRecord, "DnsTlsaRecordInfo", "csharp");
@@clientName(NaptrRecord, "DnsNaptrRecordInfo", "csharp");
@@clientName(SoaRecord.expireTime, "expireTimeInSeconds", "csharp");
@@clientName(SoaRecord.retryTime, "retryTimeInSeconds", "csharp");
@@clientName(SoaRecord.minimumTTL, "minimumTtlInSeconds", "csharp");
@@clientName(SoaRecord.refreshTime, "refreshTimeInSeconds", "csharp");
@@clientName(Zone, "DnsZone", "csharp");
@@clientName(ZoneType, "DnsZoneType", "csharp");
@@clientName(SigningKey, "DnsSigningKey", "csharp");
@@clientName(RecordSet, "DnsRecord", "csharp");
@@clientName(NsRecord.nsdname, "DnsNSDomainName", "csharp");
@@clientName(PtrRecord.ptrdname, "DnsPtrDomainName", "csharp");
@@clientName(RecordSetProperties.TTL, "TtlInSeconds", "csharp");
@@clientName(
  ZoneProperties.maxNumberOfRecordSets,
  "maxNumberOfRecords",
  "csharp"
);
@@clientName(
  ZoneProperties.maxNumberOfRecordsPerRecordSet,
  "maxNumberOfRecordsPerRecord",
  "csharp"
);
@@clientName(ZoneProperties.numberOfRecordSets, "numberOfRecords", "csharp");
@@clientName(
  DnsResourceReferenceRequest,
  "DnsResourceReferenceContent",
  "csharp"
);
@@clientName(ARecord.ipv4Address, "IPv4Address", "csharp");
@@clientName(AaaaRecord.ipv6Address, "IPv6Address", "csharp");
@@clientName(ZoneUpdate, "DnsZonePatch", "csharp");
@@clientName(
  DnsResourceReferenceOperationGroup.getByTargetResources,
  "GetDnsResourceReferencesByTargetResources",
  "csharp"
);
@@clientName(TxtRecord.value, "Values", "csharp");
@@clientName(RecordSetProperties, "DnsRecordSetProperties", "csharp");

@@alternateType(DnssecConfig.etag, Azure.Core.eTag, "csharp");
@@alternateType(RecordSet.etag, Azure.Core.eTag, "csharp");
@@alternateType(Zone.etag, Azure.Core.eTag, "csharp");
@@alternateType(
  RecordSetProperties.targetResource,
  Azure.ResourceManager.Models.WritableSubResource,
  "csharp"
);
@@alternateType(
  RecordSetProperties.trafficManagementProfile,
  Azure.ResourceManager.Models.WritableSubResource,
  "csharp"
);
@@alternateType(
  ZoneProperties.registrationVirtualNetworks,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(
  ZoneProperties.resolutionVirtualNetworks,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(
  DnsResourceReferenceRequestProperties.targetResources,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(
  DnsResourceReference.dnsResources,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(
  DnsResourceReference.targetResource,
  Azure.ResourceManager.Models.WritableSubResource,
  "csharp"
);
@@alternateType(ARecord.ipv4Address, Azure.Core.ipV4Address, "csharp");
@@alternateType(AaaaRecord.ipv6Address, Azure.Core.ipV6Address, "csharp");

namespace Azure.ResourceManager.Models {
  /** Represents a reference to an existing resource by its id. */
  model WritableSubResource {
    /** The resource id. */
    id?: Azure.Core.armResourceIdentifier;
  }
}
