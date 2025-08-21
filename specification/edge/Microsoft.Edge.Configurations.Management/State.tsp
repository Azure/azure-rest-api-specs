import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@added(Versions.v2025_08_01)
@doc("Configuration State Enums")
union ConfigurationState {
  @doc("Configuration Completed")
  ConfigurationCompleted: "ConfigurationCompleted",

  @doc("Configuration Completed")
  ConfigurationPending: "ConfigurationPending",

  string,
}
