import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Machine.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridCompute;
/**
 * Describes a Machine Extension.
 */
@parentResource(Machine)
model MachineExtension
  is Azure.ResourceManager.TrackedResource<MachineExtensionProperties> {
  ...ResourceNameParameter<
    Resource = MachineExtension,
    KeyName = "extensionName",
    SegmentName = "extensions",
    NamePattern = ""
  >;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    MachineExtension,
    Response = ArmResourceUpdatedResponse<MachineExtension> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = MachineExtension> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to create or update the extension.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    MachineExtension,
    PatchModel = MachineExtensionUpdate
  >;

  /**
   * The operation to delete the extension.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    MachineExtension,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * The operation to get all extensions of a non-Azure machine
   */
  list is ArmResourceListByParent<
    MachineExtension,
    Parameters = {
      /**
       * The expand expression to apply on the operation.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
}

@@doc(MachineExtension.name, "The name of the machine extension.");
@@doc(MachineExtension.properties, "Describes Machine Extension Properties.");
@@doc(MachineExtensions.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create Machine Extension operation."
);
@@doc(MachineExtensions.update::parameters.properties,
  "Parameters supplied to the Create Machine Extension operation."
);
