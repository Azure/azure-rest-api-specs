import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./MessagingCatalog.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.MessagingCatalog;

/** The Private Endpoint Connection resource. */
@added(Versions.v2025_11_01_preview)
@parentResource(MessagingCatalog)
model PrivateEndpointConnectionResource
  is ProxyResource<PrivateEndpointConnectionProperties> {
  ...PrivateEndpointConnectionParameter;
}

/** Private endpoint connection operations */
@added(Versions.v2025_11_01_preview)
@armResourceOperations(PrivateEndpointConnectionResource)
interface PrivateEndpointConnections {
  /** Get a specific private endpoint connection */
  get is ArmResourceRead<PrivateEndpointConnectionResource>;
  /** Create or update a private endpoint connection */
  create is ArmResourceCreateOrReplaceAsync<PrivateEndpointConnectionResource>;
  /** Delete a private endpoint connection */
  delete is ArmResourceDeleteWithoutOkAsync<PrivateEndpointConnectionResource>;
  /** List private endpoint connections on the given resource */
  list is ArmResourceListByParent<PrivateEndpointConnectionResource>;
}

/** Private Link Resource for MessagingCatalog */
#suppress "@azure-tools/typespec-providerhub-controller/no-resource-operations" "Expected for private links"
@added(Versions.v2025_11_01_preview)
@parentResource(MessagingCatalog)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  ...PrivateLinkResourceParameter;
}

/** Operations for private link resources on MessagingCatalog */
@added(Versions.v2025_11_01_preview)
@armResourceOperations(PrivateLinkResource)
interface PrivateLinks {
  /** List private links on the given resource */
  list is ArmResourceListByParent<PrivateLinkResource>;
}
