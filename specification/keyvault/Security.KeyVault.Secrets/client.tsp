import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(KeyVault, "Client", "go");
@@clientName(KeyVault, "Secret", "java");
@@clientName(KeyVault, "Secret", "rust");

using KeyVault;

// renaming SecretItem to SecretProperties.
// renaming existing SecretProperties to something else
// to avoid a naming conflict as it's not part of the public surface area
@@clientName(SecretProperties, "ShouldNotGenerate", "go");
@@clientName(SecretItem, "SecretProperties", "go");

@@clientName(DeletedSecretBundle, "DeletedSecret", "go");
@@clientName(DeletedSecretItem, "DeletedSecretProperties", "go");
@@clientName(SecretBundle, "Secret", "go");
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

// Rust configuration
@@clientName(SecretProperties, "OmitSecretProperties", "rust");
@@clientName(SecretItem, "SecretProperties", "rust");

@@clientName(DeletedSecretBundle, "DeletedSecret", "rust");
@@clientName(DeletedSecretItem, "DeletedSecretProperties", "rust");
@@clientName(SecretBundle, "Secret", "rust");
@@clientName(SecretRestoreParameters, "RestoreSecretParameters", "rust");
@@clientName(SecretSetParameters, "SetSecretParameters", "rust");
@@clientName(SecretUpdateParameters,
  "UpdateSecretPropertiesParameters",
  "rust"
);
@@clientName(DeletedSecretListResult,
  "ListDeletedSecretPropertiesResult",
  "rust"
);
@@clientName(SecretListResult, "ListSecretPropertiesResult", "rust");

@@clientName(getDeletedSecrets, "ListDeletedSecretProperties", "rust");
@@clientName(getSecrets, "ListSecretProperties", "rust");
@@clientName(getSecretVersions, "ListSecretPropertiesVersions", "rust");
@@clientName(updateSecret, "UpdateSecretProperties", "rust");

@@clientName(SecretRestoreParameters.secretBundleBackup,
  "SecretBackup",
  "rust"
);
