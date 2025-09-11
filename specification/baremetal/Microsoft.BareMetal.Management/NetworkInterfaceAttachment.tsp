import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ClientGenerator.Core;
using OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.BareMetal;

/**
 * Operations for NetworkInterfaceAttachment resource.
 */
@added(Versions.v2025_08_01_preview)
@armResourceOperations
interface NetworkInterfaceAttachments {
  /** Get the NetworkInterfaceAttachment. */
  get is ArmResourceRead<NetworkInterfaceAttachment>;

  /** Create or replace the NetworkInterfaceAttachment (LRO). */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NetworkInterfaceAttachment>;

  /** Patch (LRO). */
  @doc("Update anchor NICs and/or tags. Service returns the full NetworkInterfaceAttachment resource (including read-only bgpNics).")
  update is ArmCustomPatchAsync<
    NetworkInterfaceAttachment,
    NetworkInterfaceAttachmentPatchModel
  >;

  /** Delete the resource (LRO). */
  delete is ArmResourceDeleteWithoutOkAsync<NetworkInterfaceAttachment>;

  /** List by resource group. */
  listResourceGroup is ArmResourceListByParent<NetworkInterfaceAttachment>;

  /** List by subscription. */
  listSubscription is ArmListBySubscription<NetworkInterfaceAttachment>;
}

@@Azure.ClientGenerator.Core.clientName(NetworkInterfaceAttachments.createOrUpdate::parameters.resource,
  "networkInterfaceAttachmentObject"
);
@@clientName(NetworkInterfaceAttachments.createOrUpdate::parameters.resource,
  "networkInterfaceAttachmentObject"
);

@@Azure.ClientGenerator.Core.clientName(NetworkInterfaceAttachments.update::parameters.properties,
  "networkInterfaceAttachmentPatch"
);
@@clientName(NetworkInterfaceAttachments.update::parameters.properties,
  "networkInterfaceAttachmentPatch"
);
