import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EndpointResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridConnectivity;
/**
 * The service configuration details associated with the target resource.
 */
@parentResource(EndpointResource)
model ServiceConfigurationResource
  is Azure.ResourceManager.ExtensionResource<ServiceConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = ServiceConfigurationResource,
    KeyName = "serviceConfigurationName",
    SegmentName = "serviceConfigurations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ServiceConfigurationResources {
  /**
   * Gets the details about the service to the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServiceConfigurations_Get")
  get is ArmResourceRead<
    ServiceConfigurationResource,
    Azure.ResourceManager.Foundations.ExtensionBaseParameters
  >;

  /**
   * Create or update a service in serviceConfiguration for the endpoint resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServiceConfigurations_CreateOrupdate")
  createOrupdate is ArmResourceCreateOrReplaceSync<
    ServiceConfigurationResource,
    Azure.ResourceManager.Foundations.ExtensionBaseParameters
  >;

  /**
   * Update the service details in the service configurations of the target resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("ServiceConfigurations_Update")
  update is ArmCustomPatchSync<
    ServiceConfigurationResource,
    ServiceConfigurationResourcePatch,
    Azure.ResourceManager.Foundations.ExtensionBaseParameters
  >;

  /**
   * Deletes the service details to the target resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "For backward compatibility"
  @operationId("ServiceConfigurations_Delete")
  delete is ArmResourceDeleteSync<
    ServiceConfigurationResource,
    Azure.ResourceManager.Foundations.ExtensionBaseParameters
  >;

  /**
   * API to enumerate registered services in service configurations under a Endpoint Resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServiceConfigurations_ListByEndpointResource")
  listByEndpointResource is ArmResourceListByParent<
    ServiceConfigurationResource,
    Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Response = ServiceConfigurationList
  >;
}

@@doc(ServiceConfigurationResource.name, "The service name.");
@@doc(ServiceConfigurationResource.properties,
  "The service configuration properties."
);
@@doc(ServiceConfigurationResources.createOrupdate::parameters.resource,
  "Service details"
);
@@doc(ServiceConfigurationResources.update::parameters.properties,
  "Service details"
);
@@summary(ServiceConfigurationResources.listByEndpointResource,
  "Lists of all the services associated with endpoint resource."
);
@@path(ServiceConfigurationResource.name, #{ allowReserved: true });
