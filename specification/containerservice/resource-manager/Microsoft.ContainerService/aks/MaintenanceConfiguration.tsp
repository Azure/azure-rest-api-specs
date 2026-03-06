import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ContainerService;

// =============================================================================
// MaintenanceConfiguration resource and operations
// =============================================================================

/**
 * Planned maintenance configuration, used to configure when updates can be deployed to a Managed Cluster. See [planned maintenance](https://docs.microsoft.com/azure/aks/planned-maintenance) for more information about planned maintenance.
 */
@parentResource(ManagedCluster)
model MaintenanceConfiguration
  is Azure.ResourceManager.ProxyResource<MaintenanceConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = MaintenanceConfiguration,
    KeyName = "configName",
    SegmentName = "maintenanceConfigurations",
    NamePattern = ""
  >;
}

@@doc(MaintenanceConfiguration.name,
  "The name of the maintenance configuration. Supported values are 'default', 'aksManagedAutoUpgradeSchedule', or 'aksManagedNodeOSUpgradeSchedule'."
);
@@doc(MaintenanceConfiguration.properties,
  "Properties of a default maintenance configuration."
);
@@doc(MaintenanceConfigurations.createOrUpdate::parameters.resource,
  "The maintenance configuration to create or update."
);

@armResourceOperations
interface MaintenanceConfigurations {
  /**
   * Gets the specified maintenance configuration of a managed cluster.
   */
  get is ArmResourceRead<MaintenanceConfiguration>;

  /**
   * Creates or updates a maintenance configuration in the specified managed cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<MaintenanceConfiguration>;

  /**
   * Deletes a maintenance configuration.
   */
  delete is ArmResourceDeleteSync<MaintenanceConfiguration>;

  /**
   * Gets a list of maintenance configurations in the specified managed cluster.
   */
  listByManagedCluster is ArmResourceListByParent<MaintenanceConfiguration>;
}

// =============================================================================
// MaintenanceConfiguration models
// =============================================================================

/**
 * The weekday enum.
 */
union WeekDay {
  string,

  /** Represents Sunday. */
  Sunday: "Sunday",

  /** Represents Monday. */
  Monday: "Monday",

  /** Represents Tuesday. */
  Tuesday: "Tuesday",

  /** Represents Wednesday. */
  Wednesday: "Wednesday",

  /** Represents Thursday. */
  Thursday: "Thursday",

  /** Represents Friday. */
  Friday: "Friday",

  /** Represents Saturday. */
  Saturday: "Saturday",
}

/**
 * The week index. Specifies on which week of the month the dayOfWeek applies.
 */
union Type {
  string,

  /**
   * First week of the month.
   */
  First: "First",

  /**
   * Second week of the month.
   */
  Second: "Second",

  /**
   * Third week of the month.
   */
  Third: "Third",

  /**
   * Fourth week of the month.
   */
  Fourth: "Fourth",

  /**
   * Last week of the month.
   */
  Last: "Last",
}

