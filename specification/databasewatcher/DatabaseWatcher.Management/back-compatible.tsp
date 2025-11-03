import "@azure-tools/typespec-client-generator-core";

using Microsoft.DatabaseWatcher;

// Flatten properties for backward compatibility
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AlertRuleResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(HealthValidation.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SharedPrivateLinkResource.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Watcher.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
