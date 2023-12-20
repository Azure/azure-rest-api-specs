import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("Time Zone.")
@locationResource
model SqlTimeZone is ProxyResource<TimeZoneProperties> {
  @path
  @key("timeZoneId")
  @segment("timeZones")
  name: string;
}

@armResourceOperations
interface SqlTimeZones {
  @doc("Gets a managed instance time zone.")
  get is ArmResourceRead<SqlTimeZone>;
  @doc("Gets a list of managed instance time zones by location.")
  listByLocation is ArmResourceListByParent<SqlTimeZone>;
}
