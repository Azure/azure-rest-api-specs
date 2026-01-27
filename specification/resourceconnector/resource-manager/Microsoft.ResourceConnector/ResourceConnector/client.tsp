import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./main.tsp";

using Http;
using Azure.ClientGenerator.Core;
using TypeSpec.Rest;
using Microsoft.ResourceConnector;

/*
 * Shared client overrides
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op AppliancesUpdateCustomized(
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,
  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.ProviderNamespace<Appliance>,

  @path
  @maxLength(63)
  @minLength(1)
  @doc("Appliances name.")
  @segment("appliances")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  resourceName: string,

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "override"
  @doc("Resource tags")
  @body
  tags?: Record<string>,
): Appliance;
@@override(Appliances.update, AppliancesUpdateCustomized, "javascript,python");

/*
 * Python overrides
 */
@@clientName(Microsoft.ResourceConnector,
  "ResourceConnectorMgmtClient",
  "python"
);

/*
 * JavaScript overrides
 */
@@clientName(Microsoft.ResourceConnector,
  "ResourceConnectorManagementClient",
  "javascript"
);

/*
 * Java overrides
 */
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

/*
 * .NET overrides
 */
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
  "ApplianceListCredentialResult",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.ApplianceListKeysResults,
  "ApplianceListKeysResult",
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
@@clientName(Status, "ApplianceStatus", "csharp");
@@clientName(Status.ETCDSnapshotFailed, "EtcdSnapshotFailed", "csharp");
@@clientName(Status.UpdatingCAPI, "UpdatingCapi", "csharp");
@@clientName(Status.UpgradingKVAIO, "UpgradingKvaio", "csharp");
@@clientName(Status.ValidatingETCDHealth, "ValidatingEtcdHealth ", "csharp");
@@clientName(Status.WaitingForKVAIO, "WaitingForKvaio", "csharp");
@@clientName(Status.NetworkDNSUpdateComplete,
  "NetworkDnsUpdateComplete",
  "csharp"
);
@@clientName(Status.NetworkDNSUpdateFailed, "NetworkDnsUpdateFailed", "csharp");
@@clientName(Status.NetworkDNSUpdatePreparing,
  "NetworkDnsUpdatePreparing",
  "csharp"
);
@@clientName(Status.NetworkDNSUpdating, "NetworkDnsUpdating", "csharp");
@@clientName(Distro, "ApplianceDistro", "csharp");
@@clientName(Event, "ApplianceEvent", "csharp");
@@clientName(NetworkProfile, "ApplianceNetworkProfile", "csharp");
@@clientName(PatchableAppliance, "ResourceConnectorAppliancePatch", "csharp");
@@clientName(AppliancesOperationGroup.getTelemetryConfig,
  "GetApplianceTelemetryConfig",
  "csharp"
);
@@clientName(Provider.SCVMM, "Scvmm", "csharp");
@@clientName(Appliances.createOrUpdate::parameters.resource, "data", "csharp");
@@clientName(Appliances.update::parameters.properties, "patch", "csharp");
@@alternateType(Appliance.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
