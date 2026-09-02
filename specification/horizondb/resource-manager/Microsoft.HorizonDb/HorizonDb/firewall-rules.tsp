import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@added(Versions.v2026_10_01)
@doc("An IPv4 address in dotted-decimal notation.")
@pattern("^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])[.]){3}(?:25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$")
scalar DottedDecimalIpv4Address extends string;

@removed(Versions.v2026_10_01)
@renamedFrom(Versions.v2026_10_01, "HorizonDbFirewallRule")
@doc("Represents the HorizonDB firewall rule.")
@parentResource(Pool)
model LegacyHorizonDbFirewallRule
  is Azure.ResourceManager.ProxyResource<FirewallRuleProperties> {
  @doc("The name of the HorizonDB firewall rule.")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(128)
  @key("firewallRuleName")
  @path
  @segment("firewallRules")
  name: string;
}

@added(Versions.v2026_10_01)
@doc("Represents a customer-managed firewall rule for a HorizonDB endpoint.")
@parentResource(Endpoint)
model FirewallRule
  is Azure.ResourceManager.ProxyResource<FirewallRuleProperties> {
  @doc("The name of the HorizonDB endpoint firewall rule.")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(128)
  @key("firewallRuleName")
  @path
  @segment("firewallRules")
  name: string;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbFirewallRuleProperties")
@doc("Properties of a HorizonDB firewall rule.")
model FirewallRuleProperties {
  @removed(Versions.v2026_10_01)
  @doc("The start IP address of the firewall rule (IPv4).")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @renamedFrom(Versions.v2026_10_01, "startIpAddress")
  legacyStartIpAddress: string;

  @added(Versions.v2026_10_01)
  @doc("The start IPv4 address of the firewall rule in dotted-decimal notation.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  startIpAddress: DottedDecimalIpv4Address;

  @removed(Versions.v2026_10_01)
  @doc("The end IP address of the firewall rule (IPv4).")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @renamedFrom(Versions.v2026_10_01, "endIpAddress")
  legacyEndIpAddress: string;

  @added(Versions.v2026_10_01)
  @doc("The end IPv4 address of the firewall rule in dotted-decimal notation. This address must be numerically greater than or equal to startIpAddress.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  endIpAddress: DottedDecimalIpv4Address;

  @removed(Versions.v2026_10_01)
  @doc("The description of the HorizonDB firewall rule.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @renamedFrom(Versions.v2026_10_01, "description")
  legacyDescription?: string;

  @added(Versions.v2026_10_01)
  @doc("The description of the HorizonDB firewall rule. The maximum length is 1024 characters.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  description?: WritableDescription;

  @doc("The provisioning state of the firewall rule.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_10_01)
@doc("Properties of a HorizonDB endpoint firewall rule for update operations. Omitted properties preserve their current values. The service validates the effective IP range after merging the supplied values with the existing rule.")
model FirewallRulePropertiesForPatchUpdate {
  @doc("The start IPv4 address to apply in dotted-decimal notation. The resulting effective start address must be numerically less than or equal to the effective end address.")
  @visibility(Lifecycle.Update)
  startIpAddress?: DottedDecimalIpv4Address;

  @doc("The end IPv4 address to apply in dotted-decimal notation. The resulting effective end address must be numerically greater than or equal to the effective start address.")
  @visibility(Lifecycle.Update)
  endIpAddress?: DottedDecimalIpv4Address;

  @doc("The description to apply to the HorizonDB firewall rule. The maximum length is 1024 characters.")
  @visibility(Lifecycle.Update)
  description?: WritableDescription;
}

@added(Versions.v2026_10_01)
@doc("A HorizonDB endpoint firewall rule update request.")
model FirewallRuleForPatchUpdate {
  @doc("The properties to update. Omission preserves all current firewall rule properties.")
  properties?: FirewallRulePropertiesForPatchUpdate;
}

@removed(Versions.v2026_10_01)
@armResourceOperations
interface HorizonDbFirewallRules {
  @doc("Gets information about a HorizonDB firewall rule.")
  get is ArmResourceRead<LegacyHorizonDbFirewallRule>;

  @doc("Lists all HorizonDB firewall rules in a pool.")
  list is ArmResourceListByParent<LegacyHorizonDbFirewallRule>;

  @doc("Creates a new HorizonDB firewall rule or updates an existing rule.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LegacyHorizonDbFirewallRule>;

  @doc("Deletes a HorizonDB firewall rule.")
  delete is ArmResourceDeleteWithoutOkAsync<
    LegacyHorizonDbFirewallRule,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;
}

@added(Versions.v2026_10_01)
@armResourceOperations
interface FirewallRules {
  @doc("Gets information about a HorizonDB endpoint firewall rule.")
  get is ArmResourceRead<FirewallRule>;

  @doc("Lists all HorizonDB firewall rules in an endpoint.")
  list is ArmResourceListByParent<FirewallRule>;

  @doc("Creates or replaces a HorizonDB endpoint firewall rule.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FirewallRule>;

  @doc("Updates selected properties of a HorizonDB endpoint firewall rule. Omitted properties preserve their current values.")
  update is ArmCustomPatchSync<FirewallRule, FirewallRuleForPatchUpdate>;

  @doc("Deletes a HorizonDB endpoint firewall rule.")
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallRule,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;
}
