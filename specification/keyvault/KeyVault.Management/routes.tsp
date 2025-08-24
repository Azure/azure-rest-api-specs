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
interface VaultsOperationGroup {
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
interface ManagedHsmsOperationGroup {
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
