import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace PolicyTrackedResourcesApi;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union PolicyTrackedResourcesResourceType {
  string,

  /**
   * default
   */
  default: "default",
}

/**
 * Query results.
 */
model PolicyTrackedResourcesQueryResults {
  /**
   * The PolicyTrackedResource items on this page
   */
  @visibility(Lifecycle.Read)
  @pageItems
  @identifiers(#["trackedResourceId"])
  value?: PolicyTrackedResource[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: url;
}

/**
 * Policy tracked resource record.
 */
model PolicyTrackedResource {
  /**
   * The ID of the policy tracked resource.
   */
  @visibility(Lifecycle.Read)
  trackedResourceId?: string;

  /**
   * The details of the policy that require the tracked resource.
   */
  @visibility(Lifecycle.Read)
  policyDetails?: PolicyDetails;

  /**
   * The details of the policy triggered deployment that created the tracked resource.
   */
  @visibility(Lifecycle.Read)
  createdBy?: TrackedResourceModificationDetails;

  /**
   * The details of the policy triggered deployment that modified the tracked resource.
   */
  @visibility(Lifecycle.Read)
  lastModifiedBy?: TrackedResourceModificationDetails;

  /**
   * Timestamp of the last update to the tracked resource.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateUtc?: utcDateTime;
}

/**
 * The policy details.
 */
model PolicyDetails {
  /**
   * The ID of the policy definition.
   */
  @visibility(Lifecycle.Read)
  policyDefinitionId?: string;

  /**
   * The ID of the policy assignment.
   */
  @visibility(Lifecycle.Read)
  policyAssignmentId?: string;

  /**
   * The display name of the policy assignment.
   */
  @visibility(Lifecycle.Read)
  policyAssignmentDisplayName?: string;

  /**
   * The scope of the policy assignment.
   */
  @visibility(Lifecycle.Read)
  policyAssignmentScope?: string;

  /**
   * The ID of the policy set definition.
   */
  @visibility(Lifecycle.Read)
  policySetDefinitionId?: string;

  /**
   * The policy definition reference ID within the policy set definition.
   */
  @visibility(Lifecycle.Read)
  policyDefinitionReferenceId?: string;
}

/**
 * The details of the policy triggered deployment that created or modified the tracked resource.
 */
model TrackedResourceModificationDetails {
  /**
   * The details of the policy that created or modified the tracked resource.
   */
  @visibility(Lifecycle.Read)
  policyDetails?: PolicyDetails;

  /**
   * The ID of the deployment that created or modified the tracked resource.
   */
  @visibility(Lifecycle.Read)
  deploymentId?: string;

  /**
   * Timestamp of the deployment that created or modified the tracked resource.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deploymentTime?: utcDateTime;
}
