import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * A profile is a logical grouping of endpoints that share the same settings.
 */
model Profile is Azure.ResourceManager.TrackedResource<ProfileProperties> {
  ...ResourceNameParameter<
    Resource = Profile,
    KeyName = "profileName",
    SegmentName = "profiles",
    NamePattern = "^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$"
  >;

  /**
   * The pricing tier (defines Azure Front Door Standard or Premium or a CDN provider, feature list and rate) of the profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: Sku;

  /**
   * Kind of the profile. Used by portal to differentiate traditional CDN profile and new AFD profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  kind?: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceAsync<
    Profile,
    Response = ArmResourceUpdatedResponse<Profile> | ArmResourceCreatedResponse<Profile> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Profile>> & {
      @bodyRoot
      _: Profile;
    })
  >;

  /**
   * Updates an existing Azure Front Door Standard or Azure Front Door Premium or CDN profile with the specified profile name under the specified subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Profile,
    PatchModel = ProfileUpdateParameters,
    Response = ArmResponse<Profile> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Profile>> & {
      @bodyRoot
      _: Profile;
    })
  >;

  /**
   * Deletes an existing  Azure Front Door Standard or Azure Front Door Premium or CDN profile with the specified parameters. Deleting a profile will result in the deletion of all of the sub-resources including endpoints, origins and custom domains.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Profile,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmLroLocationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all of the Azure Front Door Standard, Azure Front Door Premium, and CDN profiles within a resource group.
   */
  @list
  listByResourceGroup is ArmResourceListByParent<Profile>;

  /**
   * Lists all of the Azure Front Door Standard, Azure Front Door Premium, and CDN profiles within an Azure subscription.
   */
  @list
  list is ArmListBySubscription<Profile>;

  /**
   * Check the availability of an afdx endpoint name, and return the globally unique endpoint host name.
   */
  checkEndpointNameAvailability is ArmResourceActionSync<
    Profile,
    CheckEndpointNameAvailabilityInput,
    ArmResponse<CheckEndpointNameAvailabilityOutput>
  >;

  /**
   * Checks the quota and actual usage of endpoints under the given Azure Front Door profile.
   */
  @action("usages")
  @list
  listResourceUsage is ArmResourceActionSync<
    Profile,
    void,
    ArmResponse<UsagesListResult>
  >;

  /**
   * Validates the custom domain mapping to ensure it maps to the correct Azure Front Door endpoint in DNS.
   */
  checkHostNameAvailability is ArmResourceActionSync<
    Profile,
    CheckHostNameAvailabilityInput,
    ArmResponse<CheckNameAvailabilityOutput>
  >;

  /**
   * Validate a Secret in the profile.
   */
  validateSecret is ArmResourceActionSync<
    Profile,
    ValidateSecretInput,
    ArmResponse<ValidateSecretOutput>
  >;

  /**
   * Upgrade a profile from Standard_AzureFrontDoor to Premium_AzureFrontDoor.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  upgrade is ArmResourceActionAsyncBase<
    Profile,
    ProfileUpgradeParameters,
    ArmResponse<Profile> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Profile>> & {
      @bodyRoot
      _: Profile;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Profile>
  >;

  /**
   * Get log report for AFD profile
   */
  @get
  getLogAnalyticsMetrics is ArmResourceActionSync<
    Profile,
    void,
    ArmResponse<MetricsResponse>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "metrics", explode: true })
      metrics: LogMetric[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("dateTimeBegin")
      dateTimeBegin: utcDateTime;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("dateTimeEnd")
      dateTimeEnd: utcDateTime;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("granularity")
      granularity: LogMetricsGranularity;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "groupBy", explode: true })
      groupBy?: LogMetricsGroupBy[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "continents", explode: true })
      continents?: string[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "countryOrRegions", explode: true })
      countryOrRegions?: string[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "customDomains", explode: true })
      customDomains: string[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "protocols", explode: true })
      protocols: string[];
    }
  >;

  /**
   * Get log analytics ranking report for AFD profile
   */
  @get
  getLogAnalyticsRankings is ArmResourceActionSync<
    Profile,
    void,
    ArmResponse<RankingsResponse>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "rankings", explode: true })
      rankings: LogRanking[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "metrics", explode: true })
      metrics: LogRankingMetric[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("maxRanking")
      maxRanking: int32;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("dateTimeBegin")
      dateTimeBegin: utcDateTime;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("dateTimeEnd")
      dateTimeEnd: utcDateTime;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "customDomains", explode: true })
      customDomains?: string[];
    }
  >;

  /**
   * Get all available location names for AFD log analytics report.
   */
  @get
  getLogAnalyticsLocations is ArmResourceActionSync<
    Profile,
    void,
    ArmResponse<ContinentsResponse>
  >;

  /**
   * Get all endpoints and custom domains available for AFD log report
   */
  @get
  getLogAnalyticsResources is ArmResourceActionSync<
    Profile,
    void,
    ArmResponse<ResourcesResponse>
  >;

  /**
   * Get Waf related log analytics report for AFD profile.
   */
  @get
  getWafLogAnalyticsMetrics is ArmResourceActionSync<
    Profile,
    void,
    ArmResponse<WafMetricsResponse>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "metrics", explode: true })
      metrics: WafMetric[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("dateTimeBegin")
      dateTimeBegin: utcDateTime;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("dateTimeEnd")
      dateTimeEnd: utcDateTime;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("granularity")
      granularity: WafGranularity;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "actions", explode: true })
      actions?: WafAction[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "groupBy", explode: true })
      groupBy?: WafRankingGroupBy[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "ruleTypes", explode: true })
      ruleTypes?: WafRuleType[];
    }
  >;

  /**
   * Get WAF log analytics charts for AFD profile
   */
  @get
  getWafLogAnalyticsRankings is ArmResourceActionSync<
    Profile,
    void,
    ArmResponse<WafRankingsResponse>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "metrics", explode: true })
      metrics: WafMetric[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("dateTimeBegin")
      dateTimeBegin: utcDateTime;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("dateTimeEnd")
      dateTimeEnd: utcDateTime;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("maxRanking")
      maxRanking: int32;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "rankings", explode: true })
      rankings: WafRankingType[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "actions", explode: true })
      actions?: WafAction[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "ruleTypes", explode: true })
      ruleTypes?: WafRuleType[];
    }
  >;

  /**
   * Commit the migrated Azure Frontdoor(Standard/Premium) profile.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  migrationCommit is ArmResourceActionAsync<
    Profile,
    void,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Generates a dynamic SSO URI used to sign in to the CDN supplemental portal. Supplemental portal is used to configure advanced feature capabilities that are not yet available in the Azure portal, such as core reports in a standard profile; rules engine, advanced HTTP reports, and real-time stats and alerts in a premium profile. The SSO URI changes approximately every 10 minutes.
   */
  generateSsoUri is ArmResourceActionSync<Profile, void, ArmResponse<SsoUri>>;

  /**
   * Gets the supported optimization types for the current profile. A user can create an endpoint with an optimization type from the listed values.
   */
  @action("getSupportedOptimizationTypes")
  listSupportedOptimizationTypes is ArmResourceActionSync<
    Profile,
    void,
    ArmResponse<SupportedOptimizationTypesListResult>
  >;

  /**
   * Checks the quota and actual usage of endpoints under the given Azure Front Door Standard or Azure Front Door Premium or CDN profile.
   */
  @action("checkResourceUsage")
  @list
  profilesListResourceUsage is ArmResourceActionSync<
    Profile,
    void,
    ArmResponse<ResourceUsageListResult>
  >;

  /**
   * Checks if CDN profile can be migrated to Azure Frontdoor(Standard/Premium) profile.
   */
  cdnCanMigrateToAfd is ArmResourceActionAsync<Profile, void, CanMigrateResult>;

  /**
   * Migrate the CDN profile to Azure Frontdoor(Standard/Premium) profile. This step prepares the profile for migration and will be followed by Commit to finalize the migration.
   */
  cdnMigrateToAfd is ArmResourceActionAsync<
    Profile,
    CdnMigrationToAfdParameters,
    MigrateResult
  >;

  /**
   * Abort the migration to Azure Frontdoor Premium/Standard.
   */
  migrationAbort is ArmResourceActionAsyncBase<
    Profile,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Profile>
  >;
}

@@doc(Profile.name,
  "Name of the Azure Front Door Standard or Azure Front Door Premium or CDN profile which is unique within the resource group."
);
@@doc(Profile.properties,
  "The JSON object that contains the properties required to create a profile."
);
@@doc(Profiles.create::parameters.resource,
  "Profile properties needed to create a new profile."
);
@@doc(Profiles.update::parameters.properties,
  "Profile properties needed to update an existing profile."
);
@@doc(Profiles.checkEndpointNameAvailability::parameters.body,
  "Input to check."
);
@@doc(Profiles.checkHostNameAvailability::parameters.body,
  "Custom domain to be validated."
);
@@doc(Profiles.validateSecret::parameters.body, "The Secret source.");
@@doc(Profiles.upgrade::parameters.body, "Profile upgrade input parameter.");
@@doc(Profiles.cdnMigrateToAfd::parameters.body,
  "Properties needed to migrate the profile."
);
