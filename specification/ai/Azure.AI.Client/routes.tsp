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

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to define route."
@doc("List secrets for a given connection.")
@route("connections/{connectionNameInUrl}/listsecrets")
@post
op listSecrets is Azure.Core.Foundations.Operation<
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
  ListSecretsResponse
>;
