import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager.CommonTypes;
using Microsoft.DocumentDB;

@@clientName(Microsoft.DocumentDB, "MongoClusterMgmtClient", "python");
@@clientName(Microsoft.DocumentDB,
  "MongoClusterManagementClient",
  "javascript,java"
);
@@access(Operations.list, Access.internal, "csharp");
@@clientName(CheckNameAvailabilityResponse,
  "MongoClusterNameAvailabilityResult",
  "csharp"
);
@@clientName(CheckNameAvailabilityResponse.nameAvailable,
  "isNameAvailable",
  "csharp"
);
@@clientName(MongoClusterRestoreParameters,
  "MongoClusterRestoreContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityRequest,
  "MongoClusterNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityRequest.type, "ResourceType", "csharp");
@@clientName(MongoClusters.checkNameAvailability,
  "CheckMongoClusterNameAvailability",
  "csharp"
);
@@clientName(MongoClusterReplicaParameters,
  "MongoClusterReplicaContent",
  "csharp"
);
@@clientName(ConnectionString, "MongoClusterConnectionString", "csharp");
@@clientName(CreateMode, "MongoClusterCreateMode", "csharp");
@@clientName(NodeKind, "MongoClusterNodeKind", "csharp");
@@clientName(PreviewFeature, "MongoClusterPreviewFeature", "csharp");
@@clientName(PromoteMode, "MongoClusterPromoteMode", "csharp");
@@clientName(PromoteOption, "MongoClusterPromoteOption", "csharp");
@@clientName(PromoteReplicaRequest, "PromoteReplicaContent", "csharp");
@@clientName(ProvisioningState, "MongoClusterProvisioningState", "csharp");
@@clientName(Replica, "MongoClusterReplica", "csharp");
@@clientName(ReplicationProperties,
  "MongoClusterReplicationProperties",
  "csharp"
);
@@clientName(ReplicationRole, "MongoClusterReplicationRole", "csharp");
@@clientName(ReplicationState, "MongoClusterReplicationState", "csharp");
@@clientName(AdministratorProperties,
  "MongoClusterAdministratorProperties",
  "csharp"
);
@@clientName(CheckNameAvailabilityReason,
  "MongoClusterNameUnavailableReason",
  "csharp"
);
@@clientName(Microsoft.DocumentDB.PublicNetworkAccess,
  "MongoClusterPublicNetworkAccess",
  "csharp"
);
@@clientName(FirewallRule, "MongoClusterFirewallRule", "csharp");
@@clientName(FirewallRuleProperties,
  "MongoClusterFirewallRuleProperties",
  "csharp"
);
@@clientName(FirewallRuleProperties.startIpAddress, "startIPAddress");
@@clientName(FirewallRuleProperties.endIpAddress, "endIPAddress");
@@clientName(PrivateEndpointConnectionResource,
  "MongoClusterPrivateEndpointConnectionResource",
  "csharp"
);
@@clientName(PrivateEndpointConnectionProperties,
  "MongoClusterPrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(Microsoft.DocumentDB.PrivateLinkResource,
  "MongoClusterPrivateLinkResourceData",
  "csharp"
);
@@clientName(PrivateLinks.listByMongoCluster, "GetPrivateLinks", "csharp");
@@clientName(Replicas.listByParent, "GetReplicasByParent", "csharp");
@@clientName(ListConnectionStringsResult,
  "MongoClusterConnectionStringsResult",
  "csharp"
);
@@clientName(User, "MongoClusterUser", "csharp");
@@clientName(UserProperties, "MongoClusterUserProperties", "csharp");
@@clientName(AuthenticationMode, "MongoClusterAuthenticationMode", "csharp");
@@clientName(CustomerManagedKeyEncryptionProperties,
  "MongoClusterCmkEncryptionProperties",
  "csharp"
);
@@clientName(DataApiMode, "MongoClusterDataApiMode", "csharp");
@@clientName(DatabaseRole, "MongoClusterDatabaseRole", "csharp");
@@clientName(EntraIdentityProvider,
  "MongoClusterEntraIdentityProvider",
  "csharp"
);
@@clientName(EntraIdentityProviderProperties,
  "MongoClusterEntraIdentityProviderProperties",
  "csharp"
);
@@clientName(EntraPrincipalType, "MongoClusterEntraPrincipalType", "csharp");
@@clientName(IdentityProvider, "MongoClusterIdentityProvider", "csharp");
@@clientName(Microsoft.DocumentDB.KeyEncryptionKeyIdentity,
  "MongoClusterKeyEncryptionKeyIdentity",
  "csharp"
);
@@clientName(Microsoft.DocumentDB.KeyEncryptionKeyIdentityType,
  "MongoClusterKeyEncryptionKeyIdentityType",
  "csharp"
);
@@clientName(StorageProperties, "MongoClusterStorageProperties", "csharp");
@@clientName(StorageType, "MongoClusterStorageType", "csharp");
@@clientName(UserRole, "MongoClusterUserRole", "csharp");

// we add this model in this namespace in order to replace some models with this model via alternateType decorator
namespace Azure.ResourceManager.Models {
  /** represents a reference to an existing resource by its id */
  model SubResource {
    /** the id */
    id?: Azure.Core.armResourceIdentifier;
  }
}

@@alternateType(PrivateEndpointConnectionProperties.privateEndpoint,
  Azure.ResourceManager.Models.SubResource,
  "csharp"
);
