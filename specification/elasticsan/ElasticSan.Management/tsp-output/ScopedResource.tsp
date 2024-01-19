import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AzureMonitorPrivateLinkScope.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
@doc("A private link scoped resource")
@parentResource(AzureMonitorPrivateLinkScope)
model ScopedResource is ProxyResource<ScopedResourceProperties> {
  @doc("The name of the scoped resource object.")
  @path
  @key("name")
  @segment("scopedResources")
  name: string;
}

@armResourceOperations
interface ScopedResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a scoped resource in a private link scope.")
  @operationId("PrivateLinkScopedResources_Get")
  get is ArmResourceRead<ScopedResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Approve or reject a private endpoint connection with a given name.")
  @operationId("PrivateLinkScopedResources_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ScopedResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a private endpoint connection with a given name.")
  @operationId("PrivateLinkScopedResources_Delete")
  delete is ArmResourceDeleteAsync<ScopedResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all private endpoint connections on a private link scope.")
  @operationId("PrivateLinkScopedResources_ListByPrivateLinkScope")
  listByPrivateLinkScope is ArmResourceListByParent<ScopedResource>;
}

@@projectedName(ScopedResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ScopedResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ScopedResources.createOrUpdate::parameters.resource, "");
