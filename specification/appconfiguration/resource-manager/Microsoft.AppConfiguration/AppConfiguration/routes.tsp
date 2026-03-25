// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.AppConfiguration;

// TODO -- we need this until https://github.com/Azure/typespec-azure/issues/3903 is resolved
@doc("lists resource {name}", ProviderResource)
@segmentOf(ProviderResource)
@list
@Azure.ResourceManager.armResourceList(ProviderResource)
@get
op ListBySubscription<ProviderResource extends Azure.ResourceManager.Foundations.Resource> is Azure.ResourceManager.Foundations.ArmReadOperation<
  ApiVersionParameter &
    SubscriptionIdParameter &
    ProviderNamespace<ProviderResource>,
  ResourceListResult<ProviderResource>,
  ErrorResponse
>;

@armResourceOperations(#{ omitTags: true })
interface ConfigurationStoresOperationGroup {
  /**
   * Gets information about the deleted configuration stores in a subscription.
   */
  listDeleted is ListBySubscription<DeletedConfigurationStore>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationsOperationGroup {
  /**
   * Checks whether the configuration store name is available for use.
   */
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityParameters,
    Response = NameAvailabilityStatus,
    Scope = SubscriptionActionScope
  >;
  /**
   * Checks whether the configuration store name is available for use.
   */
  @autoRoute
  @action("checkNameAvailability")
  regionalCheckNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityParameters,
    Response = NameAvailabilityStatus,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
