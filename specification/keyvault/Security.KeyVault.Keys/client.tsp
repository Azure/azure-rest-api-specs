import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(KeyVault, "Key", "java");
@@clientName(KeyVault, "Client", "go");
@@clientName(KeyVault, "Key", "rust");

using KeyVault;

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
@@clientName(KeyCreateParameters, "CreateKeyParameters", "go");
@@clientName(KeyExportParameters, "ExportKeyParameters", "go");
@@clientName(KeyImportParameters, "ImportKeyParameters", "go");
@@clientName(KeyReleaseParameters, "ReleaseParameters", "go");
@@clientName(KeyRestoreParameters, "RestoreKeyParameters", "go");
@@clientName(KeySignParameters, "SignParameters", "go");
@@clientName(KeyUpdateParameters, "UpdateKeyParameters", "go");
@@clientName(KeyVerifyParameters, "VerifyParameters", "go");
@@clientName(GetRandomBytesRequest, "GetRandomBytesParameters", "go");
@@clientName(getDeletedKeys, "ListDeletedKeyProperties", "go");
@@clientName(getKeys, "ListKeyProperties", "go");
@@clientName(getKeyVersions, "ListKeyPropertiesVersions", "go");
@@clientName(DeletedKeyBundle, "DeletedKey", "go");
@@clientName(KeyProperties, "KeyP", "go");
@@clientName(KeyItem, "KeyProperties", "go");
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
