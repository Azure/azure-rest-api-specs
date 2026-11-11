import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AlertsManagement;

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * User
   */
  User: "User",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Application
   */
  Application: "Application",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Key
   */
  Key: "Key",
}

/**
 * The unit to display for a metric alert rule.
 */
union MetricAlertsDisplayUnit {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * None
   */
  None: "None",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Percentage
   */
  Percentage: "Percentage",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Bytes
   */
  Bytes: "Bytes",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Kilobytes
   */
  Kilobytes: "Kilobytes",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Megabytes
   */
  Megabytes: "Megabytes",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Gigabytes
   */
  Gigabytes: "Gigabytes",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Terabytes
   */
  Terabytes: "Terabytes",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Petabytes
   */
  Petabytes: "Petabytes",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * BytesPerDay
   */
  BytesPerDay: "BytesPerDay",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * BytesPerHour
   */
  BytesPerHour: "BytesPerHour",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * BytesPerMinute
   */
  BytesPerMinute: "BytesPerMinute",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * BytesPerSecond
   */
  BytesPerSecond: "BytesPerSecond",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * KilobytesPerSecond
   */
  KilobytesPerSecond: "KilobytesPerSecond",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * MegabytesPerSecond
   */
  MegabytesPerSecond: "MegabytesPerSecond",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * GigabytesPerSecond
   */
  GigabytesPerSecond: "GigabytesPerSecond",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * TerabytesPerSecond
   */
  TerabytesPerSecond: "TerabytesPerSecond",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PetabytesPerSecond
   */
  PetabytesPerSecond: "PetabytesPerSecond",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Count
   */
  Count: "Count",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Thousand
   */
  Thousand: "Thousand",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Million
   */
  Million: "Million",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Billion
   */
  Billion: "Billion",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Trillion
   */
  Trillion: "Trillion",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * MicroSeconds
   */
  MicroSeconds: "MicroSeconds",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * MilliSeconds
   */
  MilliSeconds: "MilliSeconds",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Seconds
   */
  Seconds: "Seconds",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Minutes
   */
  Minutes: "Minutes",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Hours
   */
  Hours: "Hours",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Days
   */
  Days: "Days",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * CountPerDay
   */
  CountPerDay: "CountPerDay",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * CountPerHour
   */
  CountPerHour: "CountPerHour",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * CountPerMinute
   */
  CountPerMinute: "CountPerMinute",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * CountPerSecond
   */
  CountPerSecond: "CountPerSecond",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ThousandPerSecond
   */
  ThousandPerSecond: "ThousandPerSecond",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * MillionPerSecond
   */
  MillionPerSecond: "MillionPerSecond",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * BillionPerSecond
   */
  BillionPerSecond: "BillionPerSecond",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * TrillionPerSecond
   */
  TrillionPerSecond: "TrillionPerSecond",
}

/**
 * List of alert rule recommendations.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model AlertRuleRecommendationsListResponse
  is Azure.Core.Page<AlertRuleRecommendationResource>;

/**
 * A single alert rule recommendation resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AlertRuleRecommendationResource
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * recommendation properties.
   */
  properties: AlertRuleRecommendationProperties;
}

/**
 * Describes the format of Alert Rule Recommendations response.
 */
model AlertRuleRecommendationProperties {
  /**
   * The recommendation alert rule type.
   */
  alertRuleType: string;

  /**
   * The recommendation alert rule category.
   */
  category?: string;

  /**
   * A dictionary that provides the display information for an alert rule recommendation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  displayInformation: Record<string>;

  /**
   * A complete ARM template to deploy the alert rules.
   */
  ruleArmTemplate: RuleArmTemplate;
}

/**
 * A complete ARM template to deploy the alert rules.
 */
model RuleArmTemplate {
  /**
   * JSON schema reference
   */
  $schema: string;

  /**
   * A 4 number format for the version number of this template file. For example, 1.0.0.0
   */
  @pattern("(^[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+$)")
  contentVersion: string;

  /**
   * Variable definitions
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  variables: unknown;

  /**
   * Input parameter definitions
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters: unknown;

  /**
   * Alert rule resource definitions
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resources: unknown[];
}
