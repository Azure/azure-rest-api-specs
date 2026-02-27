import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ClientGenerator.Core;
using OpenAPI;

namespace Microsoft.BareMetal;

@armResourceOperations
interface PeeringSettings {
  /**
   * Get the PeeringSetting.
   */
  get is ArmResourceRead<PeeringSetting>;

  /**
   * Create or update the PeeringSetting.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PeeringSetting>;

  /**
   * Patch the PeeringSetting.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<PeeringSetting, PeeringSettingUpdate>;

  /**
   * Delete the PeeringSetting.
   */
  delete is ArmResourceDeleteWithoutOkAsync<PeeringSetting>;

  /**
   * List all PeeringSetting objects in the resource group.
   */
  listResourceGroup is ArmResourceListByParent<PeeringSetting>;

  /**
   * List all PeeringSetting objects in the subscription.
   */
  listSubscription is ArmListBySubscription<PeeringSetting>;
}

@@Azure.ClientGenerator.Core.clientName(PeeringSettings.createOrUpdate::parameters.resource,
  "peeringSettingObject"
);
@@clientName(PeeringSettings.createOrUpdate::parameters.resource,
  "peeringSettingObject"
);

@@Azure.ClientGenerator.Core.clientName(PeeringSettings.update::parameters.properties,
  "peeringSettingUpdateObject"
);
@@clientName(PeeringSettings.update::parameters.properties,
  "peeringSettingUpdateObject"
);
