import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.RoleManagementAlerts;

/**
 * Severity level of the alert.
 */
union SeverityLevel {
  string,

  /**
   * Low
   */
  Low: "Low",

  /**
   * Medium
   */
  Medium: "Medium",

  /**
   * High
   */
  High: "High",
}

/**
 * Alert properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AlertProperties {
  /**
   * The alert scope.
   */
  @visibility(Lifecycle.Read)
  scope?: string;

  /**
   * False by default; true if the alert is active.
   */
  isActive?: boolean;

  /**
   * The number of generated incidents of the alert.
   */
  @visibility(Lifecycle.Read)
  incidentCount?: int32;

  /**
   * The date time when the alert configuration was updated or new incidents were generated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDateTime?: utcDateTime;

  /**
   * The date time when the alert was last scanned.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastScannedDateTime?: utcDateTime;

  /**
   * The alert definition.
   */
  @visibility(Lifecycle.Read)
  alertDefinition?: AlertDefinition;

  /**
   * The alert incidents.
   */
  @visibility(Lifecycle.Read)
  alertIncidents?: AlertIncident[];

  /**
   * The alert configuration.
   */
  @visibility(Lifecycle.Read)
  alertConfiguration?: AlertConfiguration;
}

/**
 * Alert definition properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AlertDefinitionProperties {
  /**
   * The alert display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The alert scope.
   */
  @visibility(Lifecycle.Read)
  scope?: string;

  /**
   * The alert description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Severity level of the alert.
   */
  @visibility(Lifecycle.Read)
  severityLevel?: SeverityLevel;

  /**
   * Security impact of the alert.
   */
  @visibility(Lifecycle.Read)
  securityImpact?: string;

  /**
   * The methods to mitigate the alert.
   */
  @visibility(Lifecycle.Read)
  mitigationSteps?: string;

  /**
   * The ways to prevent the alert.
   */
  @visibility(Lifecycle.Read)
  howToPrevent?: string;

  /**
   * True if the alert can be remediated; false, otherwise.
   */
  @visibility(Lifecycle.Read)
  isRemediatable?: boolean;

  /**
   * True if the alert configuration can be configured; false, otherwise.
   */
  @visibility(Lifecycle.Read)
  isConfigurable?: boolean;
}

/**
 * Alert incident properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("alertIncidentType")
model AlertIncidentProperties {
  /**
   * The alert incident type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  alertIncidentType: string;
}

/**
 * Alert configuration properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("alertConfigurationType")
model AlertConfigurationProperties {
  /**
   * The alert definition ID.
   */
  @visibility(Lifecycle.Read)
  alertDefinitionId?: string;

  /**
   * The alert scope.
   */
  @visibility(Lifecycle.Read)
  scope?: string;

  /**
   * True if the alert is enabled, false will disable the scanning for the specific alert.
   */
  isEnabled?: boolean;

  /**
   * The alert configuration type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  alertConfigurationType: string;

  /**
   * The alert definition.
   */
  @visibility(Lifecycle.Read)
  alertDefinition?: AlertDefinition;
}

/**
 * Alert operation result
 */
model AlertOperationResult {
  /**
   * The id of the alert operation.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The status of the alert operation.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The status detail of the alert operation.
   */
  @visibility(Lifecycle.Read)
  statusDetail?: string;

  /**
   * The created date of the alert operation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;

  /**
   * The last action date of the alert operation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActionDateTime?: utcDateTime;

  /**
   * The location of the alert associated with the operation.
   */
  @visibility(Lifecycle.Read)
  resourceLocation?: string;
}

/**
 * The Azure roles assigned outside PIM alert configuration properties.
 */
model AzureRolesAssignedOutsidePimAlertConfigurationProperties
  extends AlertConfigurationProperties {
  /**
   * The alert configuration type.
   */
  alertConfigurationType: "AzureRolesAssignedOutsidePimAlertConfiguration";
}

/**
 * The duplicate role created alert configuration.
 */
model DuplicateRoleCreatedAlertConfigurationProperties
  extends AlertConfigurationProperties {
  /**
   * The alert configuration type.
   */
  alertConfigurationType: "DuplicateRoleCreatedAlertConfiguration";
}

/**
 * Too many owners assigned to resource alert configuration properties.
 */
