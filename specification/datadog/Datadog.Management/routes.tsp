import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Datadog;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface MarketplaceAgreementsOperationGroup {
  /**
   * List Datadog marketplace agreements in the subscription.
   */
  @summary("List Datadog marketplace agreements in the subscription.")
  @autoRoute
  @get
  @list
  @action("agreements")
  list is ArmProviderActionSync<
    Response = DatadogAgreementResourceListResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Create Datadog marketplace agreement in the subscription.
   */
  @summary("Create Datadog marketplace agreement in the subscription.")
  @autoRoute
  @put
  @action("agreements/default")
  createOrUpdate is ArmProviderActionSync<
    Request = DatadogAgreementResource,
    Response = DatadogAgreementResource,
    Scope = SubscriptionActionScope,
    Parameters = {},
    OptionalRequestBody = true
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface CreationSupportedOperationGroup {
  /**
   * Informs if the current subscription is being already monitored for selected Datadog organization.
   */
  @summary("Informs if the current subscription is being already monitored for selected Datadog organization.")
  @autoRoute
  @get
  @list
  @action("subscriptionStatuses")
  list is ArmProviderActionSync<
    Response = CreateResourceSupportedResponseList,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Datadog Organization Id
       */
      @query("datadogOrganizationId")
      datadogOrganizationId: string;
    }
  >;
  /**
   * Informs if the current subscription is being already monitored for selected Datadog organization.
   */
  @summary("Informs if the current subscription is being already monitored for selected Datadog organization.")
  @autoRoute
  @get
  @action("subscriptionStatuses/default")
  get is ArmProviderActionSync<
    Response = CreateResourceSupportedResponse,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Datadog Organization Id
       */
      @query("datadogOrganizationId")
      datadogOrganizationId: string;
    }
  >;
}
