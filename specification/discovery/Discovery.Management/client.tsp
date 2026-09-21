import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "./tool.tsp";
import "../Discovery.Management.Shared/all.tsp";
import "../Discovery.Bookshelf.Management/all.tsp";
import "../Discovery.Supercomputer.Management/all.tsp";
import "../Discovery.Workspace.Management/all.tsp";
import "@typespec/versioning";

using Microsoft.Discovery;
using Microsoft.Discovery.Shared;

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

// C# names use the service prefix to avoid collisions with other management libraries.
@@clientName(Bookshelf, "DiscoveryBookshelf", "csharp");
@@clientName(ChatModelDeployment, "DiscoveryChatModelDeployment", "csharp");
@@clientName(NodePool, "DiscoveryNodePool", "csharp");
@@clientName(Project, "DiscoveryProject", "csharp");
@@clientName(StorageAsset, "DiscoveryStorageAsset", "csharp");
@@clientName(StorageContainer, "DiscoveryStorageContainer", "csharp");
@@clientName(Supercomputer, "DiscoverySupercomputer", "csharp");
@@clientName(Tool, "DiscoveryTool", "csharp");
@@clientName(Workspace, "DiscoveryWorkspace", "csharp");

@@clientName(
  ChatModelDeploymentProperties,
  "DiscoveryChatModelDeploymentProperties",
  "csharp"
);
@@clientName(CustomerManagedKeys, "DiscoveryCustomerManagedKeys", "csharp");
@@clientName(KeyVaultProperties, "DiscoveryKeyVaultProperties", "csharp");
@@clientName(Identity, "DiscoveryManagedIdentityReference", "csharp");
@@clientName(
  Azure.ResourceManager.CommonTypes.MoboBrokerResource,
  "DiscoveryMoboBrokerResource",
  "csharp"
);
@@clientName(NetworkEgressType, "DiscoveryNetworkEgressType", "csharp");
@@clientName(NodePoolProperties, "DiscoveryNodePoolProperties", "csharp");
@@clientName(
  Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProperties,
  "DiscoveryPrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(ProjectProperties, "DiscoveryProjectProperties", "csharp");
@@clientName(ProvisioningState, "DiscoveryProvisioningState", "csharp");
@@clientName(PublicNetworkAccess, "DiscoveryPublicNetworkAccess", "csharp");
@@clientName(ScaleSetPriority, "DiscoveryScaleSetPriority", "csharp");
@@clientName(
  StorageAssetProperties,
  "DiscoveryStorageAssetProperties",
  "csharp"
);
@@clientName(
  StorageContainerProperties,
  "DiscoveryStorageContainerProperties",
  "csharp"
);
@@clientName(StorageStore, "DiscoveryStorageStore", "csharp");
@@clientName(
  SupercomputerIdentities,
  "DiscoverySupercomputerIdentities",
  "csharp"
);
@@clientName(
  SupercomputerProperties,
  "DiscoverySupercomputerProperties",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.SystemAssignedServiceIdentity,
  "DiscoverySystemAssignedServiceIdentity",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.SystemAssignedServiceIdentityType,
  "DiscoverySystemAssignedServiceIdentityType",
  "csharp"
);
@@clientName(SystemSku, "DiscoverySystemSku", "csharp");
@@clientName(ToolProperties, "DiscoveryToolProperties", "csharp");
@@clientName(VmSize, "DiscoveryVmSize", "csharp");
@@clientName(WorkspaceProperties, "DiscoveryWorkspaceProperties", "csharp");
@@clientName(BlobStorageMountProtocol.NFS, "Nfs", "csharp");
@@clientName(NetAppMountProtocol.NFS, "Nfs", "csharp");

// Rename DiscoveryStorage to ManagedStorage for Go SDK to avoid collision with Storage type
// after the Go emitter removes the "Discovery" prefix
@@clientName(
  Microsoft.Discovery.DiscoveryStorage,
  "DiscoveryManagedStorage",
  "go"
);

@@clientName(Microsoft.Discovery, "DiscoveryMgmtClient", "python");
