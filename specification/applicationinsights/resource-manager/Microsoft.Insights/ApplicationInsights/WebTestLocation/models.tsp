import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace WebTestLocation;

/**
 * Describes the list of web test locations available to an Application Insights Component.
 */
model ApplicationInsightsWebTestLocationsListResult {
  /**
   * List of web test locations.
   */
  @pageItems
  @identifiers(#["DisplayName"])
  value: ApplicationInsightsComponentWebTestLocation[];

  /** The URL to the next page of results */
  @nextLink
  nextLink?: string;
}

/**
 * Properties that define a web test location available to an Application Insights Component.
 */
model ApplicationInsightsComponentWebTestLocation {
  /**
   * The display name of the web test location.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  DisplayName?: string;

  /**
   * Internally defined geographic location tag.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  Tag?: string;
}
