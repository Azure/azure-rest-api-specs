// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.App;

/** Custom location parameter with pattern matching original swagger */
alias AppLocationParameter = {
  /** The location for which resource usage is queried. */
  @path
  @segment("locations")
  @pattern("^[-\\w\\._]+$")
  location: string;
};

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
    Parameters = LocationResourceParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
    Parameters = LocationResourceParameter,
    Error = DefaultErrorResponse
  >;
}

/**
 * Get the verification id of a subscription used for verifying custom domains
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@tag("Subscriptions")
@action("getCustomDomainVerificationId")
op getCustomDomainVerificationId is ArmProviderActionSync<
  Response = OkResponse & {
    @header("Content-Type") contentType: "application/json";

    @bodyRoot
    customDomainVerificationId: CustomDomainVerificationId;
  },
  Scope = SubscriptionActionScope,
  Error = DefaultErrorResponse
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
    Parameters = AppLocationParameter,
    Error = DefaultErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
