import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

using Playwright.Management;

// Flatten properties for backward compatibility
<<<<<<< HEAD
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PlaywrightQuota.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PlaywrightWorkspace.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PlaywrightWorkspaceQuota.properties,
  "autorest"
);
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PlaywrightQuota.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PlaywrightWorkspace.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PlaywrightWorkspaceQuota.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
