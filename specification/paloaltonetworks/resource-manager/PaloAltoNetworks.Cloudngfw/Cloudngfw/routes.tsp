// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace PaloAltoNetworks.Cloudngfw;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface PaloAltoNetworksCloudngfwOperationsOperationGroup {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("A long-running provider action.")
  @operationId("PaloAltoNetworksCloudngfwOperations_createProductSerialNumber")
  @autoRoute
  createProductSerialNumber is ArmProviderActionSync<
    Response = ProductSerialNumberRequestStatus,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("A long-running provider action.")
  @operationId("PaloAltoNetworksCloudngfwOperations_listCloudManagerTenants")
  @autoRoute
  listCloudManagerTenants is ArmProviderActionSync<
    Response = CloudManagerTenantList,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("A long-running provider action.")
  @operationId("PaloAltoNetworksCloudngfwOperations_listProductSerialNumberStatus")
  @autoRoute
  listProductSerialNumberStatus is ArmProviderActionSync<
    Response = ProductSerialNumberStatus | NotFoundResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("A long-running provider action.")
  @operationId("PaloAltoNetworksCloudngfwOperations_listSupportInfo")
  @autoRoute
  listSupportInfo is ArmProviderActionSync<
    Response = SupportInfoModel,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;

  /**
   * Resolve a Strata Cloud Manager link code into the Strata Cloud Manager instance it is bound to,
   * so the instance can be shown to the customer before it is committed onto a firewall.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Pins the swagger operationId to the camelCase action name. All 36 custom actions in this spec (including the four sibling provider actions in this same operation group) publish as <Group>_<camelCaseAction>; without this decorator the emitter PascalCases the action segment, which would make these the only provider actions in the group not matching that shape."
  @added(Versions.v2026_09_25_preview)
  @operationId("PaloAltoNetworksCloudngfwOperations_resolveStrataCloudManager")
  @autoRoute
  resolveStrataCloudManager is ArmProviderActionSync<
    Request = ScmLinkCodeRequest,
    Response = StrataCloudManagerInstance,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;

  /**
   * List the Marketplace offers, and the plans within each offer, that are available to the
   * subscription, each plan annotated with the firewall mode it provisions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Pins the swagger operationId to the camelCase action name. All 36 custom actions in this spec (including the four sibling provider actions in this same operation group) publish as <Group>_<camelCaseAction>; without this decorator the emitter PascalCases the action segment, which would make these the only provider actions in the group not matching that shape."
  @added(Versions.v2026_09_25_preview)
  @operationId("PaloAltoNetworksCloudngfwOperations_listMarketplaceOffers")
  @autoRoute
  @get
  @list
  @action("marketplaceOffers")
  listMarketplaceOffers is ArmProviderActionSync<
    Response = MarketplaceOffersResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
