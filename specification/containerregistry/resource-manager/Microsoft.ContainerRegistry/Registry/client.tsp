import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.ContainerRegistry;

@@clientName(Microsoft.ContainerRegistry,
  "ContainerRegistryManagementClient",
  "javascript,python"
);

@@clientName(IPRule, "IpRule", "java");
@@clientName(IPRule.value, "ipAddressOrRange", "java");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.CommonTypes.PrivateLinkResource.properties,
  "java"
);

@@usage(Webhook, Usage.input | Usage.output, "java");
