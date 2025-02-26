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

namespace Microsoft.KeyVault;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface VaultsOperations {
  /**
   * Gets information about the deleted vaults in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Vaults_ListDeleted")
  @autoRoute
  @get
  @action("deletedVaults")
  listDeleted is ArmProviderActionSync<
    Response = Azure.ResourceManager.ResourceListResult<DeletedVault>,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * The List operation gets information about the vaults associated with the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
  @operationId("Vaults_List")
  @route("/subscriptions/{subscriptionId}/resources")
  @get
  list(
    ...ApiVersionParameter,

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

    ...SubscriptionIdParameter,
  ): ArmResponse<ResourceListResult> | ErrorResponse;

  /**
   * Checks that the vault name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Vaults_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = VaultCheckNameAvailabilityParameters,
    Response = CheckNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ManagedHsmsOperations {
  /**
   * The List operation gets information about the deleted managed HSMs associated with the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedHsms_ListDeleted")
  @autoRoute
  @get
  @action("deletedManagedHSMs")
  listDeleted is ArmProviderActionSync<
    Response = Azure.ResourceManager.ResourceListResult<DeletedManagedHsm>,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Checks that the managed hsm name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedHsms_CheckMhsmNameAvailability")
  @autoRoute
  checkMhsmNameAvailability is ArmProviderActionSync<
    Request = CheckMhsmNameAvailabilityParameters,
    Response = CheckMhsmNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

@@doc(VaultsOperations.checkNameAvailability::parameters.body,
  "The name of the vault."
);
