import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ResourceConnector;
/**
 * Appliances definition.
 */
model Appliance is Azure.ResourceManager.TrackedResource<ApplianceProperties> {
  ...ResourceNameParameter<
    Resource = Appliance,
    KeyName = "resourceName",
    SegmentName = "appliances",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface Appliances {
  /**
   * Gets the details of an Appliance with a specified resource group and name.
   */
  @summary("Gets an Appliance.")
  get is ArmResourceRead<Appliance>;

  /**
   * Creates or updates an Appliance in the specified Subscription and Resource Group.
   */
  @summary("Creates or updates an Appliance.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Appliance>;

  /**
   * Updates an Appliance with the specified Resource Name in the specified Resource Group and Subscription.
   */
  @patch(#{ implicitOptionality: false })
  @summary("Updates an Appliance.")
  update is ArmCustomPatchSync<Appliance, PatchModel = PatchableAppliance>;

  /**
   * Deletes an Appliance with the specified Resource Name, Resource Group, and Subscription Id.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes an Appliance.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Appliance,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**

   * Gets a list of Appliances in the specified subscription and resource group. The operation returns properties of each Appliance.

   */
  @summary("Gets a list of Appliances in the specified subscription and resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Appliance,
    Response = ApplianceListResult
  >;

  /**

   * Gets a list of Appliances in the specified subscription. The operation returns properties of each Appliance

   */
  @summary("Gets a list of Appliances in a subscription.")
  listBySubscription is ArmListBySubscription<
    Appliance,
    Response = ApplianceListResult
  >;

  /**
   * Returns the cluster user credentials for the dedicated appliance.
   */
  @summary("Returns the cluster user credential.")
  listClusterUserCredential is ArmResourceActionSync<
    Appliance,
    void,
    ArmResponse<ApplianceListCredentialResults>
  >;

  /**
   * Returns the cluster customer credentials for the dedicated appliance.
   */
  @action("listkeys")
  @summary("Gets the management config.")
  listKeys is ArmResourceActionSync<
    Appliance,
    void,
    ArmResponse<ApplianceListKeysResults>,
    Parameters = {
      /**
       * This sets the type of artifact being returned, when empty no artifact endpoint is returned.
       */
      @query("artifactType")
      artifactType?: string;
    }
  >;

  /**
   * Gets the upgrade graph of an Appliance with a specified resource group and name and specific release train.
   */
  @get
  @summary("Gets an Appliance upgrade graph.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceConnector/appliances/{resourceName}/upgradeGraphs/{upgradeGraph}")
  getUpgradeGraph is ApplianceOps.ActionSync<
    Appliance,
    Parameters = {
      /**
       * Upgrade graph version, ex - stable
       */
      @path
      @key
      @segment("upgradeGraphs")
      upgradeGraph: string;
    },
    Request = void,
    Response = ArmResponse<UpgradeGraph>
  >;
}

// This is needed to define the route for getUpgradeGraph operation since it does not follow standard ARM patterns.
alias ApplianceOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
  },
  {
    /**
     * Appliances name.
     */
    @path
    @segment("appliances")
    @key
    @minLength(1)
    @maxLength(63)
    @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
    resourceName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceConnector/appliances/{resourceName}",
  }
>;

@@maxLength(Appliance.name, 63);
@@minLength(Appliance.name, 1);
@@doc(Appliance.name, "Appliances name.");
@@doc(Appliance.properties, "The set of properties specific to an Appliance");
@@doc(Appliances.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update an Appliance."
);
@@doc(Appliances.update::parameters.properties,
  "The updatable fields of an existing Appliance."
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Appliances.update::parameters.properties
);
