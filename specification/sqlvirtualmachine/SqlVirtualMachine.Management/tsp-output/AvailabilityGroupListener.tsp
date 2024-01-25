import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlVirtualMachineGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SqlVirtualMachine;
/**
 * A SQL Server availability group listener.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SqlVirtualMachineGroup)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  AvailabilityGroupListenerProperties
)
model AvailabilityGroupListener extends ProxyResourceBase {
  /**
   * Name of the availability group listener.
   */
  @path
  @key("availabilityGroupListenerName")
  @segment("availabilityGroupListeners")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AvailabilityGroupListenerProperties;
}

@armResourceOperations
interface AvailabilityGroupListeners {
  /**
   * Gets an availability group listener.
   */
  get is ArmResourceRead<
    AvailabilityGroupListener,
    {
      ...BaseParameters<AvailabilityGroupListener>;

      /**
       * Name of the SQL virtual machine group.
       */
      @path
      sqlVirtualMachineGroupName: string;

      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Creates or updates an availability group listener.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AvailabilityGroupListener,
    {
      ...BaseParameters<AvailabilityGroupListener>;

      /**
       * Name of the SQL virtual machine group.
       */
      @path
      sqlVirtualMachineGroupName: string;
    }
  >;

  /**
   * Deletes an availability group listener.
   */
  delete is ArmResourceDeleteAsync<
    AvailabilityGroupListener,
    {
      ...BaseParameters<AvailabilityGroupListener>;

      /**
       * Name of the SQL virtual machine group.
       */
      @path
      sqlVirtualMachineGroupName: string;
    }
  >;

  /**
   * Lists all availability group listeners in a SQL virtual machine group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AvailabilityGroupListeners_ListByGroup")
  listByGroup is ArmResourceListByParent<
    AvailabilityGroupListener,
    {
      ...BaseParameters<AvailabilityGroupListener>;

      /**
       * Name of the SQL virtual machine group.
       */
      @path
      sqlVirtualMachineGroupName: string;
    }
  >;
}

@@projectedName(AvailabilityGroupListeners.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(AvailabilityGroupListeners.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(AvailabilityGroupListeners.createOrUpdate::parameters.resource,
  "The availability group listener."
);
