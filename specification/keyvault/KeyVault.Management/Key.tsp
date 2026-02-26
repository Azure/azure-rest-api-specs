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
model Key is Azure.ResourceManager.ProxyResource<KeyProperties, false> {
  ...ResourceNameParameter<
    Resource = Key,
    KeyName = "keyName",
    SegmentName = "keys",
    NamePattern = "^[a-zA-Z0-9-]{1,127}$"
  >;

  /**
   * The supported Azure location where the managed HSM Pool should be created.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

@armResourceOperations
interface KeyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the vault which contains the key to be retrieved. */
        @path
        @segment("vaults")
        @key
        @pattern("^[a-zA-Z0-9-]{3,24}$")
        vaultName: string,
      },
      {
        /** The name of the key to be retrieved. */
        @path
        @segment("keys")
        @key
        @pattern("^[a-zA-Z0-9-]{1,127}$")
        keyName: string,
      }
    > {}

@armResourceOperations
interface Keys {
  /**
   * Gets the current version of the specified key from the specified key vault.
   */
  get is KeyOps.Read<Key, OverrideErrorType = CloudError>;

  /**
   * Creates the first version of a new key if it does not exist. If it already exists, then the existing key is returned without any write operations being performed. This API does not create subsequent versions, and does not update existing keys.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createIfNotExist is KeyOps.CreateOrUpdateSync<
    Key,
    Request = KeyCreateParameters,
    Response = ArmResourceUpdatedResponse<Key>,
    OverrideErrorType = CloudError
  >;

  /**
   * Lists the keys in the specified key vault.
   */
  list is KeyOps.List<Key, OverrideErrorType = CloudError>;
}
@armResourceOperations
interface KeyOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the vault which contains the key version to be retrieved. */
        @path
        @segment("vaults")
        @key
        @pattern("^[a-zA-Z0-9-]{3,24}$")
        vaultName: string,

        /** The name of the key version to be retrieved. */
        @path
        @segment("keys")
        @key
        @pattern("^[a-zA-Z0-9-]{1,127}$")
        keyName: string,
      },
      {
        /** The version of the key to be retrieved. */
        @path
        @segment("versions")
        @key
        @pattern("^[a-fA-F0-9]{32}$")
        keyVersion: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface KeyOperationGroup {
  /**
   * Gets the specified version of the specified key in the specified key vault.
   */
  getVersion is KeyOperationGroupOps.Read<Key, OverrideErrorType = CloudError>;

  /**
   * Lists the keys in the specified key vault.
   */
  listVersions is KeyOperationGroupOps.List<
    Key,
    OverrideErrorType = CloudError
  >;
}

@@doc(Key.name, "The name of the key to be retrieved.");
@@doc(Key.properties, "The properties of the key.");
@@doc(Keys.createIfNotExist::parameters.resource,
  "The parameters used to create the specified key."
);
