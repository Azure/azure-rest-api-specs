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

namespace Azure.Ai.Runtime;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
@doc("To do")
@route("connections/{connectionName}/listsecrets")
@post
@added(Versions.v2024_07_01_preview)
op listSecrets(
  @doc("Connection Name")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
  @maxLength(254)
  @path
  connectionName: string,
): ListSecretsResponse;
