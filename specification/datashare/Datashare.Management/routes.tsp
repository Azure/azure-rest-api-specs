// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ConsumerInvitationsOperationGroup {
  /**
   * Lists invitations
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List the invitations")
  @operationId("ConsumerInvitations_ListInvitations")
  @autoRoute
  @get
  listInvitations is ArmProviderActionSync<
    Response = ConsumerInvitationList,
    Parameters = {
      /**
       * The continuation token
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
  /**
   * Reject an invitation
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Rejects the invitation identified by invitationId")
  @operationId("ConsumerInvitations_RejectInvitation")
  @autoRoute
  rejectInvitation is ArmProviderActionSync<
    Request = ConsumerInvitation,
    Response = ConsumerInvitation,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface EmailRegistrationsOperationGroup {
  /**
   * Activate the email registration for the current tenant
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Activates the tenant and email combination using email code received.")
  @operationId("EmailRegistrations_ActivateEmail")
  @autoRoute
  activateEmail is ArmProviderActionSync<
    Request = EmailRegistration,
    Response = EmailRegistration,
    Parameters = LocationParameter
  >;
  /**
   * Register an email for the current tenant
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Registers the tenant and email combination for verification.")
  @operationId("EmailRegistrations_RegisterEmail")
  @autoRoute
  registerEmail is ArmProviderActionSync<
    Response = EmailRegistration,
    Parameters = LocationParameter
  >;
}
