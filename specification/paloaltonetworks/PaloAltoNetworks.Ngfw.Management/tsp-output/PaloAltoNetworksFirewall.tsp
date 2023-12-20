import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PaloAltoNetworks.Ngfw;
@doc("PaloAltoNetworks Firewall")
model PaloAltoNetworksFirewall
  is TrackedResource<FirewallDeploymentProperties> {
  @doc("Firewall resource name")
  @path
  @key("firewallName")
  @segment("firewalls")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface PaloAltoNetworksFirewalls {
  @doc("Get a FirewallResource")
  get is ArmResourceRead<PaloAltoNetworksFirewall>;
  @doc("Create a FirewallResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PaloAltoNetworksFirewall>;
  @doc("Update a FirewallResource")
  update is ArmResourcePatchSync<
    PaloAltoNetworksFirewall,
    FirewallDeploymentProperties
  >;
  @doc("Delete a FirewallResource")
  delete is ArmResourceDeleteAsync<PaloAltoNetworksFirewall>;
  @doc("List FirewallResource resources by resource group")
  listByResourceGroup is ArmResourceListByParent<PaloAltoNetworksFirewall>;
  @doc("List FirewallResource resources by subscription ID")
  listBySubscription is ArmListBySubscription<PaloAltoNetworksFirewall>;
  @doc("Get Global Rulestack associated with the Firewall")
  getGlobalRulestack is ArmResourceActionSync<
    PaloAltoNetworksFirewall,
    void,
    GlobalRulestackInfo
  >;
  @doc("Log Profile for Firewall")
  getLogProfile is ArmResourceActionSync<
    PaloAltoNetworksFirewall,
    void,
    LogSettings
  >;
  @doc("support info for firewall.")
  getSupportInfo is ArmResourceActionSync<
    PaloAltoNetworksFirewall,
    void,
    SupportInfo,
    {
      ...BaseParameters<PaloAltoNetworksFirewall>;

      @doc("email address on behalf of which this API called")
      @query("email")
      email?: string;
    }
  >;
  @doc("Log Profile for Firewall")
  saveLogProfile is ArmResourceActionNoContentSync<
    PaloAltoNetworksFirewall,
    LogSettings
  >;
}
