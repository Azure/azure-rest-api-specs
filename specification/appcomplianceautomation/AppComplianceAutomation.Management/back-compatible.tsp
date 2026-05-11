import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AppComplianceAutomation;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flatten"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(EvidenceResource.properties,
  "autorest,go,python,javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flatten"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ReportResource.properties,
  "autorest,go,python,javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flatten"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScopingConfigurationResource.properties,
  "autorest,go,python,javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flatten"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SnapshotResource.properties,
  "autorest,go,python,javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flatten"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WebhookResource.properties,
  "autorest,go,python,javascript"
);
