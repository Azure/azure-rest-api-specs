// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Authorization;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PolicyDefinitionVersionsOperationGroup {
  /**
   * This operation lists all the built-in policy definition versions for all built-in policy definitions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Lists all built-in policy definition versions.")
  @autoRoute
  @action("listPolicyDefinitionVersions")
  listAllBuiltins is ArmProviderActionSync<Response = ResourceListResult<PolicyDefinitionVersion>>;
  /**
   * This operation lists all the policy definition versions for all policy definitions at the management group scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Lists all policy definition versions at management group scope.")
  @autoRoute
  @action("listPolicyDefinitionVersions")
  listAllAtManagementGroup is ArmProviderActionSync<
    Response = ResourceListResult<PolicyDefinitionVersion>,
    Parameters = {
      /**
       * The name of the management group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      @segment("managementGroups")
      managementGroupName: string;
    }
  >;
  /**
   * This operation lists all the policy definition versions for all policy definitions within a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Lists all policy definition versions within a subscription.")
  @autoRoute
  @action("listPolicyDefinitionVersions")
  listAll is ArmProviderActionSync<
    Response = ResourceListResult<PolicyDefinitionVersion>,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PolicySetDefinitionVersionsOperationGroup {
  /**
   * This operation lists all the built-in policy set definition versions for all built-in policy set definitions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Lists all built-in policy set definition versions.")
  @autoRoute
  @action("listPolicySetDefinitionVersions")
  listAllBuiltins is ArmProviderActionSync<Response = ResourceListResult<PolicySetDefinitionVersion>>;
  /**
   * This operation lists all the policy set definition versions for all policy set definitions at the management group scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Lists all policy set definition versions at management group scope.")
  @autoRoute
  @action("listPolicySetDefinitionVersions")
  listAllAtManagementGroup is ArmProviderActionSync<
    Response = ResourceListResult<PolicySetDefinitionVersion>,
    Parameters = {
      /**
       * The name of the management group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      @segment("managementGroups")
      managementGroupName: string;
    }
  >;
  /**
   * This operation lists all the policy set definition versions for all policy set definitions within a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Lists all policy set definition versions within a subscription.")
  @autoRoute
  @action("listPolicySetDefinitionVersions")
  listAll is ArmProviderActionSync<
    Response = ResourceListResult<PolicySetDefinitionVersion>,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PolicyTokensOperationGroup {
  /**
   * This operation acquires a policy token in the given subscription for the given request body.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Acquires a policy token.")
  @autoRoute
  @action("acquirePolicyToken")
  acquire is ArmProviderActionSync<
    Request = PolicyTokenRequest,
    Response = PolicyTokenResponse,
    Scope = SubscriptionActionScope
  >;
  /**
   * This operation acquires a policy token in the given management group for the given request body.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Acquires a policy token at management group level.")
  @autoRoute
  @action("acquirePolicyToken")
  acquireAtManagementGroup is ArmProviderActionSync<
    Request = PolicyTokenRequest,
    Response = PolicyTokenResponse,
    Parameters = {
      /**
       * The name of the management group.
       */
      @path
      @segment("managementGroups")
      managementGroupName: string;
    }
  >;
}
