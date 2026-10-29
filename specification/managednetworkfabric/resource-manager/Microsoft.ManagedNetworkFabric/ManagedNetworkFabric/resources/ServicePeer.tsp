import "../models/common.tsp";
import "../models/ServicePeer.tsp";
import "./Vrf.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Resource extends the ARM TrackedResource base type, which requires inheritance."
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("Defines the ServicePeer resource. A ServicePeer is a whole-Vrf InternetDefault service edge with a fail-closed attachment lifecycle.")
@parentResource(Vrf)
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2026_07_15_preview)
model ServicePeer extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the ServicePeer.")
  @pattern("^[A-Za-z][A-Za-z0-9-]*$")
  @minLength(1)
  @maxLength(64)
  @path
  @key("servicePeerName")
  @segment("servicePeers")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The ServicePeer properties.")
  properties: ServicePeerProperties;
}

@armResourceOperations
@added(Versions.v2026_07_15_preview)
interface ServicePeers {
  @doc("Gets the specified ServicePeer.")
  get is ArmResourceRead<ServicePeer>;

  @doc("Creates a ServicePeer.")
  create is ArmResourceCreateOrReplaceAsync<ServicePeer>;

  @doc("Updates a ServicePeer.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<ServicePeer, ServicePeerPatch>;

  @doc("Deletes the specified ServicePeer.")
  delete is ArmResourceDeleteWithoutOkAsync<ServicePeer>;

  @doc("Lists ServicePeers by Vrf.")
  listByVrf is ArmResourceListByParent<ServicePeer>;

  @doc("Prepares a single-consumer service endpoint attachment.")
  @action("prepareAttachment")
  prepareAttachment is ArmResourceActionAsync<
    ServicePeer,
    PrepareServicePeerAttachmentRequest,
    ServicePeerAttachment
  >;

  @doc("Confirms a previously prepared service endpoint attachment.")
  @action("confirmAttachment")
  confirmAttachment is ArmResourceActionAsync<
    ServicePeer,
    ConfirmServicePeerAttachmentRequest,
    OperationAcknowledged
  >;

  @doc("Revokes an attachment and withdraws service exposure before cleanup.")
  @action("revoke")
  revoke is ArmResourceActionAsync<
    ServicePeer,
    RevokeServicePeerAttachmentRequest,
    OperationAcknowledged
  >;
}

@@doc(ServicePeers.create::parameters.resource, "Request payload.");
