import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace
@service({
  title: "Azure Dev Tunnels",
  version: "2023-05-23-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.DevTunnels;

interface Operations extends Azure.ResourceManager.Operations {
  @tag("CheckNameAvailability")
  checkName is checkGlobalNameAvailability;
}

@doc("Provisioning state enum")
enum ProvisioningState {
  @doc("The operation succeeded")
  Succeeded,
  
  @doc("The operation failed")
  Failed,

  @doc("The operation was canceled")
  Canceled,
}

@doc("The properties of TunnelPlan")
model TunnelPlanProperties {
  @doc("The billing tier for the plan")
  billingTier: string;

  @doc("Cluster ID where the TunnelPlan resides, used for data-plane operations")
  @visibility("read")
  clusterId?: string;

  @doc("The provisioning state of the plan")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("A Tunnel Plan resource")
model TunnelPlanResource is TrackedResource<TunnelPlanProperties> {
  @key("planName")
  @segment("tunnelPlans")
  @doc("The name of the Tunnel Plan")
  @visibility("read")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
  ...EntityTag;
}

@doc("The response to a getToken request")
model GetTokenResponse {
  @doc("The TunnelPlan token")
  token: string;
}

@armResourceOperations
interface TunnelPlans {
  @autoRoute
  @armResourceAction(TResource)
  @post
  @doc("POST ARM resource action with no body")
  ArmResourceActionNoBodySync<
    TResource extends ArmResource,
    TResponse extends {},
    TBaseParameters = BaseParameters<TResource>
  >(
    ...ResourceInstanceParameters<TResource, TBaseParameters>
  ): ArmResponse<TResponse> | ErrorResponse;

  get is ArmResourceRead<TunnelPlanResource>;
  createOrUpdate is ArmResourceCreateOrUpdateSync<TunnelPlanResource>;
  update is ArmResourcePatchSync<TunnelPlanResource, TunnelPlanProperties>;
  delete is ArmResourceDeleteSync<TunnelPlanResource>;
  listByResourceGroup is ArmResourceListByParent<TunnelPlanResource>;
  listBySubscription is ArmListBySubscription<TunnelPlanResource>;
  @doc("Get a Tunnel Plan token")
  listToken is TunnelPlans.ArmResourceActionNoBodySync<
    TunnelPlanResource,
    GetTokenResponse
  >;
}

@doc("The properties of a billing tier")
model BillingTierProperties {
  @doc("Description of the billing tier")
  description: string;

  @doc("The provisioning state of the plan")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@subscriptionResource
model BillingTierResource is ProxyResource<BillingTierProperties> {
  @doc("Billing Tier Name")
  @visibility("read")
  @key
  @path
  @segment("billingTiers")
  name: string;
}

@armResourceOperations(BillingTierResource)
interface BillingTiers
  extends ResourceListBySubscription<BillingTierResource> {}