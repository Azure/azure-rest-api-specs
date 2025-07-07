import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;

@parentResource(VaultResource)
model ResourceGuardProxyBaseResource
  is Azure.ResourceManager.TrackedResource<ResourceGuardProxyBase> {
  ...ResourceNameParameter<
    Resource = ResourceGuardProxyBaseResource,
    KeyName = "resourceGuardProxyName",
    SegmentName = "backupResourceGuardProxies",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ResourceGuardProxyBaseResources {
  /**
   * Returns ResourceGuardProxy under vault and with the name referenced in request
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuardProxy_Get")
  get is ArmResourceRead<ResourceGuardProxyBaseResource>;

  /**
   * Add or Update ResourceGuardProxy under vault
   * Secures vault critical operations
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ResourceGuardProxy_Put")
  put is ArmResourceCreateOrReplaceSync<
    ResourceGuardProxyBaseResource,
    Response = ArmResourceUpdatedResponse<ResourceGuardProxyBaseResource>
  >;

  /**
   * Delete ResourceGuardProxy under vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuardProxy_Delete")
  delete is ArmResourceDeleteSync<ResourceGuardProxyBaseResource>;

  /**
   * List the ResourceGuardProxies under vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuardProxies_Get")
  resourceGuardProxiesGet is ArmResourceListByParent<
    ResourceGuardProxyBaseResource,
    Response = ArmResponse<ResourceGuardProxyBaseResourceList>
  >;

  /**
   * Secures delete ResourceGuardProxy operations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceGuardProxy_UnlockDelete")
  unlockDelete is ArmResourceActionSync<
    ResourceGuardProxyBaseResource,
    UnlockDeleteRequest,
    ArmResponse<UnlockDeleteResponse>
  >;
}

@@doc(ResourceGuardProxyBaseResource.name, "");
@@doc(ResourceGuardProxyBaseResource.properties,
  "ResourceGuardProxyBaseResource properties"
);
@@doc(ResourceGuardProxyBaseResources.put::parameters.resource,
  "Request body for operation"
);
@@doc(ResourceGuardProxyBaseResources.unlockDelete::parameters.body,
  "Request body for operation"
);