/**
 * Properties used to configure planned maintenance for a Managed Cluster.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AKS uses custom provisioning states beyond standard ARM states. Using string type for forward compatibility."
model MaintenanceConfigurationProperties {
  /**
   * Time slots during the week when planned maintenance is allowed to proceed. If two array entries specify the same day of the week, the applied configuration is the union of times in both entries.
   */
  @identifiers(#[])
  timeInWeek?: TimeInWeek[];

  /**
   * Time slots on which upgrade is not allowed.
   */
  @identifiers(#[])
  notAllowedTime?: TimeSpan[];

  /**
   * Maintenance window for the maintenance configuration.
   */
  maintenanceWindow?: MaintenanceWindow;
}

/**
 * Time in a week.
 */
model TimeInWeek {
  /**
   * The day of the week.
   */
  day?: WeekDay;

  /**
   * A list of hours in the day used to identify a time range. Each integer hour represents a time range beginning at 0m after the hour ending at the next hour (non-inclusive). 0 corresponds to 00:00 UTC, 23 corresponds to 23:00 UTC. Specifying [0, 1] means the 00:00 - 02:00 UTC time range.
   */
  hourSlots?: HourInDay[];
}

/**
 * Hour in a day.
 */
@minValue(0)
@maxValue(23)
scalar HourInDay extends int32;

/**
 * A time range. For example, between 2021-05-25T13:00:00Z and 2021-05-25T14:00:00Z.
 */
model TimeSpan {
  /**
   * The start of a time span
   */
  start?: utcDateTime;

  /**
   * The end of a time span
   */
  end?: utcDateTime;
}

/**
 * Maintenance window used to configure scheduled auto-upgrade for a Managed Cluster.
 */
model MaintenanceWindow {
  /**
   * Recurrence schedule for the maintenance window.
   */
  schedule: Schedule;

  /**
   * Length of maintenance window range from 4 to 24 hours.
   */
  @maxValue(24)
  @minValue(4)
  durationHours: int32 = 24;

  /**
   * The UTC offset in format +/-HH:mm. For example, '+05:30' for IST and '-07:00' for PST. If not specified, the default is '+00:00'.
   */
  @pattern("^(-|\\+)[0-9]{2}:[0-9]{2}$")
  utcOffset?: string;

  /**
   * The date the maintenance window activates. If the current date is before this date, the maintenance window is inactive and will not be used for upgrades. If not specified, the maintenance window will be active right away.
   */
  startDate?: plainDate;

  /**
   * The start time of the maintenance window. Accepted values are from '00:00' to '23:59'. 'utcOffset' applies to this field. For example: '02:00' with 'utcOffset: +02:00' means UTC time '00:00'.
   */
  @pattern("^\\d{2}:\\d{2}$")
  startTime: string;

  /**
   * Date ranges on which upgrade is not allowed. 'utcOffset' applies to this field. For example, with 'utcOffset: +02:00' and 'dateSpan' being '2022-12-23' to '2023-01-03', maintenance will be blocked from '2022-12-22 22:00' to '2023-01-03 22:00' in UTC time.
   */
  @identifiers(#[])
  notAllowedDates?: DateSpan[];
}

/**
 * One and only one of the schedule types should be specified. Choose either 'daily', 'weekly', 'absoluteMonthly' or 'relativeMonthly' for your maintenance schedule.
 */
model Schedule {
  /**
   * For schedules like: 'recur every day' or 'recur every 3 days'.
   */
  daily?: DailySchedule;

  /**
   * For schedules like: 'recur every Monday' or 'recur every 3 weeks on Wednesday'.
   */
  weekly?: WeeklySchedule;

  /**
   * For schedules like: 'recur every month on the 15th' or 'recur every 3 months on the 20th'.
   */
  absoluteMonthly?: AbsoluteMonthlySchedule;

  /**
   * For schedules like: 'recur every month on the first Monday' or 'recur every 3 months on last Friday'.
   */
  relativeMonthly?: RelativeMonthlySchedule;
}

/**
 * For schedules like: 'recur every day' or 'recur every 3 days'.
 */
model DailySchedule {
  /**
   * Specifies the number of days between each set of occurrences.
   */
  @maxValue(7)
  @minValue(1)
  intervalDays: int32;
}

/**
 * For schedules like: 'recur every Monday' or 'recur every 3 weeks on Wednesday'.
 */
model WeeklySchedule {
  /**
   * Specifies the number of weeks between each set of occurrences.
   */
  @maxValue(4)
  @minValue(1)
  intervalWeeks: int32;

  /**
   * Specifies on which day of the week the maintenance occurs.
   */
  dayOfWeek: WeekDay;
}

/**
 * For schedules like: 'recur every month on the 15th' or 'recur every 3 months on the 20th'.
 */
model AbsoluteMonthlySchedule {
  /**
   * Specifies the number of months between each set of occurrences.
   */
  @maxValue(6)
  @minValue(1)
  intervalMonths: int32;

  /**
   * The date of the month.
   */
  @maxValue(31)
  @minValue(1)
  dayOfMonth: int32;
}

/**
 * For schedules like: 'recur every month on the first Monday' or 'recur every 3 months on last Friday'.
 */
model RelativeMonthlySchedule {
  /**
   * Specifies the number of months between each set of occurrences.
   */
  @maxValue(6)
  @minValue(1)
  intervalMonths: int32;

  /**
   * The week index. Specifies on which week of the month the dayOfWeek applies.
   */
  weekIndex: Type;

  /**
   * Specifies on which day of the week the maintenance occurs.
   */
  dayOfWeek: WeekDay;
}

/**
 * A date range. For example, between '2022-12-23' and '2023-01-05'.
 */
model DateSpan {
  /**
   * The start date of the date span.
   */
  start: plainDate;

  /**
   * The end date of the date span.
   */
  end: plainDate;
}
