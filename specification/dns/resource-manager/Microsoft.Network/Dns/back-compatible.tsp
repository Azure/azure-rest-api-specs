import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;

@@clientName(RecordSetProperties.ARecords, "ARecords");
@@clientName(RecordSetProperties.AAAARecords, "AaaaRecords");
@@clientName(RecordSetProperties.MXRecords, "MxRecords");
@@clientName(RecordSetProperties.NSRecords, "NsRecords");
@@clientName(RecordSetProperties.PTRRecords, "PtrRecords");
@@clientName(RecordSetProperties.SRVRecords, "SrvRecords");
@@clientName(RecordSetProperties.TXTRecords, "TxtRecords");
@@clientName(RecordSetProperties.CNAMERecord, "CnameRecord");
@@clientName(RecordSetProperties.SOARecord, "SoaRecord");
@@clientName(RecordSetProperties.DSRecords, "DsRecords");
@@clientName(RecordSetProperties.TLSARecords, "TlsaRecords");
@@clientName(RecordSetProperties.NAPTRRecords, "NaptrRecords");
@@clientName(RecordSetProperties.caaRecords, "CaaRecords");
@@clientName(SoaRecord.minimumTTL, "minimumTtl");

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DnsResourceReferenceRequest.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DnsResourceReferenceResult.properties);

@@clientName(RecordSetUpdateParameters.RecordSet, "recordSet");

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DnssecConfig.properties);

@@clientName(RecordSets.createOrUpdate::parameters.resource, "parameters");
@@clientName(RecordSets.update::parameters.properties, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RecordSet.properties);

@@clientName(Zones.createOrUpdate::parameters.resource, "parameters");
@@clientName(Zones.update::parameters.properties, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Zone.properties);
@@visibility(DnssecConfig.properties, Lifecycle.Read);
@@clientName(DnsResourceReferenceOperationGroup.getByTargetResources::parameters.body,
  "parameters"
);

// @@clientLocation decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output
@@clientLocation(RecordSets.listByType, RecordSets);
@@clientLocation(Zones.listByDnsZone, RecordSets);
@@clientLocation(Zones.listAllByDnsZone, RecordSets);
@@clientLocation(DnsResourceReferenceOperationGroup.getByTargetResources,
  "DnsResourceReference"
);
