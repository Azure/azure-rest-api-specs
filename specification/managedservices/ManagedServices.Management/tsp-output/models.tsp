import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ManagedServices;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The multi-factor authorization provider to be used for just-in-time access requests.")
enum MultiFactorAuthProvider {
  Azure,
  None,
}

@doc("The current provisioning state of the registration definition.")
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

@doc("The properties of a registration definition.")
model RegistrationDefinitionProperties {
  @doc("The description of the registration definition.")
  description?: string;

  @doc("The collection of authorization objects describing the access Azure Active Directory principals in the managedBy tenant will receive on the delegated resource in the managed tenant.")
  authorizations: Authorization[];

  @doc("The collection of eligible authorization objects describing the just-in-time access Azure Active Directory principals in the managedBy tenant will receive on the delegated resource in the managed tenant.")
  eligibleAuthorizations?: EligibleAuthorization[];

  @doc("The name of the registration definition.")
  registrationDefinitionName?: string;

  @doc("The identifier of the managedBy tenant.")
  managedByTenantId: string;

  @doc("The current provisioning state of the registration definition.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The identifier of the managed tenant.")
  @visibility("read")
  manageeTenantId?: string;

  @doc("The name of the managed tenant.")
  @visibility("read")
  manageeTenantName?: string;

  @doc("The name of the managedBy tenant.")
  @visibility("read")
  managedByTenantName?: string;
}

@doc("The Azure Active Directory principal identifier and Azure built-in role that describes the access the principal will receive on the delegated resource in the managed tenant.")
model Authorization {
  @doc("The identifier of the Azure Active Directory principal.")
  principalId: string;

  @doc("The display name of the Azure Active Directory principal.")
  principalIdDisplayName?: string;

  @doc("The identifier of the Azure built-in role that defines the permissions that the Azure Active Directory principal will have on the projected scope.")
  roleDefinitionId: string;

  @doc("The delegatedRoleDefinitionIds field is required when the roleDefinitionId refers to the User Access Administrator Role. It is the list of role definition ids which define all the permissions that the user in the authorization can assign to other principals.")
  delegatedRoleDefinitionIds?: string[];
}

@doc("The Azure Active Directory principal identifier, Azure built-in role, and just-in-time access policy that describes the just-in-time access the principal will receive on the delegated resource in the managed tenant.")
model EligibleAuthorization {
  @doc("The identifier of the Azure Active Directory principal.")
  principalId: string;

  @doc("The display name of the Azure Active Directory principal.")
  principalIdDisplayName?: string;

  @doc("The identifier of the Azure built-in role that defines the permissions that the Azure Active Directory principal will have on the projected scope.")
  roleDefinitionId: string;

  @doc("The just-in-time access policy setting.")
  justInTimeAccessPolicy?: JustInTimeAccessPolicy;
}

@doc("Just-in-time access policy setting.")
model JustInTimeAccessPolicy {
  @doc("The multi-factor authorization provider to be used for just-in-time access requests.")
  multiFactorAuthProvider: MultiFactorAuthProvider;

  @doc("The maximum access duration in ISO 8601 format for just-in-time access requests.")
  maximumActivationDuration?: duration;

  @doc("The list of managedByTenant approvers for the eligible authorization.")
  managedByTenantApprovers?: EligibleApprover[];
}

@doc("Defines the Azure Active Directory principal that can approve any just-in-time access requests by the principal defined in the EligibleAuthorization.")
model EligibleApprover {
  @doc("The identifier of the Azure Active Directory principal.")
  principalId: string;

  @doc("The display name of the Azure Active Directory principal.")
  principalIdDisplayName?: string;
}

@doc("The details for the Managed Services offer’s plan in Azure Marketplace.")
model Plan {
  @doc("Azure Marketplace plan name.")
  name: string;

  @doc("Azure Marketplace publisher ID.")
  publisher: string;

  @doc("Azure Marketplace product code.")
  product: string;

  @doc("Azure Marketplace plan's version.")
  version: string;
}

@doc("The error response indicating why the incoming request wasn’t able to be processed")
model ErrorDefinition {
  @doc("The error code.")
  code: string;

  @doc("The error message indicating why the operation failed.")
  message: string;

  @doc("The internal error details.")
  details?: ErrorDefinition[];
}

@doc("The properties of the registration assignment.")
model RegistrationAssignmentProperties {
  @doc("The fully qualified path of the registration definition.")
  registrationDefinitionId: string;

  @doc("The current provisioning state of the registration assignment.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The registration definition associated with the registration assignment.")
  @visibility("read")
  registrationDefinition?: RegistrationAssignmentPropertiesRegistrationDefinition;
}

@doc("The registration definition associated with the registration assignment.")
model RegistrationAssignmentPropertiesRegistrationDefinition {
  @doc("The properties of the registration definition associated with the registration assignment.")
  properties?: RegistrationAssignmentPropertiesRegistrationDefinitionProperties;

  @doc("The details for the Managed Services offer’s plan in Azure Marketplace.")
  plan?: Plan;

  @doc("The fully qualified path of the registration definition.")
  @visibility("read")
  id?: string;

  @doc("The type of the Azure resource (Microsoft.ManagedServices/registrationDefinitions).")
  @visibility("read")
  type?: string;

  @doc("The name of the registration definition.")
  @visibility("read")
  name?: string;

  @doc("The metadata for the registration definition resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The properties of the registration definition associated with the registration assignment.")
model RegistrationAssignmentPropertiesRegistrationDefinitionProperties {
  @doc("The description of the registration definition.")
  description?: string;

  @doc("The collection of authorization objects describing the access Azure Active Directory principals in the managedBy tenant will receive on the delegated resource in the managed tenant.")
  authorizations?: Authorization[];

  @doc("The collection of eligible authorization objects describing the just-in-time access Azure Active Directory principals in the managedBy tenant will receive on the delegated resource in the managed tenant.")
  eligibleAuthorizations?: EligibleAuthorization[];

  @doc("The name of the registration definition.")
  registrationDefinitionName?: string;

  @doc("The current provisioning state of the registration definition.")
  provisioningState?: ProvisioningState;

  @doc("The identifier of the managed tenant.")
  manageeTenantId?: string;

  @doc("The name of the managed tenant.")
  manageeTenantName?: string;

  @doc("The identifier of the managedBy tenant.")
  managedByTenantId?: string;

  @doc("The name of the managedBy tenant.")
  managedByTenantName?: string;
}

@doc("The properties of the marketplace registration definition.")
model MarketplaceRegistrationDefinitionProperties {
  @doc("The identifier of the managedBy tenant.")
  managedByTenantId: string;

  @doc("The collection of authorization objects describing the access Azure Active Directory principals in the managedBy tenant will receive on the delegated resource in the managed tenant.")
  authorizations: Authorization[];

  @doc("The collection of eligible authorization objects describing the just-in-time access Azure Active Directory principals in the managedBy tenant will receive on the delegated resource in the managed tenant.")
  eligibleAuthorizations?: EligibleAuthorization[];

  @doc("The marketplace offer display name.")
  offerDisplayName?: string;

  @doc("The marketplace publisher display name.")
  publisherDisplayName?: string;

  @doc("The marketplace plan display name.")
  planDisplayName?: string;
}
