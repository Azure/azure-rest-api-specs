import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Compute;
/**
 * Describes a Virtual Machine Extension Image.
 */
model VirtualMachineExtensionImage
  is Azure.ResourceManager.TrackedResource<VirtualMachineExtensionImageProperties> {
  ...ResourceNameParameter<
    Resource = VirtualMachineExtensionImage,
    KeyName = "type",
    SegmentName = "types",
    NamePattern = ""
  >;
}

alias ImageTypePath = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...LocationResourceParameter;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @path @segment("publishers") publisherName: string;
};

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
interface VirtualMachineExtensionImageOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      ImageTypePath & KeysOf<VirtualMachineExtensionImage>,
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required"
        @path @segment("versions") version: string,
      },
      CloudError,
      #{
        useStaticRoute: true,
        route: "/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/publishers/{publisherName}/artifacttypes/vmextension/types",
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
interface VirtualMachineExtensionImageTypeOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      ImageTypePath,
      KeysOf<VirtualMachineExtensionImage>,
      CloudError,
      #{
        useStaticRoute: true,
        route: "/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/publishers/{publisherName}/artifacttypes/vmextension/types",
      }
    > {}

@armResourceOperations(#{ allowStaticRoutes: true })
interface VirtualMachineExtensionImages {
  /**
   * Gets a virtual machine extension image.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/publishers/{publisherName}/artifacttypes/vmextension/types/{type}/versions/{version}")
  get is VirtualMachineExtensionImageOps.Read<VirtualMachineExtensionImage>;

  /**
   * Gets a list of virtual machine extension image types.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/publishers/{publisherName}/artifacttypes/vmextension/types")
  listTypes is VirtualMachineExtensionImageTypeOps.ListSinglePage<
    VirtualMachineExtensionImage,
    Response = ArmResponse<VirtualMachineExtensionImage[]>
  >;

  /**
   * Gets a list of virtual machine extension image versions.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/publishers/{publisherName}/artifacttypes/vmextension/types/{type}/versions")
  listVersions is VirtualMachineExtensionImageOps.ListSinglePage<
    VirtualMachineExtensionImage,
    Response = ArmResponse<VirtualMachineExtensionImage[]>,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required"
      @query("$top")
      $top?: int32;

      #suppress "@azure-tools/typespec-azure-core/documentation-required"
      @query("$orderby")
      $orderby?: string;
    }
  >;
}

@@doc(VirtualMachineExtensionImage.name, "");
@@doc(
  VirtualMachineExtensionImage.properties,
  "Describes the properties of a Virtual Machine Extension Image."
);
