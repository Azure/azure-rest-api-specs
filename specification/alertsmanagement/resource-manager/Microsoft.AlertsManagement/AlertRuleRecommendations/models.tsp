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

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

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

  /**
   * None
   */
  None: "None",

  /**
   * Percentage
   */
  Percentage: "Percentage",

  /**
   * Bytes
   */
  Bytes: "Bytes",

  /**
   * Kilobytes
   */
  Kilobytes: "Kilobytes",

  /**
   * Megabytes
   */
  Megabytes: "Megabytes",

  /**
   * Gigabytes
   */
  Gigabytes: "Gigabytes",

  /**
   * Terabytes
   */
  Terabytes: "Terabytes",

  /**
   * Petabytes
   */
  Petabytes: "Petabytes",

  /**
   * BytesPerDay
   */
  BytesPerDay: "BytesPerDay",

  /**
   * BytesPerHour
   */
  BytesPerHour: "BytesPerHour",

  /**
   * BytesPerMinute
   */
  BytesPerMinute: "BytesPerMinute",

  /**
   * BytesPerSecond
   */
  BytesPerSecond: "BytesPerSecond",

  /**
   * KilobytesPerSecond
   */
  KilobytesPerSecond: "KilobytesPerSecond",

  /**
   * MegabytesPerSecond
   */
  MegabytesPerSecond: "MegabytesPerSecond",

  /**
   * GigabytesPerSecond
   */
  GigabytesPerSecond: "GigabytesPerSecond",

  /**
   * TerabytesPerSecond
   */
  TerabytesPerSecond: "TerabytesPerSecond",

  /**
   * PetabytesPerSecond
   */
  PetabytesPerSecond: "PetabytesPerSecond",

  /**
   * Count
   */
  Count: "Count",

  /**
   * Thousand
   */
  Thousand: "Thousand",

  /**
   * Million
   */
  Million: "Million",

  /**
   * Billion
   */
  Billion: "Billion",

  /**
   * Trillion
   */
  Trillion: "Trillion",

  /**
   * MicroSeconds
   */
  MicroSeconds: "MicroSeconds",

  /**
   * MilliSeconds
   */
  MilliSeconds: "MilliSeconds",

  /**
   * Seconds
   */
  Seconds: "Seconds",

  /**
   * Minutes
   */
  Minutes: "Minutes",

  /**
   * Hours
   */
  Hours: "Hours",

  /**
   * Days
   */
  Days: "Days",

  /**
   * CountPerDay
   */
  CountPerDay: "CountPerDay",

  /**
   * CountPerHour
   */
  CountPerHour: "CountPerHour",

  /**
   * CountPerMinute
   */
  CountPerMinute: "CountPerMinute",

  /**
   * CountPerSecond
   */
  CountPerSecond: "CountPerSecond",

  /**
   * ThousandPerSecond
   */
  ThousandPerSecond: "ThousandPerSecond",

  /**
   * MillionPerSecond
   */
  MillionPerSecond: "MillionPerSecond",

  /**
   * BillionPerSecond
   */
  BillionPerSecond: "BillionPerSecond",

  /**
   * TrillionPerSecond
   */
  TrillionPerSecond: "TrillionPerSecond",
}

/**
 * List of alert rule recommendations.
 */
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
