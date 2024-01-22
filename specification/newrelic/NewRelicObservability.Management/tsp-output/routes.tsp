import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace NewRelic.Observability;

interface AccountsOperations {
  /**
   * List all the existing accounts
   */
  @route("/subscriptions/{subscriptionId}/providers/NewRelic.Observability/accounts")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

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
    },
    AccountsListResponse
  >;
}

interface OrganizationsOperations {
  /**
   * List all the existing organizations
   */
  @route("/subscriptions/{subscriptionId}/providers/NewRelic.Observability/organizations")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

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
    },
    OrganizationsListResponse
  >;
}

interface PlansOperations {
  /**
   * List plans data
   */
  @route("/subscriptions/{subscriptionId}/providers/NewRelic.Observability/plans")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

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
    },
    PlanDataListResponse
  >;
}
