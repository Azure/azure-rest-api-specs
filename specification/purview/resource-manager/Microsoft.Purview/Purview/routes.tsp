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

namespace Microsoft.Purview;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AccountsOperationGroup {
  /**
   * Checks if account name is available.
   */
  @summary("Checks the account name availability.")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityRequest,
    Response = CheckNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Error = ErrorResponseModel
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DefaultAccountsOperationGroup {
  /**
   * Get the default account for the scope.
   */
  @summary("Gets the default account information set for the scope.")
  @autoRoute
  @get
  @action("getDefaultAccount")
  get is ArmProviderActionSync<
    Response = DefaultAccountPayload,
    Parameters = {
      /**
       * The tenant ID.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
      @query("scopeTenantId")
      scopeTenantId: string;

      /**
       * The scope for the default account.
       */
      @query("scopeType")
      scopeType: ScopeType;

      /**
       * The Id of the scope object, for example if the scope is "Subscription" then it is the ID of that subscription.
       */
      @query("scope")
      scope?: string;
    },
    Error = ErrorResponseModel
  >;
  /**
   * Removes the default account from the scope.
   */
  @summary("Removes the default account from the scope.")
  @autoRoute
  @action("removeDefaultAccount")
  remove is ArmProviderActionSync<
    Response = {
      @body body: void;
    } | NoContentResponse,
    Parameters = {
      /**
       * The tenant ID.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
      @query("scopeTenantId")
      scopeTenantId: string;

      /**
       * The scope for the default account.
       */
      @query("scopeType")
      scopeType: ScopeType;

      /**
       * The Id of the scope object, for example if the scope is "Subscription" then it is the ID of that subscription.
       */
      @query("scope")
      scope?: string;
    },
    Error = ErrorResponseModel
  >;
  /**
   * Sets the default account for the scope.
   */
  @summary("Sets the default account for the scope.")
  @autoRoute
  @action("setDefaultAccount")
  set is ArmProviderActionSync<
    Request = DefaultAccountPayload,
    Response = DefaultAccountPayload,
    Error = ErrorResponseModel
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface FeaturesOperationGroup {
  /**
   * Gets details from a list of feature names.
   */
  @summary("""
    Gets a list of features and their status for the location and subscription.
    Status of enabled features will be true. Status of disabled features will be false.
    Features that don't exist will be excluded from the results.
    """)
  @autoRoute
  @action("listFeatures")
  subscriptionGet is ArmProviderActionSync<
    Request = BatchFeatureRequest,
    Response = BatchFeatureStatus,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Location of feature.
       */
      @path
      @segment("locations")
      locations: string;
    },
    Error = ErrorResponseModel
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface UsagesOperationGroup {
  /**
   * Get the usage quota configuration
   */
  @summary("Gets the Usage quota configuration.")
  @autoRoute
  @get
  @action("usages")
  get is ArmProviderActionSync<
    Response = UsageList,
    Scope = SubscriptionActionScope,
    Parameters = {
      ...LocationParameter;

      /**
       * The filter, currently unused.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = ErrorResponseModel
  >;
}
