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

namespace Microsoft.AppPlatform;
/**
 * Service resource
 */
model ServiceResource is TrackedResource<ClusterResourceProperties> {
  /**
   * The name of the Service resource.
   */
  @path
  @key("serviceName")
  @segment("Spring")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ServiceResources {
  /**
   * Get a Service and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_Get")
  get is ArmResourceRead<ServiceResource>;

  /**
   * Create a new Service or update an exiting Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServiceResource>;

  /**
   * Operation to update an exiting Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Services_Update")
  update is ArmCustomPatchAsync<ServiceResource, ServiceResource>;

  /**
   * Operation to delete a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_Delete")
  delete is ArmResourceDeleteAsync<ServiceResource>;

  /**
   * Handles requests to list all resources in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_List")
  list is ArmResourceListByParent<ServiceResource>;

  /**
   * Handles requests to list all resources in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_ListBySubscription")
  listBySubscription is ArmListBySubscription<ServiceResource>;

  /**
   * List test keys for a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_ListTestKeys")
  listTestKeys is ArmResourceActionSync<ServiceResource, void, TestKeys>;

  /**
   * Regenerate a test key for a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_RegenerateTestKey")
  regenerateTestKey is ArmResourceActionSync<
    ServiceResource,
    RegenerateTestKeyRequestPayload,
    TestKeys
  >;

  /**
   * Disable test endpoint functionality for a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_DisableTestEndpoint")
  disableTestEndpoint is ArmResourceActionSync<ServiceResource, void, void>;

  /**
   * Enable test endpoint functionality for a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_EnableTestEndpoint")
  enableTestEndpoint is ArmResourceActionSync<ServiceResource, void, TestKeys>;

  /**
   * Stop a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_Stop")
  stop is ArmResourceActionNoResponseContentAsync<ServiceResource, void>;

  /**
   * Start a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_Start")
  start is ArmResourceActionNoResponseContentAsync<ServiceResource, void>;

  /**
   * Check if the config server settings are valid.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConfigServers_Validate")
  validate is ArmResourceActionAsync<
    ServiceResource,
    ConfigServerSettings,
    ConfigServerSettingsValidateResult,
    BaseParameters<ServiceResource>,
    ArmLroLocationHeader
  >;

  /**
   * Checks that the resource name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_CheckNameAvailability")
  checkNameAvailability is checkLocalNameAvailability<
    NameAvailabilityParameters,
    NameAvailability
  >;

  /**
   * List deployments for a certain service
   */
  // FIXME: Deployments_ListForCluster could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_ListForCluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AppPlatform/Spring/{serviceName}/deployments")
  @get
  listForCluster is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription ID which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the Service resource.
       */
      @path
      serviceName: string;

      /**
       * Version of the deployments to be listed
       */
      @query({
        name: "version",
        format: "multi",
      })
      version?: string[];
    },
    ResourceListResult<DeploymentResource>
  >;
}

@@doc(ServiceResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@projectedName(ServiceResources.update::parameters.properties,
  "json",
  "resource"
);
@@extension(ServiceResources.update::parameters.properties,
  "x-ms-client-name",
  "resource"
);
@@doc(ServiceResources.update::parameters.properties,
  "Parameters for the update operation"
);
@@projectedName(ServiceResources.regenerateTestKey::parameters.body,
  "json",
  "regenerateTestKeyRequest"
);
@@extension(ServiceResources.regenerateTestKey::parameters.body,
  "x-ms-client-name",
  "regenerateTestKeyRequest"
);
@@doc(ServiceResources.regenerateTestKey::parameters.body,
  "Parameters for the operation"
);
@@projectedName(ServiceResources.validate::parameters.body,
  "json",
  "configServerSettings"
);
@@extension(ServiceResources.validate::parameters.body,
  "x-ms-client-name",
  "configServerSettings"
);
@@doc(ServiceResources.validate::parameters.body,
  "Config server settings to be validated"
);
