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

namespace Azure.Ai.Project;

interface Connections {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to define route."
  @doc("List secrets for a given connection.")
  @route("connections/{connectionName}/listsecrets")
  @post
  listSecrets is Azure.Core.Foundations.Operation<
    {
      @doc("Connection Name")
      connectionName: string;

      @doc("The ID of the target subscription.")
      subscriptionId: string;

      @doc("The name of the Resource Group.")
      resourceGroupName: string;

      @doc("The name of the AzureML workspace or AI project.")
      workspaceName: string;

      // How can I take the already existing apiVersion value defined in Azure.Core.Foundations.Operation as query parameter?
      @doc("The api version.")
      @key("api-version")
      apiVersionInBody: "2024-07-01-preview";
    },
    ListSecretsResponse
  >;
}
