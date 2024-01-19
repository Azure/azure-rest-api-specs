import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SignalRResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SignalRService;
@doc("Describes a Shared Private Link Resource")
@parentResource(SignalRResource)
model SharedPrivateLinkResource
  is ProxyResource<SharedPrivateLinkResourceProperties> {
  @doc("The name of the shared private link resource")
  @path
  @key("sharedPrivateLinkResourceName")
  @segment("sharedPrivateLinkResources")
  name: string;
}

@armResourceOperations
interface SharedPrivateLinkResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the specified shared private link resource")
  @operationId("SignalRSharedPrivateLinkResources_Get")
  get is ArmResourceRead<SharedPrivateLinkResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a shared private link resource")
  @operationId("SignalRSharedPrivateLinkResources_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SharedPrivateLinkResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the specified shared private link resource")
  @operationId("SignalRSharedPrivateLinkResources_Delete")
  delete is ArmResourceDeleteAsync<SharedPrivateLinkResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List shared private link resources")
  @operationId("SignalRSharedPrivateLinkResources_List")
  list is ArmResourceListByParent<SharedPrivateLinkResource>;
}

@@projectedName(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "The shared private link resource"
);
