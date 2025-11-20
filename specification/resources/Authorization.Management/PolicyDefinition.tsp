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
 * The policy definition.
 */
@subscriptionResource
model PolicyDefinition
  is Azure.ResourceManager.ProxyResource<PolicyDefinitionProperties> {
  ...ResourceNameParameter<
    Resource = PolicyDefinition,
    KeyName = "policyDefinitionName",
    SegmentName = "policyDefinitions",
    NamePattern = "^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$"
  >;
}

alias PolicyDefinitionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The name of the policy definition to get. */
    @path
    @segment("policyDefinitions")
    @key
    @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
    policyDefinitionName: string;
  }
>;

alias PolicyDefinitionTenantOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The name of the built-in policy definition to get. */
    @path
    @segment("policyDefinitions")
    @key
    @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
    policyDefinitionName: string;
  }
>;

alias PolicyDefinitionManagementGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    ...Extension.ExtensionProviderNamespace<PolicyDefinition>;
  },
  {
    ...Extension.ExtensionProviderNamespace<PolicyDefinition>;

    /** The name of the policy definition to get. */
    @path
    @segment("policyDefinitions")
    @key
    @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
    policyDefinitionName: string;
  }
>;

@armResourceOperations
interface PolicyDefinitions {
  /**
   * This operation retrieves the policy definition in the given subscription with the given name.
   */
  get is PolicyDefinitionOps.Read<PolicyDefinition>;

  /**
   * This operation creates or updates a policy definition in the given subscription with the given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is PolicyDefinitionOps.CreateOrUpdateSync<
    PolicyDefinition,
    Response = ArmResourceCreatedSyncResponse<PolicyDefinition>
  >;

  /**
   * This operation deletes the policy definition in the given subscription with the given name.
   */
  delete is PolicyDefinitionOps.DeleteSync<PolicyDefinition>;

  /**
   * This operation retrieves a list of all the policy definitions in a given subscription that match the optional given $filter. Valid values for $filter are: 'atExactScope()', 'policyType -eq {value}' or 'category eq '{value}''. If $filter is not provided, the unfiltered list includes all policy definitions associated with the subscription, including those that apply directly or from management groups that contain the given subscription. If $filter=atExactScope() is provided, the returned list only includes all policy definitions that at the given subscription. If $filter='policyType -eq {value}' is provided, the returned list only includes all policy definitions whose type match the {value}. Possible policyType values are NotSpecified, BuiltIn, Custom, and Static. If $filter='category -eq {value}' is provided, the returned list only includes all policy definitions whose category match the {value}.
   */
  list is PolicyDefinitionOps.List<
    PolicyDefinition,
    Parameters = {
      /**
       * The filter to apply on the operation. Valid values for $filter are: 'atExactScope()', 'policyType -eq {value}' or 'category eq '{value}''. If $filter is not provided, no filtering is performed. If $filter=atExactScope() is provided, the returned list only includes all policy definitions that at the given scope. If $filter='policyType -eq {value}' is provided, the returned list only includes all policy definitions whose type match the {value}. Possible policyType values are NotSpecified, BuiltIn, Custom, and Static. If $filter='category -eq {value}' is provided, the returned list only includes all policy definitions whose category match the {value}.
       */
      @query("$filter")
      $filter?: string;

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
   * This operation retrieves the built-in policy definition with the given name.
   */
  getBuiltIn is PolicyDefinitionTenantOps.Read<PolicyDefinition>;

  /**
   * This operation retrieves a list of all the built-in policy definitions that match the optional given $filter. If $filter='policyType -eq {value}' is provided, the returned list only includes all built-in policy definitions whose type match the {value}. Possible policyType values are NotSpecified, BuiltIn, Custom, and Static. If $filter='category -eq {value}' is provided, the returned list only includes all built-in policy definitions whose category match the {value}.
   */
  listBuiltIn is PolicyDefinitionTenantOps.List<
    PolicyDefinition,
    Parameters = {
      /**
       * The filter to apply on the operation. Valid values for $filter are: 'atExactScope()', 'policyType -eq {value}' or 'category eq '{value}''. If $filter is not provided, no filtering is performed. If $filter=atExactScope() is provided, the returned list only includes all policy definitions that at the given scope. If $filter='policyType -eq {value}' is provided, the returned list only includes all policy definitions whose type match the {value}. Possible policyType values are NotSpecified, BuiltIn, Custom, and Static. If $filter='category -eq {value}' is provided, the returned list only includes all policy definitions whose category match the {value}.
       */
      @query("$filter")
      $filter?: string;

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
   * This operation retrieves the policy definition in the given management group with the given name.
   */
  getAtManagementGroup is PolicyDefinitionManagementGroupOps.Read<PolicyDefinition>;

  /**
   * This operation creates or updates a policy definition in the given management group with the given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdateAtManagementGroup is PolicyDefinitionManagementGroupOps.CreateOrUpdateSync<
    PolicyDefinition,
    Response = ArmResourceCreatedSyncResponse<PolicyDefinition>
  >;

  /**
   * This operation deletes the policy definition in the given management group with the given name.
   */
  deleteAtManagementGroup is PolicyDefinitionManagementGroupOps.DeleteSync<PolicyDefinition>;

  /**
   * This operation retrieves a list of all the policy definitions in a given management group that match the optional given $filter. Valid values for $filter are: 'atExactScope()', 'policyType -eq {value}' or 'category eq '{value}''. If $filter is not provided, the unfiltered list includes all policy definitions associated with the management group, including those that apply directly or from management groups that contain the given management group. If $filter=atExactScope() is provided, the returned list only includes all policy definitions that at the given management group. If $filter='policyType -eq {value}' is provided, the returned list only includes all policy definitions whose type match the {value}. Possible policyType values are NotSpecified, BuiltIn, Custom, and Static. If $filter='category -eq {value}' is provided, the returned list only includes all policy definitions whose category match the {value}.
   */
  listByManagementGroup is PolicyDefinitionManagementGroupOps.List<
    PolicyDefinition,
    Parameters = {
      /**
       * The filter to apply on the operation. Valid values for $filter are: 'atExactScope()', 'policyType -eq {value}' or 'category eq '{value}''. If $filter is not provided, no filtering is performed. If $filter=atExactScope() is provided, the returned list only includes all policy definitions that at the given scope. If $filter='policyType -eq {value}' is provided, the returned list only includes all policy definitions whose type match the {value}. Possible policyType values are NotSpecified, BuiltIn, Custom, and Static. If $filter='category -eq {value}' is provided, the returned list only includes all policy definitions whose category match the {value}.
       */
      @query("$filter")
      $filter?: string;

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

@@doc(PolicyDefinition.name, "The name of the policy definition to get.");
@@doc(PolicyDefinition.properties, "The policy definition properties.");
@@doc(PolicyDefinitions.createOrUpdate::parameters.resource,
  "The policy definition properties."
);
@@doc(PolicyDefinitions.createOrUpdateAtManagementGroup::parameters.resource,
  "The policy definition properties."
);
