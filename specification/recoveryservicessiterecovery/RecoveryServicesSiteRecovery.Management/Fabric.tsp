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
@parentResource(Vault)
model Fabric is Azure.ResourceManager.ProxyResource<FabricProperties> {
  ...ResourceNameParameter<
    Resource = Fabric,
    KeyName = "fabricName",
    SegmentName = "replicationFabrics",
    NamePattern = ""
  >;

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

alias FabricOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the recovery services vault. */
    @path
    @segment("vaults")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    resourceName: string;
  },
  {
    /** Fabric name. */
    @path
    @segment("replicationFabrics")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    fabricName: string;
  }
>;

model FabricAcceptedLroResponse<FinalResult extends TypeSpec.Reflection.Model | unknown | void = Fabric>
  is ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = FinalResult> &
    Azure.Core.Foundations.RetryAfterHeader>;

@armResourceOperations
interface Fabrics {
  /**
   * Gets the details of an Azure Site Recovery fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the details of an ASR fabric.")
  get is ArmResourceRead<
    Fabric,
    Parameters = {
      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = never
  >;

  /**
   * The operation to create an Azure Site Recovery fabric (for e.g. Hyper-V site).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates an Azure Site Recovery fabric.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    Fabric,
    Request = FabricCreationInput,
    Response = ArmResourceUpdatedResponse<Fabric> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Fabric> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = never
  >;

  /**
   * The operation to purge(force delete) an Azure Site Recovery fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Purges the site.")
  purge is ArmResourceDeleteWithoutOkAsync<Fabric, Error = never>;

  /**
   * Gets a list of the Azure Site Recovery fabrics in the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the list of ASR fabrics.")
  list is ArmResourceListByParent<
    Fabric,
    Response = ArmResponse<FabricCollection>,
    Error = never
  >;

  /**
   * The operation to perform a consistency check on the fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Checks the consistency of the ASR fabric.")
  checkConsistency is ArmResourceActionAsyncBase<
    Fabric,
    void,
    ArmResponse<Fabric> | FabricAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Fabric>,
    Error = never
  >;

  /**
   * The operation to migrate an Azure Site Recovery fabric to AAD.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("migratetoaad")
  @summary("Migrates the site to AAD.")
  migrateToAad is ArmResourceActionAsyncBase<
    Fabric,
    void,
    NoContentResponse | FabricAcceptedLroResponse<void>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Fabric>,
    Error = never
  >;

  /**
   * The operation to move replications from a process server to another process server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Perform failover of the process server.")
  reassociateGateway is ArmResourceActionAsyncBase<
    Fabric,
    FailoverProcessServerRequest,
    ArmResponse<Fabric> | FabricAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Fabric>,
    Error = never
  >;

  /**
   * The operation to delete or remove an Azure Site Recovery fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("remove")
  @summary("Deletes the site.")
  delete is ArmResourceActionAsyncBase<
    Fabric,
    void,
    NoContentResponse | FabricAcceptedLroResponse<void>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Fabric>,
    Error = never
  >;

  /**
   * Renews the connection certificate for the ASR replication fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Renews certificate for the fabric.")
  renewCertificate is ArmResourceActionAsyncBase<
    Fabric,
    RenewCertificateInput,
    ArmResponse<Fabric> | FabricAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Fabric>,
    Error = never
  >;

  /**
   * Removes the appliance's infrastructure under the fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Removes the appliance's infrastructure under the fabric.")
  removeInfra is FabricOps.ActionAsync<
    Fabric,
    void,
    void,
    Response = ArmAcceptedLroResponse
  >;
}

@@doc(Fabric.name, "Fabric name.");
@@doc(Fabric.properties, "Fabric related data.");
@@doc(Fabrics.create::parameters.resource, "Fabric creation input.");
@@doc(Fabrics.reassociateGateway::parameters.body,
  "The input to the failover process server operation."
);
@@doc(Fabrics.renewCertificate::parameters.body, "Renew certificate input.");
