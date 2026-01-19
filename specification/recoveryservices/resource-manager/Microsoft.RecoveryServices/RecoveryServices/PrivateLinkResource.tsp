import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Vault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Information of the private link resource.
 */
@parentResource(Vault)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "privateLinkResourceName",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateLinkResourceOperationGroup {
  /**
   * Returns a specified private link resource that need to be created for Backup and SiteRecovery
   */
  get is ArmResourceRead<PrivateLinkResource, Error = CloudError>;

  /**
   * Returns the list of private link resources that need to be created for Backup and SiteRecovery
   */
  list is ArmResourceListByParent<
    PrivateLinkResource,
    Response = ArmResponse<PrivateLinkResources>,
    Error = CloudError
  >;
}

@@doc(PrivateLinkResource.name, "");
@@doc(PrivateLinkResource.properties, "Resource properties");
