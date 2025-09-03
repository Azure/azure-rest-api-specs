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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Identity;
}

@armResourceOperations
interface Appliances {
  /**
   * Gets the details of an Appliance with a specified resource group and name.
   */
  get is ArmResourceRead<Appliance>;

  /**
   * Creates or updates an Appliance in the specified Subscription and Resource Group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Appliance>;

  /**
   * Updates an Appliance with the specified Resource Name in the specified Resource Group and Subscription.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Appliance, PatchModel = PatchableAppliance>;

  /**
   * Deletes an Appliance with the specified Resource Name, Resource Group, and Subscription Id.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Appliance,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of Appliances in the specified subscription and resource group. The operation returns properties of each Appliance.
   */
  listByResourceGroup is ArmResourceListByParent<Appliance>;

  /**
   * Gets a list of Appliances in the specified subscription. The operation returns properties of each Appliance
   */
  listBySubscription is ArmListBySubscription<Appliance>;

  /**
   * Returns the cluster user credentials for the dedicated appliance.
   */
  listClusterUserCredential is ArmResourceActionSync<
    Appliance,
    void,
    ArmResponse<ApplianceListCredentialResults>
  >;

  /**
   * Returns the cluster customer credentials for the dedicated appliance.
   */
  @action("listkeys")
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
  getUpgradeGraph is ArmResourceActionSync<
    Appliance,
    void,
    ArmResponse<UpgradeGraph>,
    Parameters = {
      /**
       * Upgrade graph version, ex - stable
       */
      @path
      @segment("upgradeGraphs")
      upgradeGraph?: string;
    }
  >;
}

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
