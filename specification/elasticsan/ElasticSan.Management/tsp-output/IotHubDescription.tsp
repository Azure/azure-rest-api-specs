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

namespace Microsoft.Devices;
@doc("The description of the IoT hub.")
model IotHubDescription is TrackedResource<IotHubProperties> {
  @doc("The name of the IoT hub.")
  @path
  @key("resourceName")
  @segment("IotHubs")
  name: string;

  @doc("The Etag field is *not* required. If it is provided in the response body, it must also be provided as a header per the normal ETag convention.")
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface IotHubDescriptions {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the non-security related metadata of an IoT hub.")
  @operationId("IotHubResource_Get")
  get is ArmResourceRead<IotHubDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update the metadata of an Iot hub. The usual pattern to modify a property is to retrieve the IoT hub metadata and security metadata, and then combine them with the modified values in a new body to update the IoT hub. If certain properties are missing in the JSON, updating IoT Hub may cause these values to fallback to default, which may lead to unexpected behavior.")
  @operationId("IotHubResource_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    IotHubDescription,
    {
      ...BaseParameters<IotHubDescription>;

      @doc("ETag of the IoT Hub. Do not specify for creating a brand new IoT Hub. Required to update an existing IoT Hub.")
      @header
      `If-Match`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update an existing IoT Hub tags. to update other fields use the CreateOrUpdate method")
  @operationId("IotHubResource_Update")
  update is ArmCustomPatchAsync<IotHubDescription, TagsResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete an IoT hub.")
  @operationId("IotHubResource_Delete")
  delete is ArmResourceDeleteAsync<IotHubDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get all the IoT hubs in a resource group.")
  @operationId("IotHubResource_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<IotHubDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get all the IoT hubs in a subscription.")
  @operationId("IotHubResource_ListBySubscription")
  listBySubscription is ArmListBySubscription<IotHubDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Test all routes configured in this Iot Hub")
  @operationId("IotHubResource_TestAllRoutes")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Test the new route for this Iot Hub")
  @operationId("IotHubResource_TestRoute")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the security metadata for an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security.")
  @operationId("IotHubResource_ListKeys")
  listKeys is ArmResourceActionSync<
    IotHubDescription,
    void,
    SharedAccessSignatureAuthorizationRuleListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a shared access policy by name from an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security.")
  @operationId("IotHubResource_GetKeysForKeyName")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Exports all the device identities in the IoT hub identity registry to an Azure Storage blob container. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry#import-and-export-device-identities.")
  @operationId("IotHubResource_ExportDevices")
  exportDevices is ArmResourceActionSync<
    IotHubDescription,
    ExportDevicesRequest,
    JobResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Import, update, or delete device identities in the IoT hub identity registry from a blob. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry#import-and-export-device-identities.")
  @operationId("IotHubResource_ImportDevices")
  importDevices is ArmResourceActionSync<
    IotHubDescription,
    ImportDevicesRequest,
    JobResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Manually initiate a failover for the IoT Hub to its secondary region. To learn more, see https://aka.ms/manualfailover")
  @operationId("IotHub_ManualFailover")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Check if an IoT hub name is available.")
  @operationId("IotHubResource_CheckNameAvailability")
  checkNameAvailability is checkGlobalNameAvailability<
    OperationInputs,
    IotHubNameAvailabilityInfo
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotHubResource_GetStats")
  @summary("Get the statistics from an IoT hub")
  @doc("Get the statistics from an IoT hub.")
  // FIXME: IotHubResource_GetStats could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/IotHubStats")
  @get
  getStats is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotHubResource_GetValidSkus")
  @summary("Get the list of valid SKUs for an IoT hub")
  @doc("Get the list of valid SKUs for an IoT hub.")
  // FIXME: IotHubResource_GetValidSkus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/skus")
  @get
  getValidSkus is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotHubResource_ListJobs")
  @summary("Get a list of all the jobs in an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry")
  @doc("Get a list of all the jobs in an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry.")
  // FIXME: IotHubResource_ListJobs could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/jobs")
  @get
  listJobs is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotHubResource_GetJob")
  @summary("Get the details of a job from an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry")
  @doc("Get the details of a job from an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry.")
  // FIXME: IotHubResource_GetJob could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/jobs/{jobId}")
  @get
  getJob is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotHubResource_GetQuotaMetrics")
  @summary("Get the quota metrics for an IoT hub")
  @doc("Get the quota metrics for an IoT hub.")
  // FIXME: IotHubResource_GetQuotaMetrics could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/quotaMetrics")
  @get
  getQuotaMetrics is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotHubResource_GetEndpointHealth")
  @summary("Get the health for routing endpoints")
  @doc("Get the health for routing endpoints.")
  // FIXME: IotHubResource_GetEndpointHealth could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{iotHubName}/routingEndpointsHealth")
  @get
  getEndpointHealth is Azure.Core.Foundations.Operation<
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

@@projectedName(IotHubDescriptions.createOrUpdate::parameters.resource,
  "json",
  "iotHubDescription"
);
@@extension(IotHubDescriptions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "iotHubDescription"
);
@@doc(IotHubDescriptions.createOrUpdate::parameters.resource,
  "The IoT hub metadata and security metadata."
);
@@projectedName(IotHubDescriptions.update::parameters.properties,
  "json",
  "IotHubTags"
);
@@extension(IotHubDescriptions.update::parameters.properties,
  "x-ms-client-name",
  "IotHubTags"
);
@@doc(IotHubDescriptions.update::parameters.properties,
  "Updated tag information to set into the iot hub instance."
);
@@projectedName(IotHubDescriptions.testAllRoutes::parameters.body,
  "json",
  "input"
);
@@extension(IotHubDescriptions.testAllRoutes::parameters.body,
  "x-ms-client-name",
  "input"
);
@@doc(IotHubDescriptions.testAllRoutes::parameters.body,
  "Input for testing all routes"
);
@@projectedName(IotHubDescriptions.testRoute::parameters.body, "json", "input");
@@extension(IotHubDescriptions.testRoute::parameters.body,
  "x-ms-client-name",
  "input"
);
@@doc(IotHubDescriptions.testRoute::parameters.body,
  "Route that needs to be tested"
);
@@projectedName(IotHubDescriptions.exportDevices::parameters.body,
  "json",
  "exportDevicesParameters"
);
@@extension(IotHubDescriptions.exportDevices::parameters.body,
  "x-ms-client-name",
  "exportDevicesParameters"
);
@@doc(IotHubDescriptions.exportDevices::parameters.body,
  "The parameters that specify the export devices operation."
);
@@projectedName(IotHubDescriptions.importDevices::parameters.body,
  "json",
  "importDevicesParameters"
);
@@extension(IotHubDescriptions.importDevices::parameters.body,
  "x-ms-client-name",
  "importDevicesParameters"
);
@@doc(IotHubDescriptions.importDevices::parameters.body,
  "The parameters that specify the import devices operation."
);
@@projectedName(IotHubDescriptions.manualFailover::parameters.body,
  "json",
  "failoverInput"
);
@@extension(IotHubDescriptions.manualFailover::parameters.body,
  "x-ms-client-name",
  "failoverInput"
);
@@doc(IotHubDescriptions.manualFailover::parameters.body,
  "Region to failover to. Must be the Azure paired region. Get the value from the secondary location in the locations property. To learn more, see https://aka.ms/manualfailover/region"
);
