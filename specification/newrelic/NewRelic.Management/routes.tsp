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

namespace NewRelic.Observability;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AccountsOperationGroup {
  /**
   * Lists all the New Relic accounts linked to your email address, helping you understand the existing accounts that have been created
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_List")
  @autoRoute
  @get
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

      ...LocationParameter;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OrganizationsOperationGroup {
  /**
   * Lists all the New Relic organizations linked to your email address, helping you understand the existing organizations that have been created
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Organizations_List")
  @autoRoute
  @get
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

      ...LocationParameter;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PlansOperationGroup {
  /**
   * Lists the plans data linked to your organization, providing an overview of the available plans
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Plans_List")
  @autoRoute
  @get
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SaaSOperationGroup {
  /**
   * Resolve the token to get the SaaS resource ID and activate the SaaS resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SaaS_ActivateResource")
  @autoRoute
  @action("activateSaaS")
  activateResource is ArmProviderActionSync<
    Request = ActivateSaaSParameterRequest,
    Response = SaaSResourceDetailsResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
