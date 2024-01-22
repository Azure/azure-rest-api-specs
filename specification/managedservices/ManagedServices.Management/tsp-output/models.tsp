import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ManagedServices;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The multi-factor authorization provider to be used for just-in-time access requests.
 */
enum MultiFactorAuthProvider {
  Azure,
  None,
}

/**
 * The current provisioning state of the registration definition.
 */
enum ProvisioningState {
  NotSpecified,
  Accepted,
  Running,
  Ready,
  Creating,
  Created,
  Deleting,
  Deleted,
  Canceled,
  Failed,
  Succeeded,
  Updating,
}

/**
 * The properties of a registration definition.
 */
model RegistrationDefinitionProperties {
  /**
   * The description of the registration definition.
   */
  description?: string;

  /**
   * The collection of authorization objects describing the access Azure Active Directory principals in the managedBy tenant will receive on the delegated resource in the managed tenant.
   */
  authorizations: Authorization[];

  /**
   * The collection of eligible authorization objects describing the just-in-time access Azure Active Directory principals in the managedBy tenant will receive on the delegated resource in the managed tenant.
   */
  eligibleAuthorizations?: EligibleAuthorization[];

  /**
   * The name of the registration definition.
   */
  registrationDefinitionName?: string;

  /**
   * The identifier of the managedBy tenant.
   */
  managedByTenantId: string;

  /**
   * The current provisioning state of the registration definition.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The identifier of the managed tenant.
   */
  @visibility("read")
  manageeTenantId?: string;

  /**
   * The name of the managed tenant.
   */
  @visibility("read")
  manageeTenantName?: string;

  /**
   * The name of the managedBy tenant.
   */
  @visibility("read")
  managedByTenantName?: string;
}

/**
 * The Azure Active Directory principal identifier and Azure built-in role that describes the access the principal will receive on the delegated resource in the managed tenant.
 */
model Authorization {
  /**
   * The identifier of the Azure Active Directory principal.
   */
  principalId: string;

  /**
   * The display name of the Azure Active Directory principal.
   */
  principalIdDisplayName?: string;

  /**
   * The identifier of the Azure built-in role that defines the permissions that the Azure Active Directory principal will have on the projected scope.
   */
  roleDefinitionId: string;

  /**
   * The delegatedRoleDefinitionIds field is required when the roleDefinitionId refers to the User Access Administrator Role. It is the list of role definition ids which define all the permissions that the user in the authorization can assign to other principals.
   */
  delegatedRoleDefinitionIds?: string[];
}

/**
 * The Azure Active Directory principal identifier, Azure built-in role, and just-in-time access policy that describes the just-in-time access the principal will receive on the delegated resource in the managed tenant.
 */
model EligibleAuthorization {
  /**
   * The identifier of the Azure Active Directory principal.
   */
  principalId: string;

  /**
   * The display name of the Azure Active Directory principal.
   */
  principalIdDisplayName?: string;

  /**
   * The identifier of the Azure built-in role that defines the permissions that the Azure Active Directory principal will have on the projected scope.
   */
  roleDefinitionId: string;

  /**
   * The just-in-time access policy setting.
   */
  justInTimeAccessPolicy?: JustInTimeAccessPolicy;
}

/**
 * Just-in-time access policy setting.
 */
model JustInTimeAccessPolicy {
  /**
   * The multi-factor authorization provider to be used for just-in-time access requests.
   */
  multiFactorAuthProvider: MultiFactorAuthProvider = MultiFactorAuthProvider.None;

  /**
   * The maximum access duration in ISO 8601 format for just-in-time access requests.
   */
  maximumActivationDuration?: duration = duration.PT8H;

  /**
   * The list of managedByTenant approvers for the eligible authorization.
   */
  managedByTenantApprovers?: EligibleApprover[];
}

/**
 * Defines the Azure Active Directory principal that can approve any just-in-time access requests by the principal defined in the EligibleAuthorization.
 */
model EligibleApprover {
  /**
   * The identifier of the Azure Active Directory principal.
   */
  principalId: string;

  /**
   * The display name of the Azure Active Directory principal.
   */
  principalIdDisplayName?: string;
}

