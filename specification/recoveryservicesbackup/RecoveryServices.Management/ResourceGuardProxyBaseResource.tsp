import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.RecoveryServices;

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(VaultResource)
@Azure.ResourceManager.Private.armResourceInternal(ResourceGuardProxyBase)
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model ResourceGuardProxyBaseResource extends Resource {
  ...ResourceNameParameter<
    Resource = ResourceGuardProxyBaseResource,
    KeyName = "resourceGuardProxyName",
    SegmentName = "backupResourceGuardProxies",
    NamePattern = ""
  >;

  /**
   * ResourceGuardProxyBaseResource properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ResourceGuardProxyBase;
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
@@doc(ResourceGuardProxy.put::parameters.resource,
  "Request body for operation"
);
@@doc(ResourceGuardProxy.unlockDelete::parameters.body,
  "Request body for operation"
);
