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
using Azure.ClientGenerator.Core;

namespace Microsoft.KeyVault;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface VaultsOperationGroup {
  /**
   * Gets information about the deleted vaults in a subscription.
   */
  @autoRoute
  @get
  @action("deletedVaults")
  @list
  listDeleted is ArmProviderActionSync<
    Response = ResourceListResult<DeletedVault>,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = CloudError
  >;
  /**
   * The List operation gets information about the vaults associated with the subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resources")
  @get
  @list
  list(
    /**
     * The filter to apply on the operation.
     */
    @query("$filter")
    $filter: "resourceType eq 'Microsoft.KeyVault/vaults'",

    /**
     * Maximum number of results to return.
     */
    @query("$top")
    $top?: int32,

    /**
     * Azure Resource Manager Api Version.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @apiVersion(false)
    @query("api-version")
    @OpenAPI.extension("x-ms-api-version", false)
    `api-version`: "2015-11-01",

    ...SubscriptionIdParameter,
  ): ArmResponse<VaultListResult> | CloudError;

  /**
   * Checks that the vault name is valid and is not already in use.
   */
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = VaultCheckNameAvailabilityParameters,
    Response = CheckNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ManagedHsmsOperationGroup {
  /**
   * The List operation gets information about the deleted managed HSMs associated with the subscription.
   */
  @autoRoute
  @get
  @action("deletedManagedHSMs")
  @list
  listDeleted is ArmProviderActionSync<
    Response = ResourceListResult<DeletedManagedHsm>,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = ManagedHsmError
  >;
  /**
   * Checks that the managed hsm name is valid and is not already in use.
   */
  @autoRoute
  checkMhsmNameAvailability is ArmProviderActionSync<
    Request = CheckMhsmNameAvailabilityParameters,
    Response = CheckMhsmNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = CloudError
  >;
}

@@doc(VaultsOperationGroup.checkNameAvailability::parameters.body,
  "The name of the vault."
);
