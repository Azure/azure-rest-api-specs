import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Security;

/**
 * the kind of the settings string
 */
union SettingKind {
  string,

  /**
   * DataExportSettings
   */
  DataExportSettings: "DataExportSettings",

  /**
   * AlertSuppressionSetting
   */
  AlertSuppressionSetting: "AlertSuppressionSetting",

  /**
   * AlertSyncSettings
   */
  AlertSyncSettings: "AlertSyncSettings",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SettingName {
  string,

  /**
   * MCAS
   */
  MCAS: "MCAS",

  /**
   * WDATP
   */
  WDATP: "WDATP",

  /**
   * WDATP_EXCLUDE_LINUX_PUBLIC_PREVIEW
   */
  WDATP_EXCLUDE_LINUX_PUBLIC_PREVIEW: "WDATP_EXCLUDE_LINUX_PUBLIC_PREVIEW",

  /**
   * WDATP_UNIFIED_SOLUTION
   */
  WDATP_UNIFIED_SOLUTION: "WDATP_UNIFIED_SOLUTION",

  /**
   * Sentinel
   */
  Sentinel: "Sentinel",
}

/**
 * Subscription settings list.
 */
model SettingsList {
  /**
   * The settings list.
   */
  @pageItems
  value?: Setting[];

  /**
   * The URI to fetch the next page.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Represents a data export setting
 */
model DataExportSettings extends Setting {
  /**
   * Data export setting data
   */
  properties?: DataExportSettingProperties;

  /**
   * the kind of the settings string
   */
  kind: "DataExportSettings";
}

/**
 * The data export setting properties
 */
model DataExportSettingProperties {
  /**
   * Is the data export setting enabled
   */
  enabled: boolean;
}

/**
 * Represents an alert sync setting
 */
model AlertSyncSettings extends Setting {
  /**
   * Alert sync setting data
   */
  properties?: AlertSyncSettingProperties;

  /**
   * the kind of the settings string
   */
  kind: "AlertSyncSettings";
}

/**
 * The alert sync setting properties
 */
model AlertSyncSettingProperties {
  /**
   * Is the alert sync setting enabled
   */
  enabled: boolean;
}
