import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(KeyVault, "Client", "go");
@@clientName(KeyVault, "Secret", "java");
@@clientName(KeyVault, "Secret", "rust");

using KeyVault;

@@clientName(SecretProperties, "SecretP", "go");
@@clientName(DeletedSecretBundle, "DeletedSecret", "go");
@@clientName(DeletedSecretItem, "DeletedSecretProperties", "go");
@@clientName(SecretBundle, "Secret", "go");
@@clientName(SecretItem, "SecretProperties", "go");
@@clientName(SecretRestoreParameters, "RestoreSecretParameters", "go");
@@clientName(SecretSetParameters, "SetSecretParameters", "go");
@@clientName(SecretUpdateParameters, "UpdateSecretPropertiesParameters", "go");
@@clientName(DeletedSecretListResult,
  "DeletedSecretPropertiesListResult",
  "go"
);
@@clientName(SecretListResult, "SecretPropertiesListResult", "go");

@@clientName(getDeletedSecrets, "ListDeletedSecretProperties", "go");
@@clientName(getSecrets, "ListSecretProperties", "go");
@@clientName(getSecretVersions, "ListSecretPropertiesVersions", "go");
@@clientName(updateSecret, "UpdateSecretProperties", "go");

@@clientName(SecretRestoreParameters.secretBundleBackup, "SecretBackup", "go");
@@clientName(SecretBundle.kid, "KID", "go");
