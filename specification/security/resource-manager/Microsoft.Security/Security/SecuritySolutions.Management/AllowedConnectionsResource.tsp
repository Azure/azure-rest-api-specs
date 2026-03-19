import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * The resource whose properties describes the allowed traffic between Azure resources
 */
@parentResource(ResourceGroupLocationResource)
model AllowedConnectionsResource
  is Azure.ResourceManager.ProxyResource<AllowedConnectionsResourceProperties> {
  ...ResourceNameParameter<
    Resource = AllowedConnectionsResource,
    KeyName = "connectionType",
    SegmentName = "allowedConnections",
    NamePattern = "",
    Type = ConnectionType
  >;

  /**
   * Location where the resource is stored
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface AllowedConnectionsResources {
  /**
   * Gets the list of all possible traffic between resources for the subscription and location, based on connection type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  @operationId("AllowedConnections_Get")
  get is ArmResourceRead<AllowedConnectionsResource>;

  /**
   * Gets the list of all possible traffic between resources for the subscription and location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  @operationId("AllowedConnections_ListByHomeRegion")
  listByHomeRegion is Extension.ListByTarget<
    Extension.Subscription,
    AllowedConnectionsResource,
    Response = ArmResponse<AllowedConnectionsList>
  >;
}

@@doc(AllowedConnectionsResource.name,
  "The type of allowed connections (Internal, External)"
);
@@doc(AllowedConnectionsResource.properties,
  "Describes the allowed traffic between Azure resources"
);
