import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Security.KeyVault.Common/common.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;

@TypeSpec.Versioning.useDependency(KeyVault.Versions.`v7.5`)
@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace ClientCustomizations;

@@clientName(KeyVault, "Key", "java");
@@clientName(KeyVault, "Client", "go");
@@clientName(KeyVault, "Key", "rust");

using KeyVault;

// Java configuration
@@clientName(KeyEncryptionAlgorithm, "KeyExportEncryptionAlgorithm", "java");
@@clientName(KeyReleaseResult, "ReleaseKeyResult", "java");
@@clientName(JsonWebKeyCurveName, "KeyCurveName", "java");
@@clientName(JsonWebKeyOperation, "KeyOperation", "java");
@@clientName(JsonWebKeyType, "KeyType", "java");

// Go configuration

/**
 * The key vault client performs cryptographic key operations and vault operations against the Key Vault service.
 */
@client(
  {
    name: "Client",
    service: KeyVault,
  },
  "go"
)
interface Client {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createKey is createKey;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  rotateKey is rotateKey;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  importKey is importKey;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteKey is deleteKey;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateKey is updateKey;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getKey is getKey;
  /**
   * The full key identifier, attributes, and tags are provided in the response. This operation requires the keys/list permission.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  @summary("Retrieves a list of individual key versions with the same key name.")
  @route("/keys/{key-name}/versions")
  @get
  listKeyPropertiesVersions is KeyVaultOperation<
    {
      /**
       * The name of the key.
       */
      @path("key-name")
      @clientName("name", "go")
      keyName: string;
    },
    KeyListResult
  >;
  /**
   * Retrieves a list of the keys in the Key Vault as JSON Web Key structures that contain the public part of a stored key. The LIST operation is applicable to all key types, however only the base key identifier, attributes, and tags are provided in the response. Individual versions of a key are not listed in the response. This operation requires the keys/list permission.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  @summary("List keys in the specified vault.")
  @route("/keys")
  @get
  listKeyProperties is KeyVaultOperation<{}, KeyListResult>;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  backupKey is backupKey;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  restoreKey is restoreKey;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  encrypt is encrypt;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  decrypt is decrypt;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  sign is sign;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  verify is verify;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  wrapKey is wrapKey;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  unwrapKey is unwrapKey;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  release is release;
  /**
   * Retrieves a list of the keys in the Key Vault as JSON Web Key structures that contain the public part of a deleted key. This operation includes deletion-specific information. The Get Deleted Keys operation is applicable for vaults enabled for soft-delete. While the operation can be invoked on any vault, it will return an error if invoked on a non soft-delete enabled vault. This operation requires the keys/list permission.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  @summary("Lists the deleted keys in the specified vault.")
  @route("/deletedkeys")
  @get
  listDeletedKeyProperties is KeyVaultOperation<{}, DeletedKeyListResult>;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getDeletedKey is getDeletedKey;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  purgeDeletedKey is purgeDeletedKey;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  recoverDeletedKey is recoverDeletedKey;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getKeyRotationPolicy is getKeyRotationPolicy;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  updateKeyRotationPolicy is updateKeyRotationPolicy;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getRandomBytes is getRandomBytes;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getKeyAttestation is getKeyAttestation;
}

// renaming Keytem to KeyProperties.
// renaming existing KeyProperties to something else
// to avoid a naming conflict as it's not part of the public surface area
@@clientName(KeyProperties, "ShouldNotGenerate", "go");
@@clientName(KeyItem, "KeyProperties", "go");

@@clientName(KeyCreateParameters, "CreateKeyParameters", "go");
@@clientName(KeyExportParameters, "ExportKeyParameters", "go");
@@clientName(KeyImportParameters, "ImportKeyParameters", "go");
@@clientName(KeyReleaseParameters, "ReleaseParameters", "go");
@@clientName(KeyRestoreParameters, "RestoreKeyParameters", "go");
@@clientName(KeySignParameters, "SignParameters", "go");
@@clientName(KeyUpdateParameters, "UpdateKeyParameters", "go");
@@clientName(KeyVerifyParameters, "VerifyParameters", "go");
@@clientName(GetRandomBytesRequest, "GetRandomBytesParameters", "go");

@@clientName(DeletedKeyBundle, "DeletedKey", "go");
@@clientName(DeletedKeyItem, "DeletedKeyProperties", "go");
@@clientName(DeletedKeyListResult, "DeletedKeyPropertiesListResult", "go");
@@clientName(KeyListResult, "KeyPropertiesListResult", "go");
@@clientName(LifetimeActions, "LifetimeAction", "go");
@@clientName(LifetimeActionsType, "LifetimeActionType", "go");
@@clientName(LifetimeActionsTrigger, "LifetimeActionTrigger", "go");
@@clientName(KeyAttributes.hsmPlatform, "HSMPlatform", "go");
@@clientName(KeyRestoreParameters.keyBundleBackup, "KeyBackup", "go");
@@clientName(KeyOperationsParameters, "KeyOperationParameters", "go");

@@clientName(KeyImportParameters.hsm, "HSM", "go");
@@clientName(KeyReleaseParameters.enc, "algorithm", "go");
@@clientName(KeyOperationsParameters.aad, "AdditionalAuthenticatedData", "go");
@@clientName(KeyOperationsParameters.tag, "AuthenticationTag", "go");

@@clientName(JsonWebKeyType, "KeyType", "go");
@@clientName(JsonWebKeyOperation, "KeyOperation", "go");
@@clientName(JsonWebKeyEncryptionAlgorithm, "EncryptionAlgorithm", "go");
@@clientName(JsonWebKeyCurveName, "CurveName", "go");
@@clientName(JsonWebKeySignatureAlgorithm, "SignatureAlgorithm", "go");

@@clientName(JsonWebKey.kid, "KID", "go");
@@clientName(KeyItem.kid, "KID", "go");
@@clientName(KeyOperationResult.kid, "KID", "go");
@@clientName(KeyOperationsParameters.iv, "IV", "go");
@@clientName(KeyOperationResult.iv, "IV", "go");

@@clientName(JsonWebKey.dp, "DP", "go");
@@clientName(JsonWebKey.dq, "DQ", "go");
@@clientName(JsonWebKey.qi, "QI", "go");

@@clientName(KeyAttestation.certificatePemFile, "CertificatePEMFile", "go");

// JS configuration
@@clientName(JsonWebKeyCurveName.P256_K, "P256K", "javascript");
@@clientName(JsonWebKeySignatureAlgorithm.RSNULL, "Rsnull", "javascript");
@@clientName(JsonWebKeySignatureAlgorithm.ES256_K, "ES256K", "javascript");
@@clientName(JsonWebKeyEncryptionAlgorithm.RSA_OAEP, "RSAOaep", "javascript");
@@clientName(JsonWebKeyEncryptionAlgorithm.RSA_OAEP256,
  "RSAOaep256",
  "javascript"
);
@@clientName(JsonWebKeyEncryptionAlgorithm.RSA1_5, "RSA15", "javascript");
@@clientName(JsonWebKeyEncryptionAlgorithm.A128_GCM, "A128GCM", "javascript");
@@clientName(JsonWebKeyEncryptionAlgorithm.A192_GCM, "A192GCM", "javascript");
@@clientName(JsonWebKeyEncryptionAlgorithm.A256_GCM, "A256GCM", "javascript");
@@clientName(JsonWebKeyEncryptionAlgorithm.A128_KW, "A128KW", "javascript");
@@clientName(JsonWebKeyEncryptionAlgorithm.A192_KW, "A192KW", "javascript");
@@clientName(JsonWebKeyEncryptionAlgorithm.A256_KW, "A256KW", "javascript");
@@clientName(JsonWebKeyEncryptionAlgorithm.A128_CBC, "A128CBC", "javascript");
@@clientName(JsonWebKeyEncryptionAlgorithm.A192_CBC, "A192CBC", "javascript");
@@clientName(JsonWebKeyEncryptionAlgorithm.A256_CBC, "A256CBC", "javascript");
@@clientName(JsonWebKeyEncryptionAlgorithm.A128_CBCPAD,
  "A128Cbcpad",
  "javascript"
);
@@clientName(JsonWebKeyEncryptionAlgorithm.A192_CBCPAD,
  "A192Cbcpad",
  "javascript"
);
@@clientName(JsonWebKeyEncryptionAlgorithm.A256_CBCPAD,
  "A256Cbcpad",
  "javascript"
);
@@clientName(JsonWebKeyEncryptionAlgorithm.CKM_AES_KEY_WRAP,
  "CkmAesKeyWrap",
  "javascript"
);
@@clientName(JsonWebKeyEncryptionAlgorithm.CKM_AES_KEY_WRAP_PAD,
  "CkmAesKeyWrapPad",
  "javascript"
);
@@clientName(JsonWebKeyType.EC_HSM, "ECHSM", "javascript");
@@clientName(JsonWebKeyType.RSA_HSM, "RSAHSM", "javascript");
@@clientName(JsonWebKeyType.oct_HSM, "OctHSM", "javascript");
@@clientName(JsonWebKeyType.oct, "Oct", "javascript");
@@clientName(KeyEncryptionAlgorithm.CKM_RSA_AES_KEY_WRAP,
  "CkmRsaAesKeyWrap",
  "javascript"
);
@@clientName(KeyEncryptionAlgorithm.RSA_AES_KEY_WRAP_256,
  "RsaAesKeyWrap256",
  "javascript"
);
@@clientName(KeyEncryptionAlgorithm.RSA_AES_KEY_WRAP_384,
  "RsaAesKeyWrap384",
  "javascript"
);
