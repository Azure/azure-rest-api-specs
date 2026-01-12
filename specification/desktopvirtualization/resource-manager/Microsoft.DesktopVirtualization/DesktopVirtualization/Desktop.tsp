import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;
/**
 * Schema for Desktop properties.
 */
@parentResource(ApplicationGroup)
model Desktop is Azure.ResourceManager.ProxyResource<DesktopProperties> {
  ...ResourceNameParameter<
    Resource = Desktop,
    KeyName = "desktopName",
    SegmentName = "desktops",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
}

@armResourceOperations
interface Desktops {
  /**
   * Get a desktop.
   */
  get is ArmResourceRead<Desktop>;

  /**
   * Update a desktop.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Desktop,
    DesktopPatch,
    Request = {
      /**
       * The resource properties to be updated
       */
      @bodyRoot desktop?: DesktopPatch;
    }
  >;

  /**
   * List desktops.
   */
  list is ArmResourceListByParent<
    Desktop,
    Parameters = {
      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    },
    Response = DesktopList
  >;
}

@@maxLength(Desktop.name, 24);
@@minLength(Desktop.name, 3);
@@doc(Desktop.name,
  "The name of the desktop within the specified desktop group"
);
@@doc(Desktop.properties, "Detailed properties for Desktop");
