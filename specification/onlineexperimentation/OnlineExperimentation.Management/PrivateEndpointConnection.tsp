import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";
import "@typespec/openapi";
import "@typespec/rest";
import "./OnlineExperimentationWorkspace.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.OnlineExperimentation;
/**
 * Private endpoint connection resource for an online experimentation workspace resource.
 */
@parentResource(OnlineExperimentationWorkspace)
@added(Microsoft.OnlineExperimentation.Versions.v2025_08_01_preview)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
}

@added(Microsoft.OnlineExperimentation.Versions.v2025_08_01_preview)
@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the private endpoint connection details for an online experimentation workspace resource.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Updates private endpoint connection status (Approval/Rejected) for an online experimentation workspace resource. This gets invoked by resource admin.
   */
  update is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;

  /**
   * Deletes private endpoint connection for an online experimentation workspace resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<PrivateEndpointConnection>;

  /**
   * Gets all the private endpoint connections configured on an online experimentation workspace resource.
   */
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}
