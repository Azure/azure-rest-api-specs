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

@doc("Base Credential definition")
model BaseCredential {
  @doc("Credential name")
  @visibility("read")
  name: string;
}

@doc("ApiKey Credential definition")
model ApiKeyCredential extends BaseCredential {
  @doc("API Key")
  @visibility("read")
  apiKey: string;
}

@doc("AAD Credential definition")
model AADCredential extends BaseCredential {
  // No properties need to be stored for this case
}

@doc("SAS Credential definition")
model SASCredential extends BaseCredential {
  @doc("SAS Token")
  @visibility("read")
  sasToken: string;
}
