import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

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
 * Describes an Azure resource.
 */
/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * The error object.
   */
  error?: CloudErrorBody;
}

/**
 * The error detail.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model CloudErrorBody {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The error target.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * The error details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  details?: CloudErrorBody[];

  /**
   * The error additional info.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * The resource management error additional info.
 */
model ErrorAdditionalInfo {
  /**
   * The additional info type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The additional info.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  info?: unknown;
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
