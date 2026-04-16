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
  startTimeUtc: utcDateTime;

  /** End time of the maintenance plan in UTC. */
  @encodedName("application/json", "endTimeUTC")
  endTimeUtc: utcDateTime;

  /** Scope of the maintenance plan (Ex: Flighting, AllProf etc.). */
  updateScope: MaintenancePlansUpdateScope;

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
  /** Apply flighting firmware updates on the node. */
  FlightingNodeFirmwareUpdates: "FlightingNodeFirmwareUpdates",

  /** Apply flighting firmware updates on rack components. */
  FlightingRackFirmwareUpdates: "FlightingRackFirmwareUpdates",

  /** Apply qualified firmware updates on the node. */
  QualifiedNodeFirmwareUpdates: "QualifiedNodeFirmwareUpdates",

  /** Apply qualified firmware updates on rack components. */
  QualifiedRackFirmwareUpdates: "QualifiedRackFirmwareUpdates",

  /** Apply all qualified updates on the node. */
  QualifiedNodeAllUpdates: "QualifiedNodeAllUpdates",

  /** Apply all qualified updates on rack components. */
  QualifiedRackAllUpdates: "QualifiedRackAllUpdates",

  /** Apply all critical impactless updates on the node. */
  CriticalNodeImpactlessUpdates: "CriticalNodeImpactlessUpdates",

  /** Apply all critical impactless updates on rack components. */
  CriticalRackImpactlessUpdates: "CriticalRackImpactlessUpdates",

  /** Apply all critical impactful updates on the node. */
  CriticalNodeImpactfulUpdates: "CriticalNodeImpactfulUpdates",

  /** Apply all critical impactful updates on rack components. */
  CriticalRackImpactfulUpdates: "CriticalRackImpactfulUpdates",

  /** Customer specifies via versionToUpdate what package they want us to update. */
  Custom: "Custom",

  /** @deprecated Legacy single-node flighting enum member. Use FlightingNodeFirmwareUpdates or FlightingRackFirmwareUpdates. */
  #deprecated "Use FlightingNodeFirmwareUpdates or FlightingRackFirmwareUpdates"
  FlightingNodeFirmwareUpdatesOnly: "FlightingNodeFirmwareUpdatesOnly",

  /** @deprecated Legacy node qualified update enum member. Use QualifiedNodeFirmwareUpdates or QualifiedRackFirmwareUpdates. */
  #deprecated "Use QualifiedNodeFirmwareUpdates or QualifiedRackFirmwareUpdates"
  QualifiedNodeFirmwareUpdatesOnly: "QualifiedNodeFirmwareUpdatesOnly",

  /** @deprecated Legacy node critical impactless enum member. Use CriticalNodeImpactlessUpdates or CriticalRackImpactlessUpdates. */
  #deprecated "Use CriticalNodeImpactlessUpdates or CriticalRackImpactlessUpdates"
  CriticalImpactlessUpdatesOnly: "CriticalImpactlessUpdatesOnly",

  /** @deprecated Legacy node critical impactful enum member. Use CriticalNodeImpactfulUpdates or CriticalRackImpactfulUpdates. */
  #deprecated "Use CriticalNodeImpactfulUpdates or CriticalRackImpactfulUpdates"
  CriticalImpactfulUpdatesOnly: "CriticalImpactfulUpdatesOnly",

  /** @deprecated Legacy qualified update enum member. Use QualifiedNodeAllUpdates or QualifiedRackAllUpdates. */
  #deprecated "Use QualifiedNodeAllUpdates or QualifiedRackAllUpdates"
  AllQualifiedUpdates: "AllQualifiedUpdates",
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
