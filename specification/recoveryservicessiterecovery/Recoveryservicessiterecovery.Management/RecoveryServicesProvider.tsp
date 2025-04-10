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
}

@armResourceOperations
interface RecoveryServicesProviders {
  /**
   * Gets the details of registered recovery services provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryServicesProviders_Get")
  get is ArmResourceRead<RecoveryServicesProvider>;

  /**
   * The operation to add a recovery services provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ReplicationRecoveryServicesProviders_Create")
  create is ArmResourceCreateOrReplaceAsync<
    RecoveryServicesProvider,
    Response = ArmResourceUpdatedResponse<RecoveryServicesProvider> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to purge(force delete) a recovery services provider from the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryServicesProviders_Purge")
  purge is ArmResourceDeleteWithoutOkAsync<RecoveryServicesProvider>;

  /**
   * Lists the registered recovery services providers for the specified fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryServicesProviders_ListByReplicationFabrics")
  listByReplicationFabrics is ArmResourceListByParent<
    RecoveryServicesProvider,
    Response = ArmResponse<RecoveryServicesProviderCollection>
  >;

  /**
   * The operation to refresh the information from the recovery services provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationRecoveryServicesProviders_RefreshProvider")
  refreshProvider is ArmResourceActionAsync<
    RecoveryServicesProvider,
    void,
    ArmResponse<RecoveryServicesProvider>
  >;

  /**
   * The operation to removes/delete(unregister) a recovery services provider from the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("remove")
  @operationId("ReplicationRecoveryServicesProviders_Delete")
  delete is ArmResourceActionAsync<
    RecoveryServicesProvider,
    void,
    NoContentResponse
  >;
}

@@doc(RecoveryServicesProvider.name, "Recovery services provider name.");
@@doc(RecoveryServicesProvider.properties, "Provider properties.");
@@doc(RecoveryServicesProviders.create::parameters.resource,
  "Add provider input."
);
