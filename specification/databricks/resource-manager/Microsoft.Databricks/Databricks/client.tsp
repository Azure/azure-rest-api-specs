import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.Databricks;

@@clientName(Azure.ResourceManager.CommonTypes.ErrorDetail,
  "ArmErrorDetail",
  "python"
);
@@clientName(Microsoft.Databricks,
  "AzureDatabricksManagementClient",
  "python,javascript"
);
@@clientLocation(VirtualNetworkPeerings.get, "VNetPeering", "python");
@@clientLocation(VirtualNetworkPeerings.createOrUpdate,
  "VNetPeering",
  "python"
);
@@clientLocation(VirtualNetworkPeerings.delete, "VNetPeering", "python");
@@clientLocation(VirtualNetworkPeerings.listByWorkspace,
  "VNetPeering",
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(WorkspaceDeleteParameters.forceDeletion,
  false,
  "python"
);

@@clientName(Microsoft.Databricks.ErrorDetail,
  "DatabricksErrorDetail",
  "java,csharp"
);
@@clientName(Workspace, "DatabricksWorkspace", "csharp");
@@clientName(PrivateEndpointConnection,
  "DatabricksPrivateEndpointConnection",
  "csharp"
);
@@clientName(AccessConnector, "DatabricksAccessConnector", "csharp");
@@clientName(AccessConnectorProperties,
  "DatabricksAccessConnectorProperties",
  "csharp"
);
@@clientName(AccessConnectorUpdate, "DatabricksAccessConnectorPatch", "csharp");
@@clientName(VirtualNetworkPeering,
  "DatabricksVirtualNetworkPeering",
  "csharp"
);
@@clientName(PublicNetworkAccess, "DatabricksPublicNetworkAccess", "csharp");
@@clientName(ProvisioningState, "DatabricksProvisioningState", "csharp");
@@clientName(ComputeMode, "DatabricksComputeMode", "csharp");
@@clientName(IdentityType, "DatabricksIdentityType", "csharp");
@@clientName(InitialType, "DatabricksInitialCatalogType", "csharp");
@@clientName(KeySource, "DatabricksKeySource", "csharp");
@@clientName(EncryptionKeySource, "DatabricksEncryptionKeySource", "csharp");
@@clientName(CustomParameterType, "DatabricksCustomParameterType", "csharp");
@@clientName(DefaultStorageFirewall,
  "DatabricksDefaultStorageFirewall",
  "csharp"
);
@@clientName(Encryption, "DatabricksEncryption", "csharp");
@@clientName(EncryptionEntitiesDefinition,
  "DatabricksEncryptionEntities",
  "csharp"
);
@@clientName(EncryptionV2, "DatabricksEncryptionV2", "csharp");
@@clientName(EncryptionV2KeyVaultProperties,
  "DatabricksEncryptionV2KeyVaultProperties",
  "csharp"
);
@@clientName(ManagedDiskEncryption,
  "DatabricksManagedDiskEncryption",
  "csharp"
);
@@clientName(ManagedDiskEncryptionKeyVaultProperties,
  "DatabricksManagedDiskEncryptionKeyVaultProperties",
  "csharp"
);
@@clientName(EnhancedSecurityComplianceDefinition,
  "DatabricksEnhancedSecurityCompliance",
  "csharp"
);
@@clientName(EnhancedSecurityMonitoringValue,
  "DatabricksEnhancedSecurityMonitoringValue",
  "csharp"
);
@@clientName(ComplianceSecurityProfileDefinition,
  "DatabricksComplianceSecurityProfile",
  "csharp"
);
@@clientName(ComplianceSecurityProfileValue,
  "DatabricksComplianceSecurityProfileValue",
  "csharp"
);
@@clientName(AutomaticClusterUpdateValue,
  "DatabricksAutomaticClusterUpdateValue",
  "csharp"
);
@@clientName(EndpointDependency, "DatabricksEndpointDependency", "csharp");
@@clientName(EndpointDetail, "DatabricksEndpointDetail", "csharp");
@@clientName(OutboundEnvironmentEndpoint,
  "DatabricksOutboundEnvironmentEndpoint",
  "csharp"
);
@@clientName(PrivateEndpointConnectionProperties,
  "DatabricksPrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(PrivateLinkServiceConnectionStatus,
  "DatabricksPrivateLinkServiceConnectionStatus",
  "csharp"
);
@@clientName(PeeringState, "DatabricksVirtualNetworkPeeringState", "csharp");
@@clientName(PeeringProvisioningState,
  "DatabricksVirtualNetworkPeeringProvisioningState",
  "csharp"
);
@@clientName(GroupIdInformationProperties,
  "DatabricksGroupIdInformationProperties",
  "csharp"
);
@@clientName(ManagedIdentityConfiguration,
  "DatabricksManagedIdentityConfiguration",
  "csharp"
);
@@clientName(DefaultCatalogProperties,
  "DatabricksDefaultCatalogProperties",
  "csharp"
);
@@clientName(CreatedBy, "DatabricksCreatedBy", "csharp");
@@clientName(RequiredNsgRules, "DatabricksRequiredNsgRules", "csharp");
@@clientName(WorkspacePropertiesAccessConnector,
  "DatabricksWorkspaceAccessConnectorInfo",
  "csharp"
);
@@clientName(WorkspaceProviderAuthorization,
  "DatabricksWorkspaceProviderAuthorization",
  "csharp"
);
@@clientName(WorkspaceCustomParameters, "WorkspaceCustomProperties", "csharp");
@@clientName(WorkspaceCustomStringParameter,
  "WorkspaceCustomStringParameterValue",
  "csharp"
);
@@clientName(WorkspaceNoPublicIPBooleanParameter,
  "WorkspaceNoPublicIPBooleanParameterValue",
  "csharp"
);
@@clientName(WorkspaceNoPublicIPBooleanParameter.value, "IsEnabled", "csharp");
@@clientName(WorkspaceCustomBooleanParameter,
  "WorkspaceCustomBooleanParameterValue",
  "csharp"
);
@@clientName(WorkspaceCustomBooleanParameter.value, "IsEnabled", "csharp");
@@clientName(WorkspaceEncryptionParameter,
  "WorkspaceEncryptionParameterValue",
  "csharp"
);
@@clientName(WorkspaceCustomObjectParameter,
  "WorkspaceCustomObjectParameterValue",
  "csharp"
);
@@clientName(ManagedDiskEncryption.rotationToLatestKeyVersionEnabled,
  "IsRotationToLatestKeyVersionEnabled",
  "csharp"
);
@@clientName(AccessConnectorProperties.referedBy, "ReferredBy", "csharp");
@@clientName(GroupIdInformation, "DatabricksPrivateLinkResource", "csharp");
@@clientName(Workspaces.list,
  "GetOutboundNetworkDependenciesEndpoints",
  "csharp"
);
@@clientName(Microsoft.Databricks.WorkspaceNoPublicIPBooleanParameter,
  "WorkspaceNoPublicIpBooleanParameter",
  "java"
);
@@alternateType(WorkspaceProperties.managedResourceGroupId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(WorkspaceProperties.diskEncryptionSetId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(PrivateEndpoint.id, armResourceIdentifier, "csharp");
@@alternateType(VirtualNetworkPeeringPropertiesFormatDatabricksVirtualNetwork.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(VirtualNetworkPeeringPropertiesFormatRemoteVirtualNetwork.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ManagedIdentityConfiguration.principalId, uuid, "csharp");
@@alternateType(ManagedIdentityConfiguration.tenantId, uuid, "csharp");
@@alternateType(CreatedBy.oid, uuid, "csharp");
@@alternateType(CreatedBy.applicationId, uuid, "csharp");
@@alternateType(WorkspaceProviderAuthorization.principalId, uuid, "csharp");
@@alternateType(WorkspaceProviderAuthorization.roleDefinitionId,
  uuid,
  "csharp"
);
