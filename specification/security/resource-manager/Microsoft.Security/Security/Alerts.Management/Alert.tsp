import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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

alias AlertOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
  {},
  {
    /** Name of the alert object */
    @path
    @segment("alerts")
    @key
    alertName: string;
  }
>;

@armResourceOperations
interface Alerts {
  /**
   * Get an alert that is associated with a subscription
   */
  getSubscriptionLevel is AlertOps.Read<Alert>;

  /**
   * List all the alerts that are associated with the subscription that are stored in a specific location
   */
  listSubscriptionLevelByRegion is AlertOps.List<
    Alert,
    Response = ArmResponse<AlertList>
  >;

  /**
   * Update the alert's state
   */
  @action("dismiss")
  updateSubscriptionLevelStateToDismiss is AlertOps.ActionSync<
    Alert,
    void,
    NoContentResponse
  >;

  /**
   * Update the alert's state
   */
  @action("resolve")
  updateSubscriptionLevelStateToResolve is AlertOps.ActionSync<
    Alert,
    void,
    NoContentResponse
  >;

  /**
   * Update the alert's state
   */
  @action("activate")
  updateSubscriptionLevelStateToActivate is AlertOps.ActionSync<
    Alert,
    void,
    NoContentResponse
  >;

  /**
   * Update the alert's state
   */
  @action("inProgress")
  updateSubscriptionLevelStateToInProgress is AlertOps.ActionSync<
    Alert,
    void,
    NoContentResponse
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

@armResourceOperations
interface AlertOperationGroup {
  /**
   * Get an alert that is associated a resource group or a resource in a resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Alerts_GetResourceGroupLevel")
  getResourceGroupLevel is AlertOperationGroupOps.Read<Alert>;

  /**
   * List all the alerts that are associated with the resource group that are stored in a specific location
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Alerts_ListResourceGroupLevelByRegion")
  listResourceGroupLevelByRegion is AlertOperationGroupOps.List<
    Alert,
    Response = ArmResponse<AlertList>
  >;

  /**
   * Update the alert's state
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Alerts_UpdateResourceGroupLevelStateToResolve")
  @action("resolve")
  updateResourceGroupLevelStateToResolve is AlertOperationGroupOps.ActionSync<
    Alert,
    void,
    NoContentResponse
  >;

  /**
   * Update the alert's state
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Alerts_UpdateResourceGroupLevelStateToDismiss")
  @action("dismiss")
  updateResourceGroupLevelStateToDismiss is AlertOperationGroupOps.ActionSync<
    Alert,
    void,
    NoContentResponse
  >;

  /**
   * Update the alert's state
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Alerts_UpdateResourceGroupLevelStateToActivate")
  @action("activate")
  updateResourceGroupLevelStateToActivate is AlertOperationGroupOps.ActionSync<
    Alert,
    void,
    NoContentResponse
  >;

  /**
   * Update the alert's state
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Alerts_UpdateResourceGroupLevelStateToInProgress")
  @action("inProgress")
  updateResourceGroupLevelStateToInProgress is AlertOperationGroupOps.ActionSync<
    Alert,
    void,
    NoContentResponse
  >;
}

@@doc(Alert.name, "Name of the alert object");
@@doc(Alert.properties, "describes security alert properties.");
