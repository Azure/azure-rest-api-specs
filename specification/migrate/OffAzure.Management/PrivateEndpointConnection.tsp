import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MasterSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * REST model used to encapsulate Private Link properties for tracked resources.
 */
@parentResource(MasterSite)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionPropertiesV2> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "peConnectionName",
    SegmentName = "privateEndpointConnections"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface PrivateEndpointConnections {
  /**
   * Gets the private link resource.
   */
  @tag("PrivateEndpointConnectionController")
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Gets the private link resource.
   */
  @tag("PrivateEndpointConnectionController")
  create is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;

  /**
   * Deletes the private link resource.
   */
  @tag("PrivateEndpointConnectionController")
  delete is ArmResourceDeleteSync<PrivateEndpointConnection>;

  /**
   * Gets the private link resource.
   */
  @tag("PrivateEndpointConnectionController")
  listByMasterSite is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@doc(PrivateEndpointConnection.name, " Private link resource name.");
@@doc(PrivateEndpointConnection.properties,
  "The resource-specific properties for this resource."
);
