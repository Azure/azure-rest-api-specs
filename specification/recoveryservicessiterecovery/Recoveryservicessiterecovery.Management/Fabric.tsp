import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Fabric definition.
 */
model Fabric is Azure.ResourceManager.ProxyResource<FabricProperties> {
  ...ResourceNameParameter<
    Resource = Fabric,
    KeyName = "fabricName",
    SegmentName = "replicationFabrics",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Fabrics {
  /**
   * Gets the details of an Azure Site Recovery fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationFabrics_Get")
  get is ArmResourceRead<
    Fabric,
    Parameters = {
      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * The operation to create an Azure Site Recovery fabric (for e.g. Hyper-V site).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ReplicationFabrics_Create")
  create is ArmResourceCreateOrReplaceAsync<
    Fabric,
    Response = ArmResourceUpdatedResponse<Fabric> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to purge(force delete) an Azure Site Recovery fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationFabrics_Purge")
  purge is ArmResourceDeleteWithoutOkAsync<Fabric>;

  /**
   * Gets a list of the Azure Site Recovery fabrics in the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationFabrics_List")
  list is ArmResourceListByParent<
    Fabric,
    Response = ArmResponse<FabricCollection>
  >;

  /**
   * The operation to perform a consistency check on the fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationFabrics_CheckConsistency")
  checkConsistency is ArmResourceActionAsync<Fabric, void, ArmResponse<Fabric>>;

  /**
   * The operation to migrate an Azure Site Recovery fabric to AAD.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("migratetoaad")
  @operationId("ReplicationFabrics_MigrateToAad")
  migrateToAad is ArmResourceActionAsync<Fabric, void, NoContentResponse>;

  /**
   * The operation to move replications from a process server to another process server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationFabrics_ReassociateGateway")
  reassociateGateway is ArmResourceActionAsync<
    Fabric,
    FailoverProcessServerRequest,
    ArmResponse<Fabric>
  >;

  /**
   * The operation to delete or remove an Azure Site Recovery fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("remove")
  @operationId("ReplicationFabrics_Delete")
  delete is ArmResourceActionAsync<Fabric, void, NoContentResponse>;

  /**
   * Renews the connection certificate for the ASR replication fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationFabrics_RenewCertificate")
  renewCertificate is ArmResourceActionAsync<
    Fabric,
    RenewCertificateInput,
    ArmResponse<Fabric>
  >;

  /**
   * Removes the appliance's infrastructure under the fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationFabrics_RemoveInfra")
  removeInfra is ArmResourceActionAsyncBase<
    Fabric,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Fabric>
  >;
}

@@doc(Fabric.name, "Fabric name.");
@@doc(Fabric.properties, "Fabric related data.");
@@doc(Fabrics.create::parameters.resource, "Fabric creation input.");
@@doc(Fabrics.reassociateGateway::parameters.body,
  "The input to the failover process server operation."
);
@@doc(Fabrics.renewCertificate::parameters.body, "Renew certificate input.");
