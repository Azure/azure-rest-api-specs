import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace NewRelic.Observability;

interface AccountsOperations {
  @doc("List all the existing accounts")
  @route("/subscriptions/{subscriptionId}/providers/NewRelic.Observability/accounts")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("User Email.")
      @query("userEmail")
      userEmail: string;

      @doc("Location for NewRelic.")
      @query("location")
      location: string;
    },
    AccountsListResponse
  >;
}

interface OrganizationsOperations {
  @doc("List all the existing organizations")
  @route("/subscriptions/{subscriptionId}/providers/NewRelic.Observability/organizations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("User Email.")
      @query("userEmail")
      userEmail: string;

      @doc("Location for NewRelic.")
      @query("location")
      location: string;
    },
    OrganizationsListResponse
  >;
}

interface PlansOperations {
  @doc("List plans data")
  @route("/subscriptions/{subscriptionId}/providers/NewRelic.Observability/plans")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("Account Id.")
      @query("accountId")
      accountId?: string;

      @doc("Organization Id.")
      @query("organizationId")
      organizationId?: string;
    },
    PlanDataListResponse
  >;
}
