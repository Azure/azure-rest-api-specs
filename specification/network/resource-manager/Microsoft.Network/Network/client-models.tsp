import "@azure-tools/typespec-azure-resource-manager";
import "./Network/main.tsp";

namespace Microsoft.Network;

/**
 * Shared writable subresource representation used by the previous C# AutoRest projection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility with the previous Network AutoRest C# hierarchy."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Back compatibility with the previous Network AutoRest C# hierarchy."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "Back compatibility with the previous Network AutoRest C# hierarchy."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Back compatibility with the previous Network AutoRest C# hierarchy."
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model WritableSubResourceModel extends SubResource {
  /**
   * Resource name.
   */
  name?: string;

  /**
   * Resource type.
   */
  type?: string;
}
