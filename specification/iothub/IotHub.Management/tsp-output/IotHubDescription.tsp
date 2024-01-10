import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Devices;
@doc("The description of the IoT hub.")
model IotHubDescription is TrackedResource<IotHubProperties> {
  @doc("The name of the IoT hub.")
  @key("resourceName")
  @segment("IotHubs")
  name: string;

  @doc("The Etag field is *not* required. If it is provided in the response body, it must also be provided as a header per the normal ETag convention.")
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
@projectedName("client", "IotHubResource")
interface IotHubDescriptions_IotHubResource {
  @doc("Get the non-security related metadata of an IoT hub.")
  get is ArmResourceRead<IotHubDescription>;

  @doc("Create or update the metadata of an Iot hub. The usual pattern to modify a property is to retrieve the IoT hub metadata and security metadata, and then combine them with the modified values in a new body to update the IoT hub. If certain properties are missing in the JSON, updating IoT Hub may cause these values to fallback to default, which may lead to unexpected behavior.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    IotHubDescription,
    {
      ...BaseParameters<IotHubDescription>;

      @doc("ETag of the IoT Hub. Do not specify for creating a brand new IoT Hub. Required to update an existing IoT Hub.")
      @header
      `If-Match`?: string;
    }
  >;

  @doc("Update an existing IoT Hub tags. to update other fields use the CreateOrUpdate method")
  update is ArmCustomPatchAsync<IotHubDescription, TagsResource>;

  @doc("Delete an IoT hub.")
  delete is ArmResourceDeleteAsync<IotHubDescription>;

  @doc("Get all the IoT hubs in a resource group.")
  listByResourceGroup is ArmResourceListByParent<IotHubDescription>;

  @doc("Get all the IoT hubs in a subscription.")
  listBySubscription is ArmListBySubscription<IotHubDescription>;

  @doc("Test all routes configured in this Iot Hub")
  testAllRoutes is ArmResourceActionSync<
    IotHubDescription,
    TestAllRoutesInput,
    TestAllRoutesResult,
    {
      ...BaseParameters<IotHubDescription>;

      @doc("IotHub to be tested")
      @path
      iotHubName: string;
    }
  >;

  @doc("Test the new route for this Iot Hub")
  testRoute is ArmResourceActionSync<
    IotHubDescription,
    TestRouteInput,
    TestRouteResult,
    {
      ...BaseParameters<IotHubDescription>;

      @doc("IotHub to be tested")
      @path
      iotHubName: string;
    }
  >;

  @doc("Get the security metadata for an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security.")
  listKeys is ArmResourceActionSync<
    IotHubDescription,
    void,
    SharedAccessSignatureAuthorizationRuleListResult
  >;

  @doc("Get a shared access policy by name from an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security.")
  getKeysForKeyName is ArmResourceActionSync<
    IotHubDescription,
    void,
    SharedAccessSignatureAuthorizationRule,
    {
      ...BaseParameters<IotHubDescription>;

      @doc("The name of the shared access policy.")
      @path
      keyName: string;
    }
  >;

  @doc("Exports all the device identities in the IoT hub identity registry to an Azure Storage blob container. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry#import-and-export-device-identities.")
  exportDevices is ArmResourceActionSync<
    IotHubDescription,
    ExportDevicesRequest,
    JobResponse
  >;

  @doc("Import, update, or delete device identities in the IoT hub identity registry from a blob. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry#import-and-export-device-identities.")
  importDevices is ArmResourceActionSync<
    IotHubDescription,
    ImportDevicesRequest,
    JobResponse
  >;

  @summary("Get the statistics from an IoT hub")
  @doc("Get the statistics from an IoT hub.")
  // FIXME: IotHubResource_GetStats could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/IotHubStats")
  @get
  GetStats is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;
    },
    RegistryStatistics
  >;

  @summary("Get the list of valid SKUs for an IoT hub")
  @doc("Get the list of valid SKUs for an IoT hub.")
  // FIXME: IotHubResource_GetValidSkus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/skus")
  @get
  GetValidSkus is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;
    },
    IotHubSkuDescriptionListResult
  >;

  @summary("Get a list of all the jobs in an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry")
  @doc("Get a list of all the jobs in an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry.")
  // FIXME: IotHubResource_ListJobs could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/jobs")
  @get
  ListJobs is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;
    },
    JobResponseListResult
  >;

  @summary("Get the details of a job from an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry")
  @doc("Get the details of a job from an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry.")
  // FIXME: IotHubResource_GetJob could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/jobs/{jobId}")
  @get
  GetJob is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;

      @doc("The job identifier.")
      @path
      jobId: string;
    },
    JobResponse
  >;

  @summary("Get the quota metrics for an IoT hub")
  @doc("Get the quota metrics for an IoT hub.")
  // FIXME: IotHubResource_GetQuotaMetrics could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/quotaMetrics")
  @get
  GetQuotaMetrics is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the IoT hub.")
      @path
      resourceGroupName: string;

      @doc("The name of the IoT hub.")
      @path
      resourceName: string;
    },
    IotHubQuotaMetricInfoListResult
  >;

  @summary("Get the health for routing endpoints")
  @doc("Get the health for routing endpoints.")
  // FIXME: IotHubResource_GetEndpointHealth could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{iotHubName}/routingEndpointsHealth")
  @get
  GetEndpointHealth is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @path
      resourceGroupName: string;

      @path
      iotHubName: string;
    },
    EndpointHealthDataListResult
  >;
}

@armResourceOperations
@projectedName("client", "IotHub")
interface IotHubDescriptions_IotHub {
  @doc("Manually initiate a failover for the IoT Hub to its secondary region. To learn more, see https://aka.ms/manualfailover")
  manualFailover is ArmResourceActionAsync<
    IotHubDescription,
    FailoverInput,
    void,
    {
      ...BaseParameters<IotHubDescription>;

      @doc("Name of the IoT hub to failover")
      @path
      iotHubName: string;
    }
  >;
}
