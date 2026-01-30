import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Legacy;

namespace Microsoft.RecoveryServices;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy TrackedResourceWithOptionalLocation for back compatibility"
@doc("")
@parentResource(VaultResource)
model ResourceGuardProxyBaseResource
  is TrackedResourceWithOptionalLocation<ResourceGuardProxyBase> {
  ...ResourceNameParameter<
    Resource = ResourceGuardProxyBaseResource,
    KeyName = "resourceGuardProxyName",
    SegmentName = "backupResourceGuardProxies",
    NamePattern = ""
  >;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: string;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @list
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
