import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Governance rule over a given scope")
model GovernanceRule is ExtensionResource<GovernanceRuleProperties> {
  @doc("The governance rule key - unique key for the standard governance rule (GUID)")
  @key("ruleId")
  @segment("governanceRules")
  name: string;
}

@armResourceOperations
interface GovernanceRules {
  @doc("Get a specific governance rule for the requested scope by ruleId")
  get is ArmResourceRead<GovernanceRule>;
  @doc("Creates or updates a governance rule over a given scope")
  createOrUpdate is ArmResourceCreateOrReplaceSync<GovernanceRule>;
  @doc("Delete a Governance rule over a given scope")
  delete is ArmResourceDeleteAsync<GovernanceRule>;
  @doc("Get a list of all relevant governance rules over a scope")
  list is ArmResourceListByParent<GovernanceRule>;
  @doc("Execute a governance rule")
  execute is ArmResourceActionNoResponseContentAsync<
    GovernanceRule,
    ExecuteGovernanceRuleParams
  >;
}
