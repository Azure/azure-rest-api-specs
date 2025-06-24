import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataReplication;

// csharp, java don't expose LRO polling status API
@@scope(OperationResults.get, "!csharp, !java");
@@scope(LocationBasedOperationResults.get, "!csharp, !java");

@@clientName(FabricAgentModelProperties.lastHeartbeat,
  "LastHeartbeatOn",
  "csharp"
);
@@clientName(CheckNameAvailabilityModel,
  "DataReplicationNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityResponseModel,
  "DataReplicationNameAvailabilityResult",
  "csharp"
);
@@clientName(CheckNameAvailabilityResponseModel.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(DeploymentPreflightResource,
  "DeploymentPreflightResourceInfo",
  "csharp"
);
@@clientName(EmailConfigurationModel,
  "DataReplicationEmailConfiguration",
  "csharp"
);
@@clientName(EmailConfigurationModelProperties,
  "DataReplicationEmailConfigurationProperties",
  "csharp"
);
@@clientName(ErrorModel, "DataReplicationErrorInfo", "csharp");
@@clientName(EventModel, "DataReplicationEvent", "csharp");
@@clientName(EventModelProperties, "DataReplicationEventProperties", "csharp");
@@clientName(EventModelProperties.timeOfOccurrence, "OccurredOn", "csharp");
@@clientName(EventModelCustomProperties,
  "DataReplicationEventCustomProperties",
  "csharp"
);
@@clientName(HyperVToAzStackHCIEventModelCustomProperties,
  "HyperVToAzStackHciEventCustomProperties",
  "csharp"
);
@@clientName(VMwareToAzStackHCIEventModelCustomProperties,
  "VMwareToAzStackHciEventCustomProperties",
  "csharp"
);
@@clientName(HealthErrorModel, "DataReplicationHealthErrorInfo", "csharp");
@@clientName(HealthStatus, "DataReplicationHealthStatus", "csharp");
@@clientName(IdentityModel, "DataReplicationIdentity", "csharp");
@@clientName(InnerHealthErrorModel,
  "DataReplicationInnerHealthErrorInfo",
  "csharp"
);
@@clientName(PolicyModel, "DataReplicationPolicy", "csharp");
@@clientName(PolicyModelProperties,
  "DataReplicationPolicyProperties",
  "csharp"
);
@@clientName(PolicyModelCustomProperties,
  "DataReplicationPolicyCustomProperties",
  "csharp"
);
@@clientName(VMwareToAzStackHCIPolicyModelCustomProperties,
  "VMwareToAzStackHciPolicyCustomProperties",
  "csharp"
);
@@clientName(ProtectedItemModel, "DataReplicationProtectedItem", "csharp");
@@clientName(ProtectedItemModelProperties,
  "DataReplicationProtectedItemProperties",
  "csharp"
);
@@clientName(ProtectedItemModelProperties.resyncRequired,
  "IsResyncRequired",
  "csharp"
);
@@clientName(ProtectedItemModelPropertiesUpdate,
  "DataReplicationProtectedItemPropertiesUpdate",
  "csharp"
);
@@clientName(ProtectedItemModelCustomProperties,
  "DataReplicationProtectedItemCustomProperties",
  "csharp"
);
@@clientName(ProtectedItemModelCustomPropertiesUpdate,
  "DataReplicationProtectedItemCustomPropertiesUpdate",
  "csharp"
);
@@clientName(ProtectionState, "DataReplicationProtectionState", "csharp");
@@clientName(ProvisioningState, "DataReplicationProvisioningState", "csharp");
@@clientName(RecoveryPointModel, "DataReplicationRecoveryPoint", "csharp");
@@clientName(RecoveryPointModelProperties,
  "DataReplicationRecoveryPointProperties",
  "csharp"
);
@@clientName(RecoveryPointModelCustomProperties,
  "DataReplicationRecoveryPointCustomProperties",
  "csharp"
);
@@clientName(VMwareToAzStackHCIRecoveryPointModelCustomProperties,
  "VMwareToAzStackHCIRecoveryPointCustomProperties",
  "csharp"
);
@@clientName(RecoveryPointType, "DataReplicationRecoveryPointType", "csharp");
@@clientName(ReplicationExtensionModel, "DataReplicationExtension", "csharp");
@@clientName(ReplicationExtensionModelProperties,
  "DataReplicationExtensionProperties",
  "csharp"
);
@@clientName(ReplicationExtensionModelCustomProperties,
  "DataReplicationExtensionCustomProperties",
  "csharp"
);
@@clientName(VMwareToAzStackHCIReplicationExtensionModelCustomProperties,
  "VMwareToAzStackHCIReplicationExtensionCustomProperties",
  "csharp"
);
@@clientName(ReplicationVaultType, "DataReplicationVaultType", "csharp");
@@clientName(ResynchronizationState,
  "DataReplicationResynchronizationState",
  "csharp"
);
@@clientName(TaskModel, "DataReplicationTask", "csharp");
@@clientName(TaskModelCustomProperties,
  "DataReplicationTaskCustomProperties",
  "csharp"
);
@@clientName(TaskState, "DataReplicationTaskState", "csharp");
@@clientName(TestFailoverState, "DataReplicationTestFailoverState", "csharp");
@@clientName(VaultModel, "DataReplicationVault", "csharp");
@@clientName(VaultModelProperties, "DataReplicationVaultProperties", "csharp");
@@clientName(FabricAgentModel, "DataReplicationFabricAgent", "csharp");
@@clientName(FabricAgentModelProperties,
  "DataReplicationFabricAgentProperties",
  "csharp"
);
@@clientName(FabricAgentModelCustomProperties,
  "DataReplicationFabricAgentCustomProperties",
  "csharp"
);
@@clientName(VMwareFabricAgentModelCustomProperties,
  "VMwareFabricAgentCustomProperties",
  "csharp"
);
@@clientName(VMwareMigrateFabricModelCustomProperties,
  "VMwareMigrateFabricCustomProperties",
  "csharp"
);
@@clientName(FabricModel, "DataReplicationFabric", "csharp");
@@clientName(FabricModelProperties,
  "DataReplicationFabricProperties",
  "csharp"
);
@@clientName(FabricModelCustomProperties,
  "DataReplicationFabricCustomProperties",
  "csharp"
);
@@clientName(AzStackHCIFabricModelCustomProperties,
  "AzStackHciFabricCustomProperties",
  "csharp"
);
@@clientName(HyperVMigrateFabricModelCustomProperties,
  "HyperVMigrateFabricCustomProperties",
  "csharp"
);
@@clientName(JobModel, "DataReplicationJob", "csharp");
@@clientName(JobModelProperties, "DataReplicationJobProperties", "csharp");
@@clientName(JobModelCustomProperties,
  "DataReplicationJobCustomProperties",
  "csharp"
);
@@clientName(FailoverJobModelCustomProperties,
  "FailoverJobCustomProperties",
  "csharp"
);
@@clientName(TestFailoverCleanupJobModelCustomProperties,
  "TestFailoverCleanupJobCustomProperties",
  "csharp"
);
@@clientName(TestFailoverJobModelCustomProperties,
  "TestFailoverJobCustomProperties",
  "csharp"
);
@@clientName(JobObjectType, "DataReplicationJobObjectType", "csharp");
@@clientName(JobState, "DataReplicationJobState", "csharp");
@@clientName(PrivateEndpointConnectionProxy,
  "DataReplicationPrivateEndpointConnectionProxy",
  "csharp"
);
@@clientName(PrivateEndpointConnectionProxyProperties,
  "DataReplicationPrivateEndpointConnectionProxyProperties",
  "csharp"
);
@@clientName(PrivateEndpointConnectionProxy,
  "DataReplicationPrivateEndpointConnectionProxy",
  "csharp"
);
@@clientName(PrivateEndpointConnection,
  "DataReplicationPrivateEndpointConnection",
  "csharp"
);
@@clientName(PrivateEndpointConnectionResponseProperties,
  "DataReplicationPrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(PrivateEndpointConnectionStatus,
  "DataReplicationPrivateEndpointConnectionStatus",
  "csharp"
);
@@clientName(PrivateLinkResource,
  "DataReplicationPrivateLinkResource",
  "csharp"
);
@@clientName(PrivateLinkResourceProperties,
  "DataReplicationPrivateLinkResourceProperties",
  "csharp"
);
@@clientName(PrivateLinkServiceConnection,
  "DataReplicationPrivateLinkServiceConnection",
  "csharp"
);
@@clientName(PrivateLinkServiceProxy,
  "DataReplicationPrivateLinkServiceProxy",
  "csharp"
);
@@clientName(PrivateLinkServiceConnectionState,
  "DataReplicationPrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(ConnectionDetails,
  "RemotePrivateEndpointConnectionDetails",
  "csharp"
);
@@clientName(DiskControllerInputs,
  "DataReplicationDiskControllerInputs",
  "csharp"
);
@@clientName(HyperVToAzStackHCIProtectedItemModelCustomProperties.lastRecoveryPointReceived,
  "LastRecoveryPointReceivedOn",
  "csharp"
);
@@clientName(VMwareToAzStackHCIProtectedItemModelCustomProperties,
  "VMwareToAzStackHCIProtectedItemCustomProperties",
  "csharp"
);
@@clientName(VMwareToAzStackHCIProtectedItemModelCustomProperties.lastRecoveryPointReceived,
  "LastRecoveryPointReceivedOn",
  "csharp"
);
@@clientName(VMwareToAzStackHCIProtectedItemModelCustomPropertiesUpdate,
  "VMwareToAzStackHCIProtectedItemCustomPropertiesUpdate",
  "csharp"
);
@@clientName(DeploymentPreflightModel, "DeploymentPreflight", "csharp");
@@clientName(HyperVToAzStackHCIPolicyModelCustomProperties,
  "HyperVToAzStackHciPolicyCustomProperties",
  "csharp"
);
@@clientName(HyperVToAzStackHCIProtectedItemModelCustomProperties,
  "HyperVToAzStackHciProtectedItemCustomProperties",
  "csharp"
);
@@clientName(HyperVToAzStackHCIProtectedItemModelCustomPropertiesUpdate,
  "HyperVToAzStackHciProtectedItemCustomPropertiesUpdate",
  "csharp"
);
@@clientName(HyperVToAzStackHCIRecoveryPointModelCustomProperties,
  "HyperVToAzStackHciRecoveryPointCustomProperties",
  "csharp"
);
@@clientName(HyperVToAzStackHCIReplicationExtensionModelCustomProperties,
  "HyperVToAzStackHciReplicationExtensionCustomProperties",
  "csharp"
);
@@clientName(PlannedFailoverModel, "PlannedFailover", "csharp");
@@clientName(PlannedFailoverModelProperties,
  "PlannedFailoverProperties",
  "csharp"
);
@@clientName(PlannedFailoverModelCustomProperties,
  "PlannedFailoverCustomProperties",
  "csharp"
);
@@clientName(HyperVToAzStackHCIPlannedFailoverModelCustomProperties,
  "HyperVToAzStackHciPlannedFailoverCustomProperties",
  "csharp"
);
@@clientName(VMwareToAzStackHCIPlannedFailoverModelCustomProperties,
  "VMwareToAzStackHciPlannedFailoverCustomProperties",
  "csharp"
);
@@alternateType(CheckNameAvailabilityModel.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(DeploymentPreflightResource.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(EventModelProperties.resourceType,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(HealthErrorModel.affectedResourceType,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(PrivateEndpointConnectionProxy.etag, Azure.Core.eTag, "csharp");
@@alternateType(DeploymentPreflightResource.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(IdentityModel.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(AzStackHCIFabricModelCustomProperties.fabricResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AzStackHCIFabricModelCustomProperties.fabricContainerId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(HyperVMigrateFabricModelCustomProperties.fabricContainerId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// java, avoid model name causing file path too long
@@clientName(VMwareToAzStackHCIPlannedFailoverModelCustomProperties,
  "VMwareToAzStackHciPlannedFailoverCustomProps",
  "java"
);
@@clientName(VMwareToAzStackHCIReplicationExtensionModelCustomProperties,
  "VMwareToAzStackHciRepExtnCustomProps",
  "java"
);
@@clientName(HyperVToAzStackHCIRecoveryPointModelCustomProperties,
  "HyperVToAzStackHciRecoveryPointCustomProps",
  "java"
);
@@clientName(HyperVToAzStackHCIPlannedFailoverModelCustomProperties,
  "HyperVToAzStackHciPlannedFailoverCustomProps",
  "java"
);
@@clientName(VMwareToAzStackHCIProtectedItemModelCustomProperties,
  "VMwareToAzStackHciProtectedItemCustomProps",
  "java"
);
@@clientName(VMwareToAzStackHCIProtectedItemModelCustomPropertiesUpdate,
  "VMwareToAzStackHciProtectedItemCustomPropsUpdate",
  "java"
);
@@clientName(HyperVToAzStackHCIProtectedItemModelCustomProperties,
  "HyperVToAzStackHciProtectedItemCustomProps",
  "java"
);
@@clientName(HyperVToAzStackHCIProtectedItemModelCustomPropertiesUpdate,
  "HyperVToAzStackHciProtectedItemCustomPropsUpdate",
  "java"
);
@@clientName(HyperVToAzStackHCIReplicationExtensionModelCustomProperties,
  "HyperVToAzStackHciReplicationExtCustomProps",
  "java"
);
@@clientName(VMwareToAzStackHCIRecoveryPointModelCustomProperties,
  "VMwareToAzStackHCIRecoveryPointCustomProps",
  "java"
);
@@clientName(ReplicationExtensionModel, "ReplicationExtension", "java");
@@clientName(PrivateEndpointConnectionProxies,
  "PrivateEndpointConnProxies",
  "java"
);
@@clientName(JobModelCustomProperties, "JobCustomProperties", "java");

@@clientName(Microsoft.DataReplication,
  "RecoveryServicesDataReplicationMgmtClient",
  "python"
);
@@clientName(Microsoft.DataReplication, "DataReplicationMgmtClient", "java");
