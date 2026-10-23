import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureDataTransfer;

@@clientLocation(Connections.list, "ListPendingConnections");
@@clientLocation(Connections.listPendingFlowsList, "ListPendingFlows");
@@clientName(Connections.listPendingFlowsList, "List");

@@clientLocation(Pipelines.list, "ListFlowsByPipeline");
@@clientLocation(Pipelines.listSchemasList, "ListSchemas");
@@clientName(Pipelines.listSchemasList, "List");
