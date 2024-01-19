import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
@doc("Governance rule over a given scope")
model GovernanceRule is ExtensionResource<GovernanceRuleProperties> {
  @doc("The governance rule key - unique key for the standard governance rule (GUID)")
  @path
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
  delete is ArmResourceDeleteAsync<
    GovernanceRule,
    BaseParameters<GovernanceRule>,
    ArmLroLocationHeader
  >;

  @doc("Get a list of all relevant governance rules over a scope")
  list is ArmResourceListByParent<GovernanceRule>;

  @doc("Execute a governance rule")
  execute is ArmResourceActionNoResponseContentAsync<
    GovernanceRule,
    ExecuteGovernanceRuleParams,
    BaseParameters<GovernanceRule>,
    ArmLroLocationHeader
  >;
}

@@projectedName(GovernanceRules.createOrUpdate::parameters.resource,
  "json",
  "governanceRule"
);
@@extension(GovernanceRules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "governanceRule"
);
@@doc(GovernanceRules.createOrUpdate::parameters.resource,
  "Governance rule over a given scope"
);
@@projectedName(GovernanceRules.execute::parameters.body,
  "json",
  "ExecuteGovernanceRuleParams"
);
@@extension(GovernanceRules.execute::parameters.body,
  "x-ms-client-name",
  "ExecuteGovernanceRuleParams"
);
@@doc(GovernanceRules.execute::parameters.body,
  "Execute governance rule over a given scope"
);
