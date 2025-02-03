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
