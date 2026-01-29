import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.KubernetesConfiguration,
  "KubernetesConfigurationExtensionTypesMgmtClient",
  "python"
);
@@clientName(Microsoft.KubernetesConfiguration,
  "ExtensionTypesClient",
  "javascript"
);
