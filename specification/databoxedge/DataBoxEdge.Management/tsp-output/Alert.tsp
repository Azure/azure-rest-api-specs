import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
@doc("Alert on the data box edge/gateway device.")
@parentResource(DataBoxEdgeDevice)
model Alert is ProxyResource<AlertProperties> {
  @doc("The alert name.")
  @path
  @key("name")
  @segment("alerts")
  name: string;
}

@armResourceOperations
interface Alerts {
  @doc("Gets an alert by name.")
  get is ArmResourceRead<Alert>;

  @doc("Gets all the alerts for a Data Box Edge/Data Box Gateway device.")
  listByDataBoxEdgeDevice is ArmResourceListByParent<Alert>;
}
