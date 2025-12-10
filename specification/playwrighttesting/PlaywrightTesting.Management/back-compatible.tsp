import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Microsoft.AzurePlaywrightService;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Account.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AccountQuota.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Quota.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
