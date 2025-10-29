import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SqlVirtualMachine;
/**
 * A SQL virtual machine group.
 */
model SqlVirtualMachineGroup
  is Azure.ResourceManager.TrackedResource<SqlVirtualMachineGroupProperties> {
  ...ResourceNameParameter<
    Resource = SqlVirtualMachineGroup,
    KeyName = "sqlVirtualMachineGroupName",
    SegmentName = "sqlVirtualMachineGroups",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SqlVirtualMachineGroups {
  /**
   * Gets a SQL virtual machine group.
   */
  get is ArmResourceRead<SqlVirtualMachineGroup>;

  /**
   * Creates or updates a SQL virtual machine group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SqlVirtualMachineGroup>;

  /**
   * Updates SQL virtual machine group tags.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    SqlVirtualMachineGroup,
    PatchModel = SqlVirtualMachineGroupUpdate,
    Response = ArmResponse<SqlVirtualMachineGroup> &
      ArmAsyncOperationHeader<FinalResult = SqlVirtualMachineGroup>
  >;

  /**
   * Deletes a SQL virtual machine group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    SqlVirtualMachineGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all SQL virtual machine groups in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<SqlVirtualMachineGroup>;

  /**
   * Gets all SQL virtual machine groups in a subscription.
   */
  list is ArmListBySubscription<SqlVirtualMachineGroup>;

  /**
   * Gets the list of sql virtual machines in a SQL virtual machine group.
   */
  @get
  @action("sqlVirtualMachines")
  @list
  listBySqlVmGroup is ArmResourceActionSync<
    SqlVirtualMachineGroup,
    void,
    ArmResponse<ResourceListResult<SqlVirtualMachine>>
  >;
}

@@doc(SqlVirtualMachineGroup.name, "Name of the SQL virtual machine group.");
@@doc(SqlVirtualMachineGroup.properties, "Resource properties.");
@@doc(SqlVirtualMachineGroups.createOrUpdate::parameters.resource,
  "The SQL virtual machine group."
);
@@doc(SqlVirtualMachineGroups.update::parameters.properties,
  "The SQL virtual machine group."
);
