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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface MarketplaceAgreementsOperationGroup {
  /**
   * List Datadog marketplace agreements in the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List Datadog marketplace agreements in the subscription.")
  @operationId("MarketplaceAgreements_List")
  @autoRoute
  @get
  @action("agreements")
  list is ArmProviderActionSync<
    Response = DatadogAgreementResourceListResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Create Datadog marketplace agreement in the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Create Datadog marketplace agreement in the subscription.")
  @operationId("MarketplaceAgreements_CreateOrUpdate")
  @autoRoute
  @put
  @action("agreements/default")
  createOrUpdate is ArmProviderActionSync<
    Request = DatadogAgreementResource,
    Response = DatadogAgreementResource,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface CreationSupportedOperationGroup {
  /**
   * Informs if the current subscription is being already monitored for selected Datadog organization.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Informs if the current subscription is being already monitored for selected Datadog organization.")
  @operationId("CreationSupported_List")
  @autoRoute
  @get
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Informs if the current subscription is being already monitored for selected Datadog organization.")
  @operationId("CreationSupported_Get")
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
