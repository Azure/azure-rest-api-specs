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
  @summary("Get available workload profiles by location.")
  @autoRoute
  @get
  @list
  @action("availableManagedEnvironmentsWorkloadProfileTypes")
  @tag("AvailableWorkloadProfiles")
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
  @summary("Get billing meters by location.")
  @autoRoute
  @get
  @action("billingMeters")
  @tag("BillingMeters")
  get is ArmProviderActionSync<
    Response = BillingMeterCollection,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = DefaultErrorResponse
  >;
}

/**
 * Get the verification id of a subscription used for verifying custom domains
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@autoRoute
@tag("Subscriptions")
op getCustomDomainVerificationId is ArmProviderActionSync<
  Response = OkResponse & {
    @bodyRoot
    customDomainVerificationId: CustomDomainVerificationId;
  },
  Scope = SubscriptionActionScope,
  Error = DefaultErrorResponse
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface UsagesOperationGroup {
  /**
   * Gets, for the specified location, the current resource usage information as well as the limits under the subscription.
   */
  @autoRoute
  @get
  @list
  @action("usages")
  @tag("Usages")
  list is ArmProviderActionSync<
    Response = ListUsagesResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = DefaultErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ManagedEnvironmentUsagesOperationGroup {
  /**
   * Gets the current usage information as well as the limits for environment.
   */
  @autoRoute
  @get
  @list
  @action("usages")
  @tag("Usages")
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
    },
    Error = DefaultErrorResponse
  >;
}
