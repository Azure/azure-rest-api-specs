import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ResourceManager.CommonTypes;
using Azure.ClientGenerator.Core;

namespace Microsoft.Edge;

@doc("Remove Version response")
@clientName("RemoveVersionResult", "csharp")
model RemoveVersionResponse {
  @doc("Status for remove version response")
  status: string;
}