model TooManyOwnersAssignedToResourceAlertConfigurationProperties
  extends AlertConfigurationProperties {
  /**
   * The threshold number of owners.
   */
  thresholdNumberOfOwners?: int32;

  /**
   * The threshold percentage of owners out of all role members.
   */
  thresholdPercentageOfOwnersOutOfAllRoleMembers?: int32;

  /**
   * The alert configuration type.
   */
  alertConfigurationType: "TooManyOwnersAssignedToResourceAlertConfiguration";
}

/**
 * Too many permanent owners assigned to resource alert configuration properties.
 */
model TooManyPermanentOwnersAssignedToResourceAlertConfigurationProperties
  extends AlertConfigurationProperties {
  /**
   * The threshold number of permanent owners.
   */
  thresholdNumberOfPermanentOwners?: int32;

  /**
   * The threshold percentage of permanent owners out of all owners.
   */
  thresholdPercentageOfPermanentOwnersOutOfAllOwners?: int32;

  /**
   * The alert configuration type.
   */
  alertConfigurationType: "TooManyPermanentOwnersAssignedToResourceAlertConfiguration";
}

/**
 * Azure roles assigned outside PIM alert incident properties.
 */
model AzureRolesAssignedOutsidePimAlertIncidentProperties
  extends AlertIncidentProperties {
  /**
   * The assignee display name.
   */
  @visibility(Lifecycle.Read)
  assigneeDisplayName?: string;

  /**
   * The assignee user principal name.
   */
  @visibility(Lifecycle.Read)
  assigneeUserPrincipalName?: string;

  /**
   * The assignee ID.
   */
  @visibility(Lifecycle.Read)
  assigneeId?: string;

  /**
   * The role display name.
   */
  @visibility(Lifecycle.Read)
  roleDisplayName?: string;

  /**
   * The role template ID.
   */
  @visibility(Lifecycle.Read)
  roleTemplateId?: string;

  /**
   * The role definition ID.
   */
  @visibility(Lifecycle.Read)
  roleDefinitionId?: string;

  /**
   * The date the assignment was activated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  assignmentActivatedDate?: utcDateTime;

  /**
   * The requestor ID.
   */
  @visibility(Lifecycle.Read)
  requestorId?: string;

  /**
   * The requestor display name.
   */
  @visibility(Lifecycle.Read)
  requestorDisplayName?: string;

  /**
   * The requestor user principal name.
   */
  @visibility(Lifecycle.Read)
  requestorUserPrincipalName?: string;

  /**
   * The alert incident type.
   */
  alertIncidentType: "AzureRolesAssignedOutsidePimAlertIncident";
}

/**
 * Duplicate role created alert incident properties.
 */
model DuplicateRoleCreatedAlertIncidentProperties
  extends AlertIncidentProperties {
  /**
   * The role name.
   */
  @visibility(Lifecycle.Read)
  roleName?: string;

  /**
   * The duplicate roles.
   */
  @visibility(Lifecycle.Read)
  duplicateRoles?: string;

  /**
   * The reason for the incident.
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * The alert incident type.
   */
  alertIncidentType: "DuplicateRoleCreatedAlertIncident";
}

/**
 * Too many owners assigned to resource alert incident properties.
 */
model TooManyOwnersAssignedToResourceAlertIncidentProperties
  extends AlertIncidentProperties {
  /**
   * The assignee name.
   */
  @visibility(Lifecycle.Read)
  assigneeName?: string;

  /**
   * The assignee type.
   */
  @visibility(Lifecycle.Read)
  assigneeType?: string;

  /**
   * The alert incident type.
   */
  alertIncidentType: "TooManyOwnersAssignedToResourceAlertIncident";
}

/**
 * Too many permanent owners assigned to resource alert incident properties.
 */
model TooManyPermanentOwnersAssignedToResourceAlertIncidentProperties
  extends AlertIncidentProperties {
  /**
   * The assignee name.
   */
  @visibility(Lifecycle.Read)
  assigneeName?: string;

  /**
   * The assignee type.
   */
  @visibility(Lifecycle.Read)
  assigneeType?: string;

  /**
   * The alert incident type.
   */
  alertIncidentType: "TooManyPermanentOwnersAssignedToResourceAlertIncident";
}
