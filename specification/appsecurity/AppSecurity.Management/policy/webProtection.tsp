using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.AppSecurity;

@doc("Web protection policy definition")
model WebProtection {
  @doc("Describes the managedRules structure")
  @extension("x-ms-identifiers", ["ruleSetType", "ruleSetVersion"])
  @minItems(MinManagedRulesCount)
  @maxItems(MaxManagedRulesCount)
  managedRules: ManagedRuleSet[];
}
