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

namespace Microsoft.Cdn;
/**
 * A profile is a logical grouping of endpoints that share the same settings.
 */
model Profile is TrackedResource<ProfileProperties> {
  /**
   * Name of the Azure Front Door Standard or Azure Front Door Premium or CDN profile which is unique within the resource group.
   */
  @path
  @key("profileName")
  @segment("profiles")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Profiles {
  /**
   * Gets an Azure Front Door Standard or Azure Front Door Premium or CDN profile with the specified profile name under the specified subscription and resource group.
   */
  get is ArmResourceRead<Profile>;

  /**
   * Creates a new Azure Front Door Standard or Azure Front Door Premium or CDN profile with a profile name under the specified subscription and resource group.
   */
  create is ArmResourceCreateOrReplaceAsync<Profile>;

  /**
   * Updates an existing Azure Front Door Standard or Azure Front Door Premium or CDN profile with the specified profile name under the specified subscription and resource group.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<Profile, ProfileUpdateParameters>;

  /**
   * Deletes an existing  Azure Front Door Standard or Azure Front Door Premium or CDN profile with the specified parameters. Deleting a profile will result in the deletion of all of the sub-resources including endpoints, origins and custom domains.
   */
  delete is ArmResourceDeleteAsync<Profile>;

  /**
   * Lists all of the Azure Front Door Standard, Azure Front Door Premium, and CDN profiles within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Profiles_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Profile>;

  /**
   * Lists all of the Azure Front Door Standard, Azure Front Door Premium, and CDN profiles within an Azure subscription.
   */
  list is ArmListBySubscription<Profile>;

  /**
   * Checks the quota and actual usage of AzureFrontDoor endpoints under the given CDN profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorProfiles_ListResourceUsage")
  listResourceUsage is ArmResourceActionSync<Profile, void, UsagesListResult>;

  /**
   * Check the name availability of a host name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorProfiles_CheckHostNameAvailability")
  checkHostNameAvailability is ArmResourceActionSync<
    Profile,
    HostNameAvailabilityContent,
    CdnNameAvailabilityResult
  >;

  /**
   * Generates a dynamic SSO URI used to sign in to the CDN supplemental portal. Supplemental portal is used to configure advanced feature capabilities that are not yet available in the Azure portal, such as core reports in a standard profile; rules engine, advanced HTTP reports, and real-time stats and alerts in a premium profile. The SSO URI changes approximately every 10 minutes.
   */
  generateSsoUri is ArmResourceActionSync<Profile, void, SsoUri>;

  /**
   * Gets the supported optimization types for the current profile. A user can create an endpoint with an optimization type from the listed values.
   */
  listSupportedOptimizationTypes is ArmResourceActionSync<
    Profile,
    void,
    SupportedOptimizationTypesListResult
  >;

  // /**
  //  * Checks the quota and actual usage of endpoints under the given Azure Front Door Standard or Azure Front Door Premium or CDN profile.
  //  */
  // listResourceUsage is ArmResourceActionSync<
  //   Profile,
  //   void,
  //   ResourceUsageListResult
  // >;

  /**
   * Get log report for AFD profile
   */
  // FIXME: LogAnalytics_GetLogAnalyticsMetrics could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LogAnalytics_GetLogAnalyticsMetrics")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}/getLogAnalyticsMetrics")
  @get
  getLogAnalyticsMetrics is Azure.Core.Foundations.Operation<
    {
      /**
       * Azure Subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * Name of the Azure Front Door Standard or Azure Front Door Premium profile which is unique within the resource group. which is unique within the resource group.
       */
      @path
      profileName: string;

      @query({
        name: "metrics",
        format: "multi",
      })
      metrics: LogMetric[];

      @query("dateTimeBegin")
      dateTimeBegin: utcDateTime;

      @query("dateTimeEnd")
      dateTimeEnd: utcDateTime;

      @query("granularity")
      granularity: LogMetricsGranularity;

      @query({
        name: "groupBy",
        format: "multi",
      })
      groupBy?: LogMetricsGroupBy[];

      @query({
        name: "continents",
        format: "multi",
      })
      continents?: string[];

      @query({
        name: "countryOrRegions",
        format: "multi",
      })
      countryOrRegions?: string[];

      @query({
        name: "customDomains",
        format: "multi",
      })
      customDomains: string[];

      @query({
        name: "protocols",
        format: "multi",
      })
      protocols: string[];
    },
    MetricsResponse
  >;

  /**
   * Get log analytics ranking report for AFD profile
   */
  // FIXME: LogAnalytics_GetLogAnalyticsRankings could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LogAnalytics_GetLogAnalyticsRankings")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}/getLogAnalyticsRankings")
  @get
  getLogAnalyticsRankings is Azure.Core.Foundations.Operation<
    {
      /**
       * Azure Subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * Name of the Azure Front Door Standard or Azure Front Door Premium profile which is unique within the resource group. which is unique within the resource group.
       */
      @path
      profileName: string;

      @query({
        name: "rankings",
        format: "multi",
      })
      rankings: LogRanking[];

      @query({
        name: "metrics",
        format: "multi",
      })
      metrics: LogRankingMetric[];

      @query("maxRanking")
      maxRanking: int32;

      @query("dateTimeBegin")
      dateTimeBegin: utcDateTime;

      @query("dateTimeEnd")
      dateTimeEnd: utcDateTime;

      @query({
        name: "customDomains",
        format: "multi",
      })
      customDomains?: string[];
    },
    RankingsResponse
  >;

  /**
   * Get all available location names for AFD log analytics report.
   */
  // FIXME: LogAnalytics_GetLogAnalyticsLocations could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LogAnalytics_GetLogAnalyticsLocations")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}/getLogAnalyticsLocations")
  @get
  getLogAnalyticsLocations is Azure.Core.Foundations.Operation<
    {
      /**
       * Azure Subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * Name of the Azure Front Door Standard or Azure Front Door Premium profile which is unique within the resource group. which is unique within the resource group.
       */
      @path
      profileName: string;
    },
    ContinentsResponse
  >;

  /**
   * Get all endpoints and custom domains available for AFD log report
   */
  // FIXME: LogAnalytics_GetLogAnalyticsResources could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LogAnalytics_GetLogAnalyticsResources")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}/getLogAnalyticsResources")
  @get
  getLogAnalyticsResources is Azure.Core.Foundations.Operation<
    {
      /**
       * Azure Subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * Name of the Azure Front Door Standard or Azure Front Door Premium profile which is unique within the resource group. which is unique within the resource group.
       */
      @path
      profileName: string;
    },
    ResourcesResponse
  >;

  /**
   * Get Waf related log analytics report for AFD profile.
   */
  // FIXME: LogAnalytics_GetWafLogAnalyticsMetrics could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LogAnalytics_GetWafLogAnalyticsMetrics")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}/getWafLogAnalyticsMetrics")
  @get
  getWafLogAnalyticsMetrics is Azure.Core.Foundations.Operation<
    {
      /**
       * Azure Subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * Name of the Azure Front Door Standard or Azure Front Door Premium profile which is unique within the resource group. which is unique within the resource group.
       */
      @path
      profileName: string;

      @query({
        name: "metrics",
        format: "multi",
      })
      metrics: WafMetric[];

      @query("dateTimeBegin")
      dateTimeBegin: utcDateTime;

      @query("dateTimeEnd")
      dateTimeEnd: utcDateTime;

      @query("granularity")
      granularity: WafGranularity;

      @query({
        name: "actions",
        format: "multi",
      })
      actions?: WafAction[];

      @query({
        name: "groupBy",
        format: "multi",
      })
      groupBy?: WafRankingGroupBy[];

      @query({
        name: "ruleTypes",
        format: "multi",
      })
      ruleTypes?: WafRuleType[];
    },
    WafMetricsResponse
  >;

  /**
   * Get WAF log analytics charts for AFD profile
   */
  // FIXME: LogAnalytics_GetWafLogAnalyticsRankings could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LogAnalytics_GetWafLogAnalyticsRankings")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}/getWafLogAnalyticsRankings")
  @get
  getWafLogAnalyticsRankings is Azure.Core.Foundations.Operation<
    {
      /**
       * Azure Subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * Name of the Azure Front Door Standard or Azure Front Door Premium profile which is unique within the resource group. which is unique within the resource group.
       */
      @path
      profileName: string;

      @query({
        name: "metrics",
        format: "multi",
      })
      metrics: WafMetric[];

      @query("dateTimeBegin")
      dateTimeBegin: utcDateTime;

      @query("dateTimeEnd")
      dateTimeEnd: utcDateTime;

      @query("maxRanking")
      maxRanking: int32;

      @query({
        name: "rankings",
        format: "multi",
      })
      rankings: WafRankingType[];

      @query({
        name: "actions",
        format: "multi",
      })
      actions?: WafAction[];

      @query({
        name: "ruleTypes",
        format: "multi",
      })
      ruleTypes?: WafRuleType[];
    },
    WafRankingsResponse
  >;
}

@@projectedName(Profiles.create::parameters.resource, "json", "profile");
@@extension(Profiles.create::parameters.resource,
  "x-ms-client-name",
  "profile"
);
@@doc(Profiles.create::parameters.resource,
  "Profile properties needed to create a new profile."
);
@@projectedName(Profiles.update::parameters.properties,
  "json",
  "profileUpdateParameters"
);
@@extension(Profiles.update::parameters.properties,
  "x-ms-client-name",
  "profileUpdateParameters"
);
@@doc(Profiles.update::parameters.properties,
  "Profile properties needed to update an existing profile."
);
@@projectedName(Profiles.checkHostNameAvailability::parameters.body,
  "json",
  "checkHostNameAvailabilityInput"
);
@@extension(Profiles.checkHostNameAvailability::parameters.body,
  "x-ms-client-name",
  "checkHostNameAvailabilityInput"
);
@@doc(Profiles.checkHostNameAvailability::parameters.body,
  "Custom domain to be validated."
);
