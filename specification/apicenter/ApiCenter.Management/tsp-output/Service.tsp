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

namespace Microsoft.ApiCenter;
/**
 * The service entity.
 */
model Service is TrackedResource<ServiceProperties> {
  /**
   * Service name
   */
  @pattern("^[a-zA-Z0-9\\-]{1,64}$")
  @path
  @key("serviceName")
  @segment("services")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Services {
  /**
   * Get service
   */
  get is ArmResourceRead<Service>;

  /**
   * Create or update service
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Service>;

  /**
   * Update service
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Service, ServiceUpdate>;

  /**
   * Delete service
   */
  delete is ArmResourceDeleteSync<Service>;

  /**
   * Lists services within a resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Service>;

  /**
   * Lists services within an Azure subscription.
   */
  listBySubscription is ArmListBySubscription<Service>;
}

@@doc(Services.createOrUpdate::parameters.resource, "The service entity.");
@@projectedName(Services.update::parameters.properties, "json", "parameters");
@@extension(Services.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Services.update::parameters.properties,
  "The service properties to be updated."
);
