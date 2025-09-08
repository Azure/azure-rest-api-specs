import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Automanage;

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Internal: "Internal",
}

/**
 * Automanage configuration profile properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConfigurationProfileProperties {
  /**
   * configuration dictionary of the configuration profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @example(#{ `Antimalware/Enable`: true })
  @summary("configuration")
  configuration?: unknown;
}

/**
 * The response of the list best practice operation.
 */
model BestPracticeList {
  /**
   * Result of the list best practice operation.
   */
  @pageItems
  value?: BestPractice[];

  /**
   * Url to get the next page.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Definition of the configuration profile.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConfigurationProfileUpdate extends UpdateResource {
  /**
   * Properties of the configuration profile.
   */
  properties?: ConfigurationProfileProperties;
}

/**
 * Represents an update resource
 */
model UpdateResource {
  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * The response of the list configuration profile operation.
 */
model ConfigurationProfileList {
  /**
   * Result of the list ConfigurationProfile operation.
   */
  @pageItems
  value?: ConfigurationProfile[];

  /**
   * Url to get the next page.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Automanage configuration profile assignment properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConfigurationProfileAssignmentProperties {
  /**
   * The Automanage configurationProfile ARM Resource URI.
   */
  configurationProfile?: string;

  /**
   * The target VM resource URI
   */
  @visibility(Lifecycle.Read)
  targetId?: string;

  /**
   * The status of onboarding, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * The response of the list configuration profile assignment operation.
 */
model ConfigurationProfileAssignmentList {
  /**
   * Result of the list configuration profile assignment operation.
   */
  @pageItems
  value?: ConfigurationProfileAssignment[];

  /**
   * Url to get the next page.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Data related to the report detail.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AssignmentReportProperties {
  /**
   * Start time of the configuration profile assignment processing.
   */
  startTime?: string;

  /**
   * End time of the configuration profile assignment processing.
   */
  endTime?: string;

  /**
   * Last modified time of the configuration profile assignment processing.
   */
  @visibility(Lifecycle.Read)
  lastModifiedTime?: string;

  /**
   * Duration of the configuration profile assignment processing.
   */
  @visibility(Lifecycle.Read)
  duration?: duration;

  /**
   * Type of the configuration profile assignment processing (Initial/Consistency).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The status of the configuration profile assignment.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The configurationProfile linked to the assignment.
   */
  @visibility(Lifecycle.Read)
  configurationProfile?: string;

  /**
   * List of resources processed by the configuration profile assignment.
   */
  @visibility(Lifecycle.Read)
  resources?: ReportResource[];

  /**
   * Error message, if any, returned by the configuration profile assignment processing.
   */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;

  /**
   * Version of the report format
   */
  @visibility(Lifecycle.Read)
  reportFormatVersion?: string;
}

/**
 * Details about the resource processed by the configuration profile assignment
 */
model ReportResource {
  /**
   * Name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * ARM id of the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Status of the resource.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Error message, if any, returned when deploying the resource.
   */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

/**
 * The response of the list report operation.
 */
model ReportList {
  /**
   * Result of the list report operation.
   */
  @pageItems
  value?: Report[];

  /**
   * Url to get the next page.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The list of ServicePrincipals.
 */
model ServicePrincipalListResult {
  /**
   * The list of servicePrincipals.
   */
  @pageItems
  value?: ServicePrincipal[];

  /**
   * Url to get the next page.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The Service Principal properties for the subscription.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServicePrincipalProperties {
  /**
   * The Service Principal Id for the subscription.
   */
  @visibility(Lifecycle.Read)
  servicePrincipalId?: string;

  /**
   * Returns the contributor RBAC Role exist or not for the Service Principal Id.
   */
  @visibility(Lifecycle.Read)
  authorizationSet?: boolean;
}
