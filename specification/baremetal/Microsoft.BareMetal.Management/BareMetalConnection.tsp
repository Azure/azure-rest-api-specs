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
interface BareMetalConnections {
  /**
   * Get the BareMetalConnection.
   */
  get is ArmResourceRead<BareMetalConnection>;

  /**
   * Create or update the BareMetalConnection.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BareMetalConnection>;

  /**
   * Patch the BareMetalConnection. Only the tags may be updated.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<BareMetalConnection, BareMetalConnectionUpdate>;

  /**
   * Delete the BareMetalConnection.
   */
  delete is ArmResourceDeleteWithoutOkAsync<BareMetalConnection>;

  /**
   * List all BareMetalConnection objects in the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("BareMetalConnections_ListResourceGroup")
  listResourceGroup is ArmResourceListByParent<BareMetalConnection>;

  /**
   * List all BareMetalConnection objects in the subscription.
   */
  listSubscription is ArmListBySubscription<BareMetalConnection>;
}

@@Azure.ClientGenerator.Core.clientName(BareMetalConnections.createOrUpdate::parameters.resource,
  "bareMetalConnectionObject"
);
@@clientName(BareMetalConnections.createOrUpdate::parameters.resource,
  "bareMetalConnectionObject"
);

@@Azure.ClientGenerator.Core.clientName(BareMetalConnections.update::parameters.properties,
  "bareMetalConnectionObject"
);
@@clientName(BareMetalConnections.update::parameters.properties,
  "bareMetalConnectionObject"
);
