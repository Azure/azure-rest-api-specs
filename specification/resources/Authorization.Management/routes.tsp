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

alias ManagementGroupNameParameters<Resource extends {}> = {
  /** the provider namespace */
  @path
  @segment("providers")
  @key
  providerNamespace: "Microsoft.Management";

  ...CommonTypes.ManagementGroupNameParameter;
  ...ProviderNamespace<Resource>;
  ...ApiVersionParameter;
};

alias ManagementGroupIdParameters<Resource extends {}> = {
  /** the provider namespace */
  @path
  @segment("providers")
  @key
  providerNamespace: "Microsoft.Management";

  /** The ID of the management group. */
  @path
  @segment("managementGroups")
  @key
  managementGroupId: string;

  ...ProviderNamespace<Resource>;
  ...ApiVersionParameter;
};

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PolicyDefinitionVersionsOperationGroup {
  /**
   * This operation lists all the built-in policy definition versions for all built-in policy definitions.
   */
  @summary("Lists all built-in policy definition versions.")
  @autoRoute
  @action("listPolicyDefinitionVersions")
  listAllBuiltins is ArmProviderActionSync<Response = ResourceListResult<PolicyDefinitionVersion>>;

  /**
   * This operation lists all the policy definition versions for all policy definitions at the management group scope.
   */
  @summary("Lists all policy definition versions at management group scope.")
  @autoRoute
  @post
  @action("listPolicyDefinitionVersions")
  @armResourceCollectionAction
  listAllAtManagementGroup(
    ...ManagementGroupNameParameters<PolicyDefinitionVersion>,
  ): ResourceListResult<PolicyDefinitionVersion> | ErrorResponse;

  /**
   * This operation lists all the policy definition versions for all policy definitions within a subscription.
   */
  @summary("Lists all policy definition versions within a subscription.")
  @autoRoute
  @action("listPolicyDefinitionVersions")
  listAll is ArmProviderActionSync<
    Response = ResourceListResult<PolicyDefinitionVersion>,
    Scope = SubscriptionActionScope
  >;
}

alias PolicySetDefinitionVersionListOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";
  },
  {},
  {}
>;

alias PolicySetDefinitionVersionTenantListOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";
  },
  {},
  {}
>;

alias PolicySetDefinitionVersionManagementGroupListOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Management";

    ...CommonTypes.ManagementGroupNameParameter;
    ...ApiVersionParameter;
  },
  {
    ...Extension.ExtensionProviderNamespace<PolicySetDefinitionVersion>;
  },
  {
    ...Extension.ExtensionProviderNamespace<PolicySetDefinitionVersion>;
  }
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PolicySetDefinitionVersionsOperationGroup {
  /**
   * This operation lists all the built-in policy set definition versions for all built-in policy set definitions.
   */
  @summary("Lists all built-in policy set definition versions.")
  @post
  @segment("listPolicySetDefinitionVersions")
  listAllBuiltins is PolicySetDefinitionVersionTenantListOps.ListSinglePage<PolicySetDefinitionVersion>;
  /**
   * This operation lists all the policy set definition versions for all policy set definitions at the management group scope.
   */
  @summary("Lists all policy set definition versions at management group scope.")
  @post
  @segment("listPolicySetDefinitionVersions")
  listAllAtManagementGroup is PolicySetDefinitionVersionManagementGroupListOps.ListSinglePage<PolicySetDefinitionVersion>;

  /**
   * This operation lists all the policy set definition versions for all policy set definitions within a subscription.
   */
  @summary("Lists all policy set definition versions within a subscription.")
  @post
  @segment("listPolicySetDefinitionVersions")
  listAll is PolicySetDefinitionVersionListOps.ListSinglePage<PolicySetDefinitionVersion>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PolicyTokensOperationGroup {
  /**
   * This operation acquires a policy token in the given subscription for the given request body.
   */
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
  @summary("Acquires a policy token at management group level.")
  @autoRoute
  @post
  @action("acquirePolicyToken")
  @armResourceCollectionAction
  acquireAtManagementGroup(
    ...ManagementGroupNameParameters<PolicyTokenRequest>,

    /** The policy token properties. */
    @body parameters: PolicyTokenRequest,
  ): PolicyTokenResponse | ErrorResponse;
}
