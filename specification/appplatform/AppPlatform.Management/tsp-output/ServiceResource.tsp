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
@doc("Service resource")
model ServiceResource is TrackedResource<ClusterResourceProperties> {
  @doc("The name of the Service resource.")
  @path
  @key("serviceName")
  @segment("Spring")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ServiceResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a Service and its properties.")
  @operationId("Services_Get")
  get is ArmResourceRead<ServiceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a new Service or update an exiting Service.")
  @operationId("Services_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServiceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to update an exiting Service.")
  @operationId("Services_Update")
  update is ArmCustomPatchAsync<ServiceResource, ServiceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to delete a Service.")
  @operationId("Services_Delete")
  delete is ArmResourceDeleteAsync<ServiceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all resources in a resource group.")
  @operationId("Services_List")
  list is ArmResourceListByParent<ServiceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all resources in a subscription.")
  @operationId("Services_ListBySubscription")
  listBySubscription is ArmListBySubscription<ServiceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List test keys for a Service.")
  @operationId("Services_ListTestKeys")
  listTestKeys is ArmResourceActionSync<ServiceResource, void, TestKeys>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Regenerate a test key for a Service.")
  @operationId("Services_RegenerateTestKey")
  regenerateTestKey is ArmResourceActionSync<
    ServiceResource,
    RegenerateTestKeyRequestPayload,
    TestKeys
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Disable test endpoint functionality for a Service.")
  @operationId("Services_DisableTestEndpoint")
  disableTestEndpoint is ArmResourceActionSync<ServiceResource, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Enable test endpoint functionality for a Service.")
  @operationId("Services_EnableTestEndpoint")
  enableTestEndpoint is ArmResourceActionSync<ServiceResource, void, TestKeys>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Stop a Service.")
  @operationId("Services_Stop")
  stop is ArmResourceActionNoResponseContentAsync<ServiceResource, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Start a Service.")
  @operationId("Services_Start")
  start is ArmResourceActionNoResponseContentAsync<ServiceResource, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Check if the config server settings are valid.")
  @operationId("ConfigServers_Validate")
  validate is ArmResourceActionAsync<
    ServiceResource,
    ConfigServerSettings,
    ConfigServerSettingsValidateResult,
    BaseParameters<ServiceResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Checks that the resource name is valid and is not already in use.")
  @operationId("Services_CheckNameAvailability")
  checkNameAvailability is checkLocalNameAvailability<
    NameAvailabilityParameters,
    NameAvailability
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_ListForCluster")
  @doc("List deployments for a certain service")
  // FIXME: Deployments_ListForCluster could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AppPlatform/Spring/{serviceName}/deployments")
  @get
  listForCluster is Azure.Core.Foundations.Operation<
    {
      @doc("Gets subscription ID which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the Service resource.")
      @path
      serviceName: string;

      @doc("Version of the deployments to be listed")
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
