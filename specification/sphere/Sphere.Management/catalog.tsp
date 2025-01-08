import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace Microsoft.AzureSphere;
/**
 * An Azure Sphere catalog
 */
model Catalog is TrackedResource<CatalogProperties> {
  /**
   * Name of catalog
   */
  @pattern("^[A-Za-z0-9_-]{1,50}$")
  @path
  @key("catalogName")
  @segment("catalogs")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface Catalogs {
  /**
   * Get a Catalog
   */
  get is ArmResourceRead<Catalog>;

  /**
   * Create a Catalog
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Catalog,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a Catalog
   */
  @parameterVisibility
  update is ArmCustomPatchSync<Catalog, CatalogUpdate>;

  /**
   * Delete a Catalog
   */
  #suppress "deprecated" "For backward compatible"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatible"
  delete is ArmResourceDeleteAsync<Catalog>;

  /**
   * List Catalog resources by resource group
   */
  listByResourceGroup is ArmResourceListByParent<Catalog>;

  /**
   * List Catalog resources by subscription ID
   */
  listBySubscription is ArmListBySubscription<Catalog>;

  /**
   * Counts devices in catalog.
   */
  countDevices is ArmResourceActionSync<Catalog, void, CountDevicesResponse>;

  /**
   * Lists deployments for catalog.
   */
  listDeployments is ArmResourceActionSync<
    Catalog,
    void,
    ResourceListResult<Deployment>,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<Catalog>;
      ...CustomFilterQueryParameter;
      ...CustomTopQueryParameter;
      ...CustomSkipQueryParameter;
      ...CustomMaxPageSizeQueryParameter;
    }
  >;

  /**
   * List the device groups for the catalog.
   */
  listDeviceGroups is ArmResourceActionSync<
    Catalog,
    ListDeviceGroupsRequest,
    ResourceListResult<DeviceGroup>,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<Catalog>;
      ...CustomFilterQueryParameter;
      ...CustomTopQueryParameter;
      ...CustomSkipQueryParameter;
      ...CustomMaxPageSizeQueryParameter;
    }
  >;

  /**
   * Lists device insights for catalog.
   */
  listDeviceInsights is ArmResourceActionSync<
    Catalog,
    void,
    PagedDeviceInsight,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<Catalog>;
      ...CustomFilterQueryParameter;
      ...CustomTopQueryParameter;
      ...CustomSkipQueryParameter;
      ...CustomMaxPageSizeQueryParameter;
    }
  >;

  /**
   * Lists devices for catalog.
   */
  listDevices is ArmResourceActionSync<
    Catalog,
    void,
    ResourceListResult<Device>,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<Catalog>;
      ...CustomFilterQueryParameter;
      ...CustomTopQueryParameter;
      ...CustomSkipQueryParameter;
      ...CustomMaxPageSizeQueryParameter;
    }
  >;

  /**
   * Creates an image. Use this action when the image ID is unknown.
   */
  uploadImage is ArmResourceActionNoResponseContentAsync<Catalog, Image>;
}

@@doc(Catalogs.listDeviceGroups::parameters.body,
  "List device groups for catalog."
);
@@clientName(Catalogs.listDeviceGroups::parameters.body,
  "listDeviceGroupsRequest"
);
@@doc(Catalogs.uploadImage::parameters.body, "Image upload request body.");
@@clientName(Catalogs.uploadImage::parameters.body, "uploadImageRequest");
