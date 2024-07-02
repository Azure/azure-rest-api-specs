import "../../../models/oraclesubscription/oracleSubscription.tsp";

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
  @example(
    "./examples/oracleSubscriptions_listCloudAccountDetails.json",
    "List Cloud Account details for the Oracle Subscription"
  )
  listCloudAccountDetails is ListActions.ArmResourceGetActionAsync<
    OracleSubscription<Plan>,
    CloudAccountDetails
  >;

  @doc("List Saas Subscription Details")
  @example(
    "./examples/oracleSubscriptions_listSaasSubscriptionDetails.json",
    "List Saas Subscription details for the Oracle Subscription"
  )
  listSaasSubscriptionDetails is ListActions.ArmResourceGetActionAsync<
    OracleSubscription<Plan>,
    SaasSubscriptionDetails
  >;

  @doc("List Activation Links")
  @example(
    "./examples/oracleSubscriptions_listActivationLinks.json",
    "List Activation Links for the Oracle Subscription"
  )
  listActivationLinks is ListActions.ArmResourceGetActionAsync<
    OracleSubscription<Plan>,
    ActivationLinks
  >;

  @added(Versions.v20240601_preview)
  @doc("Add Azure Subscriptions")
  @example(
    "./examples/oracleSubscriptions_addAzureSubscriptions.json",
    "Add Azure Subscriptions to the OracleSubscription"
  )
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

@@example(OracleSubscriptions.listBySubscription,
  "./examples/oracleSubscriptions_listBySubscription.json",
  "List Oracle Subscriptions by subscription"
);
@@example(OracleSubscriptions.createOrUpdate,
  "./examples/oracleSubscriptions_create.json",
  "Create or Update Oracle Subscription"
);
@@example(OracleSubscriptions.get,
  "./examples/oracleSubscriptions_get.json",
  "Get Oracle Subscription"
);
@@example(OracleSubscriptions.update,
  "./examples/oracleSubscriptions_patch.json",
  "Patch Oracle Subscription"
);
@@example(OracleSubscriptions.delete,
  "./examples/oracleSubscriptions_delete.json",
  "Delete Oracle Subscription"
);
