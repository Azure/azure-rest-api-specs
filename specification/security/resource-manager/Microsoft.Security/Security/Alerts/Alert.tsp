import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Microsoft.Security;
/**
 * Security alert
 */
@subscriptionResource
model Alert is Azure.ResourceManager.ProxyResource<AlertProperties> {
  ...ResourceNameParameter<
    Resource = Alert,
    KeyName = "alertName",
    SegmentName = "alerts",
    NamePattern = ""
  >;
}

alias AlertOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";

    /** The location where ASC stores the data of the subscription. can be retrieved from Get locations */
    @path
    @segment("locations")
    @key
    ascLocation: string;
  },
  {
    /** Name of the alert object */
    @path
    @segment("alerts")
    @key
    alertName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface Alerts {
  /**
   * Get an alert that is associated with a subscription
   */
  @tag("Alerts")
  getSubscriptionLevel is AlertOps.Read<Alert, OverrideErrorType = CloudError>;

  /**
   * List all the alerts that are associated with the subscription that are stored in a specific location
   */
  @tag("Alerts")
  listSubscriptionLevelByRegion is AlertOps.List<
    Alert,
    Response = ArmResponse<AlertList>,
    OverrideErrorType = CloudError
  >;

  /**
   * Update the alert's state
   */
  @action("dismiss")
  @tag("Alerts")
  updateSubscriptionLevelStateToDismiss is AlertOps.ActionSync<
    Alert,
    void,
    NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Update the alert's state
   */
  @action("resolve")
  @tag("Alerts")
  updateSubscriptionLevelStateToResolve is AlertOps.ActionSync<
    Alert,
    void,
    NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Update the alert's state
   */
  @action("activate")
  @tag("Alerts")
  updateSubscriptionLevelStateToActivate is AlertOps.ActionSync<
    Alert,
    void,
    NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Update the alert's state
   */
  @action("inProgress")
  @tag("Alerts")
  updateSubscriptionLevelStateToInProgress is AlertOps.ActionSync<
    Alert,
    void,
    NoContentResponse,
    OverrideErrorType = CloudError
  >;
}
alias AlertOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The location where ASC stores the data of the subscription. can be retrieved from Get locations */
    @path
    @segment("locations")
    @key
    ascLocation: string;
  },
  {
    /** Name of the alert object */
    @path
    @segment("alerts")
    @key
    alertName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface AlertOperationGroup {
  /**
   * Get an alert that is associated a resource group or a resource in a resource group
   */
  @tag("Alerts")
  getResourceGroupLevel is AlertOperationGroupOps.Read<
    Alert,
    OverrideErrorType = CloudError
  >;

  /**
   * List all the alerts that are associated with the resource group that are stored in a specific location
   */
  @tag("Alerts")
  listResourceGroupLevelByRegion is AlertOperationGroupOps.List<
    Alert,
    Response = ArmResponse<AlertList>
  >;

  /**
   * Update the alert's state
   */
  @action("resolve")
  @tag("Alerts")
  updateResourceGroupLevelStateToResolve is AlertOperationGroupOps.ActionSync<
    Alert,
    void,
    NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Update the alert's state
   */
  @action("dismiss")
  @tag("Alerts")
  updateResourceGroupLevelStateToDismiss is AlertOperationGroupOps.ActionSync<
    Alert,
    void,
    NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Update the alert's state
   */
  @action("activate")
  @tag("Alerts")
  updateResourceGroupLevelStateToActivate is AlertOperationGroupOps.ActionSync<
    Alert,
    void,
    NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Update the alert's state
   */
  @action("inProgress")
  @tag("Alerts")
  updateResourceGroupLevelStateToInProgress is AlertOperationGroupOps.ActionSync<
    Alert,
    void,
    NoContentResponse,
    OverrideErrorType = CloudError
  >;
}

@@doc(Alert.name, "Name of the alert object");
@@doc(Alert.properties, "describes security alert properties.");





