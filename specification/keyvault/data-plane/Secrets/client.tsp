import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;

@versioned(KeyVault.Versions)
namespace Customizations;

@@clientName(KeyVault, "SecretClient", "java");
@@clientName(KeyVault, "Secret", "rust");
@@clientName(KeyVault, "Client", "go");

// C# customizations: the public Key Vault Secrets surface in .NET is the
// hand-written `SecretClient`, so the generated low-level transport is renamed
// to avoid colliding with the user-facing types. The TypeSpec emitter places
// these in the same namespace, and an internal handwritten `SecretAttributes`
// struct already exists in `Azure.Security.KeyVault.Secrets`. Renaming the
// wire model for C# only keeps the .NET source tree compilable while leaving
// every other language unaffected.
@@clientName(KeyVault, "KeyVaultSecretsClient", "csharp");
@@clientName(SecretAttributes, "SecretAttributesBundle", "csharp");

@@access(KeyVault, Access.internal, "csharp");

using KeyVault;

/** A required secret version parameter. */
model RequiredSecretVersionParameter {
  /**
   * The version of the secret.
   */
  @path("secret-version")
  @clientName("version", "go")
  secretVersion: string;
}

@@override(
  KeyVault.updateSecret,
  replaceParameter(
    KeyVault.updateSecret,
    "secretVersion",
    RequiredSecretVersionParameter.secretVersion
  ),
  "!rust"
);
@@override(
  KeyVault.getSecret,
  replaceParameter(
    KeyVault.getSecret,
    "secretVersion",
    RequiredSecretVersionParameter.secretVersion
  ),
  "!rust"
);

// go renames

@@override(getSecrets, removeParameter(getSecrets, "maxresults"), "go");
@@override(
  getDeletedSecrets,
  removeParameter(getDeletedSecrets, "maxresults"),
  "go"
);
@@override(
  getSecretVersions,
  removeParameter(getSecretVersions, "maxresults"),
  "go"
);

@@clientName(getDeletedSecrets, "ListDeletedSecretProperties", "go");
@@clientName(getSecrets, "ListSecretProperties", "go");
@@clientName(getSecretVersions, "ListSecretPropertiesVersions", "go");
@@clientName(KeyVault.updateSecret, "UpdateSecretProperties", "go");

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
@@clientName(
  DeletedSecretListResult,
  "DeletedSecretPropertiesListResult",
  "go"
);
@@clientName(SecretListResult, "SecretPropertiesListResult", "go");
@@clientName(SecretRestoreParameters.secretBundleBackup, "SecretBackup", "go");
@@clientName(SecretBundle.kid, "KID", "go");
@@alternateType(SecretAttributes.recoveryLevel, string, "go");

// Rust configuration
@@clientName(SecretProperties, "OmitSecretProperties", "rust");
@@clientName(SecretItem, "SecretProperties", "rust");

@@clientName(DeletedSecretBundle, "DeletedSecret", "rust");
@@clientName(DeletedSecretItem, "DeletedSecretProperties", "rust");
@@clientName(SecretBundle, "Secret", "rust");
@@clientName(SecretRestoreParameters, "RestoreSecretParameters", "rust");
@@clientName(SecretSetParameters, "SetSecretParameters", "rust");
@@clientName(
  SecretUpdateParameters,
  "UpdateSecretPropertiesParameters",
  "rust"
);
@@clientName(
  DeletedSecretListResult,
  "ListDeletedSecretPropertiesResult",
  "rust"
);
@@clientName(SecretListResult, "ListSecretPropertiesResult", "rust");

@@clientName(getDeletedSecrets, "ListDeletedSecretProperties", "rust");
@@clientName(getSecrets, "ListSecretProperties", "rust");
@@clientName(getSecretVersions, "ListSecretPropertiesVersions", "rust");
// Work around issue where previous @override prevent the following line from working without "KeyVault." prefix.
@@clientName(KeyVault.updateSecret, "UpdateSecretProperties", "rust");

@@clientName(
  SecretRestoreParameters.secretBundleBackup,
  "SecretBackup",
  "rust"
);
