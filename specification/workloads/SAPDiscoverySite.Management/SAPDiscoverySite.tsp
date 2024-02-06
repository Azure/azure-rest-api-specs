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

namespace Microsoft.Workloads;
/**
 * Define the SAP Migration discovery site resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is a product."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "ExtendedLocation is top level attributes."
model SAPDiscoverySite is TrackedResource<SAPDiscoverySiteProperties> {
  /**
   * The name of the discovery site resource for SAP Migration.
   */
  @pattern("^[A-Za-z][\\w-]*[A-Za-z0-9]$")
  @path
  @key("sapDiscoverySiteName")
  @segment("sapDiscoverySites")
  @visibility("read")
  name: string;
  /**
   * The extended location definition.
   */
  extendedLocation?: ExtendedLocation;
}
@@doc(SAPDiscoverySite.properties, " The SAP Migration discovery site resource properties.");

#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is a product."
@armResourceOperations
interface SAPDiscoverySites {
  /**
   * Gets a SAP Migration discovery site resource.
   */
  get is ArmResourceRead<SAPDiscoverySite>;

  /**
   * Creates a discovery site for SAP Migration.
   */
  create is ArmResourceCreateOrReplaceAsync<
    SAPDiscoverySite,
    BaseParameters<SAPDiscoverySite>,
    ArmLroLocationHeader
  >;

  /**
   * Updates a SAP Migration discovery site resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    SAPDiscoverySite,
    UpdateSAPDiscoverySiteRequest,
    BaseParameters<SAPDiscoverySite>,
    ArmLroLocationHeader
  >;

  /**
   * Deletes a SAP Migration discovery site resource and its child resources, that is the associated SAP Instances and Server Instances.
   */
  delete is ArmResourceDeleteAsync<
    SAPDiscoverySite,
    BaseParameters<SAPDiscoverySite>,
    ArmLroLocationHeader
  >;

  /**
   * Gets all SAP Migration discovery site resources in a Resource Group.
   */
  listByResourceGroup is ArmResourceListByParent<SAPDiscoverySite>;

  /**
   * Gets all SAP Migration discovery site resources in a Subscription.
   */
  listBySubscription is ArmListBySubscription<SAPDiscoverySite>;

  /**
   * Import a SAP Migration discovery site resource and it's child resources, that is the SAP instances and Server instances.
   */
  importEntities is ArmResourceActionAsync<
    SAPDiscoverySite,
    void,
    OperationStatusResult,
    BaseParameters<SAPDiscoverySite>,
    ArmLroLocationHeader
  >;
}

@@doc(SAPDiscoverySites.create::parameters.resource,
  "SAP Migration discovery site resource request body."
);
@@doc(SAPDiscoverySites.update::parameters.properties,
  "Request body to update a SAP Migration discovery site resource."
);
