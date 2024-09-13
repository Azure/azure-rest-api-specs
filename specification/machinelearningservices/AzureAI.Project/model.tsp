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
  authType: string;

  @doc("to do")
  credentials: ListSecretsPropertiesCredentials;
}

@doc("to do")
model ListSecretsPropertiesCredentials {
  @doc("to do")
  key: string;
}

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias ResourceCreatedResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<201> &
  T;

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias ResourceCreatedOrOkResponse<T extends TypeSpec.Reflection.Model> = ResourceCreatedResponse<T> | (TypeSpec.Http.Response<200> &
  T);
