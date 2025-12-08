import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Authorization;
/**
 * The policy set definition.
 */
@subscriptionResource
model PolicySetDefinition
  is Azure.ResourceManager.ProxyResource<PolicySetDefinitionProperties> {
  ...ResourceNameParameter<
    Resource = PolicySetDefinition,
    KeyName = "policySetDefinitionName",
    SegmentName = "policySetDefinitions",
    NamePattern = "^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$"
  >;
}

alias PolicySetDefinitionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
  {
    /** The name of the policy set definition to get. */
    @path
    @segment("policySetDefinitions")
    @key
    @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
    policySetDefinitionName: string;
  }
>;

alias PolicySetDefinitionTenantOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";
  },
  {},
  {
    /** The name of the policy set definition to get. */
    @path
    @segment("policySetDefinitions")
    @key
    @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
    policySetDefinitionName: string;
  }
>;

alias PolicySetDefinitionManagementGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

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
  },
  {
    ...Extension.ExtensionProviderNamespace<PolicySetDefinition>;
  },
  {
    ...Extension.ExtensionProviderNamespace<PolicySetDefinition>;

    /** The name of the policy set definition to get. */
    @path
    @segment("policySetDefinitions")
    @key
    @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
    policySetDefinitionName: string;
  }
>;

@armResourceOperations
interface PolicySetDefinitions {
  /**
   * This operation retrieves the policy set definition in the given subscription with the given name.
   */
  get is PolicySetDefinitionOps.Read<
    PolicySetDefinition,
    Parameters = {
      /**
       * Comma-separated list of additional properties to be included in the response. Supported values are 'LatestDefinitionVersion, EffectiveDefinitionVersion'.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * This operation creates or updates a policy set definition in the given subscription with the given name.
   */
  createOrUpdate is PolicySetDefinitionOps.CreateOrUpdateSync<PolicySetDefinition>;

  /**
   * This operation deletes the policy set definition in the given subscription with the given name.
   */
  delete is PolicySetDefinitionOps.DeleteSync<PolicySetDefinition>;

  /**
   * This operation retrieves a list of all the policy set definitions in a given subscription that match the optional given $filter. Valid values for $filter are: 'atExactScope()', 'policyType -eq {value}' or 'category eq '{value}''. If $filter is not provided, the unfiltered list includes all policy set definitions associated with the subscription, including those that apply directly or from management groups that contain the given subscription. If $filter=atExactScope() is provided, the returned list only includes all policy set definitions that at the given subscription. If $filter='policyType -eq {value}' is provided, the returned list only includes all policy set definitions whose type match the {value}. Possible policyType values are NotSpecified, BuiltIn and Custom. If $filter='category -eq {value}' is provided, the returned list only includes all policy set definitions whose category match the {value}.
   */
  list is PolicySetDefinitionOps.List<
    PolicySetDefinition,
    Parameters = {
      /**
       * The filter to apply on the operation. Valid values for $filter are: 'atExactScope()', 'policyType -eq {value}' or 'category eq '{value}''. If $filter is not provided, no filtering is performed. If $filter=atExactScope() is provided, the returned list only includes all policy set definitions that at the given scope. If $filter='policyType -eq {value}' is provided, the returned list only includes all policy set definitions whose type match the {value}. Possible policyType values are NotSpecified, BuiltIn, Custom, and Static. If $filter='category -eq {value}' is provided, the returned list only includes all policy set definitions whose category match the {value}.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Comma-separated list of additional properties to be included in the response. Supported values are 'LatestDefinitionVersion, EffectiveDefinitionVersion'.
       */
      @query("$expand")
      $expand?: string;

      /**
       * Maximum number of records to return. When the $top filter is not provided, it will return 500 records.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * This operation retrieves the built-in policy set definition with the given name.
   */
  getBuiltIn is PolicySetDefinitionTenantOps.Read<
    PolicySetDefinition,
    Parameters = {
      /**
       * Comma-separated list of additional properties to be included in the response. Supported values are 'LatestDefinitionVersion, EffectiveDefinitionVersion'.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * This operation retrieves a list of all the built-in policy set definitions that match the optional given $filter. If $filter='category -eq {value}' is provided, the returned list only includes all built-in policy set definitions whose category match the {value}.
   */
  listBuiltIn is PolicySetDefinitionTenantOps.List<
    PolicySetDefinition,
    Parameters = {
      /**
       * The filter to apply on the operation. Valid values for $filter are: 'atExactScope()', 'policyType -eq {value}' or 'category eq '{value}''. If $filter is not provided, no filtering is performed. If $filter=atExactScope() is provided, the returned list only includes all policy set definitions that at the given scope. If $filter='policyType -eq {value}' is provided, the returned list only includes all policy set definitions whose type match the {value}. Possible policyType values are NotSpecified, BuiltIn, Custom, and Static. If $filter='category -eq {value}' is provided, the returned list only includes all policy set definitions whose category match the {value}.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Comma-separated list of additional properties to be included in the response. Supported values are 'LatestDefinitionVersion, EffectiveDefinitionVersion'.
       */
      @query("$expand")
      $expand?: string;

      /**
       * Maximum number of records to return. When the $top filter is not provided, it will return 500 records.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * This operation retrieves the policy set definition in the given management group with the given name.
   */
  getAtManagementGroup is PolicySetDefinitionManagementGroupOps.Read<
    PolicySetDefinition,
    Parameters = {
      /**
       * Comma-separated list of additional properties to be included in the response. Supported values are 'LatestDefinitionVersion, EffectiveDefinitionVersion'.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * This operation creates or updates a policy set definition in the given management group with the given name.
   */
  createOrUpdateAtManagementGroup is PolicySetDefinitionManagementGroupOps.CreateOrUpdateSync<PolicySetDefinition>;

  /**
   * This operation deletes the policy set definition in the given management group with the given name.
   */
  deleteAtManagementGroup is PolicySetDefinitionManagementGroupOps.DeleteSync<PolicySetDefinition>;

  /**
   * This operation retrieves a list of all the policy set definitions in a given management group that match the optional given $filter. Valid values for $filter are: 'atExactScope()', 'policyType -eq {value}' or 'category eq '{value}''. If $filter is not provided, the unfiltered list includes all policy set definitions associated with the management group, including those that apply directly or from management groups that contain the given management group. If $filter=atExactScope() is provided, the returned list only includes all policy set definitions that at the given management group. If $filter='policyType -eq {value}' is provided, the returned list only includes all policy set definitions whose type match the {value}. Possible policyType values are NotSpecified, BuiltIn and Custom. If $filter='category -eq {value}' is provided, the returned list only includes all policy set definitions whose category match the {value}.
   */
  listByManagementGroup is PolicySetDefinitionManagementGroupOps.List<
    PolicySetDefinition,
    Parameters = {
      /**
       * The filter to apply on the operation. Valid values for $filter are: 'atExactScope()', 'policyType -eq {value}' or 'category eq '{value}''. If $filter is not provided, no filtering is performed. If $filter=atExactScope() is provided, the returned list only includes all policy set definitions that at the given scope. If $filter='policyType -eq {value}' is provided, the returned list only includes all policy set definitions whose type match the {value}. Possible policyType values are NotSpecified, BuiltIn, Custom, and Static. If $filter='category -eq {value}' is provided, the returned list only includes all policy set definitions whose category match the {value}.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Comma-separated list of additional properties to be included in the response. Supported values are 'LatestDefinitionVersion, EffectiveDefinitionVersion'.
       */
      @query("$expand")
      $expand?: string;

      /**
       * Maximum number of records to return. When the $top filter is not provided, it will return 500 records.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    }
  >;
}

@@doc(PolicySetDefinition.name,
  "The name of the policy set definition to get."
);
@@doc(PolicySetDefinition.properties, "The policy set definition properties.");
@@doc(PolicySetDefinitions.createOrUpdate::parameters.resource,
  "The policy set definition properties."
);
@@doc(PolicySetDefinitions.createOrUpdateAtManagementGroup::parameters.resource,
  "The policy set definition properties."
);
