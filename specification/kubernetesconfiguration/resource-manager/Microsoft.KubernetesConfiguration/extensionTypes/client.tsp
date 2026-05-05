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
@@clientName(Microsoft.KubernetesConfiguration,
  "ExtensionTypesMgmtClient",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.ExtensionTypeVersionForReleaseTrainProperties,
  "VersionForReleaseTrainProperties",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.ExtensionTypeVersionUnsupportedKubernetesMatrixItem,
  "UnsupportedKubernetesMatrixItem",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.ExtensionTypeVersionForReleaseTrainPropertiesUnsupportedKubernetesVersions,
  "UnsupportedKubernetesVersions",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.ExtensionTypeVersionForReleaseTrain,
  "VersionForReleaseTrain",
  "java"
);
