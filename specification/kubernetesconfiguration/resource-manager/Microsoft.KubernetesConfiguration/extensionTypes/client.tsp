import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// C# type customizations for backward compatibility
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

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

@@clientName(Microsoft.KubernetesConfiguration.ExtensionTypes.locationList,
  "listLocationList",
  "javascript"
);
@@clientName(Microsoft.KubernetesConfiguration.ExtensionTypeVersionForReleaseTrainOperationGroup.clusterListVersions,
  "listClusterListVersions",
  "javascript"
);

// C# fixes: rename interface to avoid namespace conflict (§4.9)
@@clientName(Microsoft.KubernetesConfiguration.ExtensionTypes, "ExtensionTypeInterface", "csharp");
