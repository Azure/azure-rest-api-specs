import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./LabPlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.LabServices;
@doc("Lab services virtual machine image")
@parentResource(LabPlan)
model LabVirtualMachineImage is ProxyResource<ImageProperties> {
  @doc("The image name.")
  @maxLength(100)
  @minLength(1)
  @pattern("^[-\\w\\\\._\\\\(\\\\)]+$")
  @path
  @key("imageName")
  @segment("images")
  name: string;
}

@armResourceOperations
interface LabVirtualMachineImages {
  @doc("Gets an image resource.")
  get is ArmResourceRead<LabVirtualMachineImage>;
  @doc("Updates an image resource via PUT. Creating new resources via PUT will not function.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<LabVirtualMachineImage>;
  @doc("Updates an image resource.")
  update is ArmResourcePatchSync<LabVirtualMachineImage, ImageProperties>;
  @doc("Gets all images from galleries attached to a lab plan.")
  listByLabPlan is ArmResourceListByParent<
    LabVirtualMachineImage,
    {
      ...BaseParameters<LabVirtualMachineImage>;

      @doc("The filter to apply to the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
