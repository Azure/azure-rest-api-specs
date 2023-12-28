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
model FirewallResource is TrackedResource<FirewallDeploymentProperties> {
  @doc("Firewall resource name")
  @key("firewallName")
  @segment("firewalls")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Firewalls {
  @doc("Get a FirewallResource")
  get is ArmResourceRead<FirewallResource>;
  @doc("Create a FirewallResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<FirewallResource>;
  @doc("Update a FirewallResource")
  update is ArmCustomPatchSync<FirewallResource, FirewallResourceUpdate>;
  @doc("Delete a FirewallResource")
  delete is ArmResourceDeleteAsync<FirewallResource>;
  @doc("List FirewallResource resources by resource group")
  listByResourceGroup is ArmResourceListByParent<FirewallResource>;
  @doc("List FirewallResource resources by subscription ID")
  listBySubscription is ArmListBySubscription<FirewallResource>;
  @doc("Get Global Rulestack associated with the Firewall")
  getGlobalRulestack is ArmResourceActionSync<
    FirewallResource,
    void,
    GlobalRulestackInfo
  >;
  @doc("Log Profile for Firewall")
  getLogProfile is ArmResourceActionSync<FirewallResource, void, LogSettings>;
  @doc("support info for firewall.")
  getSupportInfo is ArmResourceActionSync<
    FirewallResource,
    void,
    SupportInfo,
    {
      ...BaseParameters<FirewallResource>;

      @doc("email address on behalf of which this API called")
      @query("email")
      email?: string;
    }
  >;
  @doc("Log Profile for Firewall")
  saveLogProfile is ArmResourceActionNoContentSync<
    FirewallResource,
    LogSettings
  >;
}
