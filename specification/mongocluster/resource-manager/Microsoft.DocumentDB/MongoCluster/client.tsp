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
@@clientName(PrivateEndpointConnectionResource,
  "MongoClusterPrivateEndpointConnectionResource",
  "csharp"
);
@@clientName(PrivateEndpointConnectionProperties,
  "MongoClusterPrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(ListConnectionStringsResult,
  "MongoClusterConnectionStringsResult",
  "csharp"
);
