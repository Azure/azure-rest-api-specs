import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "./BackupVaultResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;
/**
 * ResourceGuardProxyBaseResource object, used for response and request bodies for ResourceGuardProxy APIs
 */
@parentResource(BackupVaultResource)
model ResourceGuardProxyBaseResource
  is Azure.ResourceManager.ProxyResource<ResourceGuardProxyBase> {
  ...ResourceNameParameter<
    Resource = ResourceGuardProxyBaseResource,
    KeyName = "resourceGuardProxyName",
    SegmentName = "backupResourceGuardProxies",
    NamePattern = "^[A-Za-z0-9]*$"
  >;
}

@armResourceOperations
interface ResourceGuardProxyBaseResources {
  /**
   * Returns the ResourceGuardProxy object associated with the vault, and that matches the name in the request
   */
  get is ArmResourceRead<
    Resource = ResourceGuardProxyBaseResource,
    Error = CloudError
  >;

  /**
   * Creates or Updates a ResourceGuardProxy
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ResourceGuardProxyBaseResource,
    Response = ArmResourceUpdatedResponse<ResourceGuardProxyBaseResource>,
    Error = CloudError
  >;

  /**
   * Deletes the ResourceGuardProxy
   */
  delete is ArmResourceDeleteSync<
    Resource = ResourceGuardProxyBaseResource,
    Error = CloudError
  >;

  /**
   * Returns the list of ResourceGuardProxies associated with the vault
   */
  @list
  list is ArmResourceListByParent<
    ResourceGuardProxyBaseResource,
    Response = ArmResponse<ResourceGuardProxyBaseResourceList>,
    Error = CloudError
  >;

  /**
   * UnlockDelete call for ResourceGuardProxy, executed before one can delete it
   */
  unlockDelete is ArmResourceActionSync<
    ResourceGuardProxyBaseResource,
    UnlockDeleteRequest,
    ArmResponse<UnlockDeleteResponse>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    Error = CloudError
  >;
}

@@doc(ResourceGuardProxyBaseResource.name, "name of the resource guard proxy");
@@doc(ResourceGuardProxyBaseResource.properties,
  "ResourceGuardProxyBaseResource properties"
);
@@doc(ResourceGuardProxyBaseResources.createOrUpdate::parameters.resource,
  "Request body for operation"
);
@@doc(ResourceGuardProxyBaseResources.unlockDelete::parameters.body,
  "Request body for operation"
);
