import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace SqlPools;

/**
 * Path parameters for resources whose parent is a Synapse workspace.
 * The workspace resource itself is defined by the Workspaces project.
 */
alias WorkspaceParentParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
  ...Azure.ResourceManager.Legacy.Provider;

  /** The name of the workspace. */
  @segment("workspaces")
  @key
  @path
  workspaceName: string;
};

/** Path parameters for resources whose parent is a SQL pool. */
alias SqlPoolParentParameters = {
  ...WorkspaceParentParameters;

  /** SQL pool name */
  @segment("sqlPools")
  @key
  @path
  sqlPoolName: string;
};

/** Path parameters for resources whose parent is a SQL pool schema. */
alias SqlPoolSchemaParentParameters = {
  ...SqlPoolParentParameters;

  /** The name of the schema. */
  @segment("schemas")
  @key
  @path
  schemaName: string;
};

/** Path parameters for resources whose parent is a SQL pool table. */
alias SqlPoolTableParentParameters = {
  ...SqlPoolSchemaParentParameters;

  /** The name of the table. */
  @segment("tables")
  @key
  @path
  tableName: string;
};

/** Path parameters for resources whose parent is a SQL pool column. */
alias SqlPoolColumnParentParameters = {
  ...SqlPoolTableParentParameters;

  /** The name of the column. */
  @segment("columns")
  @key
  @path
  columnName: string;
};

/** Path parameters for resources whose parent is a SQL pool data masking policy. */
alias DataMaskingPolicyParentParameters = {
  ...SqlPoolParentParameters;

  /** The name of the data masking policy for which the masking rule applies. */
  @segment("dataMaskingPolicies")
  @key
  @path
  dataMaskingPolicyName: DataMaskingPolicyName;
};

/** Path parameters for resources whose parent is a SQL pool vulnerability assessment. */
alias SqlPoolVulnerabilityAssessmentParentParameters = {
  ...SqlPoolParentParameters;

  /** The name of the vulnerability assessment. */
  @segment("vulnerabilityAssessments")
  @key
  @path
  vulnerabilityAssessmentName: VulnerabilityAssessmentName;
};

/** Path parameters for resources whose parent is a SQL pool vulnerability assessment rule. */
alias SqlPoolVulnerabilityAssessmentRuleParentParameters = {
  ...SqlPoolVulnerabilityAssessmentParentParameters;

  /** The vulnerability assessment rule ID. */
  @segment("rules")
  @key
  @path
  ruleId: string;
};

/** Path parameters for resources whose parent is a SQL pool workload group. */
alias WorkloadGroupParentParameters = {
  ...SqlPoolParentParameters;

  /** The name of the workload group. */
  @segment("workloadGroups")
  @key
  @path
  workloadGroupName: string;
};
