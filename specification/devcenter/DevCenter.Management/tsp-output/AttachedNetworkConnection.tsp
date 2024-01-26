import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * Represents an attached NetworkConnection.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Project)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  AttachedNetworkConnectionProperties
)
model AttachedNetworkConnection extends ProxyResourceBase {
  /**
   * The name of the attached NetworkConnection.
   */
  @path
  @key("attachedNetworkConnectionName")
  @segment("attachednetworks")
  @visibility("read")
  name: string;

  /**
   * Attached NetworkConnection properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AttachedNetworkConnectionProperties;
}

@armResourceOperations
interface AttachedNetworkConnections {
  /**
   * Gets an attached NetworkConnection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AttachedNetworks_GetByProject")
  getByProject is ArmResourceRead<AttachedNetworkConnection>;

  /**
   * Lists the attached NetworkConnections for a Project.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AttachedNetworks_ListByProject")
  listByProject is ArmResourceListByParent<
    AttachedNetworkConnection,
    {
      ...BaseParameters<AttachedNetworkConnection>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}
