import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SecurityCenterLocation.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Security alert")
@parentResource(SecurityCenterLocation)
model SubscriptionSecurityAlert is ProxyResource<AlertProperties> {
  @doc("Name of the alert object")
  @path
  @key("alertName")
  @segment("alerts")
  name: string;
}

@armResourceOperations
interface SubscriptionSecurityAlerts {
  @doc("Get an alert that is associated with a subscription")
  getSubscriptionLevel is ArmResourceRead<SubscriptionSecurityAlert>;
  @doc("List all the alerts that are associated with the subscription that are stored in a specific location")
  listSubscriptionLevelByRegion is ArmResourceListByParent<SubscriptionSecurityAlert>;
  @doc("Update the alert's state")
  updateSubscriptionLevelStateToDismiss is ArmResourceActionNoContentSync<
    SubscriptionSecurityAlert,
    void
  >;
  @doc("Update the alert's state")
  updateSubscriptionLevelStateToResolve is ArmResourceActionNoContentSync<
    SubscriptionSecurityAlert,
    void
  >;
  @doc("Update the alert's state")
  updateSubscriptionLevelStateToActivate is ArmResourceActionNoContentSync<
    SubscriptionSecurityAlert,
    void
  >;
  @doc("Update the alert's state")
  updateSubscriptionLevelStateToInProgress is ArmResourceActionNoContentSync<
    SubscriptionSecurityAlert,
    void
  >;
}
