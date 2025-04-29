import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;

@@clientName(RecordSetProperties.ARecords, "aRecords");
@@clientName(RecordSetProperties.AAAARecords, "aaaaRecords");
@@clientName(RecordSetProperties.MXRecords, "mxRecords");
@@clientName(RecordSetProperties.NSRecords, "NsRecords");
@@clientName(RecordSetProperties.PTRRecords, "ptrRecords");
@@clientName(RecordSetProperties.SRVRecords, "srvRecords");
@@clientName(RecordSetProperties.TXTRecords, "txtRecords");
@@clientName(RecordSetProperties.CNAMERecord, "cnameRecord");
@@clientName(RecordSetProperties.SOARecord, "soaRecord");
@@clientName(RecordSetProperties.DSRecords, "DsRecords");
@@clientName(RecordSetProperties.TLSARecords, "tlsaRecords");
@@clientName(RecordSetProperties.NAPTRRecords, "naptrRecords");

@@clientName(SoaRecord.minimumTTL, "minimumTtl");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DnsResourceReferenceRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DnsResourceReferenceResult.properties);

@@clientName(RecordSetUpdateParameters.RecordSet, "recordSet");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DnssecConfig.properties);

@@clientName(RecordSets.createOrUpdate::parameters.resource, "parameters");
@@clientName(RecordSets.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RecordSet.properties);

@@clientName(Zones.createOrUpdate::parameters.resource, "parameters");
@@clientName(Zones.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Zone.properties);
