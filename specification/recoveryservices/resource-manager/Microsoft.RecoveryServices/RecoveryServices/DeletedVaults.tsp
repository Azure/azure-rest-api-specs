import "./models.tsp";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.RecoveryServices;

/**
Deleted Vault operations.
 */
@armResourceOperations
@added(Versions.v2025_08_01)
interface DeletedVaultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...LocationParameter,
      },
      KeysOf<ResourceNameParameter<
        Resource = DeletedVault,
        KeyName = "deletedVaultName",
        SegmentName = "deletedVaults",
        NamePattern = "^[-\\w\\._\\(\\)]+$"
      >>
    > {}

@armResourceOperations
interface DeletedVaultsOperationStatus
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...LocationParameter,
      },
      {
        /**
         *The name of deleted vault.
         */
        @segment("deletedVaults")
        @path
        @pattern("^[-\\w\\._\\(\\)]+$")
        deletedVaultName: string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("operations")
        operationId: string,
      },
      ErrorType = CloudError
    > {}

@armResourceOperations
@added(Versions.v2025_08_01)
interface DeletedVaults {
  /** List deleted vaults in a subscription. */
  listBySubscriptionId is ArmListBySubscription<
    DeletedVault,
    Response = ArmResponse<DeletedVaultList>,
    Error = CloudError
  >;

  /** Get a specific deleted vault. */
  get is DeletedVaultOps.Read<DeletedVault, OverrideErrorType = CloudError>;

  /** Start undelete of a deleted vault. */
  @action("undelete")
  undelete is DeletedVaultOps.ActionAsync<
    DeletedVault,
    DeletedVaultUndeleteInput,
    DeletedVault,
    LroHeaders = ArmAsyncOperationHeader & ArmLroLocationHeader
  >;

  /**
   * Get the operation status of a deleted vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  getOperationStatus is DeletedVaultsOperationStatus.Read<
    DeletedVault,
    Response = ArmResponse<OperationResource>
  >;
}
