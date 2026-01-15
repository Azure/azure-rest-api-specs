import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/**
 * Azure Monitor Data Collection Rule Configuration Metadata API
 * Provides operations for fetching configuration metadata for data collection rules,
 * including supported data sources, destinations, and stream specifications.
 */
@armProviderNamespace("Microsoft.Insights")
@service(#{ title: "Azure Monitor Data Collection Rule Configuration Metadata API" })
@versioned(Versions)
namespace Microsoft.Insights;

/** API versions */
enum Versions {
  /** 2025-01-01 stable version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v4)
  `2025-01-01`,
}

/** Operations interface for the resource provider. */
interface Operations extends Azure.ResourceManager.Operations {}

/** Operations for fetching data collection rule configuration metadata. */
@tag("DataCollectionRuleConfigurationMetadata")
interface DataCollectionRuleConfigurationMetadata {
  /** Fetches summary configuration metadata for all supported data sources. */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Insights/locations/{location}/fetchDataCollectionRuleConfigurationMetadataSummary")
  @post
  fetchSummary(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The Azure region for the metadata request. */
    @path
    location: string,

    /** Request body containing optional resource type filter. */
    @body
    body?: DataCollectionRuleConfigurationMetadataRequest,
  ): ArmResponse<DataCollectionRuleConfigurationMetadataResponse> | ErrorResponse;

  /** Fetches detailed configuration metadata for a specific resource type. */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Insights/locations/{location}/fetchDataCollectionRuleConfigurationMetadataDetails")
  @post
  fetchDetails(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The Azure region for the metadata request. */
    @path
    location: string,

    /** Request body containing resource type filter. */
    @body
    body: DataCollectionRuleConfigurationMetadataRequest,
  ): ArmResponse<DataCollectionRuleConfigurationMetadataResponse> | ErrorResponse;
}
