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
  @doc("Get next Index version as defined by the server. The server keeps track of all versions that are string-representations of integers. If one exists, the nextVersion will be a string representation of the highest integer value + 1. Otherwise, the nextVersion will default to '1'.")
  @route("connections/{connectionName}/listsecrets")
  @post
  listSecrets is Azure.Core.Foundations.Operation<
    {
      @doc("Connection Name")
      @path
      connectionName: string;
    },
    ListSecretsResponse
  >;
}
