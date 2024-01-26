import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ResourceTypeRegistration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ResourceTypeRegistration)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ResourceTypeSku)
model SkuResource extends ProxyResourceBase {
  /**
   * The SKU.
   */
  @path
  @key("sku")
  @segment("skus")
  @visibility("read")
  name: string;

  @extension("x-ms-client-flatten", true)
  properties?: ResourceTypeSku;
}

@armResourceOperations
interface SkuResources {
  /**
   * Gets the sku details for the given resource type and sku name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Skus_Get")
  get is ArmResourceRead<SkuResource>;

  /**
   * Creates or updates the resource type skus in the given resource type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Skus_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SkuResource>;

  /**
   * Deletes a resource type sku.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Skus_Delete")
  delete is ArmResourceDeleteSync<SkuResource>;

  /**
   * Gets the list of skus for the given resource type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Skus_ListByResourceTypeRegistrations")
  listByResourceTypeRegistrations is ArmResourceListByParent<SkuResource>;
}

@@projectedName(SkuResources.createOrUpdate::parameters.resource,
  "json",
  "properties"
);
@@extension(SkuResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "properties"
);
@@doc(SkuResources.createOrUpdate::parameters.resource,
  "The required body parameters supplied to the resource sku operation."
);
