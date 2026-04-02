import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesConfiguration;

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
@@clientName(ExtensionTypeVersionForReleaseTrainProperties,
  "VersionForReleaseTrainProperties",
  "java"
);
@@clientName(ExtensionTypeVersionUnsupportedKubernetesMatrixItem,
  "UnsupportedKubernetesMatrixItem",
  "java"
);
@@clientName(ExtensionTypeVersionForReleaseTrainPropertiesUnsupportedKubernetesVersions,
  "UnsupportedKubernetesVersions",
  "java"
);
@@clientName(ExtensionTypeVersionForReleaseTrain,
  "VersionForReleaseTrain",
  "java"
);

@@clientName(ExtensionTypes.locationList, "listLocationList", "javascript");
@@clientName(ExtensionTypeVersionForReleaseTrainOperationGroup.clusterListVersions,
  "listClusterListVersions",
  "javascript"
);

// C# type customizations for backward compatibility
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
// C# fixes: rename interface to avoid namespace conflict (§4.9)
@@clientName(ExtensionTypes, "ExtensionTypeInterface", "csharp");
@@clientName(ClusterScopeSettingsProperties.allowMultipleInstances,
  "IsMultipleInstancesAllowed",
  "csharp"
);
@@clientName(ClusterScopeSettings,
  "ExtensionTypeClusterScopeSettings",
  "csharp"
);
@@clientName(ClusterScopeSettingsProperties,
  "ExtensionTypeClusterScopeSettingsProperties",
  "csharp"
);
@@clientName(ExtensionTypePropertiesPlanInfo,
  "ExtensionTypePlanInfo",
  "csharp"
);
@@clientName(ExtensionTypePropertiesSupportedScopes,
  "ExtensionTypeSupportedScopes",
  "csharp"
);
@@clientName(ExtensionTypeVersionForReleaseTrainPropertiesUnsupportedKubernetesVersions,
  "ExtensionTypeUnsupportedKubernetesVersions",
  "csharp"
);
