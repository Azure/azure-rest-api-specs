import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;

@versioned(KeyVault.Versions)
namespace Customizations;

@@clientName(KeyVault, "KeyClient", "java");
@@clientName(KeyVault, "Client", "go");
@@clientName(KeyVault, "Key", "rust");

using KeyVault;

// Make optional path parameter required for all languages

/** A required key version parameter. */
model RequiredKeyVersionParameter {
  /**
   * The version of the key.
   */
  @path("key-version")
  @clientName("version", "go")
  keyVersion: string;
}

/** A required key version parameter for decrypt operations. */
model RequiredDecryptKeyVersionParameter {
  /**
   * The version of the key.
   */
  #suppress "@azure-tools/typespec-client-generator-core/client-option" "Allow empty string to use latest key version"
  @path("key-version")
  @clientName("version", "go")
  @clientDoc(
    "The version is required and should be recorded when encrypting so you can reliably decrypt using the same version. You can pass an empty string to select the latest key version but if you don't record the specific version used for encryption, key rotation can make the data inaccessible.",
    DocumentationMode.append,
    "rust"
  )
  @clientOption("minLength", 0, "rust")
  keyVersion: string;
}

/** A required key version parameter for verify operations. */
model RequiredVerifyKeyVersionParameter {
  /**
   * The version of the key.
   */
  #suppress "@azure-tools/typespec-client-generator-core/client-option" "Allow empty string to use latest key version"
  @path("key-version")
  @clientName("version", "go")
  @clientDoc(
    "The version is required and should be recorded when signing so you can reliably verify using the same version. You can pass an empty string to select the latest key version but if you don't record the specific version used for signing, key rotation can make the data unverifiable.",
    DocumentationMode.append,
    "rust"
  )
  @clientOption("minLength", 0, "rust")
  keyVersion: string;
}

/** A required key version parameter for unwrap operations. */
model RequiredUnwrapKeyVersionParameter {
  /**
   * The version of the key.
   */
  #suppress "@azure-tools/typespec-client-generator-core/client-option" "Allow empty string to use latest key version"
  @path("key-version")
  @clientName("version", "go")
  @clientDoc(
    "The version is required and should be recorded when wrapping a data encryption key so you can reliably unwrap using the same version. You can pass an empty string to select the latest key version but if you don't record the specific version used for wrapping a key, key encryption key rotation can make the data inaccessible.",
    DocumentationMode.append,
    "rust"
  )
  @clientOption("minLength", 0, "rust")
  keyVersion: string;
}

@@override(
  KeyVault.updateKey,
  replaceParameter(
    KeyVault.updateKey,
    "keyVersion",
    RequiredKeyVersionParameter.keyVersion
  ),
  "!rust"
);
@@override(
  KeyVault.getKey,
  replaceParameter(
    KeyVault.getKey,
    "keyVersion",
    RequiredKeyVersionParameter.keyVersion
  ),
  "!rust"
);
// Rust follows the service definition for optional versions but will consistently promote the version for decrypt, verify, and unwrapKey operations.
// Not using (and storing) an explicit version for crypto operations is dangerous and can lock applications out of their data.
@@override(
  KeyVault.encrypt,
  replaceParameter(
    KeyVault.encrypt,
    "keyVersion",
    RequiredKeyVersionParameter.keyVersion
  ),
  "!rust"
);
@@override(
  KeyVault.decrypt,
  replaceParameter(
    KeyVault.decrypt,
    "keyVersion",
    RequiredDecryptKeyVersionParameter.keyVersion
  )
);
@@override(
  KeyVault.sign,
  replaceParameter(
    KeyVault.sign,
    "keyVersion",
    RequiredKeyVersionParameter.keyVersion
  ),
  "!rust"
);
@@override(
  KeyVault.verify,
  replaceParameter(
    KeyVault.verify,
    "keyVersion",
    RequiredVerifyKeyVersionParameter.keyVersion
  )
);
@@override(
  KeyVault.wrapKey,
  replaceParameter(
    KeyVault.wrapKey,
    "keyVersion",
    RequiredKeyVersionParameter.keyVersion
  ),
  "!rust"
);
@@override(
  KeyVault.unwrapKey,
  replaceParameter(
    KeyVault.unwrapKey,
    "keyVersion",
    RequiredUnwrapKeyVersionParameter.keyVersion
  )
);
@@override(
  KeyVault.secureWrapKey,
  replaceParameter(
    KeyVault.secureWrapKey,
    "keyVersion",
    RequiredKeyVersionParameter.keyVersion
  ),
  "!rust"
);
@@override(
  KeyVault.secureUnwrapKey,
  replaceParameter(
    KeyVault.secureUnwrapKey,
    "keyVersion",
    RequiredUnwrapKeyVersionParameter.keyVersion
  )
);
@@override(
  KeyVault.release,
  replaceParameter(
    KeyVault.release,
    "keyVersion",
    RequiredKeyVersionParameter.keyVersion
  ),
  "!rust"
);
@@override(
  KeyVault.getKeyAttestation,
  replaceParameter(
    KeyVault.getKeyAttestation,
    "keyVersion",
    RequiredKeyVersionParameter.keyVersion
  ),
  "!rust"
);

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

@@override(
  getKeyVersions,
  removeParameter(getKeyVersions, "maxresults"),
  "go"
);
@@override(getKeys, removeParameter(getKeys, "maxresults"), "go");
@@override(
  getDeletedKeys,
  removeParameter(getDeletedKeys, "maxresults"),
  "go"
);

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

@@alternateType(JsonWebKey.keyOps, JsonWebKeyOperation[], "go");
@@alternateType(KeyAttributes.recoveryLevel, string, "go");

