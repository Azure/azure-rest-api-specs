import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Service Registry resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ServiceResource)
@Azure.ResourceManager.Private.armResourceInternal(ServiceRegistryProperties)
@includeInapplicableMetadataInPayload(false)
model ServiceRegistryResource extends ProxyResource {
  /**
   * The name of Service Registry.
   */
  @path
  @key("serviceRegistryName")
  @segment("serviceRegistries")
  name: string;

  /**
   * Service Registry properties payload
   */
  @extension("x-ms-client-flatten", true)
  properties?: ServiceRegistryProperties;
}

@armResourceOperations
interface ServiceRegistryResources {
  /**
   * Get the Service Registry and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServiceRegistries_Get")
  get is ArmResourceRead<ServiceRegistryResource>;

  /**
   * Create the default Service Registry or update the existing Service Registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServiceRegistries_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServiceRegistryResource>;

  /**
   * Disable the default Service Registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServiceRegistries_Delete")
  delete is ArmResourceDeleteAsync<ServiceRegistryResource>;

  /**
   * Handles requests to list all resources in a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServiceRegistries_List")
  list is ArmResourceListByParent<ServiceRegistryResource>;
}
