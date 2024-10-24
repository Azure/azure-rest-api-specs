import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.MachineLearningServices;

@doc("The different Credential types")
union CredentialType {
  string,
  ApiKey: "ApiKey",
  AAD: "AAD",
  SAS: "SAS",
}

@doc("Base Credential definition")
@discriminator("type")
model BaseCredential {
  @doc("Credential name")
  @visibility("read")
  name: string;

  type: CredentialType;
}

@doc("ApiKey Credential definition")
model ApiKeyCredential extends BaseCredential {
  @doc("API Key")
  @visibility("read")
  apiKey: string;

  type: CredentialType.ApiKey;
}

@doc("AAD Credential definition")
model AadCredential extends BaseCredential {
  // No properties need to be stored for this case
  type: CredentialType.AAD;
}

@doc("SAS Credential definition")
model SasCredential extends BaseCredential {
  @doc("SAS Token")
  @visibility("read")
  sasToken: string;

  type: CredentialType.SAS;
}
