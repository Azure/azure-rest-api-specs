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

namespace Microsoft.AppConfiguration;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ConfigurationStoresOperationGroup {
  /**
   * Gets information about the deleted configuration stores in a subscription.
   */
  @autoRoute
  @list
  @get
  @action("deletedConfigurationStores")
  listDeleted is ArmProviderActionSync<
    Response = ResourceListResult<DeletedConfigurationStore>,
    Scope = SubscriptionActionScope
  >;
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
