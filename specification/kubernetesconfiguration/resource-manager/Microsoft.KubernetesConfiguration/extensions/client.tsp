import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.KubernetesConfiguration,
  "KubernetesConfigurationExtensionsMgmtClient",
  "python"
);

@@clientName(Microsoft.KubernetesConfiguration.AKSIdentityType,
  "AksIdentityType",
  "java"
);

