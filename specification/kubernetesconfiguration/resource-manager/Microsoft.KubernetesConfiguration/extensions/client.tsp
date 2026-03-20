import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// Fix string → ResourceIdentifier for base Resource.id (armCommonTypesVersion v3)
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// C# type mapping fixes for extension resource pattern
@@alternateType(Microsoft.KubernetesConfiguration.Extension.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@clientName(Microsoft.KubernetesConfiguration,
  "KubernetesConfigurationExtensionsMgmtClient",
  "python"
);

@@clientName(Microsoft.KubernetesConfiguration,
  "ExtensionsClient",
  "javascript"
);

@@clientName(Microsoft.KubernetesConfiguration.AKSIdentityType,
  "AksIdentityType",
  "java"
);

@@alternateType(Azure.ResourceManager.CommonTypes.Identity.type,
  "SystemAssigned",
  "go"
);

// C# renames to preserve backward compatibility with the existing SDK
@@clientName(Microsoft.KubernetesConfiguration.Extension,
  "KubernetesClusterExtension",
  "csharp"
);

@@clientName(Microsoft.KubernetesConfiguration.Scope,
  "KubernetesClusterExtensionScope",
  "csharp"
);

@@clientName(Microsoft.KubernetesConfiguration.ExtensionStatus,
  "KubernetesClusterExtensionStatus",
  "csharp"
);

@@clientName(Microsoft.KubernetesConfiguration.LevelType,
  "KubernetesClusterExtensionStatusLevel",
  "csharp"
);

@@clientName(Microsoft.KubernetesConfiguration.ProvisioningState,
  "KubernetesConfigurationProvisioningState",
  "csharp"
);

@@clientName(Microsoft.KubernetesConfiguration.PatchExtension,
  "KubernetesClusterExtensionPatch",
  "csharp"
);

@@clientName(Microsoft.KubernetesConfiguration.PatchExtensionProperties,
  "KubernetesClusterExtensionPatchProperties",
  "csharp"
);

@@clientName(Microsoft.KubernetesConfiguration.ExtensionProperties,
  "KubernetesClusterExtensionProperties",
  "csharp"
);

@@clientName(Microsoft.KubernetesConfiguration.ExtensionPropertiesAksAssignedIdentity,
  "KubernetesClusterExtensionAksAssignedIdentity",
  "csharp"
);

@@clientName(Microsoft.KubernetesConfiguration.ScopeCluster,
  "KubernetesClusterExtensionScopeCluster",
  "csharp"
);

@@clientName(Microsoft.KubernetesConfiguration.ScopeNamespace,
  "KubernetesClusterExtensionScopeNamespace",
  "csharp"
);
