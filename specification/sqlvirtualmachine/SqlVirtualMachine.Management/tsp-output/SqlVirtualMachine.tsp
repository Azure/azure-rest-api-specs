import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SqlVirtualMachine;
/**
 * A SQL virtual machine.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SqlVirtualMachineProperties)
model SqlVirtualMachine extends TrackedResourceBase {
  /**
   * Name of the SQL virtual machine.
   */
  @path
  @key("sqlVirtualMachineName")
  @segment("sqlVirtualMachines")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SqlVirtualMachineProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface SqlVirtualMachines {
  /**
   * Gets a SQL virtual machine.
   */
  get is ArmResourceRead<
    SqlVirtualMachine,
    {
      ...BaseParameters<SqlVirtualMachine>;

      /**
       * Name of the SQL virtual machine.
       */
      @path
      sqlVirtualMachineName: string;

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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SqlVirtualMachine,
    {
      ...BaseParameters<SqlVirtualMachine>;

      /**
       * Name of the SQL virtual machine.
       */
      @path
      sqlVirtualMachineName: string;
    }
  >;

  /**
   * Updates a SQL virtual machine.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    SqlVirtualMachine,
    SqlVirtualMachineUpdate,
    {
      ...BaseParameters<SqlVirtualMachine>;

      /**
       * Name of the SQL virtual machine.
       */
      @path
      sqlVirtualMachineName: string;
    }
  >;

  /**
   * Deletes a SQL virtual machine.
   */
  delete is ArmResourceDeleteAsync<
    SqlVirtualMachine,
    {
      ...BaseParameters<SqlVirtualMachine>;

      /**
       * Name of the SQL virtual machine.
       */
      @path
      sqlVirtualMachineName: string;
    }
  >;

  /**
   * Gets all SQL virtual machines in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SqlVirtualMachines_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<SqlVirtualMachine>;

  /**
   * Gets all SQL virtual machines in a subscription.
   */
  list is ArmListBySubscription<SqlVirtualMachine>;

  /**
   * Uninstalls and reinstalls the SQL Iaas Extension.
   */
  redeploy is ArmResourceActionAsync<
    SqlVirtualMachine,
    void,
    void,
    {
      ...BaseParameters<SqlVirtualMachine>;

      /**
       * Name of the SQL virtual machine.
       */
      @path
      sqlVirtualMachineName: string;
    }
  >;

  /**
   * Starts Assessment on SQL virtual machine.
   */
  startAssessment is ArmResourceActionAsync<
    SqlVirtualMachine,
    void,
    void,
    {
      ...BaseParameters<SqlVirtualMachine>;

      /**
       * Name of the SQL virtual machine.
       */
      @path
      sqlVirtualMachineName: string;
    }
  >;
}

@@projectedName(SqlVirtualMachines.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SqlVirtualMachines.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SqlVirtualMachines.createOrUpdate::parameters.resource,
  "The SQL virtual machine."
);
@@projectedName(SqlVirtualMachines.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(SqlVirtualMachines.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(SqlVirtualMachines.update::parameters.properties,
  "The SQL virtual machine."
);
