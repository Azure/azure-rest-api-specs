import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CostManagement;
@doc("An individual alert.")
model CostManagementAlert is ExtensionResource<AlertProperties> {
  @doc("Alert ID")
  @path
  @key("alertId")
  @segment("alerts")
  name: string;
}

@armResourceOperations
interface CostManagementAlerts {
  @doc("Gets the alert for the scope by alert ID.")
  get is ArmResourceRead<CostManagementAlert>;
  @doc("Dismisses the specified alert")
  dismiss is ArmResourcePatchSync<CostManagementAlert, AlertProperties>;
  @doc("Lists the alerts for scope defined.")
  list is ArmResourceListByParent<CostManagementAlert>;
  @doc("Lists the Alerts for external cloud provider type defined.")
  listExternal is ArmListBySubscription<CostManagementAlert>;
}
