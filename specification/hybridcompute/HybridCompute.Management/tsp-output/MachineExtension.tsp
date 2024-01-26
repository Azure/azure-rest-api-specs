import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Machine.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridCompute;
/**
 * Describes a Machine Extension.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Machine)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(MachineExtensionProperties)
model MachineExtension extends TrackedResourceBase {
  /**
   * The name of the machine extension.
   */
  @path
  @key("extensionName")
  @segment("extensions")
  @visibility("read")
  name: string;

  /**
   * Describes Machine Extension Properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MachineExtensionProperties;
}

@armResourceOperations
interface MachineExtensions {
  /**
   * The operation to get the extension.
   */
  get is ArmResourceRead<MachineExtension>;

  /**
   * The operation to create or update the extension.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MachineExtension>;

  /**
   * The operation to create or update the extension.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<MachineExtension, MachineExtensionUpdate>;

  /**
   * The operation to delete the extension.
   */
  delete is ArmResourceDeleteAsync<MachineExtension>;

  /**
   * The operation to get all extensions of a non-Azure machine
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MachineExtensions_List")
  list is ArmResourceListByParent<
    MachineExtension,
    {
      ...BaseParameters<MachineExtension>;

      /**
       * The expand expression to apply on the operation.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
}

@@projectedName(MachineExtensions.createOrUpdate::parameters.resource,
  "json",
  "extensionParameters"
);
@@extension(MachineExtensions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "extensionParameters"
);
@@doc(MachineExtensions.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create Machine Extension operation."
);
@@projectedName(MachineExtensions.update::parameters.properties,
  "json",
  "extensionParameters"
);
@@extension(MachineExtensions.update::parameters.properties,
  "x-ms-client-name",
  "extensionParameters"
);
@@doc(MachineExtensions.update::parameters.properties,
  "Parameters supplied to the Create Machine Extension operation."
);