/**
 * The details for the Managed Services offer’s plan in Azure Marketplace.
 */
model Plan {
  /**
   * Azure Marketplace plan name.
   */
  name: string;

  /**
   * Azure Marketplace publisher ID.
   */
  publisher: string;

  /**
   * Azure Marketplace product code.
   */
  product: string;

  /**
   * Azure Marketplace plan's version.
   */
  version: string;
}

/**
 * The error response indicating why the incoming request wasn’t able to be processed
 */
model ErrorDefinition {
  /**
   * The error code.
   */
  code: string;

  /**
   * The error message indicating why the operation failed.
   */
  message: string;

  /**
   * The internal error details.
   */
  details?: ErrorDefinition[];
}

/**
 * The properties of the registration assignment.
 */
model RegistrationAssignmentProperties {
  /**
   * The fully qualified path of the registration definition.
   */
  registrationDefinitionId: string;

  /**
   * The current provisioning state of the registration assignment.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The registration definition associated with the registration assignment.
   */
  @visibility("read")
  registrationDefinition?: RegistrationAssignmentPropertiesRegistrationDefinition;
}

/**
 * The registration definition associated with the registration assignment.
 */
model RegistrationAssignmentPropertiesRegistrationDefinition {
  /**
   * The properties of the registration definition associated with the registration assignment.
   */
  properties?: RegistrationAssignmentPropertiesRegistrationDefinitionProperties;

  /**
   * The details for the Managed Services offer’s plan in Azure Marketplace.
   */
  plan?: Plan;

  /**
   * The fully qualified path of the registration definition.
   */
  @visibility("read")
  id?: string;

  /**
   * The type of the Azure resource (Microsoft.ManagedServices/registrationDefinitions).
   */
  @visibility("read")
  type?: string;

  /**
   * The name of the registration definition.
   */
  @visibility("read")
  name?: string;

  /**
   * The metadata for the registration definition resource.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The properties of the registration definition associated with the registration assignment.
 */
model RegistrationAssignmentPropertiesRegistrationDefinitionProperties {
  /**
   * The description of the registration definition.
   */
  description?: string;

  /**
   * The collection of authorization objects describing the access Azure Active Directory principals in the managedBy tenant will receive on the delegated resource in the managed tenant.
   */
  authorizations?: Authorization[];

  /**
   * The collection of eligible authorization objects describing the just-in-time access Azure Active Directory principals in the managedBy tenant will receive on the delegated resource in the managed tenant.
   */
  eligibleAuthorizations?: EligibleAuthorization[];

  /**
   * The name of the registration definition.
   */
  registrationDefinitionName?: string;

  /**
   * The current provisioning state of the registration definition.
   */
  provisioningState?: ProvisioningState;

  /**
   * The identifier of the managed tenant.
   */
  manageeTenantId?: string;

  /**
   * The name of the managed tenant.
   */
  manageeTenantName?: string;

  /**
   * The identifier of the managedBy tenant.
   */
  managedByTenantId?: string;

  /**
   * The name of the managedBy tenant.
   */
  managedByTenantName?: string;
}

/**
 * The properties of the marketplace registration definition.
 */
model MarketplaceRegistrationDefinitionProperties {
  /**
   * The identifier of the managedBy tenant.
   */
  managedByTenantId: string;

  /**
   * The collection of authorization objects describing the access Azure Active Directory principals in the managedBy tenant will receive on the delegated resource in the managed tenant.
   */
  authorizations: Authorization[];

  /**
   * The collection of eligible authorization objects describing the just-in-time access Azure Active Directory principals in the managedBy tenant will receive on the delegated resource in the managed tenant.
   */
  eligibleAuthorizations?: EligibleAuthorization[];

  /**
   * The marketplace offer display name.
   */
  offerDisplayName?: string;

  /**
   * The marketplace publisher display name.
   */
  publisherDisplayName?: string;

  /**
   * The marketplace plan display name.
   */
  planDisplayName?: string;
}
