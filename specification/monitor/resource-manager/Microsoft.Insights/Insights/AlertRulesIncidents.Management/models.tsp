import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Insights;

/**
 * An alert incident indicates the activation status of an alert rule.
 */
model Incident {
  /**
   * Incident name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Rule name that is associated with the incident.
   */
  @visibility(Lifecycle.Read)
  ruleName?: string;

  /**
   * A boolean to indicate whether the incident is active or resolved.
   */
  @visibility(Lifecycle.Read)
  isActive?: boolean;

  /**
   * The time at which the incident was activated in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  activatedTime?: utcDateTime;

  /**
   * The time at which the incident was resolved in ISO8601 format. If null, it means the incident is still active.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resolvedTime?: utcDateTime;
}

/**
 * Describes the format of Error response.
 */
@error
model ErrorResponse {
  /**
   * Error code
   */
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  message?: string;
}

/**
 * The List incidents operation response.
 */
model IncidentListResult {
  /**
   * the incident collection.
   */
  @pageItems
  @identifiers(#["name"])
  value?: Incident[];

  /**
   * the URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}
