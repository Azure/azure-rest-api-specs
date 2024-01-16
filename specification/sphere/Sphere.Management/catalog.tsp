import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.AzureSphere;

//Catalogs
@doc("An Azure Sphere catalog")
model Catalog is TrackedResource<CatalogProperties> {
  @doc("Name of catalog")
  @pattern("^[A-Za-z0-9_-]{1,50}$")
  @key("catalogName")
  @path
  @segment("catalogs")
  name: string;
}

@doc("Catalog properties")
model CatalogProperties {
  @visibility("read")
  @doc("The Azure Sphere tenant ID associated with the catalog.")
  @added(Microsoft.AzureSphere.Versions.v2024_04_01)
  tenantId?: string;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Request of the action to list device groups for a catalog.")
model ListDeviceGroupsRequest {
  @doc("Device Group name.")
  deviceGroupName?: string;
}
@doc("Device insight report.")
model DeviceInsight {
  @doc("Device ID")
  deviceId: string;

  @doc("Event description")
  description: string;

  @doc("Event start timestamp")
  startTimestampUtc: utcDateTime;

  @doc("Event end timestamp")
  endTimestampUtc: utcDateTime;

  @doc("Event category")
  eventCategory: string;

  @doc("Event class")
  eventClass: string;

  @doc("Event type")
  eventType: string;

  @doc("Event count")
  eventCount: int32;
}

@armResourceOperations
interface Catalogs
  extends Azure.ResourceManager.TrackedResourceOperations<
      Catalog,
      CatalogProperties
    > {
  @removed(Versions.v2024_04_01)
  @autoRoute
  @doc("Counts devices in catalog.")
  @armResourceAction(Catalog)
  @action("countDevices")
  @renamedFrom(Versions.v2024_04_01, "countDevices")
  @post
  deprecated(
    ...ResourceInstanceParameters<Catalog>,
  ): ArmResponse<CountDeviceResponse> | ErrorResponse;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "preview api"
  @added(Versions.v2024_04_01)
  @sharedRoute
  @autoRoute
  @doc("Counts devices in catalog.")
  @armResourceAction(Catalog)
  @post
  countDevices(
    ...ResourceInstanceParameters<Catalog>,
  ): ArmResponse<CountDevicesResponse> | ErrorResponse;

  @autoRoute
  @doc("Lists device insights for catalog.")
  @armResourceAction(Catalog)
  @post
  listDeviceInsights(
    ...ResourceInstanceParameters<Catalog>,
    ...ListQueryParameters,
  ): ArmResponse<Page<DeviceInsight>> | ErrorResponse;

  @autoRoute
  @doc("Lists devices for catalog.")
  @armResourceAction(Catalog)
  @post
  listDevices(
    ...ResourceInstanceParameters<Catalog>,
    ...ListQueryParameters,
  ): ArmResponse<ResourceListResult<Device>> | ErrorResponse;

  @autoRoute
  @doc("Lists deployments for catalog.")
  @armResourceAction(Catalog)
  @post
  listDeployments(
    ...ResourceInstanceParameters<Catalog>,
    ...ListQueryParameters,
  ): ArmResponse<ResourceListResult<Deployment>> | ErrorResponse;

  @autoRoute
  @armResourceAction(Catalog)
  @doc("List the device groups for the catalog.")
  @post
  listDeviceGroups(
    ...ResourceInstanceParameters<Catalog>,
    ...ListQueryParameters,

    @doc("List device groups for catalog.")
    @body
    listDeviceGroupsRequest: ListDeviceGroupsRequest,
  ): ArmResponse<ResourceListResult<DeviceGroup>> | ErrorResponse;

  @autoRoute
  @armResourceAction(Catalog)
  @added(Versions.v2024_04_01)
  @doc("Creates an image. Use this action when the image ID is unknown.")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  uploadImage(
    ...ResourceInstanceParameters<Catalog>,

    @doc("Image upload request body.")
    @body
    uploadImageRequest: Image,
  ): ArmAcceptedLroResponse | ErrorResponse;
}
