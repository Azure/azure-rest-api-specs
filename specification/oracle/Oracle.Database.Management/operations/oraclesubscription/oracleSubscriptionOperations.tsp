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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
  @doc("List Cloud Account Details")
  @Autorest.example(
    "./examples/oracleSubscriptions_listCloudAccountDetails.json",
    "List Cloud Account details for the Oracle Subscription"
  )
  listCloudAccountDetails is ListActions.ArmResourceGetActionAsync<
    OracleSubscription<Plan>,
    CloudAccountDetails
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
  @doc("List Saas Subscription Details")
  @Autorest.example(
    "./examples/oracleSubscriptions_listSaasSubscriptionDetails.json",
    "List Saas Subscription details for the Oracle Subscription"
  )
  listSaasSubscriptionDetails is ListActions.ArmResourceGetActionAsync<
    OracleSubscription<Plan>,
    SaasSubscriptionDetails
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
  @doc("List Activation Links")
  @Autorest.example(
    "./examples/oracleSubscriptions_listActivationLinks.json",
    "List Activation Links for the Oracle Subscription"
  )
  listActivationLinks is ListActions.ArmResourceGetActionAsync<
    OracleSubscription<Plan>,
    ActivationLinks
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
  @added(Versions.v20240601_preview)
  @doc("Add Azure Subscriptions")
  @Autorest.example(
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

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(OracleSubscriptions.listBySubscription,
  "./examples/oracleSubscriptions_listBySubscription.json",
  "List Oracle Subscriptions by subscription"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(OracleSubscriptions.createOrUpdate,
  "./examples/oracleSubscriptions_create.json",
  "Create or Update Oracle Subscription"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(OracleSubscriptions.get,
  "./examples/oracleSubscriptions_get.json",
  "Get Oracle Subscription"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(OracleSubscriptions.update,
  "./examples/oracleSubscriptions_patch.json",
  "Patch Oracle Subscription"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(OracleSubscriptions.delete,
  "./examples/oracleSubscriptions_delete.json",
  "Delete Oracle Subscription"
);
