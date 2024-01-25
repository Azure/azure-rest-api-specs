import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;
/**
 * The OS option profile.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@locationResource
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(OSOptionPropertyList)
model OSOptionProfile extends ProxyResourceBase {
  @key("osOption")
  @segment("osOptions")
  @visibility("read")
  name: string;

  /**
   * The list of OS options.
   */
  @extension("x-ms-client-flatten", true)
  properties: OSOptionPropertyList;
}

@armResourceOperations
interface OSOptionProfiles {
  /**
   * Gets supported OS options in the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedClusters_GetOSOptions")
  getOSOptions is ArmResourceRead<
    OSOptionProfile,
    {
      ...BaseParameters<OSOptionProfile>;

      /**
       * The resource type for which the OS options needs to be returned
       */
      @query("resource-type")
      `resource-type`?: string;
    }
  >;
}
