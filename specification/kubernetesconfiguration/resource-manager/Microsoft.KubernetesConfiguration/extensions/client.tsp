import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesConfiguration;

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

// C# type customizations and renames for backward compatibility with the existing SDK
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Extension.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(ExtensionProperties.packageUri, url, "csharp");
@@clientName(Extension, "KubernetesClusterExtension", "csharp");
@@clientName(Scope, "KubernetesClusterExtensionScope", "csharp");
@@clientName(ExtensionStatus, "KubernetesClusterExtensionStatus", "csharp");
@@clientName(LevelType, "KubernetesClusterExtensionStatusLevel", "csharp");
@@clientName(ProvisioningState,
  "KubernetesConfigurationProvisioningState",
  "csharp"
);
@@clientName(PatchExtension, "KubernetesClusterExtensionPatch", "csharp");
@@clientName(PatchExtensionProperties,
  "KubernetesClusterExtensionPatchProperties",
  "csharp"
);
@@clientName(ExtensionProperties,
  "KubernetesClusterExtensionProperties",
  "csharp"
);
@@clientName(ExtensionPropertiesAksAssignedIdentity,
  "KubernetesClusterExtensionAksAssignedIdentity",
  "csharp"
);
@@clientName(ScopeCluster, "KubernetesClusterExtensionScopeCluster", "csharp");
@@clientName(ScopeNamespace,
  "KubernetesClusterExtensionScopeNamespace",
  "csharp"
);
@@clientName(AccessDetail, "KubernetesClusterAccessDetail", "csharp");
@@clientName(AutoUpgradeMode, "KubernetesClusterAutoUpgradeMode", "csharp");
@@clientName(AdditionalDetails, "KubernetesClusterAdditionalDetails", "csharp");
@@clientName(ManagementDetails, "KubernetesClusterManagementDetails", "csharp");
@@clientName(ExtensionProperties.autoUpgradeMinorVersion,
  "IsAutoUpgradeMinorVersionEnabled",
  "csharp"
);
@@clientName(PatchExtensionProperties.autoUpgradeMinorVersion,
  "IsAutoUpgradeMinorVersionEnabled",
  "csharp"
);
// Rename to avoid conflicts with namespace names in the SDK
@@clientName(Extensions, "ExtensionsInterface", "csharp");
// Exclude OperationStatus APIs from C# SDK - they are built into the core library
@@scope(Extensions.operationStatusGet, "!csharp");

// Backward compatibility: old SDK used ManagedServiceIdentity for AksAssignedIdentity
@@alternateType(ExtensionProperties.aksAssignedIdentity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
