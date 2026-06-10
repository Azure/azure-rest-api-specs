import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.MachineLearningServices;

@@clientLocation(BatchJobResources.get, "BatchJobDeployment");
@@clientLocation(BatchJobResources.list, "BatchJobDeployment");

@@clientLocation(BatchJobDeploymentOperationGroup.create, "BatchJobDeployment");

@@clientLocation(BatchJobEndpointOperationGroup.create, BatchJobEndpoint);
