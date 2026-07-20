import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./AccessReview/main.tsp";
import "./AttributeNamespaces/main.tsp";
import "./Authorization/main.tsp";
import "./ClassicAdmin/main.tsp";
import "./DenyAssignment/main.tsp";
import "./ProviderOperations/main.tsp";
import "./RoleAssignment/main.tsp";
import "./RoleDefinitions/main.tsp";
import "./RoleManagementAlerts/main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using Microsoft.AccessReview;
using Microsoft.AttributeNamespaces;
using Microsoft.Authorization;
using Microsoft.ClassicAdmin;
using Microsoft.DenyAssignment;
using Microsoft.ProviderOperations;
using Microsoft.RoleAssignment;
using Microsoft.RoleDefinitions;
using Microsoft.RoleManagementAlerts;

#suppress "@azure-tools/typespec-client-generator-core/inconsistent-multiple-service-dependency" "temporarily suppressing"
@client({
  name: "CombineClient",
  service: [
    Microsoft.AccessReview,
    Microsoft.AttributeNamespaces,
    Microsoft.Authorization,
    Microsoft.ClassicAdmin,
    Microsoft.DenyAssignment,
    Microsoft.ProviderOperations,
    Microsoft.RoleAssignment,
    Microsoft.RoleDefinitions,
    Microsoft.RoleManagementAlerts
  ],
  autoMergeService: true,
})
namespace Microsoft.AuthorizationCombinedClient;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "C# GA compatibility."
union RoleManagementAssignmentLevel {
  string,
  Assignment: "Assignment",
  Eligibility: "Eligibility",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "C# GA compatibility."
union AuthorizationRoleType {
  string,
  BuiltInRole: "BuiltInRole",
  CustomRole: "CustomRole",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "C# GA compatibility."
union RoleManagementScopeType {
  string,
  Subscription: "subscription",
  ManagementGroup: "managementgroup",
  ResourceGroup: "resourcegroup",
}

@@clientName(
  Microsoft.AuthorizationCombinedClient,
  "AuthorizationManagementClient",
  "javascript,python"
);
@@alternateType(
  Microsoft.DenyAssignment.DenyAssignmentPrincipalType,
  string,
  "go,python"
);
@@clientName(EligibleChildResourcesOperationGroup.get, "list", "javascript");
@@clientName(
  Microsoft.Authorization.UsersOrServicePrincipalSetUserType,
  "UserType",
  "python"
);
@@clientName(Microsoft.Authorization.UserType, "CommonUserType", "python");

@@usage(
  Microsoft.RoleAssignment.RoleAssignment,
  Azure.ClientGenerator.Core.Usage.input,
  "java"
);

// Restore C# GA resource, model, and extensible-enum names.
@@clientName(
  Microsoft.ProviderOperations.ProviderOperationsMetadata,
  "AuthorizationProviderOperationsMetadata",
  "csharp"
);
@@clientName(
  Microsoft.RoleDefinitions.RoleDefinition,
  "AuthorizationRoleDefinition",
  "csharp"
);
@@clientName(
  Microsoft.RoleDefinitions.Permission,
  "RoleDefinitionPermission",
  "csharp"
);
@@clientName(
  Microsoft.AttributeNamespaces.AccessReviewDecisionResource,
  "AccessReviewDecisionResourceTarget",
  "csharp"
);
@@clientName(
  Microsoft.ProviderOperations.ResourceType,
  "AuthorizationProviderResourceType",
  "csharp"
);
@@clientName(
  Microsoft.ProviderOperations.ProviderOperation,
  "AuthorizationProviderOperationInfo",
  "csharp"
);
@@alternateType(
  Microsoft.ProviderOperations.SettableResource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(Microsoft.Common.Principal, "RoleManagementPrincipal", "csharp");
@@clientName(
  Microsoft.Common.PrincipalType,
  "RoleManagementPrincipalType",
  "csharp"
);
@@alternateType(
  Microsoft.Common.Principal.type,
  Microsoft.Common.PrincipalType,
  "csharp"
);
@@clientName(Microsoft.Common.Principal.type, "PrincipalType", "csharp");
@@clientName(
  Microsoft.Authorization.AssignmentType,
  "RoleAssignmentScheduleAssignmentType",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.MemberType,
  "RoleManagementScheduleMemberType",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.Status,
  "RoleManagementScheduleStatus",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.RequestType,
  "RoleManagementScheduleRequestType",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.Type,
  "RoleManagementScheduleExpirationType",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.NotificationLevel,
  "RoleManagementPolicyNotificationLevel",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.RecipientType,
  "RoleManagementPolicyRecipientType",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.ExpandedProperties,
  "RoleManagementExpandedProperties",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.RoleAssignmentScheduleRequestPropertiesTicketInfo,
  "RoleAssignmentScheduleTicketInfo",
  "csharp"
);
@@clientName(
  Microsoft.ClassicAdmin.ClassicAdministrator,
  "AuthorizationClassicAdministrator",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.ApprovalMode,
  "RoleManagementApprovalMode",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.ApprovalSettings,
  "RoleManagementApprovalSettings",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.ApprovalStage,
  "RoleManagementApprovalStage",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.EnablementRules,
  "RoleAssignmentEnablementRuleType",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.NotificationDeliveryMechanism,
  "NotificationDeliveryType",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.UserSet,
  "RoleManagementUserInfo",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.UserType,
  "RoleManagementUserType",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.RoleManagementPolicyApprovalRule.setting,
  "Settings",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.RoleManagementPolicyEnablementRule.enabledRules,
  "EnablementRules",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.RoleManagementPolicyNotificationRule.notificationType,
  "NotificationDeliveryType",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.RoleManagementPolicyNotificationRule.isDefaultRecipientsEnabled,
  "AreDefaultRecipientsEnabled",
  "csharp"
);
@@clientName(
  Microsoft.DenyAssignment.DenyAssignmentProperties.doNotApplyToChildScopes,
  "IsAppliedToChildScopes",
  "csharp"
);
@@clientName(
  Microsoft.DenyAssignment.DenyAssignmentProperties.permissions,
  "DeniedPermissions",
  "csharp"
);
@@clientName(
  Microsoft.DenyAssignment.DenyAssignmentProperties.principals,
  "DeniedPrincipals",
  "csharp"
);
@@clientName(
  Microsoft.DenyAssignment.DenyAssignmentProperties.excludePrincipals,
  "ExcludedPrincipals",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.EligibleChildResource.type,
  "ResourceType",
  "csharp"
);

// Restore C# GA enum shapes that were expressed by AutoRest transforms.
@@alternateType(
  Microsoft.Authorization.RoleManagementPolicyRuleTarget.level,
  RoleManagementAssignmentLevel,
  "csharp"
);
@@alternateType(
  Microsoft.RoleDefinitions.RoleDefinitionProperties.type,
  AuthorizationRoleType,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleManagementPolicyExpirationRule.maximumDuration,
  duration,
  "csharp"
);
@@clientName(
  Microsoft.AccessReview.AttributeNamespaceCreateRequest,
  "AttributeNamespaceCreateContent",
  "csharp"
);
@@clientName(
  Microsoft.RoleAssignment.RoleAssignmentCreateParameters,
  "RoleAssignmentCreateOrUpdateContent",
  "csharp"
);

// Restore the flattened C# GA schedule request surface.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# GA compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.Authorization.RoleAssignmentScheduleRequestProperties.scheduleInfo,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# GA compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.Authorization.RoleAssignmentScheduleRequestPropertiesScheduleInfo.expiration,
  "csharp"
);
@@clientName(
  Microsoft.Authorization.RoleAssignmentScheduleRequestPropertiesScheduleInfoExpiration.type,
  "ExpirationType",
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleRequestPropertiesScheduleInfoExpiration.duration,
  duration,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# GA compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.Authorization.RoleEligibilityScheduleRequestProperties.scheduleInfo,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# GA compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.Authorization.RoleEligibilityScheduleRequestPropertiesScheduleInfo.expiration,
  "csharp"
);
@@clientName(
  Microsoft.Authorization.RoleEligibilityScheduleRequestPropertiesScheduleInfoExpiration.type,
  "ExpirationType",
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleEligibilityScheduleRequestPropertiesScheduleInfoExpiration.duration,
  duration,
  "csharp"
);

// Restore the flattened C# GA expanded-properties surface.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# GA compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.Authorization.ExpandedProperties.scope,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# GA compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.Authorization.ExpandedProperties.roleDefinition,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# GA compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.Authorization.ExpandedProperties.principal,
  "csharp"
);
@@clientName(
  Microsoft.Authorization.ExpandedPropertiesScope.id,
  "ScopeId",
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.ExpandedPropertiesScope.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  Microsoft.Authorization.ExpandedPropertiesScope.displayName,
  "ScopeDisplayName",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.ExpandedPropertiesScope.type,
  "ScopeType",
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.ExpandedPropertiesScope.type,
  RoleManagementScopeType,
  "csharp"
);
@@clientName(
  Microsoft.Authorization.ExpandedPropertiesRoleDefinition.id,
  "RoleDefinitionId",
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.ExpandedPropertiesRoleDefinition.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  Microsoft.Authorization.ExpandedPropertiesRoleDefinition.displayName,
  "RoleDefinitionDisplayName",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.ExpandedPropertiesRoleDefinition.type,
  "RoleType",
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.ExpandedPropertiesRoleDefinition.type,
  AuthorizationRoleType,
  "csharp"
);
@@clientName(
  Microsoft.Authorization.ExpandedPropertiesPrincipal.id,
  "PrincipalId",
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.ExpandedPropertiesPrincipal.id,
  Azure.Core.uuid,
  "csharp"
);
@@clientName(
  Microsoft.Authorization.ExpandedPropertiesPrincipal.displayName,
  "PrincipalDisplayName",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.ExpandedPropertiesPrincipal.type,
  "PrincipalType",
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.ExpandedPropertiesPrincipal.type,
  Microsoft.Common.PrincipalType,
  "csharp"
);

// Keep the C# GA policy-scope model distinct from the resource property envelope.
@@clientName(
  Microsoft.Authorization.RoleManagementPolicyProperties,
  "RoleManagementPolicyResourceProperties",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.PolicyProperties,
  "RoleManagementPolicyProperties",
  "csharp"
);
@@access(
  Microsoft.Authorization.PolicyProperties,
  Azure.ClientGenerator.Core.Access.public,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# GA compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.Authorization.PolicyProperties.scope,
  "csharp"
);
@@clientName(
  Microsoft.Authorization.PolicyPropertiesScope.id,
  "ScopeId",
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.PolicyPropertiesScope.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  Microsoft.Authorization.PolicyPropertiesScope.displayName,
  "ScopeDisplayName",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.PolicyPropertiesScope.type,
  "ScopeType",
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.PolicyPropertiesScope.type,
  RoleManagementScopeType,
  "csharp"
);

// Restore the flattened C# GA policy-assignment expansion.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# GA compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.Authorization.PolicyAssignmentProperties.scope,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# GA compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.Authorization.PolicyAssignmentProperties.roleDefinition,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# GA compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.Authorization.PolicyAssignmentProperties.policy,
  "csharp"
);
@@clientName(
  Microsoft.Authorization.PolicyAssignmentPropertiesScope.id,
  "ScopeId",
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.PolicyAssignmentPropertiesScope.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  Microsoft.Authorization.PolicyAssignmentPropertiesScope.displayName,
  "ScopeDisplayName",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.PolicyAssignmentPropertiesScope.type,
  "ScopeType",
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.PolicyAssignmentPropertiesScope.type,
  RoleManagementScopeType,
  "csharp"
);
@@clientName(
  Microsoft.Authorization.PolicyAssignmentPropertiesRoleDefinition.id,
  "RoleDefinitionId",
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.PolicyAssignmentPropertiesRoleDefinition.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  Microsoft.Authorization.PolicyAssignmentPropertiesRoleDefinition.displayName,
  "RoleDefinitionDisplayName",
  "csharp"
);
@@clientName(
  Microsoft.Authorization.PolicyAssignmentPropertiesRoleDefinition.type,
  "RoleType",
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.PolicyAssignmentPropertiesRoleDefinition.type,
  AuthorizationRoleType,
  "csharp"
);
@@clientName(
  Microsoft.Authorization.PolicyAssignmentPropertiesPolicy.id,
  "PolicyId",
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.PolicyAssignmentPropertiesPolicy.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Restore C# GA identifier types from AutoRest format-by-name and rename mappings.
@@alternateType(
  Microsoft.RoleAssignment.RoleAssignmentProperties.roleDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.RoleAssignment.RoleAssignmentProperties.principalId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  Microsoft.RoleAssignment.RoleAssignmentProperties.delegatedManagedIdentityResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.DenyAssignment.DenyAssignmentProperties.principals,
  Microsoft.Common.Principal[],
  "csharp"
);
@@alternateType(
  Microsoft.DenyAssignment.DenyAssignmentProperties.excludePrincipals,
  Microsoft.Common.Principal[],
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleProperties.roleDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleProperties.principalId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleProperties.roleAssignmentScheduleRequestId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleProperties.linkedRoleEligibilityScheduleId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleInstanceProperties.roleDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleInstanceProperties.principalId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleInstanceProperties.roleAssignmentScheduleId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleInstanceProperties.originRoleAssignmentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleInstanceProperties.linkedRoleEligibilityScheduleId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleInstanceProperties.linkedRoleEligibilityScheduleInstanceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleRequestProperties.roleDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleRequestProperties.principalId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleRequestProperties.targetRoleAssignmentScheduleId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleRequestProperties.targetRoleAssignmentScheduleInstanceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleRequestProperties.linkedRoleEligibilityScheduleId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleAssignmentScheduleRequestProperties.requestorId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleEligibilityScheduleProperties.roleDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleEligibilityScheduleProperties.principalId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleEligibilityScheduleProperties.roleEligibilityScheduleRequestId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleEligibilityScheduleInstanceProperties.roleDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleEligibilityScheduleInstanceProperties.principalId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleEligibilityScheduleInstanceProperties.roleEligibilityScheduleId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleEligibilityScheduleRequestProperties.roleDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleEligibilityScheduleRequestProperties.principalId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleEligibilityScheduleRequestProperties.targetRoleEligibilityScheduleId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleEligibilityScheduleRequestProperties.targetRoleEligibilityScheduleInstanceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleEligibilityScheduleRequestProperties.requestorId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleManagementPolicyAssignmentProperties.roleDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Microsoft.Authorization.RoleManagementPolicyAssignmentProperties.policyId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
// Restore descriptive C# operation names after combining the services.
@@clientName(
  Microsoft.Authorization.EligibleChildResourcesOperationGroup.get,
  "GetEligibleChildResources",
  "csharp"
);
@@clientName(
  Microsoft.RoleManagementAlerts.AlertOperationOperationGroup.get,
  "GetAlertOperation",
  "csharp"
);
@@clientName(
  Microsoft.DenyAssignment.DenyAssignments.get,
  "GetDenyAssignment",
  "csharp"
);
@@clientName(
  Microsoft.RoleDefinitions.RoleDefinitionsByIdOperationGroup.getById,
  "GetAuthorizationRoleDefinition",
  "csharp"
);
@@clientName(
  Microsoft.ClassicAdmin.ClassicAdministratorsOperationGroup.list,
  "GetClassicAdministrators",
  "csharp"
);
@@clientName(
  Microsoft.ClassicAdmin.GlobalAdministratorOperationGroup.elevateAccess,
  "ElevateAccessGlobalAdministrator",
  "csharp"
);
@@clientName(
  Microsoft.RoleDefinitions.PermissionsOperationGroup.listForResourceGroup,
  "GetAzurePermissionsForResourceGroups",
  "csharp"
);
@@clientName(
  Microsoft.RoleDefinitions.PermissionsOperationGroup.listForResource,
  "GetAzurePermissionsForResource",
  "csharp"
);

// Keep operations that the GA AutoRest configuration deliberately omitted out of C#.
@@access(
  Microsoft.Authorization.RoleManagementPolicies.delete,
  Azure.ClientGenerator.Core.Access.internal,
  "csharp"
);
@@access(
  Microsoft.Authorization.RoleManagementPolicyAssignments.delete,
  Azure.ClientGenerator.Core.Access.internal,
  "csharp"
);
@@access(
  Microsoft.RoleAssignment.RoleAssignments.listForSubscription,
  Azure.ClientGenerator.Core.Access.internal,
  "csharp"
);
@@access(
  Microsoft.RoleAssignment.RoleAssignments.listForResourceGroup,
  Azure.ClientGenerator.Core.Access.internal,
  "csharp"
);
@@access(
  Microsoft.RoleAssignment.RoleAssignments.listForResource,
  Azure.ClientGenerator.Core.Access.internal,
  "csharp"
);
@@access(
  Microsoft.RoleAssignment.RoleAssignmentsByIdOperations.getById,
  Azure.ClientGenerator.Core.Access.internal,
  "csharp"
);
@@access(
  Microsoft.RoleAssignment.RoleAssignmentsByIdOperations.createById,
  Azure.ClientGenerator.Core.Access.internal,
  "csharp"
);
@@access(
  Microsoft.RoleAssignment.RoleAssignmentsByIdOperations.deleteById,
  Azure.ClientGenerator.Core.Access.internal,
  "csharp"
);
@@access(
  Microsoft.DenyAssignment.DenyAssignments.listForResource,
  Azure.ClientGenerator.Core.Access.internal,
  "csharp"
);
@@access(
  Microsoft.DenyAssignment.DenyAssignments.list,
  Azure.ClientGenerator.Core.Access.internal,
  "csharp"
);
@@access(
  Microsoft.DenyAssignment.DenyAssignments.listForResourceGroup,
  Azure.ClientGenerator.Core.Access.internal,
  "csharp"
);
@@access(
  Microsoft.DenyAssignment.DenyAssignments.getById,
  Azure.ClientGenerator.Core.Access.internal,
  "csharp"
);
@@access(
  Microsoft.RoleDefinitions.RoleDefinitionsByIdOperationGroup.getById,
  Azure.ClientGenerator.Core.Access.internal,
  "csharp"
);

// The legacy nested Access Review flattening produces duplicate C# members.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Exclude incompatible legacy flattening from C#."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.AttributeNamespaces.AccessReviewHistoryScheduleSettings.pattern,
  "!csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Exclude incompatible legacy flattening from C#."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.AttributeNamespaces.AccessReviewHistoryScheduleSettings.range,
  "!csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Exclude incompatible legacy flattening from C#."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.AttributeNamespaces.AccessReviewRecurrenceSettings.pattern,
  "!csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Exclude incompatible legacy flattening from C#."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.AttributeNamespaces.AccessReviewRecurrenceSettings.range,
  "!csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Exclude incompatible legacy flattening from C#."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.AttributeNamespaces.AccessReviewScheduleDefinitionProperties.scope,
  "!csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Exclude incompatible legacy flattening from C#."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.AttributeNamespaces.AccessReviewDecisionProperties.resource,
  "!csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Exclude incompatible legacy flattening from C#."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.AttributeNamespaces.AccessReviewDecisionProperties.reviewedBy,
  "!csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Exclude incompatible legacy flattening from C#."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.AttributeNamespaces.AccessReviewDecisionProperties.appliedBy,
  "!csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  Microsoft.ProviderOperations.ProviderOperationsMetadataGetParameters.$expand,
  "resourceTypes",
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  Microsoft.ProviderOperations.ProviderOperationsMetadataListParameters.$expand,
  "resourceTypes",
  "python"
);
