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

namespace Microsoft.CostManagement;
@doc("An individual alert.")
model Alert is ExtensionResource<AlertProperties> {
  @doc("Alert ID")
  @path
  @key("alertId")
  @segment("alerts")
  name: string;
}

@armResourceOperations
interface Alerts {
  @doc("Gets the alert for the scope by alert ID.")
  get is ArmResourceRead<Alert>;

  @doc("Dismisses the specified alert")
  dismiss is ArmCustomPatchSync<Alert, DismissAlertPayload>;

  @doc("Lists the alerts for scope defined.")
  list is ArmResourceListByParent<Alert>;

  @doc("Lists the Alerts for external cloud provider type defined.")
  listExternal is ArmListBySubscription<Alert>;
}

@@projectedName(Alerts.dismiss::parameters.properties, "json", "parameters");
@@extension(Alerts.dismiss::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Alerts.dismiss::parameters.properties,
  "Parameters supplied to the Dismiss Alert operation."
);
