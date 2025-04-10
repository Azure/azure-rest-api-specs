import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Devices;
/**
 * The description of the IoT hub.
 */
model IotHubDescription
  is Azure.ResourceManager.TrackedResource<IotHubProperties> {
  ...ResourceNameParameter<
    Resource = IotHubDescription,
    KeyName = "resourceName",
    SegmentName = "IotHubs",
    NamePattern = ""
  >;

  /**
   * The Etag field is *not* required. If it is provided in the response body, it must also be provided as a header per the normal ETag convention.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  /**
   * IotHub SKU info
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku: IotHubSkuInfo;

  /**
   * The managed identities for the IotHub.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ArmIdentity;
}

@armResourceOperations
interface IotHubDescriptions {
  /**
   * Get the non-security related metadata of an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotHubResource_Get")
  get is ArmResourceRead<IotHubDescription>;

  /**
   * Create or update the metadata of an Iot hub. The usual pattern to modify a property is to retrieve the IoT hub metadata and security metadata, and then combine them with the modified values in a new body to update the IoT hub. If certain properties are missing in the JSON, updating IoT Hub may cause these values to fallback to default, which may lead to unexpected behavior.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotHubResource_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    IotHubDescription,
    Parameters = {
      /**
       * ETag of the IoT Hub. Do not specify for creating a brand new IoT Hub. Required to update an existing IoT Hub.
       */
      @header
      `If-Match`?: string;
    },
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an existing IoT Hub tags. to update other fields use the CreateOrUpdate method
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("IotHubResource_Update")
  update is ArmCustomPatchAsync<
    IotHubDescription,
    PatchModel = TagsResource,
    Response = ArmResponse<IotHubDescription>
  >;

  /**
   * Delete an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("IotHubResource_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    IotHubDescription,
    Response = ArmResponse<IotHubDescription> | (ArmDeleteAcceptedLroResponse & {
      @bodyRoot
      _: IotHubDescription;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * Get all the IoT hubs in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotHubResource_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<IotHubDescription>;

  /**
   * Get all the IoT hubs in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotHubResource_ListBySubscription")
  listBySubscription is ArmListBySubscription<IotHubDescription>;

  /**
   * Get the statistics from an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("IotHubStats")
  @operationId("IotHubResource_GetStats")
  getStats is ArmResourceActionSync<
    IotHubDescription,
    void,
    ArmResponse<RegistryStatistics>
  >;

  /**
   * Get the list of valid SKUs for an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("skus")
  @operationId("IotHubResource_GetValidSkus")
  getValidSkus is ArmResourceActionSync<
    IotHubDescription,
    void,
    ArmResponse<IotHubSkuDescriptionListResult>
  >;

  /**
   * Get a list of all the jobs in an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("jobs")
  @operationId("IotHubResource_ListJobs")
  listJobs is ArmResourceActionSync<
    IotHubDescription,
    void,
    ArmResponse<JobResponseListResult>
  >;

  /**
   * Get the details of a job from an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{jobId}")
  @operationId("IotHubResource_GetJob")
  getJob is ArmResourceActionSync<
    IotHubDescription,
    void,
    ArmResponse<JobResponse>,
    Parameters = {
      /**
       * The job identifier.
       */
      @path
      jobId: string;
    }
  >;

  /**
   * Get the quota metrics for an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("quotaMetrics")
  @operationId("IotHubResource_GetQuotaMetrics")
  getQuotaMetrics is ArmResourceActionSync<
    IotHubDescription,
    void,
    ArmResponse<IotHubQuotaMetricInfoListResult>
  >;

  /**
   * Get the health for routing endpoints.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("routingEndpointsHealth")
  @operationId("IotHubResource_GetEndpointHealth")
  getEndpointHealth is ArmResourceActionSync<
    IotHubDescription,
    void,
    ArmResponse<EndpointHealthDataListResult>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @path
      iotHubName: string;
    }
  >;

  /**
   * Test all routes configured in this Iot Hub
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("$testall")
  @operationId("IotHubResource_TestAllRoutes")
  testAllRoutes is ArmResourceActionSync<
    IotHubDescription,
    TestAllRoutesInput,
    ArmResponse<TestAllRoutesResult>,
    Parameters = {
      /**
       * IotHub to be tested
       */
      @path
      iotHubName: string;
    }
  >;

  /**
   * Test the new route for this Iot Hub
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("$testnew")
  @operationId("IotHubResource_TestRoute")
  testRoute is ArmResourceActionSync<
    IotHubDescription,
    TestRouteInput,
    ArmResponse<TestRouteResult>,
    Parameters = {
      /**
       * IotHub to be tested
       */
      @path
      iotHubName: string;
    }
  >;

  /**
   * Get the security metadata for an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listkeys")
  @operationId("IotHubResource_ListKeys")
  listKeys is ArmResourceActionSync<
    IotHubDescription,
    void,
    ArmResponse<SharedAccessSignatureAuthorizationRuleListResult>
  >;

  /**
   * Get a shared access policy by name from an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listkeys")
  @operationId("IotHubResource_GetKeysForKeyName")
  getKeysForKeyName is ArmResourceActionSync<
    IotHubDescription,
    void,
    ArmResponse<SharedAccessSignatureAuthorizationRule>,
    Parameters = {
      /**
       * The name of the shared access policy.
       */
      @path
      keyName: string;
    }
  >;

  /**
   * Exports all the device identities in the IoT hub identity registry to an Azure Storage blob container. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry#import-and-export-device-identities.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotHubResource_ExportDevices")
  exportDevices is ArmResourceActionSync<
    IotHubDescription,
    ExportDevicesRequest,
    ArmResponse<JobResponse>
  >;

  /**
   * Import, update, or delete device identities in the IoT hub identity registry from a blob. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry#import-and-export-device-identities.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotHubResource_ImportDevices")
  importDevices is ArmResourceActionSync<
    IotHubDescription,
    ImportDevicesRequest,
    ArmResponse<JobResponse>
  >;

  /**
   * Manually initiate a failover for the IoT Hub to its secondary region. To learn more, see https://aka.ms/manualfailover
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("failover")
  @operationId("IotHub_ManualFailover")
  manualFailover is ArmResourceActionAsync<
    IotHubDescription,
    FailoverInput,
    OkResponse,
    Parameters = {
      /**
       * Name of the IoT hub to failover
       */
      @path
      iotHubName: string;
    }
  >;
}

@@doc(IotHubDescription.name, "The name of the IoT hub.");
@@doc(IotHubDescription.properties, "IotHub properties");
@@doc(IotHubDescriptions.createOrUpdate::parameters.resource,
  "The IoT hub metadata and security metadata."
);
@@doc(IotHubDescriptions.update::parameters.properties,
  "Updated tag information to set into the iot hub instance."
);
@@doc(IotHubDescriptions.testAllRoutes::parameters.body,
  "Input for testing all routes"
);
@@doc(IotHubDescriptions.testRoute::parameters.body,
  "Route that needs to be tested"
);
@@doc(IotHubDescriptions.exportDevices::parameters.body,
  "The parameters that specify the export devices operation."
);
@@doc(IotHubDescriptions.importDevices::parameters.body,
  "The parameters that specify the import devices operation."
);
@@doc(IotHubDescriptions.manualFailover::parameters.body,
  "Region to failover to. Must be the Azure paired region. Get the value from the secondary location in the locations property. To learn more, see https://aka.ms/manualfailover/region"
);
