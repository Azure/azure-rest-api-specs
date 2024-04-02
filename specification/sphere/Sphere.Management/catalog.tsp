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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Catalog>;

  /**
   * Update a Catalog
   */
  @parameterVisibility("read")
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
      ...BaseParameters<Catalog>;
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
      ...BaseParameters<Catalog>;
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
      ...BaseParameters<Catalog>;
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
      ...BaseParameters<Catalog>;
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
@@encodedName(Catalogs.listDeviceGroups::parameters.body,
  "application/json",
  "listDeviceGroupsRequest"
);
@@extension(Catalogs.listDeviceGroups::parameters.body,
  "x-ms-client-name",
  "listDeviceGroupsRequest"
);
@@doc(Catalogs.uploadImage::parameters.body, "Image upload request body.");
@@encodedName(Catalogs.uploadImage::parameters.body,
  "application/json",
  "uploadImageRequest"
);
@@extension(Catalogs.uploadImage::parameters.body,
  "x-ms-client-name",
  "uploadImageRequest"
);
