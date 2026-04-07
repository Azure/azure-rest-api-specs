import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * Network security perimeter (NSP) configuration resource
 */
model NetworkSecurityPerimeterConfiguration
  is CommonTypes.NspConfigurationResource<KeyName = "nspConfigName">;
alias NetworkSecurityPerimeterConfigurationOperations = NspConfigurations<
  NetworkSecurityPerimeterConfiguration,
  NspConfigurationKeyName = "networkSecurityPerimeterConfigurationName"
>;

alias NetworkSecurityPerimeterConfigurationOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the action group. */
    @path
    @segment("actionGroups")
    @key
    @pattern("^.*$")
    @maxLength(43)
    actionGroupName: string;
  },
  {
    /** The name for a network security perimeter configuration */
    @path
    @segment("networkSecurityPerimeterConfigurations")
    @key
    @pattern("^.*$")
    @maxLength(512)
    @minLength(1)
    networkSecurityPerimeterConfigurationName: string;
  }
>;

@armResourceOperations
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Gets a specified NSP configuration for specified action group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ActionGroups_GetNSP")
  getNSP is NetworkSecurityPerimeterConfigurationOps.Read<CommonTypes.NetworkSecurityPerimeterConfiguration>;

  /**
   * Gets a list of NSP configurations for specified action group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ActionGroups_ListNSP")
  listNSP is NetworkSecurityPerimeterConfigurationOps.List<
    CommonTypes.NetworkSecurityPerimeterConfiguration,
    Response = ArmResponse<CommonTypes.NetworkSecurityPerimeterConfigurationListResult>
  >;

  /**
   * Reconciles a specified NSP configuration for specified action group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ActionGroups_ReconcileNSP")
  @action("reconcile")
  reconcileNSP is NetworkSecurityPerimeterConfigurationOps.ActionSync<
    CommonTypes.NetworkSecurityPerimeterConfiguration,
    void,
    ArmAcceptedLroResponse
  >;
}
alias DataCollectionEndpointOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the data collection endpoint. The name is case insensitive. */
    @path
    @segment("dataCollectionEndpoints")
    @key
    @pattern("^.*$")
    @maxLength(43)
    dataCollectionEndpointName: string;
  },
  {
    /** The name for a network security perimeter configuration */
    @path
    @segment("networkSecurityPerimeterConfigurations")
    @key
    @pattern("^.*$")
    @maxLength(512)
    @minLength(1)
    networkSecurityPerimeterConfigurationName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface DataCollectionEndpoints {
  /**
   * Gets the specified NSP configuration for the specified data collection endpoint.
   */
  @tag("NetworkSecurityPerimeterConfigurations")
  @summary("Gets the specified NSP configuration for the specified data collection endpoint.")
  getNSP is DataCollectionEndpointOps.Read<CommonTypes.NetworkSecurityPerimeterConfiguration>;

  /**
   * Gets a list of NSP configurations for the specified data collection endpoint.
   */
  @tag("NetworkSecurityPerimeterConfigurations")
  @summary("Gets a list of NSP configurations for the specified data collection endpoint.")
  listNSP is DataCollectionEndpointOps.List<
    CommonTypes.NetworkSecurityPerimeterConfiguration,
    Response = ArmResponse<CommonTypes.NetworkSecurityPerimeterConfigurationListResult>
  >;

  /**
   * Reconciles the specified NSP configuration for the specified data collection endpoint.
   */
  @action("reconcile")
  @tag("NetworkSecurityPerimeterConfigurations")
  @summary("Reconciles the specified NSP configuration for the specified data collection endpoint.")
  reconcileNSP is DataCollectionEndpointOps.ActionSync<
    CommonTypes.NetworkSecurityPerimeterConfiguration,
    void,
    ArmAcceptedLroResponse
  >;
}
alias ScheduledQueryRuleOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the rule. */
    @path
    @segment("scheduledQueryRules")
    @key
    @pattern("^.*$")
    @maxLength(43)
    ruleName: string;
  },
  {
    /** The name for a network security perimeter configuration */
    @path
    @segment("networkSecurityPerimeterConfigurations")
    @key
    @pattern("^.*$")
    @maxLength(512)
    @minLength(1)
    networkSecurityPerimeterConfigurationName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface ScheduledQueryRule {
  /**
   * Gets a network security perimeter configuration.
   */
  @tag("NetworkSecurityPerimeterConfigurations")
  getNSP is ScheduledQueryRuleOps.Read<CommonTypes.NetworkSecurityPerimeterConfiguration>;

  /**
   * Gets a list of NSP configurations for specified scheduled query rule.
   */
  @tag("NetworkSecurityPerimeterConfigurations")
  listNSP is ScheduledQueryRuleOps.List<
    CommonTypes.NetworkSecurityPerimeterConfiguration,
    Response = ArmResponse<CommonTypes.NetworkSecurityPerimeterConfigurationListResult>
  >;

  /**
   * Reconcile network security perimeter configuration for ScheduledQueryRule resource.
   */
  @action("reconcile")
  @tag("NetworkSecurityPerimeterConfigurations")
  reconcileNSP is ScheduledQueryRuleOps.ActionSync<
    CommonTypes.NetworkSecurityPerimeterConfiguration,
    void,
    ArmAcceptedLroResponse
  >;
}

@@pageItems(CommonTypes.NetworkSecurityPerimeterConfigurationListResult.value);
@@nextLink(CommonTypes.NetworkSecurityPerimeterConfigurationListResult.nextLink
);
