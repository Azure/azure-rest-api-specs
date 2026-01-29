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

namespace Microsoft.App;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AvailableWorkloadProfilesOperationGroup {
  /**
   * Get all available workload profiles for a location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get available workload profiles by location.")
  @operationId("AvailableWorkloadProfiles_Get")
  @autoRoute
  @get
  @action("availableManagedEnvironmentsWorkloadProfileTypes")
  get is ArmProviderActionSync<
    Response = AvailableWorkloadProfilesCollection,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BillingMetersOperationGroup {
  /**
   * Get all billingMeters for a location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get billing meters by location.")
  @operationId("BillingMeters_Get")
  @autoRoute
  @get
  @action("billingMeters")
  get is ArmProviderActionSync<
    Response = BillingMeterCollection,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

/**
 * Get the verification id of a subscription used for verifying custom domains
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@autoRoute
op getCustomDomainVerificationId is ArmProviderActionSync<
  Response = OkResponse & {
    @bodyRoot
    customDomainVerificationId: string;
  },
  Scope = SubscriptionActionScope
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface UsagesOperationGroup {
  /**
   * Gets, for the specified location, the current resource usage information as well as the limits under the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Usages_List")
  @autoRoute
  @get
  @action("usages")
  list is ArmProviderActionSync<
    Response = ListUsagesResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ManagedEnvironmentUsagesOperationGroup {
  /**
   * Gets the current usage information as well as the limits for environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedEnvironmentUsages_List")
  @autoRoute
  @get
  @action("usages")
  list is ArmProviderActionSync<
    Response = ListUsagesResult,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * Name of the Environment.
       */
      @pattern("^[-\\w\\._]+$")
      @path
      @segment("managedEnvironments")
      environmentName: string;
    }
  >;
}
