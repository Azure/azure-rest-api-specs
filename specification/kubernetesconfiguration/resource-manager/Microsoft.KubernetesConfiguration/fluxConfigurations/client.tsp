import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.KubernetesConfiguration,
  "KubernetesConfigurationFluxConfigurationsMgmtClient",
  "python"
);

@@clientName(Microsoft.KubernetesConfiguration.KustomizationDefinition.wait,
  "waitValue",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.KustomizationPatchDefinition.wait,
  "waitValue",
  "java"
);

@@clientName(Microsoft.KubernetesConfiguration.OCIRepositoryDefinition,
  "OciRepositoryDefinition",
  "java"
);
