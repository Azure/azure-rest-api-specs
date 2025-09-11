import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.WindowsImageBuilder;
/**
 *  WindowsImage template is an ARM resource managed by Microsoft.WindowsImageBuilder provider
 */
model WindowsImage
  is Azure.ResourceManager.TrackedResource<WindowsImageProperties> {
  ...ResourceNameParameter<
    Resource = WindowsImage,
    KeyName = "imageName",
    SegmentName = "windowsImages",
    NamePattern = "^[A-Za-z0-9-_.]{1,64}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface WindowsImages {
  /**
   * Get information about a image
   */
  get is ArmResourceRead<WindowsImage>;

  /**
   * Request to initiate SMF media creation
   */
  create is ArmResourceCreateOrReplaceAsync<WindowsImage>;

  /**
   * Update the tags for the windows Image
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<WindowsImage, WindowsImageTagUpdateParameters>;

  /**
   * Delete a Windows image
   */
  delete is ArmResourceDeleteWithoutOkAsync<WindowsImage>;

  /**
   * Gets information about the  images associated with the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<WindowsImage>;

  /**
   * Gets information about the  images associated with the subscription.
   */
  list is ArmListBySubscription<WindowsImage>;

  /**
   * Cancel the long running image build
   */
  cancel is ArmResourceActionNoResponseContentAsync<WindowsImage, void>;
}

@@doc(WindowsImage.name, "The name of the windows image ");
@@doc(WindowsImage.properties, "The properties of the windows image");
@@doc(WindowsImages.create::parameters.resource,
  "Parameters supplied to Create WindowsImage operation"
);
@@doc(WindowsImages.update::parameters.properties,
  "Additional parameters for Windows Image update."
);
