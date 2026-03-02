import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Management;
using Azure.ResourceManager;
using Http;
using Rest;

namespace ClientCustomizations;

@@clientName(Microsoft.Management, "ManagementGroupsMgmtClient", "python");

@@clientLocation(checkNameAvailability, "API", "go");
@@clientLocation(startTenantBackfill, "API", "go");
@@clientLocation(tenantBackfillStatus, "API", "go");
@@usage(CreateManagementGroupChildInfo, Usage.input, "javascript");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(SubscriptionUnderManagementGroupsParameters.`Cache-Control`,
  "no-cache",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(ManagementGroupsListParameters.`Cache-Control`,
  "no-cache",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(EntitiesListParameters.`Cache-Control`,
  "no-cache",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(ManagementGroupsGetParameters.`Cache-Control`,
  "no-cache",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(ManagementGroupsParameters.`Cache-Control`,
  "no-cache",
  "javascript"
);
