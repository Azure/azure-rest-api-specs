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
interface ResourceGuardProxy {
  /**
   * Returns ResourceGuardProxy under vault and with the name referenced in request
   */
  get is ArmResourceRead<ResourceGuardProxyBaseResource>;

  /**
   * Add or Update ResourceGuardProxy under vault
   * Secures vault critical operations
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  put is ArmResourceCreateOrReplaceSync<
    ResourceGuardProxyBaseResource,
    Response = ArmResourceUpdatedResponse<ResourceGuardProxyBaseResource>
  >;

  /**
   * Delete ResourceGuardProxy under vault
   */
  delete is ArmResourceDeleteSync<ResourceGuardProxyBaseResource>;

  /**
   * Secures delete ResourceGuardProxy operations.
   */
  unlockDelete is ArmResourceActionSync<
    ResourceGuardProxyBaseResource,
    UnlockDeleteRequest,
    ArmResponse<UnlockDeleteResponse>
  >;
}

@armResourceOperations
interface ResourceGuardProxies {
  /**
   * List the ResourceGuardProxies under vault
   */
  get is ArmResourceListByParent<
    ResourceGuardProxyBaseResource,
    Response = ArmResponse<ResourceGuardProxyBaseResourceList>
  >;
}

@@doc(ResourceGuardProxyBaseResource.name, "");
@@doc(ResourceGuardProxyBaseResource.properties,
  "ResourceGuardProxyBaseResource properties"
);
@@doc(ResourceGuardProxy.put::parameters.resource,
  "Request body for operation"
);
@@doc(ResourceGuardProxy.unlockDelete::parameters.body,
  "Request body for operation"
);
