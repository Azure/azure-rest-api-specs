import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

@versioned(KeyVault.Versions)
namespace Customizations;

@@clientName(KeyVault, "Key", "java");
@@clientName(KeyVault, "Client", "go");
@@clientName(KeyVault, "Key", "rust");

using KeyVault;

// Make optional path parameter required for all languages

/**
 * In order to perform this operation, the key must already exist in the Key Vault. Note: The cryptographic material of a key itself cannot be changed. This operation requires the keys/update permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("The update key operation changes specified attributes of a stored key and can be applied to any key type and key version stored in Azure Key Vault.")
@route("/keys/{key-name}/{key-version}")
@patch(#{ implicitOptionality: true })
op updateKey is KeyVaultOperation<
  {
    /**
     * The name of key to update.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;

    /**
     * The version of the key to update.
     */
    @path("key-version")
    @clientName("version", "go")
    keyVersion: string;

    /**
     * The parameters of the key to update.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameters: KeyUpdateParameters;
  },
  KeyBundle
>;

/**
 * The get key operation is applicable to all key types. If the requested key is symmetric, then no key material is released in the response. This operation requires the keys/get permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Gets the public part of a stored key.")
@route("/keys/{key-name}/{key-version}")
@get
op getKey is KeyVaultOperation<
  {
    /**
     * The name of the key to get.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;

    /**
     * Adding the version parameter retrieves a specific version of a key. This URI fragment is optional. If not specified, the latest version of the key is returned.
     */
    @path("key-version")
    @clientName("version", "go")
    keyVersion: string;
  },
  KeyBundle
>;

