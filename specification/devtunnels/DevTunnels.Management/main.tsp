import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Azure Dev Tunnels" })
@versioned(Versions)
namespace Microsoft.DevTunnels;

enum Versions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  `2023-05-23-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {
  @tag("CheckNameAvailability")
  checkName is checkGlobalNameAvailability;
}

@doc("Provisioning state enum")
union ProvisioningState {
  string,

  @doc("The operation succeeded")
  Succeeded: "Succeeded",

  @doc("The operation failed")
  Failed: "Failed",

  @doc("The operation was canceled")
  Canceled: "Canceled",
}

@doc("The properties of TunnelPlan")
model TunnelPlanProperties {
  @doc("The billing tier for the plan")
  billingTier: string;

  @doc("Cluster ID where the TunnelPlan resides, used for data-plane operations")
  @visibility(Lifecycle.Read)
  clusterId?: string;

  @doc("The provisioning state of the plan")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("A Tunnel Plan resource")
model TunnelPlanResource is TrackedResource<TunnelPlanProperties> {
  @key("planName")
  @segment("tunnelPlans")
  @doc("The name of the Tunnel Plan")
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;

  ...EntityTagProperty;
}

@doc("The response to a getToken request")
model GetTokenResponse {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
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
    TResource extends Azure.ResourceManager.CommonTypes.Resource,
    TResponse extends {},
    TBaseParameters = Azure.ResourceManager.Foundations.BaseParameters<TResource>
  >(
    ...ResourceInstanceParameters<TResource, TBaseParameters>,
  ): ArmResponse<TResponse> | ErrorResponse;

  get is ArmResourceRead<TunnelPlanResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<TunnelPlanResource>;
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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@subscriptionResource
model BillingTierResource is ProxyResource<BillingTierProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Legacy"
  @doc("Billing Tier Name")
  @visibility(Lifecycle.Read)
  @key
  @path
  @segment("billingTiers")
  name: string;
}

@armResourceOperations(BillingTierResource)
interface BillingTiers
  extends ResourceListBySubscription<BillingTierResource> {}
