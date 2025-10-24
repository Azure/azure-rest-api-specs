import "@azure-tools/typespec-client-generator-core";
import "./privateEndpointConnection.tsp";
import "./experimentExecution.tsp";
import "./privateAccess.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Chaos;

// PrivateEndpointConnections interface operations with PrivateAccesses_ prefix
@@clientLocation(PrivateEndpointConnections.getAPrivateEndpointConnection,
  PrivateAccesses,
  "!csharp"
);
@@clientLocation(PrivateEndpointConnections.deleteAPrivateEndpointConnection,
  PrivateAccesses,
  "!csharp"
);
@@clientLocation(PrivateEndpointConnections.listPrivateEndpointConnections,
  PrivateAccesses,
  "!csharp"
);

// ExperimentExecutions interface operations with Experiments_ prefix
@@clientLocation(ExperimentExecutions.getExecution, Experiments, "!csharp");
@@clientLocation(ExperimentExecutions.listAllExecutions,
  Experiments,
  "!csharp"
);
@@clientLocation(ExperimentExecutions.getExecutionDetails,
  Experiments,
  "!csharp"
);

@@clientName(Operations.list, "ListAll", "autorest");
@@clientName(ExperimentExecutions.getExecutionDetails, "ExecutionDetails");
@@clientName(PrivateAccesses.privateLinkResources, "GetPrivateLinkResources");
