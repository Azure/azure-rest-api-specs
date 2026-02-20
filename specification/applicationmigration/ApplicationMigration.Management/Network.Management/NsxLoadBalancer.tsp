import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;

/**
 * An NSX load balancer resource.
 */
@parentResource(NetworkSite)
model NsxLoadBalancer
  is Azure.ResourceManager.ProxyResource<NsxLoadBalancerProperties, false> {
  ...ResourceNameParameter<
    Resource = NsxLoadBalancer,
    KeyName = "loadBalancerName",
    SegmentName = "loadBalancers",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of an NSX load balancer.
 */
model NsxLoadBalancerProperties is AzureResourceProperties {
  /** ARM resource ID of the associated NSX Manager. */
  nsxManagerRef?: Azure.Core.armResourceIdentifier;

  /** The type of load balancer (L4 or L7). */
  lbType?: LbType;

  /** The administrative state. */
  adminState?: AdminState;

  /** ARM resource ID of the parent gateway. */
  parentGateway?: Azure.Core.armResourceIdentifier;

  /** The frontend configuration. */
  frontend?: FrontendConfig;

  /** The backend configuration (pool, health probe, SNAT). */
  backendConfig?: BackendConfig;
}

@armResourceOperations
interface NsxLoadBalancers {
  /**
   * Gets the NsxLoadBalancer resource.
   */
  get is ArmResourceRead<NsxLoadBalancer>;

  /**
   * Creates or updates the NsxLoadBalancer resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NsxLoadBalancer>;

  /**
   * Patches the NsxLoadBalancer resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<NsxLoadBalancer, NsxLoadBalancerPatchProperties>;

  /**
   * Deletes the NsxLoadBalancer resource.
   */
  delete is ArmResourceDeleteSync<NsxLoadBalancer>;

  /**
   * Lists NsxLoadBalancer resources within a network site.
   */
  listByNetworkSite is ArmResourceListByParent<
    NsxLoadBalancer,
    Response = ArmResponse<NsxLoadBalancerList>
  >;
}

model NsxLoadBalancerList is Azure.Core.Page<NsxLoadBalancer>;

@@maxLength(NsxLoadBalancer.name, 63);
@@minLength(NsxLoadBalancer.name, 3);
@@doc(NsxLoadBalancer.name, "The name of the load balancer.");
