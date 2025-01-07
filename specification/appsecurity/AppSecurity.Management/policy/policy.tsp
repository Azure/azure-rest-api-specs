import "./webProtection.tsp";
import "./botProtection.tsp";
import "./policySettings.tsp";
import "./protectedEndpoint.tsp";
import "./customRules/customRule.tsp";
import "./managedRulesCustomization.tsp";
import "./updateAssociations.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using OpenAPI;

namespace Microsoft.AppSecurity;

alias MinResourceNameLength = 1;
alias MaxResourceNameLength = 128;
alias MaxProtectedEndpointsCount = 100;
alias MaxCustomRulesCount = 100;
alias MinManagedRulesCount = 1;
alias MaxManagedRulesCount = 10;

@doc("The policy properties")
model PolicyProperties {
  @doc("The status of the last operation")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Global settings for the policy")
  policySettings?: PolicySettings;

  @doc("The list of endpoints this policy protects")
  @extension("x-ms-identifiers", ["endpointId"])
  @maxItems(MaxProtectedEndpointsCount)
  protectedEndpoints?: ProtectedEndpoint[] = #[];

  @doc("Rules for scrubbing sensitive log fields")
  logScrubbing?: LogScrubbing;

  @doc("User defined rules")
  @extension("x-ms-identifiers", ["name"])
  @maxItems(MaxCustomRulesCount) // AppGW custom rules limitation is 100
  customRules?: CustomRule[] = #[];

  @doc("Describes the web protection policy")
  webProtection?: WebProtection;

  @doc("Describes the bot protection policy")
  botProtection?: BotProtection;

  @doc("Customization for managed rules (including exclusions and overrides)")
  managedRulesCustomization?: ManagedRulesCustomization;

  @doc("Policy revision. Incremented on each change, starting from 0.")
  @visibility("read")
  revision?: int32 = 0;
}

@doc("Policy resource definition")
model Policy is Azure.ResourceManager.TrackedResource<PolicyProperties> {
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("The name of the policy")
  @segment("policies") // Path segment
  @key("policyName")
  @path
  @minLength(MinResourceNameLength)
  @maxLength(MaxResourceNameLength)
  name: string;

  // ...ResourceSku;

  ...EntityTagProperty;
}

// See recommendations for ARM resource operations at <https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-operations>
@armResourceOperations
interface Policies {
  get is ArmResourceRead<Policy>;
  listByParent is ArmResourceListByParent<Policy>;
  listBySubscription is ArmListBySubscription<Policy>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Policy>;
  // Although ARM recommends providing update (PATCH) support for all top-level properties, if LRO update is required it must be implemented with POST.
  // See <https://github.com/microsoft/api-guidelines/blob/15fefbaf192b73523c247b29c2266dc432fc90a4/azure/Guidelines.md?plain=1#L854>
  update is ArmTagsPatchAsync<Policy>;
  delete is ArmResourceDeleteWithoutOkAsync<Policy>;
  updateAssociations is ArmResourceActionSync<
    Policy,
    UpdateAssociationsRequest,
    UpdateAssociationsResponse
  >;
}
