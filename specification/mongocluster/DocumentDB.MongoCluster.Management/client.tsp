import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager.CommonTypes;
using Microsoft.DocumentDB;

@@clientName(Microsoft.DocumentDB, "MongoClusterMgmtClient", "python");
@@access(Operations.list, Access.internal, "csharp");
@@clientName(CheckNameAvailabilityResponse,
  "MogoClusterNameAvailabilityResult",
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
