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
  @parameterVisibility
  update is ArmResourcePatchSync<PeeringSetting, PeeringSettingUpdate>;

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

@@encodedName(PeeringSettings.createOrUpdate::parameters.resource,
  "application/json",
  "peeringSettingObject"
);
@@clientName(PeeringSettings.createOrUpdate::parameters.resource,
  "peeringSettingObject"
);

@@encodedName(PeeringSettings.update::parameters.properties,
  "application/json",
  "peeringSettingUpdateObject"
);
@@clientName(PeeringSettings.update::parameters.properties,
  "peeringSettingUpdateObject"
);
