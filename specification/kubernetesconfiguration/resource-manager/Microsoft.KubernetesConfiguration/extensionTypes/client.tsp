import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesConfiguration;

@@clientName(
  Microsoft.KubernetesConfiguration,
  "KubernetesConfigurationExtensionTypesMgmtClient",
  "python"
);
@@clientName(
  Microsoft.KubernetesConfiguration,
  "ExtensionTypesClient",
  "javascript"
);
@@clientName(
  Microsoft.KubernetesConfiguration,
  "ExtensionTypesMgmtClient",
  "java"
);
@@clientName(
  Microsoft.KubernetesConfiguration.ExtensionTypeVersionForReleaseTrainProperties,
  "VersionForReleaseTrainProperties",
  "java"
);
@@clientName(
  Microsoft.KubernetesConfiguration.ExtensionTypeVersionUnsupportedKubernetesMatrixItem,
  "UnsupportedKubernetesMatrixItem",
  "java"
);
@@clientName(
  Microsoft.KubernetesConfiguration.ExtensionTypeVersionForReleaseTrainPropertiesUnsupportedKubernetesVersions,
  "UnsupportedKubernetesVersions",
  "java"
);
@@clientName(
  Microsoft.KubernetesConfiguration.ExtensionTypeVersionForReleaseTrain,
  "VersionForReleaseTrain",
  "java"
);

@@clientName(
  Microsoft.KubernetesConfiguration.ExtensionTypes.locationList,
  "listLocationList",
  "javascript"
);
@@clientName(
  Microsoft.KubernetesConfiguration.ExtensionTypeVersionForReleaseTrainOperationGroup.clusterListVersions,
  "listClusterListVersions",
  "javascript"
);

// C# type customizations for backward compatibility
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
// C# fixes: rename interface to avoid namespace conflict (§4.9)
@@clientName(ExtensionTypes, "ExtensionTypeInterface", "csharp");
@@clientName(ExtensionType, "KubernetesConfigurationExtensionType", "csharp");
@@clientName(
  ExtensionTypeProperties,
  "KubernetesConfigurationExtensionTypeProperties",
  "csharp"
);
@@clientName(
  ClusterScopeSettingsProperties.allowMultipleInstances,
  "IsMultipleInstancesAllowed",
  "csharp"
);
@@clientName(
  ClusterScopeSettings,
  "KubernetesConfigurationExtensionTypeClusterScopeSettings",
  "csharp"
);
@@clientName(
  ClusterScopeSettingsProperties,
  "KubernetesConfigurationExtensionTypeClusterScopeSettingsProperties",
  "csharp"
);
@@clientName(
  ExtensionTypePropertiesPlanInfo,
  "KubernetesConfigurationExtensionTypePlanInfo",
  "csharp"
);
@@clientName(
  ExtensionTypePropertiesSupportedScopes,
  "KubernetesConfigurationExtensionTypeSupportedScopes",
  "csharp"
);
@@clientName(
  ExtensionTypeVersionForReleaseTrain,
  "KubernetesConfigurationExtensionTypeVersionForReleaseTrain",
  "csharp"
);
@@clientName(
  ExtensionTypeVersionForReleaseTrainProperties,
  "KubernetesConfigurationExtensionTypeVersionForReleaseTrainProperties",
  "csharp"
);
@@clientName(
  ExtensionTypeVersionForReleaseTrainPropertiesUnsupportedKubernetesVersions,
  "KubernetesConfigurationExtensionTypeUnsupportedKubernetesVersions",
  "csharp"
);
@@clientName(
  ExtensionTypeVersionUnsupportedKubernetesMatrixItem,
  "KubernetesConfigurationExtensionTypeVersionUnsupportedKubernetesMatrixItem",
  "csharp"
);