// JS configuration
@@clientName(JsonWebKeyCurveName.P256_K, "P256K", "javascript");
@@clientName(JsonWebKeySignatureAlgorithm.RSNULL, "Rsnull", "javascript");
@@clientName(JsonWebKeySignatureAlgorithm.ES256_K, "ES256K", "javascript");
@@clientName(JsonWebKeyEncryptionAlgorithm.RSA_OAEP, "RSAOaep", "javascript");
@@clientName(
  JsonWebKeyEncryptionAlgorithm.RSA_OAEP256,
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
@@clientName(
  JsonWebKeyEncryptionAlgorithm.A128_CBCPAD,
  "A128Cbcpad",
  "javascript"
);
@@clientName(
  JsonWebKeyEncryptionAlgorithm.A192_CBCPAD,
  "A192Cbcpad",
  "javascript"
);
@@clientName(
  JsonWebKeyEncryptionAlgorithm.A256_CBCPAD,
  "A256Cbcpad",
  "javascript"
);
@@clientName(
  JsonWebKeyEncryptionAlgorithm.CKM_AES_KEY_WRAP,
  "CkmAesKeyWrap",
  "javascript"
);
@@clientName(
  JsonWebKeyEncryptionAlgorithm.CKM_AES_KEY_WRAP_PAD,
  "CkmAesKeyWrapPad",
  "javascript"
);
@@clientName(JsonWebKeyType.EC_HSM, "ECHSM", "javascript");
@@clientName(JsonWebKeyType.RSA_HSM, "RSAHSM", "javascript");
@@clientName(JsonWebKeyType.oct_HSM, "OctHSM", "javascript");
@@clientName(JsonWebKeyType.oct, "Oct", "javascript");
@@clientName(
  KeyEncryptionAlgorithm.CKM_RSA_AES_KEY_WRAP,
  "CkmRsaAesKeyWrap",
  "javascript"
);
@@clientName(
  KeyEncryptionAlgorithm.RSA_AES_KEY_WRAP_256,
  "RsaAesKeyWrap256",
  "javascript"
);
@@clientName(
  KeyEncryptionAlgorithm.RSA_AES_KEY_WRAP_384,
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
// Work around issue where previous @override prevent the following line from working without "KeyVault." prefix.
@@clientName(KeyVault.updateKey, "UpdateKeyProperties", "rust");
@@clientDoc(
  KeyVault.encrypt,
  """
    
    You should record the ['KeyOperationResult::kid`] that is returned by this operation
    so you can later parse it with [`ResourceId`](crate::ResourceId) and pass the version to [`KeyClient::decrypt()`].
    You can pass an empty string for the version to `decrypt()` to select the latest key version
    but if you don't record the specific version used for encrypting, key rotation can make the data inaccessible.
    """,
  DocumentationMode.append,
  "rust"
);
@@clientDoc(
  KeyVault.sign,
  """
    
    You should record the ['KeyOperationResult::kid`] that is returned by this operation
    so you can later parse it with [`ResourceId`](crate::ResourceId) and pass the version to [`KeyClient::verify()`].
    You can pass an empty string for the version to `verify()` to select the latest key version
    but if you don't record the specific version used for signing, key rotation can make the data unverifiable.
    """,
  DocumentationMode.append,
  "rust"
);
@@clientDoc(
  KeyVault.wrapKey,
  """
    
    You should record the ['KeyOperationResult::kid`] that is returned by this operation
    so you can later parse it with [`ResourceId`](crate::ResourceId) and pass the version to [`KeyClient::unwrap_key()`].
    You can pass an empty string for the version to `unwrap_key()` to select the latest key version
    but if you don't record the specific version used for wrapping a key, key rotation can make the data inaccessible.
    """,
  DocumentationMode.append,
  "rust"
);
@@clientDoc(
  KeyVault.secureWrapKey,
  """
    
    You should record the ['KeyOperationResult::kid`] that is returned by this operation
    so you can later parse it with [`ResourceId`](crate::ResourceId) and pass the version to [`KeyClient::secure_unwrap_key()`].
    You can pass an empty string for the version to `secure_unwrap_key()` to select the latest key version
    but if you don't record the specific version used for wrapping a key, key rotation can make the data inaccessible.
    """,
  DocumentationMode.append,
  "rust"
);

@@clientDoc(
  KeyOperationResult.kid,
  """
    
    You should record this when returned from [`KeyClient::encrypt()`](crate::KeyClient::encrypt), [`sign()`](crate::KeyClient::sign),
    and [`wrap_key()`](crate::KeyClient::wrap_key) so you can later parse it with [`ResourceId`](crate::ResourceId)
    and pass the version to [`decrypt()`](crate::KeyClient::decrypt), [`verify()`](crate::KeyClient::verify),
    and [`unwrap_key()`](crate::KeyClient::unwrap_key).
    You can pass an empty string for the version to those functions to select the latest key version
    but if you don't record the specific version used encrypting, signing, or wrapping a key, key rotation can make the data inaccessible.
    """,
  DocumentationMode.append,
  "rust"
);

@@clientName(KeyReleaseParameters.enc, "algorithm", "rust");
@@clientName(
  KeyOperationsParameters.aad,
  "AdditionalAuthenticatedData",
  "rust"
);
@@clientName(KeyOperationsParameters.tag, "AuthenticationTag", "rust");

@@clientName(JsonWebKeyType, "KeyType", "rust");
@@clientName(JsonWebKeyOperation, "KeyOperation", "rust");
@@clientName(JsonWebKeyEncryptionAlgorithm, "EncryptionAlgorithm", "rust");
@@clientName(JsonWebKeyCurveName, "CurveName", "rust");
@@clientName(JsonWebKeySignatureAlgorithm, "SignatureAlgorithm", "rust");
