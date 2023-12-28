import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AscLocation.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Security alert")
@parentResource(AscLocation)
model Alert is ProxyResource<AlertProperties> {
  @doc("Name of the alert object")
  @key("alertName")
  @segment("alerts")
  name: string;
}

@armResourceOperations
interface Alerts {
  @doc("Get an alert that is associated with a subscription")
  getSubscriptionLevel is ArmResourceRead<Alert>;
  @doc("List all the alerts that are associated with the subscription that are stored in a specific location")
  listSubscriptionLevelByRegion is ArmResourceListByParent<Alert>;
  @doc("Update the alert's state")
  updateSubscriptionLevelStateToDismiss is ArmResourceActionNoContentSync<
    Alert,
    void
  >;
  @doc("Update the alert's state")
  updateSubscriptionLevelStateToResolve is ArmResourceActionNoContentSync<
    Alert,
    void
  >;
  @doc("Update the alert's state")
  updateSubscriptionLevelStateToActivate is ArmResourceActionNoContentSync<
    Alert,
    void
  >;
  @doc("Update the alert's state")
  updateSubscriptionLevelStateToInProgress is ArmResourceActionNoContentSync<
    Alert,
    void
  >;
}
