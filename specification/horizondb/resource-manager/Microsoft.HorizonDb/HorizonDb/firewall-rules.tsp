import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@doc("An IPv4 address in dotted-decimal notation.")
@pattern("^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])[.]){3}(?:25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$")
scalar DottedDecimalIpv4Address extends string;

@doc("Represents a customer-managed firewall rule for a HorizonDB pool.")
@parentResource(Pool)
model FirewallRule
  is Azure.ResourceManager.ProxyResource<FirewallRuleProperties> {
  @doc("The name of the HorizonDB pool firewall rule.")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(128)
  @key("firewallRuleName")
  @path
  @segment("firewallRules")
  name: string;
}

@doc("Properties of a HorizonDB firewall rule.")
model FirewallRuleProperties {
  @doc("The start IPv4 address of the firewall rule in dotted-decimal notation.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  startIpAddress: DottedDecimalIpv4Address;

  @doc("The end IPv4 address of the firewall rule in dotted-decimal notation. This address must be numerically greater than or equal to startIpAddress.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  endIpAddress: DottedDecimalIpv4Address;

  @doc("The description of the HorizonDB firewall rule. The maximum length is 1024 characters.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  description?: WritableDescription;

  @doc("The provisioning state of the firewall rule.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface FirewallRules {
  @doc("Gets information about a HorizonDB pool firewall rule.")
  @sharedRoute
  get is ArmResourceRead<FirewallRule>;

  @doc("Lists all HorizonDB firewall rules in a pool.")
  @sharedRoute
  list is ArmResourceListByParent<FirewallRule>;

  @doc("Creates or replaces a HorizonDB pool firewall rule.")
  @sharedRoute
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrReplace is ArmResourceCreateOrReplaceAsync<
    FirewallRule,
    LroHeaders = HorizonDbResourceLroHeaders<FirewallRule>,
    Response =
      | HorizonDbResourceUpdatedLroResponse<FirewallRule>
      | ArmResourceCreatedResponse<
          FirewallRule,
          HorizonDbResourceLroHeaders<FirewallRule>
        >
  >;

  @doc("Deletes a HorizonDB pool firewall rule.")
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallRule,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;
}
