import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataReplication;

// csharp
@@scope(OperationResults.get, "!csharp");
@@scope(LocationBasedOperationResults.get, "!csharp");

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
@@clientName(ProtectedItemModel, "DataReplicationProtectedItem", "csharp");
@@clientName(ProtectedItemModelProperties,
  "DataReplicationProtectedItemProperties",
  "csharp"
);
@@clientName(ProtectedItemModelProperties.resyncRequired,
  "IsResyncRequired",
  "csharp"
);
@@clientName(ProtectionState, "DataReplicationProtectionState", "csharp");
@@clientName(ProvisioningState, "DataReplicationProvisioningState", "csharp");
@@clientName(RecoveryPointModel, "DataReplicationRecoveryPoint", "csharp");
@@clientName(RecoveryPointModelProperties,
  "DataReplicationRecoveryPointProperties",
  "csharp"
);
@@clientName(RecoveryPointType, "DataReplicationRecoveryPointType", "csharp");
@@clientName(ReplicationExtensionModel, "DataReplicationExtension", "csharp");
@@clientName(ReplicationExtensionModelProperties,
  "DataReplicationExtensionProperties",
  "csharp"
);
@@clientName(ReplicationVaultType, "DataReplicationVaultType", "csharp");
@@clientName(ResynchronizationState,
  "DataReplicationResynchronizationState",
  "csharp"
);
@@clientName(TaskModel, "DataReplicationTask", "csharp");
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
@@clientName(PrivateLinkResource,
  "DataReplicationPrivateLinkResource",
  "csharp"
);
@@clientName(PrivateLinkResourceProperties,
  "DataReplicationPrivateLinkResourceProperties",
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
@@clientName(VMwareToAzStackHCIProtectedItemModelCustomProperties.lastRecoveryPointReceived,
  "LastRecoveryPointReceivedOn",
  "csharp"
);
@@clientName(DeploymentPreflightModel, "DeploymentPreflight", "csharp");
@@clientName(HyperVToAzStackHCIPlannedFailoverModelCustomProperties,
  "HyperVToAzStackHciPlannedFailoverCustomProperties",
  "csharp"
);
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
