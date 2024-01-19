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
@doc("Rule results.")
model RuleResults is ExtensionResource<RuleResultsProperties> {
  @doc("The rule Id.")
  @path
  @key("ruleId")
  @segment("baselineRules")
  name: string;
}

@armResourceOperations
@projectedName("client", "RuleResults")
interface RuleResultsOperationGroup {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the results for a given rule in the Baseline.")
  @operationId("SqlVulnerabilityAssessmentBaselineRules_Get")
  get is ArmResourceRead<
    RuleResults,
    {
      ...BaseParameters<RuleResults>;

      @doc("The workspace Id.")
      @query("workspaceId")
      workspaceId: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a Baseline for a rule in a database. Will overwrite any previously existing results.")
  @operationId("SqlVulnerabilityAssessmentBaselineRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    RuleResults,
    {
      ...BaseParameters<RuleResults>;

      @doc("The workspace Id.")
      @query("workspaceId")
      workspaceId: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a rule from the Baseline of a given database.")
  @operationId("SqlVulnerabilityAssessmentBaselineRules_Delete")
  delete is ArmResourceDeleteSync<
    RuleResults,
    {
      ...BaseParameters<RuleResults>;

      @doc("The workspace Id.")
      @query("workspaceId")
      workspaceId: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the results for all rules in the Baseline.")
  @operationId("SqlVulnerabilityAssessmentBaselineRules_List")
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

@@projectedName(RuleResultsOperationGroup.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(RuleResultsOperationGroup.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(RuleResultsOperationGroup.createOrUpdate::parameters.resource,
  "The baseline results for this rule."
);
