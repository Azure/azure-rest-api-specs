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

namespace Microsoft.Insights;
@doc("An Azure Monitor PrivateLinkScope definition.")
model AzureMonitorPrivateLinkScope
  is TrackedResource<AzureMonitorPrivateLinkScopeProperties> {
  @doc("The name of the Azure Monitor PrivateLinkScope resource.")
  @path
  @key("scopeName")
  @segment("privateLinkScopes")
  name: string;
}

@armResourceOperations
interface AzureMonitorPrivateLinkScopes {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a Azure Monitor PrivateLinkScope.")
  @operationId("PrivateLinkScopes_Get")
  get is ArmResourceRead<AzureMonitorPrivateLinkScope>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates (or updates) a Azure Monitor PrivateLinkScope. Note: You cannot specify a different value for InstrumentationKey nor AppId in the Put operation.")
  @operationId("PrivateLinkScopes_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AzureMonitorPrivateLinkScope>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates an existing PrivateLinkScope's tags. To update other fields use the CreateOrUpdate method.")
  @operationId("PrivateLinkScopes_UpdateTags")
  updateTags is ArmCustomPatchSync<AzureMonitorPrivateLinkScope, TagsResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a Azure Monitor PrivateLinkScope.")
  @operationId("PrivateLinkScopes_Delete")
  delete is ArmResourceDeleteAsync<AzureMonitorPrivateLinkScope>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of Azure Monitor PrivateLinkScopes within a resource group.")
  @operationId("PrivateLinkScopes_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AzureMonitorPrivateLinkScope>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of all Azure Monitor PrivateLinkScopes within a subscription.")
  @operationId("PrivateLinkScopes_List")
  list is ArmListBySubscription<AzureMonitorPrivateLinkScope>;
}

@@projectedName(AzureMonitorPrivateLinkScopes.createOrUpdate::parameters.resource,
  "json",
  "AzureMonitorPrivateLinkScopePayload"
);
@@extension(AzureMonitorPrivateLinkScopes.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "AzureMonitorPrivateLinkScopePayload"
);
@@doc(AzureMonitorPrivateLinkScopes.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create or update a Azure Monitor PrivateLinkScope."
);
@@projectedName(AzureMonitorPrivateLinkScopes.updateTags::parameters.properties,
  "json",
  "PrivateLinkScopeTags"
);
@@extension(AzureMonitorPrivateLinkScopes.updateTags::parameters.properties,
  "x-ms-client-name",
  "PrivateLinkScopeTags"
);
@@doc(AzureMonitorPrivateLinkScopes.updateTags::parameters.properties,
  "Updated tag information to set into the PrivateLinkScope instance."
);
