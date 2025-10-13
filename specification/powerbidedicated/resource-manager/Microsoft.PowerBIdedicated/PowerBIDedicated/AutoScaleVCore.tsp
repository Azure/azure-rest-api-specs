import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.PowerBIDedicated;
/**
 * Represents an instance of an auto scale v-core resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AutoScaleVCore
  is Azure.ResourceManager.TrackedResource<AutoScaleVCoreProperties, true> {
  ...ResourceNameParameter<
    Resource = AutoScaleVCore,
    KeyName = "vcoreName",
    SegmentName = "autoScaleVCores",
    NamePattern = "^[-a-zA-Z0-9_]+$"
  >;

  /**
   * The SKU of the auto scale v-core resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: AutoScaleVCoreSku;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface AutoScaleVCores {
  /**
   * Gets details about the specified auto scale v-core.
   */
  get is ArmResourceRead<AutoScaleVCore, Error = ErrorResponse>;

  /**
   * Provisions the specified auto scale v-core based on the configuration specified in the request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceSync<
    AutoScaleVCore,
    Response = ArmResourceUpdatedResponse<AutoScaleVCore>,
    Error = ErrorResponse
  >;

  /**
   * Updates the current state of the specified auto scale v-core.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AutoScaleVCore,
    PatchModel = AutoScaleVCoreUpdateParameters,
    Error = ErrorResponse
  >;

  /**
   * Deletes the specified auto scale v-core.
   */
  delete is ArmResourceDeleteSync<AutoScaleVCore, Error = ErrorResponse>;

  /**
   * Gets all the auto scale v-cores for the given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    AutoScaleVCore,
    Response = ArmResponse<AutoScaleVCoreListResult>,
    Error = ErrorResponse
  >;

  /**
   * Lists all the auto scale v-cores for the given subscription.
   */
  listBySubscription is ArmListBySubscription<
    AutoScaleVCore,
    Response = ArmResponse<AutoScaleVCoreListResult>,
    Error = ErrorResponse
  >;
}

@@maxLength(AutoScaleVCore.name, 63);
@@minLength(AutoScaleVCore.name, 3);
@@doc(AutoScaleVCore.name,
  "The name of the auto scale v-core. It must be a minimum of 3 characters, and a maximum of 63."
);
@@doc(AutoScaleVCore.properties,
  "Properties of an auto scale v-core resource."
);
@@doc(AutoScaleVCores.create::parameters.resource,
  "Contains the information used to provision the auto scale v-core."
);
@@doc(AutoScaleVCores.update::parameters.properties,
  "Request object that contains the updated information for the auto scale v-core."
);
