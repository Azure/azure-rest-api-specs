import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Projects.Connections;

/*
 See https://learn.microsoft.com/en-us/rest/api/azureml/workspaces/get?view=rest-azureml-2024-07-01-preview
*/
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Gets the properties of the specified machine learning workspace.")
@get
op getWorkspace is Azure.Core.Foundations.Operation<{}, GetWorkspaceResponse>;

/*
 See https://learn.microsoft.com/rest/api/azureml/workspace-connections/list?view=rest-azureml-2024-07-01-preview
*/
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
@doc("List the details of all the connections (not including their credentials)")
@route("connections")
@get
op listConnections is Azure.Core.Foundations.Operation<
  {
    @query
    @doc("Category of the workspace connection.")
    category?: ConnectionType;

    @query
    @doc("Indicates whether to list datastores. Service default: do not list datastores.")
    includeAll?: boolean;

    @query
    @doc("Target of the workspace connection.")
    target?: string;
  },
  ListConnectionsResponse
>;

/*
 See https://learn.microsoft.com/en-us/rest/api/azureml/workspace-connections/get?view=rest-azureml-2024-07-01-preview
*/
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get the details of a single connection, without credentials.")
@route("connections/{connectionName}")
@get
op getConnection is Azure.Core.Foundations.Operation<
  {
    @doc("Connection Name")
    connectionName: string;
  },
  GetConnectionResponse
>;

/*
 See https://learn.microsoft.com/rest/api/azureml/workspace-connections/list-secrets?view=rest-azureml-2024-07-01-preview
*/
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get the details of a single connection, including credentials (if available).")
@route("connections/{connectionName}/listsecrets")
@post
op getConnectionWithSecrets is Azure.Core.Foundations.Operation<
  {
    @doc("Connection Name")
    connectionName: string;

    @doc("The body is ignored. TODO: Can we remove this?")
    ignored: string;
  },
  GetConnectionResponse
>;
