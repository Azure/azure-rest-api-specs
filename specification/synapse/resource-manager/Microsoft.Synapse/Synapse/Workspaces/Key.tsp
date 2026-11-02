import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * A workspace key
 */
@parentResource(Workspace)
model Key is Azure.ResourceManager.ProxyResource<KeyProperties> {
  ...ResourceNameParameter<
    Resource = Key,
    KeyName = "keyName",
    SegmentName = "keys",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Keys {
  /**
   * Gets a workspace key
   */
  get is ArmResourceRead<Key>;

  /**
   * Creates or updates a workspace key
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Key,
    Response = ArmResourceUpdatedResponse<Key>
  >;

  /**
   * Deletes a workspace key
   */
  delete is ArmResourceDeleteSync<
    Key,
    Response = ArmResponse<Key> | ArmDeletedNoContentResponse
  >;

  /**
   * Returns a list of keys in a workspace
   */
  listByWorkspace is ArmResourceListByParent<Key>;
}

@@doc(Key.name, "The name of the workspace key");
@@doc(Key.properties, "Keys resource properties");
@@doc(Keys.createOrUpdate::parameters.resource, "Key put request properties");
