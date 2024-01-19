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

@parentResource(ResourceTypeRegistration)
model SkuResource is ProxyResource<ResourceTypeSku> {
  @doc("The SKU.")
  @path
  @key("sku")
  @segment("skus")
  name: string;
}

@armResourceOperations
interface SkuResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the sku details for the given resource type and sku name.")
  @operationId("Skus_Get")
  get is ArmResourceRead<SkuResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates the resource type skus in the given resource type.")
  @operationId("Skus_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SkuResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a resource type sku.")
  @operationId("Skus_Delete")
  delete is ArmResourceDeleteSync<SkuResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of skus for the given resource type.")
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
