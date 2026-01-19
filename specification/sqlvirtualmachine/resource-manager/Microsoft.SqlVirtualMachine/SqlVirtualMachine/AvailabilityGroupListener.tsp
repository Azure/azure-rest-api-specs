import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlVirtualMachineGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SqlVirtualMachine;
/**
 * A SQL Server availability group listener.
 */
@parentResource(SqlVirtualMachineGroup)
model AvailabilityGroupListener
  is Azure.ResourceManager.ProxyResource<AvailabilityGroupListenerProperties> {
  ...ResourceNameParameter<
    Resource = AvailabilityGroupListener,
    KeyName = "availabilityGroupListenerName",
    SegmentName = "availabilityGroupListeners",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AvailabilityGroupListeners {
  /**
   * Gets an availability group listener.
   */
  get is ArmResourceRead<
    AvailabilityGroupListener,
    Parameters = {
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AvailabilityGroupListener>;

  /**
   * Deletes an availability group listener.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    AvailabilityGroupListener,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all availability group listeners in a SQL virtual machine group.
   */
  listByGroup is ArmResourceListByParent<AvailabilityGroupListener>;
}

@@doc(AvailabilityGroupListener.name,
  "Name of the availability group listener."
);
@@doc(AvailabilityGroupListener.properties, "Resource properties.");
@@doc(AvailabilityGroupListeners.createOrUpdate::parameters.resource,
  "The availability group listener."
);
