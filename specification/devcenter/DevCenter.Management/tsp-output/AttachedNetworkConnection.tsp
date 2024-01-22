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
@parentResource(Project)
model AttachedNetworkConnection
  is ProxyResource<AttachedNetworkConnectionProperties> {
  /**
   * The name of the attached NetworkConnection.
   */
  @path
  @key("attachedNetworkConnectionName")
  @segment("attachednetworks")
  name: string;
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
