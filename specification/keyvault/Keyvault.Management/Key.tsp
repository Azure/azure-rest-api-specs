import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Vault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KeyVault;
/**
 * The key resource.
 */
@parentResource(Vault)
model Key is Azure.ResourceManager.TrackedResource<KeyProperties, false> {
  ...ResourceNameParameter<
    Resource = Key,
    KeyName = "keyName",
    SegmentName = "keys",
    NamePattern = "^[a-zA-Z0-9-]{1,127}$"
  >;
}

@armResourceOperations
interface KeyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Vault,
          KeyName = "vaultName",
          SegmentName = "vaults",
          NamePattern = "^[a-zA-Z0-9-]{3,24}$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = Key,
        KeyName = "keyName",
        SegmentName = "keys",
        NamePattern = "^[a-zA-Z0-9-]{1,127}$"
      >>
    > {}

@armResourceOperations
interface Keys {
  /**
   * Gets the current version of the specified key from the specified key vault.
   */
  get is KeyOps.Read<Key>;

  /**
   * Creates the first version of a new key if it does not exist. If it already exists, then the existing key is returned without any write operations being performed. This API does not create subsequent versions, and does not update existing keys.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createIfNotExist is KeyOps.CreateOrUpdateSync<
    Key,
    Response = ArmResourceUpdatedResponse<Key>
  >;
}
@armResourceOperations
interface KeyOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Vault,
          KeyName = "vaultName",
          SegmentName = "vaults",
          NamePattern = "^[a-zA-Z0-9-]{3,24}$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = Key,
          KeyName = "keyName",
          SegmentName = "keys",
          NamePattern = "^[a-zA-Z0-9-]{1,127}$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = Key,
        KeyName = "keyVersion",
        SegmentName = "versions",
        NamePattern = "^[a-fA-F0-9]{32}$"
      >>
    > {}

@armResourceOperations
interface KeyOperationGroup {
  /**
   * Gets the specified version of the specified key in the specified key vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Keys_GetVersion")
  getVersion is KeyOperationGroupOps.Read<Key>;

  /**
   * Lists the keys in the specified key vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Keys_List")
  list is KeyOperationGroupOps.List<Key>;
}

@@doc(Key.name, "The name of the key to be retrieved.");
@@doc(Key.properties, "The properties of the key.");
@@doc(Keys.createIfNotExist::parameters.resource,
  "The parameters used to create the specified key."
);
