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
@@clientName(
  ClusterScopeSettingsProperties.allowMultipleInstances,
  "IsMultipleInstancesAllowed",
  "csharp"
);
@@clientName(
  ClusterScopeSettings,
  "ExtensionTypeClusterScopeSettings",
  "csharp"
);
@@clientName(
  ClusterScopeSettingsProperties,
  "ExtensionTypeClusterScopeSettingsProperties",
  "csharp"
);
@@clientName(
  ExtensionTypePropertiesPlanInfo,
  "ExtensionTypePlanInfo",
  "csharp"
);
@@clientName(
  ExtensionTypePropertiesSupportedScopes,
  "ExtensionTypeSupportedScopes",
  "csharp"
);
@@clientName(
  ExtensionTypeVersionForReleaseTrainPropertiesUnsupportedKubernetesVersions,
  "ExtensionTypeUnsupportedKubernetesVersions",
  "csharp"
);
