import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Common;

namespace Microsoft.Security;

/**
 * The status of the health report
 */
union StatusName {
  string,

  /**
   * Healthy
   */
  Healthy: "Healthy",

  /**
   * NotHealthy
   */
  NotHealthy: "NotHealthy",

  /**
   * NotApplicable
   */
  NotApplicable: "NotApplicable",
}

/**
 * Page of health reports list
 */
model HealthReportsList {
  /**
   * The HealthReport items on this page.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: HealthReport[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  nextLink?: url;
}

/**
 * Describes properties of the health report
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HealthReportProperties {
  /**
   * The resource details of the health report
   */
  resourceDetails?: resourceDetails;

  /**
   * The environment details of the resource
   */
  environmentDetails?: environmentDetails;

  /**
   * The classification of the health report
   */
  healthDataClassification?: healthDataClassification;

  /**
   * The status of the health report
   */
  status?: status;

  /**
   * The affected defenders plans by unhealthy report
   */
  affectedDefendersPlans?: string[];

  /**
   * The affected defenders sub plans by unhealthy report
   */
  affectedDefendersSubPlans?: string[];

  /**
   * Additional data for the given health report, this field can include more details on the resource and the health scenario.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  reportAdditionalData?: Record<string>;

  /**
   * A collection of the issues in the report
   */
  @identifiers(#[])
  issues?: issue[];
}

/**
 * The resource details of the health report
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model resourceDetails {
  /**
   * The status of the health report
   */
  source?: Source;

  /**
   * The azure id of the resource
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The id of the connector
   */
  @visibility(Lifecycle.Read)
  connectorId?: string;
}

/**
 * The environment details of the resource
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model environmentDetails {
  /**
   * The native resource id of the resource (in case of Azure - the resource Id, in case of MC - the native resource id)
   */
  nativeResourceId?: string;

  /**
   * The hierarchy id of the connector (in case of Azure - the subscription Id, in case of MC - the hierarchyId id)
   */
  environmentHierarchyId?: string;

  /**
   * The organizational hierarchy id of the connector (in case of Azure - the subscription Id, in case of MC - the organizational hierarchyId id)
   */
  organizationalHierarchyId?: string;

  /**
   * The subscription Id
   */
  subscriptionId?: string;

  /**
   * The tenant Id
   */
  tenantId?: string;
}

/**
 * The classification of the health report
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model healthDataClassification {
  /**
   * The component describes the name of the agent/service that scans the issue
   */
  component?: string;

  /**
   * The scenario describes the health scenario issue of the component
   */
  scenario?: string;

  /**
   * The resource scope of the health report
   */
  scope?: string;
}

/**
 * The status of the health report
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model status {
  /**
   * The status of the health report
   */
  code?: StatusName;

  /**
   * The reason of the given status
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * The date of when the resource was scanned in the last time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastScannedDate?: utcDateTime;

  /**
   * The date of when the status of the health report was changed in the last time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  statusChangeDate?: utcDateTime;

  /**
   * The date of when the resource of the health report was scanned in the first time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  firstEvaluationDate?: utcDateTime;
}

/**
 * The issue that caused the resource to by unhealthy
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model issue {
  /**
   * The unique issue key
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  issueKey: string;

  /**
   * The issue name
   */
  issueName?: string;

  /**
   * The affected security values that MDC offers that will be affected by the issue, for example: recommendations, alerts, etc
   */
  securityValues?: string[];

  /**
   * The issue description
   */
  issueDescription?: string;

  /**
   * Human readable description of what you should do to mitigate this health issue
   */
  remediationSteps?: string;

  /**
   * The remediation script to solve this issue
   */
  remediationScript?: string;

  /**
   * Additional data for the given issue. The additional data depends on the issue type
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  issueAdditionalData?: Record<string>;
}
