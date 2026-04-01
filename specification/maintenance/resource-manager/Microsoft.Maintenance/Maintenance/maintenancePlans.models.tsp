import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Maintenance;

/**
 * Properties for maintenance plan response.
 */
model MaintenancePlansResponseProperties {
  /**
   * State of Maintenance Plan.
   */
  @visibility(Lifecycle.Read)
  state?: MaintenancePlansState;

  /**
   * The resourceId of the parent resource. This value is populated by the service based on the ARM resource path.
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;

  /** Description of the maintenance plan. */
  description?: string;

  /** Start time of the maintenance plan in UTC. */
  @encodedName("application/json", "startTimeUTC")
  startTimeUtc?: utcDateTime;

  /** End time of the maintenance plan in UTC. */
  @encodedName("application/json", "endTimeUTC")
  endTimeUtc?: utcDateTime;

  /** Scope of the maintenance plan (Ex: Flighting, AllProf etc.). */
  updateScope?: MaintenancePlansUpdateScope;

  /**
   * Version to update to.
   */
  versionToUpdate?: string;
}

/** Maintenance Plan State. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "MaintenancePlansState is constrained to a fixed set of values."
enum MaintenancePlansState {
  /** MaintenancePlan call was accepted, creation has completed successfully. */
  Succeeded: "Succeeded",

  /** MaintenancePlan call was accepted, creation has failed. */
  Failed: "Failed",
}

/** Maintenance Plan Update Scope. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "MaintenancePlansUpdateScope is constrained to a fixed set of values."
enum MaintenancePlansUpdateScope {
  /** Apply only flighting firmware updates to nodes. */
  FlightingNodeFirmwareUpdatesOnly: "FlightingNodeFirmwareUpdatesOnly",

  /** Apply all updates that are qualified for the supercomputer. */
  AllQualifiedUpdates: "AllQualifiedUpdates",

  /** Apply only qualified firmware updates. */
  QualifiedNodeFirmwareUpdatesOnly: "QualifiedNodeFirmwareUpdatesOnly",

  /** Apply only critical updates that are impactless. */
  CriticalImpactlessUpdatesOnly: "CriticalImpactlessUpdatesOnly",

  /** Apply critical updates that may have visible customer impact. */
  CriticalImpactfulUpdatesOnly: "CriticalImpactfulUpdatesOnly",
}

/**
 * Properties bag for the MaintenancePlan ARM proxy resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
model MaintenancePlanProperties {
  ...MaintenancePlansResponseProperties;
}

/**
 * Response type mentioned by the controller.
 * In ARM, the resource envelope is typically the response, so this is an alias.
 */
alias MaintenancePlansResponse = MaintenancePlan;

/**
 * Response for MaintenancePlans list.
 */
model ListMaintenancePlansResult {
  /**
   * The list of maintenance plans.
   */
  @pageItems
  value?: MaintenancePlansResponse[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: ResourceLocation<Resource>;
}