/**
 * The ENCRYPT operation encrypts an arbitrary sequence of bytes using an encryption key that is stored in Azure Key Vault. Note that the ENCRYPT operation only supports a single block of data, the size of which is dependent on the target key and the encryption algorithm to be used. The ENCRYPT operation is only strictly necessary for symmetric keys stored in Azure Key Vault since protection with an asymmetric key can be performed using public portion of the key. This operation is supported for asymmetric keys as a convenience for callers that have a key-reference but do not have access to the public key material. This operation requires the keys/encrypt permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation ID is auto-capitalized, which would be breaking"
@operationId("encrypt")
@summary("Encrypts an arbitrary sequence of bytes using an encryption key that is stored in a key vault.")
@route("/keys/{key-name}/{key-version}/encrypt")
@post
op encrypt is KeyVaultOperation<
  {
    /**
     * The name of the key.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;

    /**
     * The version of the key.
     */
    @path("key-version")
    @clientName("version", "go")
    keyVersion: string;

    /**
     * The parameters for the encryption operation.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameters: KeyOperationsParameters;
  },
  KeyOperationResult
>;

/**
 * The DECRYPT operation decrypts a well-formed block of ciphertext using the target encryption key and specified algorithm. This operation is the reverse of the ENCRYPT operation; only a single block of data may be decrypted, the size of this block is dependent on the target key and the algorithm to be used. The DECRYPT operation applies to asymmetric and symmetric keys stored in Azure Key Vault since it uses the private portion of the key. This operation requires the keys/decrypt permission. Microsoft recommends not to use CBC algorithms for decryption without first ensuring the integrity of the ciphertext using an HMAC, for example. See https://learn.microsoft.com/dotnet/standard/security/vulnerabilities-cbc-mode for more information.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation ID is auto-capitalized, which would be breaking"
@operationId("decrypt")
@summary("Decrypts a single block of encrypted data.")
@route("/keys/{key-name}/{key-version}/decrypt")
@post
op decrypt is KeyVaultOperation<
  {
    /**
     * The name of the key.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;

    /**
     * The version of the key.
     */
    @path("key-version")
    @clientName("version", "go")
    keyVersion: string;

    /**
     * The parameters for the decryption operation.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameters: KeyOperationsParameters;
  },
  KeyOperationResult
>;

/**
 * The SIGN operation is applicable to asymmetric and symmetric keys stored in Azure Key Vault since this operation uses the private portion of the key. This operation requires the keys/sign permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation ID is auto-capitalized, which would be breaking"
@operationId("sign")
@summary("Creates a signature from a digest using the specified key.")
@route("/keys/{key-name}/{key-version}/sign")
@post
op sign is KeyVaultOperation<
  {
    /**
     * The name of the key.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;

    /**
     * The version of the key.
     */
    @path("key-version")
    @clientName("version", "go")
    keyVersion: string;

    /**
     * The parameters for the signing operation.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameters: KeySignParameters;
  },
  KeyOperationResult
>;

/**
 * The VERIFY operation is applicable to symmetric keys stored in Azure Key Vault. VERIFY is not strictly necessary for asymmetric keys stored in Azure Key Vault since signature verification can be performed using the public portion of the key but this operation is supported as a convenience for callers that only have a key-reference and not the public portion of the key. This operation requires the keys/verify permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation ID is auto-capitalized, which would be breaking"
@operationId("verify")
@summary("Verifies a signature using a specified key.")
@route("/keys/{key-name}/{key-version}/verify")
@post
op verify is KeyVaultOperation<
  {
    /**
     * The name of the key.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;

    /**
     * The version of the key.
     */
    @path("key-version")
    @clientName("version", "go")
    keyVersion: string;

    /**
     * The parameters for verify operations.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameters: KeyVerifyParameters;
  },
  KeyVerifyResult
>;

/**
 * The WRAP operation supports encryption of a symmetric key using a key encryption key that has previously been stored in an Azure Key Vault. The WRAP operation is only strictly necessary for symmetric keys stored in Azure Key Vault since protection with an asymmetric key can be performed using the public portion of the key. This operation is supported for asymmetric keys as a convenience for callers that have a key-reference but do not have access to the public key material. This operation requires the keys/wrapKey permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation ID is auto-capitalized, which would be breaking"
@operationId("wrapKey")
@summary("Wraps a symmetric key using a specified key.")
@route("/keys/{key-name}/{key-version}/wrapkey")
@post
op wrapKey is KeyVaultOperation<
  {
    /**
     * The name of the key.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;

    /**
     * The version of the key.
     */
    @path("key-version")
    @clientName("version", "go")
    keyVersion: string;

    /**
     * The parameters for wrap operation.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameters: KeyOperationsParameters;
  },
  KeyOperationResult
>;

/**
 * The UNWRAP operation supports decryption of a symmetric key using the target key encryption key. This operation is the reverse of the WRAP operation. The UNWRAP operation applies to asymmetric and symmetric keys stored in Azure Key Vault since it uses the private portion of the key. This operation requires the keys/unwrapKey permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation ID is auto-capitalized, which would be breaking"
@operationId("unwrapKey")
@summary("Unwraps a symmetric key using the specified key that was initially used for wrapping that key.")
@route("/keys/{key-name}/{key-version}/unwrapkey")
@post
op unwrapKey is KeyVaultOperation<
  {
    /**
     * The name of the key.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;

    /**
     * The version of the key.
     */
    @path("key-version")
    @clientName("version", "go")
    keyVersion: string;

    /**
     * The parameters for the key operation.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameters: KeyOperationsParameters;
  },
  KeyOperationResult
>;

/**
 * The release key operation is applicable to all key types. The target key must be marked exportable. This operation requires the keys/release permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation ID is auto-capitalized, which would be breaking"
@operationId("release")
@summary("Releases a key.")
@route("/keys/{key-name}/{key-version}/release")
@post
op release is KeyVaultOperation<
  {
    /**
     * The name of the key to get.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;

    /**
     * Adding the version parameter retrieves a specific version of a key.
     */
    @path("key-version")
    @clientName("version", "go")
    keyVersion: string;

    /**
     * The parameters for the key release operation.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameters: KeyReleaseParameters;
  },
  KeyReleaseResult
>;

/**
 * The get key attestation operation returns the key along with its attestation blob. This operation requires the keys/get permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@Versioning.added(KeyVault.Versions.`v7.6_preview.2`)
@summary("Gets the public part of a stored key along with its attestation blob.")
@route("/keys/{key-name}/{key-version}/attestation")
@get
op getKeyAttestation is KeyVaultOperation<
  {
    /**
     * The name of the key to retrieve attestation for.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;

    /**
     * Adding the version parameter retrieves attestation blob for specific version of a key. This URI fragment is optional. If not specified, the latest version of the key attestation blob is returned.
     */
    @path("key-version")
    @clientName("version", "go")
    keyVersion: string;
  },
  /**
   * A key bundle containing the key, its attributes and attestation blob.
   */
  KeyBundle
>;

@@override(KeyVault.updateKey, updateKey);
@@override(KeyVault.getKey, getKey);
@@override(KeyVault.encrypt, encrypt);
@@override(KeyVault.decrypt, decrypt);
@@override(KeyVault.sign, sign);
@@override(KeyVault.verify, verify);
@@override(KeyVault.wrapKey, wrapKey);
@@override(KeyVault.unwrapKey, unwrapKey);
@@override(KeyVault.release, release);
@@override(KeyVault.getKeyAttestation, getKeyAttestation);

