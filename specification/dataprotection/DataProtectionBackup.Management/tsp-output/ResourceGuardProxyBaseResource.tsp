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
/**
 * ResourceGuardProxyBaseResource object, used for response and request bodies for ResourceGuardProxy APIs
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(BackupVaultResource)
@Azure.ResourceManager.Private.armResourceInternal(ResourceGuardProxyBase)
@includeInapplicableMetadataInPayload(false)
model ResourceGuardProxyBaseResource extends ProxyResourceBase {
  /**
   * name of the resource guard proxy
   */
  @pattern("^[A-Za-z0-9]*$")
  @path
  @key("resourceGuardProxyName")
  @segment("backupResourceGuardProxies")
  name: string;

  /**
   * ResourceGuardProxyBaseResource properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ResourceGuardProxyBase;
}

@armResourceOperations
interface ResourceGuardProxyBaseResources {
  /**
   * Returns the ResourceGuardProxy object associated with the vault, and that matches the name in the request
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DppResourceGuardProxy_Get")
  get is ArmResourceRead<ResourceGuardProxyBaseResource>;

  /**
   * Creates or Updates a ResourceGuardProxy
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DppResourceGuardProxy_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ResourceGuardProxyBaseResource>;

  /**
   * Deletes the ResourceGuardProxy
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DppResourceGuardProxy_Delete")
  delete is ArmResourceDeleteSync<ResourceGuardProxyBaseResource>;

  /**
   * Returns the list of ResourceGuardProxies associated with the vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DppResourceGuardProxy_List")
  list is ArmResourceListByParent<ResourceGuardProxyBaseResource>;

  /**
   * UnlockDelete call for ResourceGuardProxy, executed before one can delete it
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
