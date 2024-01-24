import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProviderRegistration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ProviderRegistration)
@Azure.ResourceManager.Private.armResourceInternal(
  ResourceTypeRegistrationProperties
)
@includeInapplicableMetadataInPayload(false)
model ResourceTypeRegistration extends ProxyResourceBase {
  /**
   * The resource type.
   */
  @path
  @key("resourceType")
  @segment("resourcetypeRegistrations")
  name: string;

  @extension("x-ms-client-flatten", true)
  properties?: ResourceTypeRegistrationProperties;
}

@armResourceOperations
interface ResourceTypeRegistrations {
  /**
   * Gets a resource type details in the given subscription and provider.
   */
  get is ArmResourceRead<ResourceTypeRegistration>;

  /**
   * Creates or updates a resource type.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ResourceTypeRegistration,
    BaseParameters<ResourceTypeRegistration>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a resource type
   */
  delete is ArmResourceDeleteSync<ResourceTypeRegistration>;

  /**
   * Gets the list of the resource types for the given provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceTypeRegistrations_ListByProviderRegistration")
  listByProviderRegistration is ArmResourceListByParent<ResourceTypeRegistration>;
}

@@projectedName(ResourceTypeRegistrations.createOrUpdate::parameters.resource,
  "json",
  "properties"
);
@@extension(ResourceTypeRegistrations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "properties"
);
@@doc(ResourceTypeRegistrations.createOrUpdate::parameters.resource,
  "The required request body parameters supplied to the resource type registration CreateOrUpdate operation."
);
