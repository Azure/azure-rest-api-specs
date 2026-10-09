import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AppComplianceAutomation;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flatten"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  EvidenceResource.properties,
  "autorest,go,python,javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flatten"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ReportResource.properties,
  "autorest,go,python,javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flatten"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ScopingConfigurationResource.properties,
  "autorest,go,python,javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flatten"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  SnapshotResource.properties,
  "autorest,go,python,javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flatten"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  WebhookResource.properties,
  "autorest,go,python,javascript"
);

@@clientLocation(Report.get, Report);
@@clientLocation(Report.createOrUpdate, Report);
@@clientLocation(Report.update, Report);
@@clientLocation(Report.delete, Report);
@@clientLocation(Report.list, Report);
@@clientLocation(Report.syncCertRecord, Report);
@@clientLocation(Report.checkNameAvailability, Report);
@@clientName(
  Report.checkNameAvailability,
  "NestedResourceCheckNameAvailability"
);
@@clientLocation(Report.fix, Report);
@@clientLocation(Report.getScopingQuestions, Report);
@@clientLocation(Report.verify, Report);

@@clientLocation(Evidence.get, Evidence);
@@clientLocation(Evidence.createOrUpdate, Evidence);
@@clientLocation(Evidence.delete, Evidence);
@@clientLocation(Evidence.listByReport, Evidence);
@@clientLocation(Evidence.download, Evidence);

@@clientLocation(ScopingConfiguration.get, ScopingConfiguration);
@@clientLocation(ScopingConfiguration.createOrUpdate, ScopingConfiguration);
@@clientLocation(ScopingConfiguration.delete, ScopingConfiguration);
@@clientLocation(ScopingConfiguration.list, ScopingConfiguration);

@@clientLocation(Snapshot.get, Snapshot);
@@clientLocation(Snapshot.list, Snapshot);
@@clientLocation(Snapshot.download, Snapshot);

@@clientLocation(Webhook.get, Webhook);
@@clientLocation(Webhook.createOrUpdate, Webhook);
@@clientLocation(Webhook.update, Webhook);
@@clientLocation(Webhook.delete, Webhook);
@@clientLocation(Webhook.list, Webhook);
