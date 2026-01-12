import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.ResourceConnector;

@@clientName(Microsoft.ResourceConnector,
  "ResourceConnectorManagementClient",
  "javascript"
);
@@clientName(Microsoft.ResourceConnector,
  "ResourceConnectorMgmtClient",
  "python"
);

@@clientName(Microsoft.ResourceConnector.SSHKey, "SshKey", "java");

// Fix property name case changes to maintain backward compatibility
@@clientName(Microsoft.ResourceConnector.SSHKey.expirationTimeStamp,
  "expirationTimestamp",
  "java"
);
@@clientName(Microsoft.ResourceConnector.SSHKey.creationTimeStamp,
  "creationTimestamp",
  "java"
);

@@scope(Appliances.getUpgradeGraph, "!csharp");
@@clientName(Microsoft.ResourceConnector.Appliance, "Appliance", "csharp");
@@clientName(Microsoft.ResourceConnector.SupportedVersionCatalogVersionData,
  "SupportedVersionCatalogVersionDataField",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.ApplianceOperation,
  "OperationEntity",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.ApplianceOperationValueDisplay,
  "OperationDisplay",
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.ApplianceGetTelemetryConfigResult,
  "ApplianceTelemetryConfigResult",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.ApplianceListCredentialResults,
  "ApplianceClusterUserCredentialResult",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.ApplianceListKeysResults,
  "ApplianceClusterUserKeysResult",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.ArtifactProfile,
  "ApplianceArtifactProfile",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.Distro.AKSEdge, "AksEdge", "csharp");
@@clientName(Microsoft.ResourceConnector.Provider,
  "ApplianceProvider",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.Provider.VMWare, "VMware", "csharp");
@@clientName(Microsoft.ResourceConnector.Provider.HCI, "Hci", "csharp");
@@clientName(Microsoft.ResourceConnector.SSHKey, "ApplianceSshKey", "csharp");
@@clientName(Microsoft.ResourceConnector.SupportedVersion,
  "ApplianceSupportedVersion",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.SupportedVersionCatalogVersion,
  "ApplianceSupportedVersionCatalogVersion",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.SupportedVersionCatalogVersionData,
  "ApplianceSupportedVersionCatalogVersionProperties",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.SupportedVersionMetadata,
  "ApplianceSupportedVersionMetadata",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.UpgradeGraph,
  "ApplianceUpgradeGraph",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.UpgradeGraphProperties,
  "ApplianceUpgradeGraphProperties",
  "csharp"
);
@@clientName(Appliance, "ResourceConnectorAppliance", "csharp");
@@clientName(Status, "ResourceConnectorStatus", "csharp");
@@clientName(Status.ETCDSnapshotFailed, "EtcdSnapshotFailed", "csharp");
@@clientName(Status.UpdatingCAPI, "UpdatingCapi", "csharp");
@@clientName(Status.UpgradingKVAIO, "UpgradingKvaio", "csharp");
@@clientName(Status.ValidatingETCDHealth, "ValidatingEtcdHealth ", "csharp");
@@clientName(Status.WaitingForKVAIO, "WaitingForKvaio", "csharp");
@@clientName(Distro, "ResourceConnectorDistro", "csharp");
@@clientName(Event, "ResourceConnectorEvent", "csharp");
@@clientName(NetworkProfile, "ResourceConnectorNetworkProfile", "csharp");
@@clientName(PatchableAppliance, "ResourceConnectorAppliancePatch", "csharp");
@@clientName(AppliancesOperationGroup.getTelemetryConfig, "GetTelemetryConfigAppliance", "csharp");
@@clientName(Provider.SCVMM, "Scvmm", "csharp");
@@clientName(Appliances.update::parameters.properties, "patch", "csharp");
@@alternateType(Appliance.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
