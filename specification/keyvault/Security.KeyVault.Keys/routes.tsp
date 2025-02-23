import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Security.KeyVault.Common/common.tsp";

using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

namespace KeyVault;

/**
 * The create key operation can be used to create any key type in Azure Key Vault. If the named key already exists, Azure Key Vault creates a new version of the key. It requires the keys/create permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Creates a new key, stores it, then returns key parameters and attributes to the client.")
@route("/keys/{key-name}/create")
@post
op createKey is KeyVaultOperation<
  {
    /**
     * The name for the new key. The system will generate the version name for the new key. The value you provide may be copied globally for the purpose of running the service. The value provided should not include personally identifiable or sensitive information.
     */
    @pattern("^[0-9a-zA-Z-]+$")
    @path("key-name")
    @clientName("name", "go")
    keyName: string;

    /**
     * The parameters to create a key.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameters: KeyCreateParameters;
  },
  KeyBundle
>;

/**
 * The operation will rotate the key based on the key policy. It requires the keys/rotate permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Creates a new key version, stores it, then returns key parameters, attributes and policy to the client.")
@route("/keys/{key-name}/rotate")
@post
op rotateKey is KeyVaultOperation<
  {
    /**
     * The name of key to be rotated. The system will generate a new version in the specified key.
     */
    @pattern("^[0-9a-zA-Z-]+$")
    @path("key-name")
    @clientName("name", "go")
    keyName: string;
  },
  KeyBundle
>;

/**
 * The import key operation may be used to import any key type into an Azure Key Vault. If the named key already exists, Azure Key Vault creates a new version of the key. This operation requires the keys/import permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@summary("Imports an externally created key, stores it, and returns key parameters and attributes to the client.")
@route("/keys/{key-name}")
@put
op importKey is KeyVaultOperation<
  {
    /**
     * Name for the imported key. The value you provide may be copied globally for the purpose of running the service. The value provided should not include personally identifiable or sensitive information.
     */
    @pattern("^[0-9a-zA-Z-]+$")
    @path("key-name")
    @clientName("name", "go")
    keyName: string;

    /**
     * The parameters to import a key.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameters: KeyImportParameters;
  },
  KeyBundle
>;

/**
 * The delete key operation cannot be used to remove individual versions of a key. This operation removes the cryptographic material associated with the key, which means the key is not usable for Sign/Verify, Wrap/Unwrap or Encrypt/Decrypt operations. This operation requires the keys/delete permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Deletes a key of any type from storage in Azure Key Vault.")
@route("/keys/{key-name}")
@delete
op deleteKey is KeyVaultOperation<
  {
    /**
     * The name of the key to delete.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;
  },
  DeletedKeyBundle
>;

/**
 * In order to perform this operation, the key must already exist in the Key Vault. Note: The cryptographic material of a key itself cannot be changed. This operation requires the keys/update permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("The update key operation changes specified attributes of a stored key and can be applied to any key type and key version stored in Azure Key Vault.")
@route("/keys/{key-name}/{key-version}")
@patch
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
 * The full key identifier, attributes, and tags are provided in the response. This operation requires the keys/list permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@summary("Retrieves a list of individual key versions with the same key name.")
@route("/keys/{key-name}/versions")
@get
op getKeyVersions is KeyVaultOperation<
  {
    /**
     * The name of the key.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;

    /**
     * Maximum number of results to return in a page. If not specified the service will return up to 25 results.
     */
    @maxValue(25)
    @minValue(1)
    @query("maxresults")
    maxresults?: int32;
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
op getKeys is KeyVaultOperation<
  {
    /**
     * Maximum number of results to return in a page. If not specified the service will return up to 25 results.
     */
    @maxValue(25)
    @minValue(1)
    @query("maxresults")
    maxresults?: int32;
  },
  KeyListResult
>;

