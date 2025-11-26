import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

using Playwright.Management;

// Flatten properties for backward compatibility
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PlaywrightQuota.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PlaywrightWorkspace.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PlaywrightWorkspaceQuota.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
