import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ImageTemplate.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.VirtualMachineImages;
/**
 * Represents an output that was created by running an image template.
 */
@parentResource(ImageTemplate)
model RunOutput is Azure.ResourceManager.ProxyResource<RunOutputProperties> {
  ...ResourceNameParameter<
    Resource = RunOutput,
    KeyName = "runOutputName",
    SegmentName = "runOutputs",
    NamePattern = "^[A-Za-z0-9-_.]{1,64}$"
  >;
}

@armResourceOperations
interface RunOutputs {
  /**
   * Get the specified run output for the specified image template resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineImageTemplates_GetRunOutput")
  getRunOutput is ArmResourceRead<RunOutput>;

  /**
   * List all run outputs for the specified Image Template resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineImageTemplates_ListRunOutputs")
  listRunOutputs is ArmResourceListByParent<
    RunOutput,
    Response = ArmResponse<RunOutputCollection>
  >;
}

@@doc(RunOutput.name, "The name of the run output");
@@doc(RunOutput.properties, "The properties of the run output");
