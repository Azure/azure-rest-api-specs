import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Rule results.")
model RuleResults is ExtensionResource<RuleResultsProperties> {
  @doc("The rule Id.")
  @key("ruleId")
  @segment("baselineRules")
  name: string;
}

@armResourceOperations
interface SqlVulnerabilityAssessmentBaselineRules {
  @doc("Gets the results for a given rule in the Baseline.")
  get is ArmResourceRead<
    RuleResults,
    {
      ...BaseParameters<RuleResults>;

      @doc("The workspace Id.")
      @query("workspaceId")
      workspaceId: string;
    }
  >;
  @doc("Creates a Baseline for a rule in a database. Will overwrite any previously existing results.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    RuleResults,
    {
      ...BaseParameters<RuleResults>;

      @doc("The workspace Id.")
      @query("workspaceId")
      workspaceId: string;
    }
  >;
  @doc("Deletes a rule from the Baseline of a given database.")
  delete is ArmResourceDeleteSync<
    RuleResults,
    {
      ...BaseParameters<RuleResults>;

      @doc("The workspace Id.")
      @query("workspaceId")
      workspaceId: string;
    }
  >;
  @doc("Gets the results for all rules in the Baseline.")
  list is ArmResourceListByParent<
    RuleResults,
    {
      ...BaseParameters<RuleResults>;

      @doc("The workspace Id.")
      @query("workspaceId")
      workspaceId: string;
    }
  >;
}
