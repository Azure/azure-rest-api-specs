import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachine.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * Console represents the console of an on-premises Network Cloud virtual machine.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(VirtualMachine)
@Azure.ResourceManager.Private.armResourceInternal(ConsoleProperties)
@includeInapplicableMetadataInPayload(false)
model Console extends TrackedResourceBase {
  /**
   * The name of the virtual machine console.
   */
  @pattern("^default$")
  @path
  @key("consoleName")
  @segment("consoles")
  name: string;

  /**
   * The extended location of the cluster manager associated with the cluster this virtual machine is created on.
   */
  extendedLocation: ExtendedLocation;

  /**
   * The list of the resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: ConsoleProperties;
}

@armResourceOperations
interface Consoles {
  /**
   * Get properties of the provided virtual machine console.
   */
  get is ArmResourceRead<Console>;

  /**
   * Create a new virtual machine console or update the properties of the existing virtual machine console.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Console,
    BaseParameters<Console>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch the properties of the provided virtual machine console, or update the tags associated with the virtual machine console. Properties and tag updates can be done independently.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Console,
    ConsolePatchParameters,
    BaseParameters<Console>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete the provided virtual machine console.
   */
  delete is ArmResourceDeleteAsync<
    Console,
    BaseParameters<Console>,
    ArmLroLocationHeader
  >;

  /**
   * Get a list of consoles for the provided virtual machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Consoles_ListByVirtualMachine")
  listByVirtualMachine is ArmResourceListByParent<Console>;
}

@@projectedName(Consoles.createOrUpdate::parameters.resource,
  "json",
  "consoleParameters"
);
@@extension(Consoles.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "consoleParameters"
);
@@doc(Consoles.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(Consoles.update::parameters.properties,
  "json",
  "consoleUpdateParameters"
);
@@extension(Consoles.update::parameters.properties,
  "x-ms-client-name",
  "consoleUpdateParameters"
);
@@doc(Consoles.update::parameters.properties, "The request body.");
