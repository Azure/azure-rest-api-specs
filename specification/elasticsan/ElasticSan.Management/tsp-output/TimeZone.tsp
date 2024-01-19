import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("Time Zone.")
@locationResource
model TimeZone is ProxyResource<TimeZoneProperties> {
  @path
  @key("timeZoneId")
  @segment("timeZones")
  name: string;
}

@armResourceOperations
interface TimeZones {
  @doc("Gets a managed instance time zone.")
  get is ArmResourceRead<TimeZone>;

  @doc("Gets a list of managed instance time zones by location.")
  listByLocation is ArmResourceListByParent<TimeZone>;
}
