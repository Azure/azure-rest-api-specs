import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/logicaldatacenter.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.Frontdoor management service" })
@versioned(Microsoft.Frontdoor.Versions)
namespace Microsoft.Frontdoor;

@added(Versions.v2025_08_01_preview)
@doc("Azure Frontdoor Logical Datacenter resource")
@parentResource(TenantLocationResource)
model LogicalDatacenter is ProxyResource<LogicalDatacenterProperties> {
  @pattern("[a-zA-Z0-9]+[-_]*")
  @key("logicalDatacenterName")
  @segment("logicalDatacenters")
  @doc("Datacenter")
  @path
  name: string;
}

@added(Versions.v2025_08_01_preview)
@armResourceOperations
interface LogicalDatacenters {
  get is ArmResourceRead<LogicalDatacenter>;
  listByTenant is ArmResourceListByParent<LogicalDatacenter>;
}
