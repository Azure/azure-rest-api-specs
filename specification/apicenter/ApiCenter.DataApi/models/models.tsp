import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "../models/api.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using ApiCenter.DataApi;

@versioned(ApiCenter.DataApi.Versions)
@doc("Data API introduces endpoints to manage your API Center resources.")
namespace ApiCenter.DataApi;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

@doc("API versions")
enum Versions {
  @doc("Preview release version 2024-02-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_02_01_preview: "2024-02-01-preview",
}
