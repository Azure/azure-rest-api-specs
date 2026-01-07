import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./privateEndpointConnections.tsp";
import "./privateLinkResources.tsp";
import "./privateLinkServicesForFabric.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

/** Microsoft.Fabric Management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.Fabric Management Service" })
@versioned(Microsoft.Fabric.Versions)
namespace Microsoft.Fabric;

/** The available API versions. */
enum Versions {
  @doc("API Version 2024-06-01")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01: "2024-06-01",
}
