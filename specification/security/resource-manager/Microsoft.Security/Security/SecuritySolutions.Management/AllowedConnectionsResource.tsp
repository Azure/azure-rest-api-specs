import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@tag("AllowedConnections")
interface AllowedConnectionsResources {
  /**
   * Gets the list of all possible traffic between resources for the subscription and location, based on connection type.
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  get is ArmResourceRead<AllowedConnectionsResource, Error = CloudError>;

  /**
   * Gets the list of all possible traffic between resources for the subscription and location.
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  listByHomeRegion is Extension.ListByTarget<
    Extension.Subscription,
    AllowedConnectionsResource,
    Response = ArmResponse<AllowedConnectionsList>,
    Error = CloudError
  >;
}

@@doc(AllowedConnectionsResource.name,
  "The type of allowed connections (Internal, External)"
);
@@doc(AllowedConnectionsResource.properties,
  "Describes the allowed traffic between Azure resources"
);
