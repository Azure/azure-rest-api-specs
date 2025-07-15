import "@azure-tools/typespec-client-generator-core";
import "./privateEndpointConnection.tsp";
import "./experimentExecution.tsp";
import "./privateAccess.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Chaos;

// PrivateEndpointConnections interface operations with PrivateAccesses_ prefix
@@clientLocation(PrivateEndpointConnections.getAPrivateEndpointConnection,
  PrivateAccesses
);
@@clientLocation(PrivateEndpointConnections.deleteAPrivateEndpointConnection,
  PrivateAccesses
);
@@clientLocation(PrivateEndpointConnections.listPrivateEndpointConnections,
  PrivateAccesses
);

// ExperimentExecutions interface operations with Experiments_ prefix
@@clientLocation(ExperimentExecutions.getExecution, Experiments);
@@clientLocation(ExperimentExecutions.listAllExecutions, Experiments);
@@clientLocation(ExperimentExecutions.getExecutionDetails, Experiments);

@@clientName(Operations.list, "ListAll", "autorest");
@@clientName(ExperimentExecutions.getExecutionDetails, "ExecutionDetails");
@@clientName(PrivateAccesses.privateLinkResources, "GetPrivateLinkResources");
