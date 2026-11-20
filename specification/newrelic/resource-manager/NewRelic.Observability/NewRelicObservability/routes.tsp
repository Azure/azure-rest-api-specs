// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace NewRelic.Observability;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AccountsOperationGroup {
  /**
   * Lists all the New Relic accounts linked to your email address, helping you understand the existing accounts that have been created
   */
  @autoRoute
  @get
  @list
  @action("accounts")
  list is ArmProviderActionSync<
    Response = AccountsListResponse,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * User Email.
       */
      @query("userEmail")
      userEmail: string;

      /**
       * Location for NewRelic.
       */
      @query("location")
      location: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OrganizationsOperationGroup {
  /**
   * Lists all the New Relic organizations linked to your email address, helping you understand the existing organizations that have been created
   */
  @autoRoute
  @get
  @list
  @action("organizations")
  list is ArmProviderActionSync<
    Response = OrganizationsListResponse,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * User Email.
       */
      @query("userEmail")
      userEmail: string;

      /**
       * Location for NewRelic.
       */
      @query("location")
      location: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface PlansOperationGroup {
  /**
   * Lists the plans data linked to your organization, providing an overview of the available plans
   */
  @autoRoute
  @get
  @list
  @action("plans")
  list is ArmProviderActionSync<
    Response = PlanDataListResponse,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Account Id.
       */
      @query("accountId")
      accountId?: string;

      /**
       * Organization Id.
       */
      @query("organizationId")
      organizationId?: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SaaSOperationGroup {
  /**
   * Resolve the token to get the SaaS resource ID and activate the SaaS resource
   */
  @autoRoute
  @action("activateSaaS")
  activateResource is ArmProviderActionSync<
    Request = ActivateSaaSParameterRequest,
    Response = SaaSResourceDetailsResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
