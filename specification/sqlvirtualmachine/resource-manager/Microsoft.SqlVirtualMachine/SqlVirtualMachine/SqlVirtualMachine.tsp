import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SqlVirtualMachine;
/**
 * A SQL virtual machine.
 */
model SqlVirtualMachine
  is Azure.ResourceManager.TrackedResource<SqlVirtualMachineProperties, true> {
  ...ResourceNameParameter<
    Resource = SqlVirtualMachine,
    KeyName = "sqlVirtualMachineName",
    SegmentName = "sqlVirtualMachines",
    NamePattern = "^((?!_)[^\\\\/\"'\\[\\]:|<>+=;,?*@&]{1,64}(?<![.-]))$"
  >;

  /**
   * DO NOT USE. This value will be deprecated. Azure Active Directory identity of the server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  identity?: ResourceIdentity;
}

@armResourceOperations
interface SqlVirtualMachines {
  /**
   * Gets a SQL virtual machine.
   */
  get is ArmResourceRead<
    SqlVirtualMachine,
    Parameters = {
      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Creates or updates a SQL virtual machine.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SqlVirtualMachine>;

  /**
   * Updates SQL virtual machine tags.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    SqlVirtualMachine,
    PatchModel = SqlVirtualMachineUpdate,
    Response = ArmResponse<SqlVirtualMachine> &
      ArmAsyncOperationHeader<FinalResult = SqlVirtualMachine>
  >;

  /**
   * Deletes a SQL virtual machine.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    SqlVirtualMachine,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all SQL virtual machines in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<SqlVirtualMachine>;

  /**
   * Gets all SQL virtual machines in a subscription.
   */
  list is ArmListBySubscription<SqlVirtualMachine>;

  /**
   * Starts SQL best practices Assessment on SQL virtual machine.
   */
  startAssessment is ArmResourceActionAsyncBase<
    SqlVirtualMachine,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SqlVirtualMachine>
  >;

  /**
   * Starts SQL best practices Assessment with Disk Config rules on SQL virtual machine
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlVirtualMachines_FetchDCAssessment")
  fetchDCAssessment is ArmResourceActionAsyncBase<
    SqlVirtualMachine,
    DiskConfigAssessmentRequest,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SqlVirtualMachine>
  >;

  /**
   * Uninstalls and reinstalls the SQL IaaS Extension.
   */
  redeploy is ArmResourceActionAsyncBase<
    SqlVirtualMachine,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SqlVirtualMachine>
  >;

  /**
   * Starts SQL virtual machine troubleshooting.
   */
  troubleshoot is ArmResourceActionAsync<
    SqlVirtualMachine,
    SqlVmTroubleshooting,
    SqlVmTroubleshooting
  >;
}

@@maxLength(SqlVirtualMachine.name, 64);
@@minLength(SqlVirtualMachine.name, 1);
@@doc(SqlVirtualMachine.name, "Name of the SQL virtual machine.");
@@doc(SqlVirtualMachine.properties, "Resource properties.");
@@doc(SqlVirtualMachines.createOrUpdate::parameters.resource,
  "The SQL virtual machine."
);
@@doc(SqlVirtualMachines.update::parameters.properties,
  "The SQL virtual machine."
);
@@doc(SqlVirtualMachines.fetchDCAssessment::parameters.body,
  "Disk Config Assessment property"
);
@@doc(SqlVirtualMachines.troubleshoot::parameters.body,
  "The SQL virtual machine troubleshooting entity."
);
