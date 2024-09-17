import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.Ai.Project;

@doc("to do")
model ListSecretsResponse {
  @doc("to do")
  properties: ListSecretsProperties;
}

@doc("to do")
model ListSecretsProperties {
  @doc("to do")
  authType: ConnectionAuthType;

  @doc("to do")
  credentials: ListSecretsPropertiesCredentials;

  @doc("to do")
  target: string;
}

@doc("to do")
model ListSecretsPropertiesCredentials {
  @doc("to do")
  key: string;
}

#suppress "@azure-tools/typespec-azure-core/no-enum" "Azure services should not use the enum keyword. Extensible enums should be defined as unions with `string` as an accepted variant"
@doc("to do")
enum ConnectionAuthType {
  @doc("to do")
  apiKey: "ApiKey",

  @doc("to do")
  aad: "AAD",
}
