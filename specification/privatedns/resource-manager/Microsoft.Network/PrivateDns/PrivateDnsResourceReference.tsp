import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Network;

/** Queries Private DNS record sets that reference other Azure resources. */
@added(Versions.v2026_06_01_preview)
@armResourceOperations(#{ omitTags: true })
interface PrivateDnsResourceReferenceOperations {
  /**
   * Returns the private DNS zone records specified by the referencing targetResourceIds.
   */
  @autoRoute
  @action("getPrivateDnsResourceReference")
  getByTargetResources is ArmProviderActionSync<
    Request = PrivateDnsResourceReferenceRequest,
    Response = PrivateDnsResourceReferenceResult,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
}
