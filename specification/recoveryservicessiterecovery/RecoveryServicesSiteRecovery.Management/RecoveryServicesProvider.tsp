import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Fabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Provider details.
 */
@parentResource(Fabric)
model RecoveryServicesProvider
  is Azure.ResourceManager.ProxyResource<RecoveryServicesProviderProperties> {
  ...ResourceNameParameter<
    Resource = RecoveryServicesProvider,
    KeyName = "providerName",
    SegmentName = "replicationRecoveryServicesProviders",
    NamePattern = ""
  >;

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  location?: string;
}

@armResourceOperations
interface RecoveryServicesProviders {
  /**
   * Gets the details of registered recovery services provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryServicesProviders_Get")
  @summary("Gets the details of a recovery services provider.")
  get is ArmResourceRead<RecoveryServicesProvider, Error = never>;

  /**
   * The operation to add a recovery services provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ReplicationRecoveryServicesProviders_Create")
  @summary("Adds a recovery services provider.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    RecoveryServicesProvider,
    Request = AddRecoveryServicesProviderInput,
    Response = ArmResourceUpdatedResponse<RecoveryServicesProvider> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = RecoveryServicesProvider> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = never
  >;

  /**
   * The operation to purge(force delete) a recovery services provider from the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryServicesProviders_Purge")
  @summary("Purges recovery service provider from fabric.")
  purge is ArmResourceDeleteWithoutOkAsync<
    RecoveryServicesProvider,
    Error = never
  >;

  /**
   * Lists the registered recovery services providers for the specified fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryServicesProviders_ListByReplicationFabrics")
  @summary("Gets the list of registered recovery services providers for the fabric.")
  listByReplicationFabrics is ArmResourceListByParent<
    RecoveryServicesProvider,
    Response = ArmResponse<RecoveryServicesProviderCollection>,
    Error = never
  >;

  /**
   * The operation to refresh the information from the recovery services provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryServicesProviders_RefreshProvider")
  @summary("Refresh details from the recovery services provider.")
  refreshProvider is ArmResourceActionAsync<
    RecoveryServicesProvider,
    void,
    ArmResponse<RecoveryServicesProvider>,
    Error = never
  >;

  /**
   * The operation to removes/delete(unregister) a recovery services provider from the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryServicesProviders_Delete")
  @action("remove")
  @summary("Deletes provider from fabric. Note: Deleting provider for any fabric other than SingleHost is unsupported. To maintain backward compatibility for released clients the object \"deleteRspInput\" is used (if the object is empty we assume that it is old client and continue the old behavior).")
  delete is ArmResourceActionAsync<
    RecoveryServicesProvider,
    void,
    NoContentResponse,
    Error = never
  >;
}

@@doc(RecoveryServicesProvider.name, "Recovery services provider name.");
@@doc(RecoveryServicesProvider.properties, "Provider properties.");
@@doc(RecoveryServicesProviders.create::parameters.resource,
  "Add provider input."
);
