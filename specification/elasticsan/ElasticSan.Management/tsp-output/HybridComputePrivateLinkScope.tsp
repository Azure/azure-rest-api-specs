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

namespace Microsoft.HybridCompute;
@doc("An Azure Arc PrivateLinkScope definition.")
model HybridComputePrivateLinkScope
  is TrackedResource<HybridComputePrivateLinkScopeProperties> {
  @doc("The name of the Azure Arc PrivateLinkScope resource.")
  @pattern("[a-zA-Z0-9-_\\.]+")
  @path
  @key("scopeName")
  @segment("privateLinkScopes")
  name: string;
}

@armResourceOperations
interface HybridComputePrivateLinkScopes {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a Azure Arc PrivateLinkScope.")
  @operationId("PrivateLinkScopes_Get")
  get is ArmResourceRead<HybridComputePrivateLinkScope>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates (or updates) a Azure Arc PrivateLinkScope. Note: You cannot specify a different value for InstrumentationKey nor AppId in the Put operation.")
  @operationId("PrivateLinkScopes_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<HybridComputePrivateLinkScope>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates an existing PrivateLinkScope's tags. To update other fields use the CreateOrUpdate method.")
  @operationId("PrivateLinkScopes_UpdateTags")
  updateTags is ArmCustomPatchSync<HybridComputePrivateLinkScope, TagsResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a Azure Arc PrivateLinkScope.")
  @operationId("PrivateLinkScopes_Delete")
  delete is ArmResourceDeleteAsync<HybridComputePrivateLinkScope>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of Azure Arc PrivateLinkScopes within a resource group.")
  @operationId("PrivateLinkScopes_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<HybridComputePrivateLinkScope>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of all Azure Arc PrivateLinkScopes within a subscription.")
  @operationId("PrivateLinkScopes_List")
  list is ArmListBySubscription<HybridComputePrivateLinkScope>;
}

@@projectedName(HybridComputePrivateLinkScopes.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(HybridComputePrivateLinkScopes.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(HybridComputePrivateLinkScopes.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create or update a Azure Arc for Servers and Clusters PrivateLinkScope."
);
@@projectedName(HybridComputePrivateLinkScopes.updateTags::parameters.properties,
  "json",
  "PrivateLinkScopeTags"
);
@@extension(HybridComputePrivateLinkScopes.updateTags::parameters.properties,
  "x-ms-client-name",
  "PrivateLinkScopeTags"
);
@@doc(HybridComputePrivateLinkScopes.updateTags::parameters.properties,
  "Updated tag information to set into the PrivateLinkScope instance."
);
