import "./Network/main.tsp";
import "./Vmss/main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ResourceManager;
using Azure.Core;
using Common;

// Define WritableSubResource in the ARM namespace for C# collection compatibility.
namespace Azure.ResourceManager.Models {
  model WritableSubResource {
    id?: armResourceIdentifier;
  }
}

namespace Common {
  /**
   * Common writable subresource representation used by the previous C# AutoRest projection.
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
}
