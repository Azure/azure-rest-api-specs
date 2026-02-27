import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/compositeWebEndpoints.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Inventory;

@added(Versions.v2025_03_01_preview)
@tenantResource
@parentResource(TenantLocationResource)
model CompositeWebEndpointsResource
  is ProxyResource<CompositeWebEndpointsProperties> {
  @pattern("[a-zA-Z0-9]+-[a-zA-Z0-9.:]+-[a-zA-Z0-9]")
  @key("webEndpointKey")
  @segment("compositeWebEndpoints")
  @doc("Web Endpoint")
  @path
  name: string;
}

@added(Versions.v2025_03_01_preview)
@armResourceOperations
interface CompositeWebEndpoints {
  get is ArmResourceRead<CompositeWebEndpointsResource>;
  list is ArmResourceListByParent<CompositeWebEndpointsResource>;
}
