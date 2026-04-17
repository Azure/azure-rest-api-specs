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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /**
   * IotHub SKU info
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: IotHubSkuInfo;

  /**
   * The managed identities for the IotHub.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ArmIdentity;
}

alias IotHubDescriptionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...ProviderNamespace<IotHubDescription>;
  },
  {
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @key
    @segment("IotHubs")
    iotHubName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface IotHubDescriptions {
  /**
   * Get the non-security related metadata of an IoT hub.
   */
  @summary("Get the non-security related metadata of an IoT hub")
  @tag("GET")
  get is ArmResourceRead<IotHubDescription, Error = ErrorDetails>;

  /**
   * Create or update the metadata of an Iot hub. The usual pattern to modify a property is to retrieve the IoT hub metadata and security metadata, and then combine them with the modified values in a new body to update the IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or update the metadata of an IoT hub.")
  @tag("PUT")
  @Azure.Core.useFinalStateVia("location")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    IotHubDescription,
    Parameters = {
      /**
       * ETag of the IoT Hub. Do not specify for creating a brand new IoT Hub. Required to update an existing IoT Hub.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = IotHubDescription> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorDetails
  >;

  /**
   * Update an existing IoT Hub tags. to update other fields use the CreateOrUpdate method
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Update an existing IoT Hubs tags.")
  @tag("PATCH")
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("location")
  update is ArmCustomPatchAsync<
    IotHubDescription,
    PatchModel = TagsResource,
    Response = ArmResponse<IotHubDescription> &
      ArmCombinedLroHeaders<FinalResult = IotHubDescription> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = never
  >;

  /**
   * Delete an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete an IoT hub")
  @tag("DELETE")
  delete is ArmResourceDeleteWithoutOkAsync<
    IotHubDescription,
    Response =
      | ArmResponse<IotHubDescription>
      | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = IotHubDescription> &
          Azure.Core.Foundations.RetryAfterHeader> &
          Body<IotHubDescription>)
      | ArmDeletedNoContentResponse
      | (NotFoundResponse & Body<ErrorDetails>),
    Error = ErrorDetails
  >;

  /**
   * Get all the IoT hubs in a resource group.
   */
  @summary("Get all the IoT hubs in a resource group")
  @tag("GET")
  listByResourceGroup is ArmResourceListByParent<
    IotHubDescription,
    Error = ErrorDetails
  >;

  /**
   * Get all the IoT hubs in a subscription.
   */
  @summary("Get all the IoT hubs in a subscription")
  @tag("GET")
  listBySubscription is ArmListBySubscription<
    IotHubDescription,
    Error = ErrorDetails
  >;

  /**
   * Get the list of valid SKUs for an IoT hub.
   */
  @summary("Get the list of valid SKUs for an IoT hub")
  @tag("GET")
  @list
  @get
  @action("skus")
  getValidSkus is ArmResourceActionSync<
    IotHubDescription,
    void,
    ArmResponse<IotHubSkuDescriptionListResult>,
    Error = ErrorDetails
  >;

  /**
   * Get a list of all the jobs in an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry.
   */
  @summary("Get a list of all the jobs in an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry")
  @tag("GET")
  @list
  @get
  @action("jobs")
  listJobs is ArmResourceActionSync<
    IotHubDescription,
    void,
    ArmResponse<JobResponseListResult>,
    Error = ErrorDetails
  >;

  /**
   * Get the details of a job from an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry.
   */
  @summary("Get the details of a job from an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry")
  @tag("GET")
  @get
  getJob is ArmResourceRead<
    IotHubDescription,
    Response = ArmResponse<JobResponse>,
    Parameters = {
      /**
       * The job identifier.
       */
      @path
      @segment("jobs")
      jobId: string;
    },
    Error = ErrorDetails
  >;

  /**
   * Get the quota metrics for an IoT hub.
   */
  @summary("Get the quota metrics for an IoT hub")
  @tag("GET")
  @list
  @get
  @action("quotaMetrics")
  getQuotaMetrics is ArmResourceActionSync<
    IotHubDescription,
    void,
    ArmResponse<IotHubQuotaMetricInfoListResult>,
    Error = ErrorDetails
  >;

  /**
   * Get the health for routing endpoints.
   */
  @summary("Get the health for routing endpoints")
  @tag("GET")
  @list
  @get
  @action("routingEndpointsHealth")
  getEndpointHealth is IotHubDescriptionOps.ActionSync<
    IotHubDescription,
    void,
    ArmResponse<EndpointHealthDataListResult>,
    OverrideErrorType = ErrorDetails
  >;

  /**
   * Test all routes configured in this Iot Hub
   */
  @summary("Test all routes")
  @tag("POST")
  @action("routing/routes/$testall")
  testAllRoutes is IotHubDescriptionOps.ActionSync<
    IotHubDescription,
    TestAllRoutesInput,
    ArmResponse<TestAllRoutesResult>,
    OverrideErrorType = ErrorDetails
  >;

  /**
   * Test the new route for this Iot Hub
   */
  @summary("Test the new route")
  @tag("POST")
  @action("routing/routes/$testnew")
  testRoute is IotHubDescriptionOps.ActionSync<
    IotHubDescription,
    TestRouteInput,
    ArmResponse<TestRouteResult>,
    OverrideErrorType = ErrorDetails
  >;

  /**
   * Get the security metadata for an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security.
   */
  @summary("Get the security metadata for an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security")
  @tag("POST")
  @list
  @action("listkeys")
  listKeys is ArmResourceActionSync<
    IotHubDescription,
    void,
    ArmResponse<SharedAccessSignatureAuthorizationRuleListResult>,
    Error = ErrorDetails
  >;

  /**
   * Get a shared access policy by name from an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security.
   */
  @summary("Get a shared access policy by name from an IoT hub. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security")
  @tag("POST")
  @action("listkeys")
  getKeysForKeyName is ArmResourceActionSync<
    IotHubDescription,
    void,
    ArmResponse<SharedAccessSignatureAuthorizationRule>,
    Parameters = {
      /**
       * The name of the shared access policy.
       */
      @path
      @segment("IotHubKeys")
      keyName: string;
    },
    Error = ErrorDetails
  >;

  /**
   * Exports all the device identities in the IoT hub identity registry to an Azure Storage blob container. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry#import-and-export-device-identities.
   */
  @summary("Exports all the device identities in the IoT hub identity registry to an Azure Storage blob container. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry#import-and-export-device-identities")
  @tag("POST")
  exportDevices is ArmResourceActionSync<
    IotHubDescription,
    ExportDevicesRequest,
    ArmResponse<JobResponse>,
    Error = ErrorDetails
  >;

  /**
   * Import, update, or delete device identities in the IoT hub identity registry from a blob. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry#import-and-export-device-identities.
   */
  @summary("Import, update, or delete device identities in the IoT hub identity registry from a blob. For more information, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry#import-and-export-device-identities")
  @tag("POST")
  importDevices is ArmResourceActionSync<
    IotHubDescription,
    ImportDevicesRequest,
    ArmResponse<JobResponse>,
    Error = ErrorDetails
  >;

  /**
   * Manually initiate a failover for the IoT Hub to its secondary region. To learn more, see https://aka.ms/manualfailover
   */
  @summary("Manually initiate a failover for the IoT Hub to its secondary region")
  @tag("POST")
  @action("failover")
  manualFailover is IotHubDescriptionOps.ActionAsync<
    IotHubDescription,
    FailoverInput,
    OkResponse,
    ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader,
    OverrideErrorType = ErrorDetails
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface IotHubDescriptionOperationGroup {
  /**
   * Get the statistics from an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/IotHubStats")
  @get
  @summary("Get the statistics from an IoT hub")
  @tag("GET")
  getStats(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @key
    @segment("IotHubs")
    resourceName: string,
  ): ArmResponse<RegistryStatistics> | ErrorDetails;
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
