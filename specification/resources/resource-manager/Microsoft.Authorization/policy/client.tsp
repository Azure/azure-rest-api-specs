import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;

/**
 * To manage and control access to your resources, you can define customized policies and assign them at a scope.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "For client"
namespace Microsoft.Authorization {
  alias PolicyAssignmentIdParameter = {
    /**
     * The ID of the policy assignment to get. Use the format '{scope}/providers/Microsoft.Authorization/policyAssignments/{policyAssignmentName}'.
     */
    @path policyAssignmentId: string;
  };

  /**
   * The operation retrieves the policy assignment with the given ID. Policy assignment IDs have this format: '{scope}/providers/Microsoft.Authorization/policyAssignments/{policyAssignmentName}'. Valid scopes are: management group (format: '/providers/Microsoft.Management/managementGroups/{managementGroup}'), subscription (format: '/subscriptions/{subscriptionId}'), resource group (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}', or resource (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "For client"
  @summary("Retrieves the policy assignment with the given ID.")
  @scope("java,csharp,go")
  @clientLocation(PolicyAssignments)
  @get
  @route("/{+policyAssignmentId}")
  op getById(
    ...PolicyAssignmentIdParameter,
    ...Azure.Core.Foundations.ApiVersionParameter,
  ): PolicyAssignment | ErrorResponse;

  /**
   * This operation creates or updates the policy assignment with the given ID. Policy assignments made on a scope apply to all resources contained in that scope. For example, when you assign a policy to a resource group that policy applies to all resources in the group. Policy assignment IDs have this format: '{scope}/providers/Microsoft.Authorization/policyAssignments/{policyAssignmentName}'. Valid scopes are: management group (format: '/providers/Microsoft.Management/managementGroups/{managementGroup}'), subscription (format: '/subscriptions/{subscriptionId}'), resource group (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}', or resource (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "For client"
  @summary("Creates or updates a policy assignment.")
  @scope("java,csharp,go")
  @clientLocation(PolicyAssignments)
  @put
  @route("/{+policyAssignmentId}")
  op createById(
    ...PolicyAssignmentIdParameter,

    /**
     * Parameters for policy assignment.
     */
    @bodyRoot parameters: PolicyAssignment,

    ...Azure.Core.Foundations.ApiVersionParameter,
  ): ArmResourceCreatedSyncResponse<PolicyAssignment> | ErrorResponse;

  /**
   * This operation updates the policy assignment with the given ID. Policy assignments made on a scope apply to all resources contained in that scope. For example, when you assign a policy to a resource group that policy applies to all resources in the group. Policy assignment IDs have this format: '{scope}/providers/Microsoft.Authorization/policyAssignments/{policyAssignmentName}'. Valid scopes are: management group (format: '/providers/Microsoft.Management/managementGroups/{managementGroup}'), subscription (format: '/subscriptions/{subscriptionId}'), resource group (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}', or resource (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "For client"
  #suppress "@typespec/http/patch-implicit-optional" "For client"
  @summary("Updates a policy assignment.")
  @scope("java,csharp,go")
  @clientLocation(PolicyAssignments)
  @patch
  @route("/{+policyAssignmentId}")
  op updateById(
    ...PolicyAssignmentIdParameter,

    /**
     * Parameters for policy assignment patch request.
     */
    @bodyRoot parameters: PolicyAssignmentUpdate,

    ...Azure.Core.Foundations.ApiVersionParameter,
  ): PolicyAssignment | ErrorResponse;

  /**
   * This operation deletes the policy with the given ID. Policy assignment IDs have this format: '{scope}/providers/Microsoft.Authorization/policyAssignments/{policyAssignmentName}'. Valid formats for {scope} are: '/providers/Microsoft.Management/managementGroups/{managementGroup}' (management group), '/subscriptions/{subscriptionId}' (subscription), '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' (resource group), or '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}' (resource).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "For client"
  @summary("Deletes a policy assignment.")
  @scope("java,csharp,go")
  @clientLocation(PolicyAssignments)
  @delete
  @route("/{+policyAssignmentId}")
  op deleteById(
    ...PolicyAssignmentIdParameter,
    ...Azure.Core.Foundations.ApiVersionParameter,
  ): PolicyAssignment | ArmDeletedNoContentResponse | ErrorResponse;
}
@@clientName(Microsoft.Authorization, "PolicyClient", "javascript,python");

// Rename models with forbidden suffixes for C# naming conventions
@@clientName(Microsoft.Authorization.PolicyTokenOperation,
  "PolicyTokenOperationInfo",
  "csharp"
);
@@clientName(Microsoft.Authorization.PolicyTokenRequest,
  "PolicyTokenRequestContent",
  "csharp"
);
@@clientName(Microsoft.Authorization.PolicyTokenResponse,
  "PolicyTokenResponseResult",
  "csharp"
);

// Suppress tenant-scope and management-group-scope operations from C# to avoid
// duplicate resource entries for the same model at multiple scopes.
// The subscription-scope operations provide equivalent functionality.
@@scope(Microsoft.Authorization.PolicyDefinitions.getBuiltIn, "!csharp");
@@scope(Microsoft.Authorization.PolicyDefinitions.listBuiltIn, "!csharp");
@@scope(Microsoft.Authorization.PolicyDefinitions.getAtManagementGroup,
  "!csharp"
);
@@scope(Microsoft.Authorization.PolicyDefinitions.createOrUpdateAtManagementGroup,
  "!csharp"
);
@@scope(Microsoft.Authorization.PolicyDefinitions.deleteAtManagementGroup,
  "!csharp"
);
@@scope(Microsoft.Authorization.PolicyDefinitions.listByManagementGroup,
  "!csharp"
);

@@scope(Microsoft.Authorization.PolicySetDefinitions.getBuiltIn, "!csharp");
@@scope(Microsoft.Authorization.PolicySetDefinitions.listBuiltIn, "!csharp");
@@scope(Microsoft.Authorization.PolicySetDefinitions.getAtManagementGroup,
  "!csharp"
);
@@scope(Microsoft.Authorization.PolicySetDefinitions.createOrUpdateAtManagementGroup,
  "!csharp"
);
@@scope(Microsoft.Authorization.PolicySetDefinitions.deleteAtManagementGroup,
  "!csharp"
);
@@scope(Microsoft.Authorization.PolicySetDefinitions.listByManagementGroup,
  "!csharp"
);

@@scope(Microsoft.Authorization.PolicyDefinitionVersions.getBuiltIn, "!csharp");
@@scope(Microsoft.Authorization.PolicyDefinitionVersions.listBuiltIn,
  "!csharp"
);
@@scope(Microsoft.Authorization.PolicyDefinitionVersions.getAtManagementGroup,
  "!csharp"
);
@@scope(Microsoft.Authorization.PolicyDefinitionVersions.createOrUpdateAtManagementGroup,
  "!csharp"
);
@@scope(Microsoft.Authorization.PolicyDefinitionVersions.deleteAtManagementGroup,
  "!csharp"
);
@@scope(Microsoft.Authorization.PolicyDefinitionVersions.listByManagementGroup,
  "!csharp"
);

@@scope(Microsoft.Authorization.PolicySetDefinitionVersions.getBuiltIn,
  "!csharp"
);
@@scope(Microsoft.Authorization.PolicySetDefinitionVersions.listBuiltIn,
  "!csharp"
);
@@scope(Microsoft.Authorization.PolicySetDefinitionVersions.getAtManagementGroup,
  "!csharp"
);
@@scope(Microsoft.Authorization.PolicySetDefinitionVersions.createOrUpdateAtManagementGroup,
  "!csharp"
);
@@scope(Microsoft.Authorization.PolicySetDefinitionVersions.deleteAtManagementGroup,
  "!csharp"
);
@@scope(Microsoft.Authorization.PolicySetDefinitionVersions.listByManagementGroup,
  "!csharp"
);
