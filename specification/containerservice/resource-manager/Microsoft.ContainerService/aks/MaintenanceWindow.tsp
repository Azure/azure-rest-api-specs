import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./MaintenanceConfiguration.tsp"; // reuse Schedule, DateSpan, WeekDay, Type

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ContainerService;

// =============================================================================
// MaintenanceWindow peer resource and operations
//
// MaintenanceWindow is a resource-group-scoped peer of managedClusters
// (sibling to Snapshot / ManagedClusterSnapshot in this same project). It is
// modeled with the TypeSpec identifier `MaintenanceWindowResource` because
// `MaintenanceWindow` is already taken by the existing inline maintenance
// window schedule model used on `maintenanceConfigurations.properties.maintenanceWindow`
// (see MaintenanceConfiguration.tsp). The ARM resource type remains
// `Microsoft.ContainerService/maintenanceWindows` via the `SegmentName` below,
// so this naming is internal to the TypeSpec / generated SDK only.
// =============================================================================

/**
 * A maintenance window is a resource-group-scoped resource that defines a reusable
 * maintenance schedule which can be linked to maintenance configurations on one
 * or more managed clusters.
 * For more information, see https://aka.ms/aks/maintenance-windows.
 */
@added(Versions.v2026_04_02_preview)
model MaintenanceWindowResource
  is Azure.ResourceManager.TrackedResource<MaintenanceWindowResourceProperties> {
  ...ResourceNameParameter<
    Resource = MaintenanceWindowResource,
    KeyName = "maintenanceWindowName",
    SegmentName = "maintenanceWindows",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;
}

@@maxLength(MaintenanceWindowResource.name, 63);
@@minLength(MaintenanceWindowResource.name, 1);
@@doc(MaintenanceWindowResource.name, "The name of the maintenance window.");
@@doc(
  MaintenanceWindowResource.properties,
  "Properties of a maintenance window."
);
@@doc(
  MaintenanceWindows.createOrUpdate::parameters.resource,
  "The maintenance window to create or update."
);
@@doc(
  MaintenanceWindows.updateTags::parameters.properties,
  "Parameters supplied to the Update maintenance window Tags operation."
);

@armResourceOperations
@added(Versions.v2026_04_02_preview)
interface MaintenanceWindows {
  /**
   * Gets the specified maintenance window.
   */
  get is ArmResourceRead<MaintenanceWindowResource>;

  /**
   * Creates or updates a maintenance window.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MaintenanceWindowResource>;

  /**
   * Updates tags on a maintenance window.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    MaintenanceWindowResource,
    PatchModel = TagsObject
  >;

  /**
   * Deletes a maintenance window.
   */
  delete is ArmResourceDeleteWithoutOkAsync<MaintenanceWindowResource>;

  /**
   * Lists maintenance windows in the specified resource group.
   */
  list is ArmResourceListByParent<MaintenanceWindowResource>;

  /**
   * Lists maintenance windows in the specified subscription.
   */
  listBySubscription is ArmListBySubscription<MaintenanceWindowResource>;
}

// =============================================================================
// MaintenanceWindow models
// =============================================================================

/**
 * Properties of a maintenance window.
 * For more information, see https://aka.ms/aks/maintenance-windows.
 */
@added(Versions.v2026_04_02_preview)
model MaintenanceWindowResourceProperties {
  /**
   * The provisioning state of the maintenance window.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

  /**
   * Recurrence schedule for the maintenance window. One and only one of the schedule
   * types should be specified: 'daily', 'weekly', 'absoluteMonthly', or 'relativeMonthly'.
   */
  schedule: Schedule;

  /**
   * The date the maintenance window activates. If the current date is before this
   * date, the maintenance window is inactive and will not be used. If not specified,
   * the maintenance window will be active right away.
   */
  startDate?: plainDate;

  /**
   * The start time of the maintenance window. Accepted values are from '00:00' to
   * '23:59'. 'utcOffset' applies to this field. For example: '02:00' with
   * 'utcOffset: +02:00' means UTC time '00:00'.
   */
  @pattern("^([01]\\d|2[0-3]):[0-5]\\d$")
  startTime: string;

  /**
   * Length of the maintenance window in hours.
   */
  @minValue(4)
  @maxValue(24)
  durationHours: int32 = 4;

  /**
   * The UTC offset in format +/-HH:mm. For example, '+05:30' for IST and '-07:00'
   * for PST. If not specified, the default is '+00:00'.
   * Note: this is a static offset and does not adjust for Daylight Saving Time.
   * Customers in DST-observing regions should pick the offset that matches their
   * preferred wall-clock time year-round; the maintenance window will shift by one
   * hour relative to local time when DST starts or ends.
   */
  @pattern("^[+-](0\\d|1[0-4]):(00|15|30|45)$")
  utcOffset?: string;

  /**
   * Date ranges during which maintenance is not allowed. 'utcOffset' applies to
   * these dates. For example, with 'utcOffset: +02:00' and a date span of
   * '2026-12-23' to '2027-01-03', maintenance will be blocked from
   * '2026-12-22 22:00' to '2027-01-03 22:00' in UTC time.
   */
  @identifiers(#[])
  notAllowedDates?: DateSpan[];
}
