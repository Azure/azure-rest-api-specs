import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NamespaceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NotificationHubs;
/**
 * Represents a Private Endpoint Connection ARM resource - a sub-resource of Notification Hubs namespace.
 */
@parentResource(NamespaceResource)
model PrivateEndpointConnectionResource
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnectionResource,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9-]*\\.[a-fA-F0-9\\-]+$"
  >;
}

@armResourceOperations
interface PrivateEndpointConnectionResources {
  /**
   * Returns a Private Endpoint Connection with a given name.
   * This is a public API that can be called directly by Notification Hubs users.
   */
  get is ArmResourceRead<PrivateEndpointConnectionResource>;

  /**
   * Approves or rejects Private Endpoint Connection.
   * This is a public API that can be called directly by Notification Hubs users.
   */
  update is ArmResourceCreateOrReplaceAsync<PrivateEndpointConnectionResource>;

  /**
   * Deletes the Private Endpoint Connection.
   * This is a public API that can be called directly by Notification Hubs users.
   */
  delete is ArmResourceDeleteWithoutOkAsync<PrivateEndpointConnectionResource>;

  /**
   * Returns all Private Endpoint Connections that belong to the given Notification Hubs namespace.
   * This is a public API that can be called directly by Notification Hubs users.
   */
  list is ArmResourceListByParent<PrivateEndpointConnectionResource>;
}

@@maxLength(PrivateEndpointConnectionResource.name, 87);
@@minLength(PrivateEndpointConnectionResource.name, 1);
@@doc(PrivateEndpointConnectionResource.name,
  "Private Endpoint Connection Name"
);
@@doc(PrivateEndpointConnectionResource.properties,
  "Private Endpoint Connection properties."
);
@@doc(PrivateEndpointConnectionResources.update::parameters.resource,
  "Description of the Private Endpoint Connection resource."
);