// Java configuration
@@clientName(KeyEncryptionAlgorithm, "KeyExportEncryptionAlgorithm", "java");
@@clientName(KeyReleaseResult, "ReleaseKeyResult", "java");
@@clientName(JsonWebKeyCurveName.P256, "P_256", "java");
@@clientName(JsonWebKeyCurveName.P384, "P_384", "java");
@@clientName(JsonWebKeyCurveName.P521, "P_521", "java");
@@clientName(JsonWebKeyCurveName.P256_K, "P_256K", "java");
@@clientName(JsonWebKeyCurveName, "KeyCurveName", "java");
@@clientName(JsonWebKeyOperation, "KeyOperation", "java");
@@clientName(JsonWebKeyType, "KeyType", "java");

// Go configuration

/**
 * The full key identifier, attributes, and tags are provided in the response. This operation requires the keys/list permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@summary("Retrieves a list of individual key versions with the same key name.")
@route("/keys/{key-name}/versions")
@get
op listKeyPropertiesVersions is KeyVaultOperation<
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
op listKeyProperties is KeyVaultOperation<{}, KeyListResult>;

/**
 * Retrieves a list of the keys in the Key Vault as JSON Web Key structures that contain the public part of a deleted key. This operation includes deletion-specific information. The Get Deleted Keys operation is applicable for vaults enabled for soft-delete. While the operation can be invoked on any vault, it will return an error if invoked on a non soft-delete enabled vault. This operation requires the keys/list permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@summary("Lists the deleted keys in the specified vault.")
@route("/deletedkeys")
@get
op listDeletedKeyProperties is KeyVaultOperation<{}, DeletedKeyListResult>;

@@override(getKeyVersions, listKeyPropertiesVersions, "go");
@@override(getKeys, listKeyProperties, "go");
@@override(getDeletedKeys, listDeletedKeyProperties, "go");

@@clientName(getDeletedKeys, "ListDeletedKeyProperties", "go");
@@clientName(getKeys, "ListKeyProperties", "go");
@@clientName(getKeyVersions, "ListKeyPropertiesVersions", "go");

// renaming KeyItem to KeyProperties.
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

// Rust configuration
@@clientName(KeyCreateParameters, "CreateKeyParameters", "rust");
@@clientName(KeyExportParameters, "ExportKeyParameters", "rust");
@@clientName(KeyImportParameters, "ImportKeyParameters", "rust");
@@clientName(KeyReleaseParameters, "ReleaseParameters", "rust");
@@clientName(KeyRestoreParameters, "RestoreKeyParameters", "rust");
@@clientName(KeySignParameters, "SignParameters", "rust");
@@clientName(KeyUpdateParameters, "UpdateKeyPropertiesParameters", "rust");
@@clientName(KeyVerifyParameters, "VerifyParameters", "rust");
@@clientName(GetRandomBytesRequest, "GetRandomBytesParameters", "rust");
@@clientName(getDeletedKeys, "ListDeletedKeyProperties", "rust");
@@clientName(getKeys, "ListKeyProperties", "rust");
@@clientName(getKeyVersions, "ListKeyPropertiesVersions", "rust");
@@clientName(DeletedKeyBundle, "DeletedKey", "rust");
@@clientName(KeyBundle, "Key", "rust");
@@clientName(KeyProperties, "OmitKeyProperties", "rust");
@@clientName(KeyItem, "KeyProperties", "rust");
@@clientName(DeletedKeyItem, "DeletedKeyProperties", "rust");
@@clientName(DeletedKeyListResult, "ListDeletedKeyPropertiesResult", "rust");
@@clientName(KeyListResult, "ListKeyPropertiesResult", "rust");
@@clientName(LifetimeActions, "LifetimeAction", "rust");
@@clientName(LifetimeActionsType, "LifetimeActionType", "rust");
@@clientName(LifetimeActionsTrigger, "LifetimeActionTrigger", "rust");
@@clientName(KeyRestoreParameters.keyBundleBackup, "KeyBackup", "rust");
@@clientName(KeyOperationsParameters, "KeyOperationParameters", "rust");

@@clientName(getDeletedKeys, "ListDeletedKeyProperties", "rust");
@@clientName(getKeys, "ListKeyProperties", "rust");
@@clientName(getKeyVersions, "ListKeyPropertiesVersions", "rust");
@@clientName(updateKey, "UpdateKeyProperties", "rust");

@@clientName(KeyReleaseParameters.enc, "algorithm", "rust");
@@clientName(KeyOperationsParameters.aad,
  "AdditionalAuthenticatedData",
  "rust"
);
@@clientName(KeyOperationsParameters.tag, "AuthenticationTag", "rust");

@@clientName(JsonWebKeyType, "KeyType", "rust");
@@clientName(JsonWebKeyOperation, "KeyOperation", "rust");
@@clientName(JsonWebKeyEncryptionAlgorithm, "EncryptionAlgorithm", "rust");
@@clientName(JsonWebKeyCurveName, "CurveName", "rust");
@@clientName(JsonWebKeySignatureAlgorithm, "SignatureAlgorithm", "rust");
