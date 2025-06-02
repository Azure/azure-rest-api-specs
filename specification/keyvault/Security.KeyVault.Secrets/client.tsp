import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;

@versioned(KeyVault.Versions)
namespace Customizations;

@@clientName(KeyVault, "Client", "go");
@@clientName(KeyVault, "Secret", "java");
@@clientName(KeyVault, "Secret", "rust");

using KeyVault;

// Make optional path parameter required for all languages except Rust
// TODO: have other languages eventually adopt optional path parameters

/**
 * The UPDATE operation changes specified attributes of an existing stored secret. Attributes that are not specified in the request are left unchanged. The value of a secret itself cannot be changed. This operation requires the secrets/set permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Updates the attributes associated with a specified secret in a given key vault.")
@route("/secrets/{secret-name}/{secret-version}")
@patch(#{ implicitOptionality: true })
op updateSecret is KeyVaultOperation<
  {
    /**
     * The name of the secret.
     */
    @path("secret-name")
    @clientName("name", "go")
    secretName: string;

    /**
     * The version of the secret.
     */
    @path("secret-version")
    @clientName("version", "go")
    secretVersion: string;

    /**
     * The parameters for update secret operation.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameters: SecretUpdateParameters;
  },
  SecretBundle
>;

/**
 * The GET operation is applicable to any secret stored in Azure Key Vault. This operation requires the secrets/get permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Get a specified secret from a given key vault.")
@route("/secrets/{secret-name}/{secret-version}")
@get
op getSecret is KeyVaultOperation<
  {
    /**
     * The name of the secret.
     */
    @path("secret-name")
    @clientName("name", "go")
    secretName: string;

    /**
     * The version of the secret. This URI fragment is optional. If not specified, the latest version of the secret is returned.
     */
    @path("secret-version")
    @clientName("version", "go")
    secretVersion: string;
  },
  SecretBundle
>;

@@override(KeyVault.updateSecret, updateSecret, "!rust");
@@override(KeyVault.getSecret, getSecret, "!rust");

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
