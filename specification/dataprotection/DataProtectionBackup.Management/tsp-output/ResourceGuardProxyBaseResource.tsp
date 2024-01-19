import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BackupVaultResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;
@doc("ResourceGuardProxyBaseResource object, used for response and request bodies for ResourceGuardProxy APIs")
@parentResource(BackupVaultResource)
model ResourceGuardProxyBaseResource is ProxyResource<ResourceGuardProxyBase> {
  @doc("name of the resource guard proxy")
  @pattern("^[A-Za-z0-9]*$")
  @path
  @key("resourceGuardProxyName")
  @segment("backupResourceGuardProxies")
  name: string;
}

@armResourceOperations
interface ResourceGuardProxyBaseResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the ResourceGuardProxy object associated with the vault, and that matches the name in the request")
  @operationId("DppResourceGuardProxy_Get")
  get is ArmResourceRead<ResourceGuardProxyBaseResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or Updates a ResourceGuardProxy")
  @operationId("DppResourceGuardProxy_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ResourceGuardProxyBaseResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the ResourceGuardProxy")
  @operationId("DppResourceGuardProxy_Delete")
  delete is ArmResourceDeleteSync<ResourceGuardProxyBaseResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the list of ResourceGuardProxies associated with the vault")
  @operationId("DppResourceGuardProxy_List")
  list is ArmResourceListByParent<ResourceGuardProxyBaseResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("UnlockDelete call for ResourceGuardProxy, executed before one can delete it")
  @operationId("DppResourceGuardProxy_UnlockDelete")
  unlockDelete is ArmResourceActionSync<
    ResourceGuardProxyBaseResource,
    UnlockDeleteRequest,
    UnlockDeleteResponse
  >;
}

@@projectedName(ResourceGuardProxyBaseResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ResourceGuardProxyBaseResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ResourceGuardProxyBaseResources.createOrUpdate::parameters.resource,
  "Request body for operation"
);
@@projectedName(ResourceGuardProxyBaseResources.unlockDelete::parameters.body,
  "json",
  "parameters"
);
@@extension(ResourceGuardProxyBaseResources.unlockDelete::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ResourceGuardProxyBaseResources.unlockDelete::parameters.body,
  "Request body for operation"
);
