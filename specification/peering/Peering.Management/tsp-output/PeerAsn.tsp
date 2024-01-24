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

namespace Microsoft.Peering;
/**
 * The essential information related to the peer's ASN.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@subscriptionResource
@Azure.ResourceManager.Private.armResourceInternal(PeerAsnProperties)
@includeInapplicableMetadataInPayload(false)
model PeerAsn extends Resource {
  /**
   * The peer ASN name.
   */
  @path
  @key("peerAsnName")
  @segment("peerAsns")
  name: string;

  /**
   * The properties that define a peer's ASN.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PeerAsnProperties;
}

@armResourceOperations
interface PeerAsns {
  /**
   * Gets the peer ASN with the specified name under the given subscription.
   */
  get is ArmResourceRead<PeerAsn>;

  /**
   * Creates a new peer ASN or updates an existing peer ASN with the specified name under the given subscription.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeerAsn>;

  /**
   * Deletes an existing peer ASN with the specified name under the given subscription.
   */
  delete is ArmResourceDeleteSync<PeerAsn>;

  /**
   * Lists all of the peer ASNs under the given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PeerAsns_ListBySubscription")
  listBySubscription is ArmResourceListByParent<PeerAsn>;
}

@@projectedName(PeerAsns.createOrUpdate::parameters.resource,
  "json",
  "peerAsn"
);
@@extension(PeerAsns.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "peerAsn"
);
@@doc(PeerAsns.createOrUpdate::parameters.resource, "The peer ASN.");
