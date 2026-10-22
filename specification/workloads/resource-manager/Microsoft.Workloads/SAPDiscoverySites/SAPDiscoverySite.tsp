using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

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
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,78}[a-zA-Z0-9_]$")
  @path
  @key("sapDiscoverySiteName")
  @segment("sapDiscoverySites")
  @visibility(Lifecycle.Read)
  name: string;

  /**
   * The extended location definition.
   */
  extendedLocation?: ExtendedLocation;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is a product."
@armResourceOperations
interface SAPDiscoverySites {
  /**
   * Gets a SAP Migration discovery site resource.
   */
  get is ArmResourceRead<SAPDiscoverySite>;

  /**
   * Creates a discovery site resource for SAP Migration. This resource will be used to run system discovery and assessment with Azure Migrate.
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    SAPDiscoverySite,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a SAP Migration discovery site resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmTagsPatchSync<SAPDiscoverySite>;

  /**
   * Deletes a SAP Migration discovery site resource and its child resources, that is the associated SAP Instances and Server Instances.
   */
  #suppress "deprecated" "Existing API"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API"
  delete is ArmResourceDeleteAsync<SAPDiscoverySite>;

  /**
   * Gets all SAP Migration discovery site resources in a Resource Group.
   */
  listByResourceGroup is ArmResourceListByParent<SAPDiscoverySite>;

  /**
   * Gets all SAP Migration discovery site resources in a Subscription.
   */
  listBySubscription is ArmListBySubscription<SAPDiscoverySite>;

  /**
   * Import your SAP systems' inventory using the [Discovery template](https://go.microsoft.com/fwlink/?linkid=2249111) into your SAP Migration discovery site resource and it's child resources, the SAP instances and Server instances.
   */
  importEntities is ArmResourceActionAsync<
    SAPDiscoverySite,
    void,
    Foundations.OperationStatusResult
  >;
}
