import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";
import "./main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Client.Connections;

/*
 See https://learn.microsoft.com/rest/api/azureml/workspace-connections/list-secrets?view=rest-azureml-2024-04-01
*/
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("List the details of all the connections (not including their credentials)")
@route("connections")
@get
op getConnections is Azure.Core.Foundations.Operation<
  {},
  ConnectionDetailsList
>;

/*
 See https://learn.microsoft.com/rest/api/azureml/workspace-connections/list-secrets?view=rest-azureml-2024-04-01
*/
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get the details of a single connection, includeing credential (if avaialble).")
@route("connections/{connectionNameInUrl}/listsecrets")
@post
op getConnectionSecrets is Azure.Core.Foundations.Operation<
  {
    @doc("Connection Name")
    connectionNameInUrl: string;

    @doc("Connection Name")
    connectionName: string;

    @doc("The ID of the target subscription.")
    subscriptionId: string;

    @doc("The name of the Resource Group.")
    resourceGroupName: string;

    @doc("The name of the workspace (Azire AI Studio hub).")
    workspaceName: string;

    @doc("The api version.")
    apiVersionInBody: string;
  },
  ConnectionDetails
>;