/**
 * The Key Backup operation exports a key from Azure Key Vault in a protected form. Note that this operation does NOT return key material in a form that can be used outside the Azure Key Vault system, the returned key material is either protected to a Azure Key Vault HSM or to Azure Key Vault itself. The intent of this operation is to allow a client to GENERATE a key in one Azure Key Vault instance, BACKUP the key, and then RESTORE it into another Azure Key Vault instance. The BACKUP operation may be used to export, in protected form, any key type from Azure Key Vault. Individual versions of a key cannot be backed up. BACKUP / RESTORE can be performed within geographical boundaries only; meaning that a BACKUP from one geographical area cannot be restored to another geographical area. For example, a backup from the US geographical area cannot be restored in an EU geographical area. This operation requires the key/backup permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Requests that a backup of the specified key be downloaded to the client.")
@route("/keys/{key-name}/backup")
@post
op backupKey is KeyVaultOperation<
  {
    /**
     * The name of the key.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;
  },
  BackupKeyResult
>;

/**
 * Imports a previously backed up key into Azure Key Vault, restoring the key, its key identifier, attributes and access control policies. The RESTORE operation may be used to import a previously backed up key. Individual versions of a key cannot be restored. The key is restored in its entirety with the same key name as it had when it was backed up. If the key name is not available in the target Key Vault, the RESTORE operation will be rejected. While the key name is retained during restore, the final key identifier will change if the key is restored to a different vault. Restore will restore all versions and preserve version identifiers. The RESTORE operation is subject to security constraints: The target Key Vault must be owned by the same Microsoft Azure Subscription as the source Key Vault The user must have RESTORE permission in the target Key Vault. This operation requires the keys/restore permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Restores a backed up key to a vault.")
@route("/keys/restore")
@post
op restoreKey is KeyVaultOperation<
  {
    /** The parameters to restore the key. */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameters: KeyRestoreParameters;
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
 * Retrieves a list of the keys in the Key Vault as JSON Web Key structures that contain the public part of a deleted key. This operation includes deletion-specific information. The Get Deleted Keys operation is applicable for vaults enabled for soft-delete. While the operation can be invoked on any vault, it will return an error if invoked on a non soft-delete enabled vault. This operation requires the keys/list permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@summary("Lists the deleted keys in the specified vault.")
@route("/deletedkeys")
@get
op getDeletedKeys is KeyVaultOperation<
  {
    /**
     * Maximum number of results to return in a page. If not specified the service will return up to 25 results.
     */
    @maxValue(25)
    @minValue(1)
    @query("maxresults")
    maxresults?: int32;
  },
  DeletedKeyListResult
>;

/**
 * The Get Deleted Key operation is applicable for soft-delete enabled vaults. While the operation can be invoked on any vault, it will return an error if invoked on a non soft-delete enabled vault. This operation requires the keys/get permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Gets the public part of a deleted key.")
@route("/deletedkeys/{key-name}")
@get
op getDeletedKey is KeyVaultOperation<
  {
    /**
     * The name of the key.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;
  },
  DeletedKeyBundle
>;

/**
 * The Purge Deleted Key operation is applicable for soft-delete enabled vaults. While the operation can be invoked on any vault, it will return an error if invoked on a non soft-delete enabled vault. This operation requires the keys/purge permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@summary("Permanently deletes the specified key.")
@route("/deletedkeys/{key-name}")
@delete
op purgeDeletedKey is KeyVaultOperation<
  {
    /**
     * The name of the key
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;
  },
  void
>;

/**
 * The Recover Deleted Key operation is applicable for deleted keys in soft-delete enabled vaults. It recovers the deleted key back to its latest version under /keys. An attempt to recover an non-deleted key will return an error. Consider this the inverse of the delete operation on soft-delete enabled vaults. This operation requires the keys/recover permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Recovers the deleted key to its latest version.")
@route("/deletedkeys/{key-name}/recover")
@post
op recoverDeletedKey is KeyVaultOperation<
  {
    /**
     * The name of the deleted key.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;
  },
  KeyBundle
>;

/**
 * The GetKeyRotationPolicy operation returns the specified key policy resources in the specified key vault. This operation requires the keys/get permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Lists the policy for a key.")
@route("/keys/{key-name}/rotationpolicy")
@get
op getKeyRotationPolicy is KeyVaultOperation<
  {
    /**
     * The name of the key in a given key vault.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;
  },
  KeyRotationPolicy
>;

/**
 * Set specified members in the key policy. Leave others as undefined. This operation requires the keys/update permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@summary("Updates the rotation policy for a key.")
@route("/keys/{key-name}/rotationpolicy")
@put
op updateKeyRotationPolicy is KeyVaultOperation<
  {
    /**
     * The name of the key in the given vault.
     */
    @path("key-name")
    @clientName("name", "go")
    keyName: string;

    /**
     * The policy for the key.
     */
    @body
    keyRotationPolicy: KeyRotationPolicy;
  },
  KeyRotationPolicy
>;

/**
 * Get the requested number of bytes containing random values from a managed HSM.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Get the requested number of bytes containing random values.")
@route("/rng")
@post
op getRandomBytes is KeyVaultOperation<
  {
    /** The request object to get random bytes. */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameters: GetRandomBytesRequest;
  },
  RandomBytes
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
