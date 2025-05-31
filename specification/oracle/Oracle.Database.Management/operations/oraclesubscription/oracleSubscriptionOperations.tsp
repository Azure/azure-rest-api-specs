import "../../models/oraclesubscription/oracleSubscription.tsp";
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@armResourceOperations(OracleSubscription<Plan>)
interface OracleSubscriptions
  extends OracleSubscriptionLevelResource<
      OracleSubscription<Plan>,
      OracleSubscriptionProperties
    > {
  @doc("List Cloud Account Details")
  listCloudAccountDetails is ListActions.ArmResourceGetActionAsync<
    OracleSubscription<Plan>,
    CloudAccountDetails
  >;

  @doc("List Saas Subscription Details")
  listSaasSubscriptionDetails is ListActions.ArmResourceGetActionAsync<
    OracleSubscription<Plan>,
    SaasSubscriptionDetails
  >;

  @doc("List Activation Links")
  listActivationLinks is ListActions.ArmResourceGetActionAsync<
    OracleSubscription<Plan>,
    ActivationLinks
  >;

  @added(Versions.v20240601_preview)
  @doc("Add Azure Subscriptions")
  addAzureSubscriptions is ArmResourceActionNoResponseContentAsync<
    OracleSubscription<Plan>,
    AzureSubscriptions
  >;

  /**
   * @dev Update a resource using the asynchronous call pattern.
   * @template Resource The ArmResource to update.
   * @template Properties RP-specific property bag for the resource
   * @template BaseParameters The http parameters that are part of the request
   */
  update is ArmCustomPatchAsync<
    OracleSubscription<Plan>,
    ResourceUpdateModel<
      OracleSubscription<PlanUpdate>,
      OracleSubscriptionProperties
    >,
    DefaultBaseParameters<OracleSubscription<Plan>>
  >;
}
