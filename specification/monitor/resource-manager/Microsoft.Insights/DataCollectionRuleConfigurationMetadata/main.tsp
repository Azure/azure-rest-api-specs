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
@service(#{
  title: "Azure Monitor Data Collection Rule Configuration Metadata API",
})
@versioned(Versions)
namespace Microsoft.Insights;

/** API versions */
enum Versions {
  /** 2025-01-01 stable version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  `2025-01-01`,
}

/** Operations interface for the resource provider. */
interface Operations extends Azure.ResourceManager.Operations {}

/** Operations for fetching data collection rule configuration metadata. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This is a location-based action interface, not a standard ARM resource interface"
@tag("DataCollectionRuleConfigurationMetadata")
interface DataCollectionRuleConfigurationMetadata {
  /** Fetches configuration metadata for data collection rules. When withStreamMetadata is true, returns detailed stream information. */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Insights/locations/{location}/fetchDataCollectionRuleConfigurationMetadata")
  @post
  fetch(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The Azure region for the metadata request. */
    @path
    location: string,

    /** Request body containing filter options and stream metadata flag. */
    @body
    body?: DataCollectionRuleConfigurationMetadataRequest,
  ): ArmResponse<DataCollectionRuleConfigurationMetadataResponse> | ErrorResponse;
}
