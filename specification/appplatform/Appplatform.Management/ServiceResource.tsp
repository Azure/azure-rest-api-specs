import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Service resource
 */
model ServiceResource
  is Azure.ResourceManager.TrackedResource<ClusterResourceProperties> {
  ...ResourceNameParameter<
    Resource = ServiceResource,
    KeyName = "serviceName",
    SegmentName = "Spring",
    NamePattern = "^[a-z][a-z0-9-]*[a-z0-9]$"
  >;

  /**
   * Managed Identity of the Service resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: SystemAssignedServiceIdentity;

  /**
   * Sku of the Service resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

@armResourceOperations
interface ServiceResources {
  /**
   * Get a Service and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_Get")
  get is ArmResourceRead<ServiceResource>;

  /**
   * Create a new Service or update an exiting Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("Services_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServiceResource,
    Response = ArmResourceUpdatedResponse<ServiceResource> | ArmResourceCreatedResponse<
      ServiceResource,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: ServiceResource;
    })
  >;

  /**
   * Operation to update an exiting Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("Services_Update")
  update is ArmCustomPatchAsync<
    ServiceResource,
    PatchModel = ServiceResource,
    Response = ArmResponse<ServiceResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: ServiceResource;
    })
  >;

  /**
   * Operation to delete a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Services_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ServiceResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all resources in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_List")
  list is ArmResourceListByParent<
    ServiceResource,
    Response = ArmResponse<ServiceResourceList>
  >;

  /**
   * Handles requests to list all resources in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    ServiceResource,
    Response = ArmResponse<ServiceResourceList>
  >;

  /**
   * List test keys for a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_ListTestKeys")
  listTestKeys is ArmResourceActionSync<
    ServiceResource,
    void,
    ArmResponse<TestKeys>
  >;

  /**
   * Regenerate a test key for a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_RegenerateTestKey")
  regenerateTestKey is ArmResourceActionSync<
    ServiceResource,
    RegenerateTestKeyRequestPayload,
    ArmResponse<TestKeys>
  >;

  /**
   * Disable test endpoint functionality for a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_DisableTestEndpoint")
  disableTestEndpoint is ArmResourceActionSync<
    ServiceResource,
    void,
    OkResponse
  >;

  /**
   * Enable test endpoint functionality for a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_EnableTestEndpoint")
  enableTestEndpoint is ArmResourceActionSync<
    ServiceResource,
    void,
    ArmResponse<TestKeys>
  >;

  /**
   * Stop a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_Stop")
  stop is ArmResourceActionAsyncBase<
    ServiceResource,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ServiceResource>
  >;

  /**
   * Start a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_Start")
  start is ArmResourceActionAsyncBase<
    ServiceResource,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ServiceResource>
  >;

  /**
   * Flush Virtual Network DNS settings for a VNET injected Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("flushVirtualNetworkDnsSettings")
  @operationId("Services_FlushVnetDnsSetting")
  flushVnetDnsSetting is ArmResourceActionAsyncBase<
    ServiceResource,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ServiceResource>
  >;

  /**
   * List supported APM types for a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("supportedApmTypes")
  @operationId("Services_ListSupportedApmTypes")
  listSupportedApmTypes is ArmResourceActionSync<
    ServiceResource,
    void,
    ArmResponse<SupportedApmTypes>
  >;

  /**
   * List globally enabled APMs for a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_ListGloballyEnabledApms")
  listGloballyEnabledApms is ArmResourceActionSync<
    ServiceResource,
    void,
    ArmResponse<GloballyEnabledApms>
  >;

  /**
   * Enable an APM globally.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_EnableApmGlobally")
  enableApmGlobally is ArmResourceActionAsync<
    ServiceResource,
    ApmReference,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Disable an APM globally.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_DisableApmGlobally")
  disableApmGlobally is ArmResourceActionAsync<
    ServiceResource,
    ApmReference,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists all of the available server versions supported by Microsoft.AppPlatform provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("supportedServerVersions")
  @operationId("Services_ListSupportedServerVersions")
  listSupportedServerVersions is ArmResourceActionSync<
    ServiceResource,
    void,
    ArmResponse<SupportedServerVersions>
  >;

  /**
   * Check if the config server settings are valid.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigServers_Validate")
  validate is ArmResourceActionAsync<
    ServiceResource,
    ConfigServerSettings,
    ArmResponse<ConfigServerSettingsValidateResult>
  >;

  /**
   * Get collection of buildpack bindings under all builders.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("buildpackBindings")
  @operationId("BuildpackBinding_ListForCluster")
  listForCluster is ArmResourceActionSync<
    ServiceResource,
    void,
    ArmResponse<BuildpackBindingResourceCollection>
  >;

  /**
   * List deployments for a certain service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("deployments")
  @operationId("Deployments_ListForCluster")
  deploymentsListForCluster is ArmResourceActionSync<
    ServiceResource,
    void,
    ArmResponse<DeploymentResourceCollection>,
    Parameters = {
      /**
       * Version of the deployments to be listed
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "For backward compatibility"
      @query(#{ name: "version", explode: true })
      version?: string[];

      /**
       * The expand expression to apply on the operation.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
}

@@doc(ServiceResource.name, "The name of the Service resource.");
@@doc(ServiceResource.properties, "Properties of the Service resource");
@@doc(ServiceResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@doc(ServiceResources.update::parameters.properties,
  "Parameters for the update operation"
);
@@doc(ServiceResources.regenerateTestKey::parameters.body,
  "Parameters for the operation"
);
@@doc(ServiceResources.enableApmGlobally::parameters.body,
  "The target APM for the enable operation"
);
@@doc(ServiceResources.disableApmGlobally::parameters.body,
  "The target APM for the disable operation"
);
@@doc(ServiceResources.validate::parameters.body,
  "Config server settings to be validated"
);
