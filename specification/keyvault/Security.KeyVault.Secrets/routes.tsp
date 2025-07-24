import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "./models.tsp";
import "../Security.KeyVault.Common/common.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;

namespace KeyVault;

/**
 * The SET operation adds a secret to the Azure Key Vault. If the named secret already exists, Azure Key Vault creates a new version of that secret. This operation requires the secrets/set permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@summary("Sets a secret in a specified key vault.")
@route("/secrets/{secret-name}")
@put
op setSecret is KeyVaultOperation<
  {
    /**
     * The name of the secret. The value you provide may be copied globally for the purpose of running the service. The value provided should not include personally identifiable or sensitive information.
     */
    @pattern("^[0-9a-zA-Z-]+$")
    @path("secret-name")
    @clientName("name", "go")
    secretName: string;

    /**
     * The parameters for setting the secret.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameters: SecretSetParameters;
  },
  SecretBundle
>;

/**
 * The DELETE operation applies to any secret stored in Azure Key Vault. DELETE cannot be applied to an individual version of a secret. This operation requires the secrets/delete permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Deletes a secret from a specified key vault.")
@route("/secrets/{secret-name}")
@delete
op deleteSecret is KeyVaultOperation<
  {
    /**
     * The name of the secret.
     */
    @path("secret-name")
    @clientName("name", "go")
    secretName: string;
  },
  DeletedSecretBundle
>;

/**
 * The UPDATE operation changes specified attributes of an existing stored secret. Attributes that are not specified in the request are left unchanged. The value of a secret itself cannot be changed. This operation requires the secrets/set permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-autorest/unsupported-optional-path-param" "Intentionally optional"
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
    secretVersion?: string;

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
#suppress "@azure-tools/typespec-autorest/unsupported-optional-path-param" "Intentionally optional"
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
    secretVersion?: string;

    /**
     * The media type (MIME type) of the certificate. If a supported format is specified, the certificate content is converted to the requested format. Currently, only PFX to PEM conversion is supported. If an unsupported format is specified, the request is rejected. If not specified, the certificate is returned in its original format without conversion.
     */
    @Versioning.added(KeyVault.Versions.v2025_06_01_preview)
    @query("outContentType")
    outContentType?: ContentType;
  },
  SecretBundle
>;

/**
 * The Get Secrets operation is applicable to the entire vault. However, only the base secret identifier and its attributes are provided in the response. Individual secret versions are not listed in the response. This operation requires the secrets/list permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@summary("List secrets in a specified key vault.")
@route("/secrets")
@get
op getSecrets is KeyVaultOperation<
  {
    /**
     * Maximum number of results to return in a page. If not specified the service will return up to 25 results.
     */
    @maxValue(25)
    @minValue(1)
    @query("maxresults")
    maxresults?: int32;
  },
  SecretListResult
>;

/**
 * The full secret identifier and attributes are provided in the response. No values are returned for the secrets. This operations requires the secrets/list permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@summary("List all versions of the specified secret.")
@route("/secrets/{secret-name}/versions")
@get
op getSecretVersions is KeyVaultOperation<
  {
    /**
     * The name of the secret.
     */
    @path("secret-name")
    @clientName("name", "go")
    secretName: string;

    /**
     * Maximum number of results to return in a page. If not specified the service will return up to 25 results.
     */
    @maxValue(25)
    @minValue(1)
    @query("maxresults")
    maxresults?: int32;
  },
  SecretListResult
>;

/**
 * The Get Deleted Secrets operation returns the secrets that have been deleted for a vault enabled for soft-delete. This operation requires the secrets/list permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@summary("Lists deleted secrets for the specified vault.")
@route("/deletedsecrets")
@get
op getDeletedSecrets is KeyVaultOperation<
  {
    /**
     * Maximum number of results to return in a page. If not specified the service will return up to 25 results.
     */
    @maxValue(25)
    @minValue(1)
    @query("maxresults")
    maxresults?: int32;
  },
  DeletedSecretListResult
>;

/**
 * The Get Deleted Secret operation returns the specified deleted secret along with its attributes. This operation requires the secrets/get permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Gets the specified deleted secret.")
@route("/deletedsecrets/{secret-name}")
@get
op getDeletedSecret is KeyVaultOperation<
  {
    /**
     * The name of the secret.
     */
    @path("secret-name")
    @clientName("name", "go")
    secretName: string;
  },
  DeletedSecretBundle
>;

/**
 * The purge deleted secret operation removes the secret permanently, without the possibility of recovery. This operation can only be enabled on a soft-delete enabled vault. This operation requires the secrets/purge permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@summary("Permanently deletes the specified secret.")
@route("/deletedsecrets/{secret-name}")
@delete
op purgeDeletedSecret is KeyVaultOperation<
  {
    /**
     * The name of the secret.
     */
    @path("secret-name")
    @clientName("name", "go")
    secretName: string;
  },
  void
>;

/**
 * Recovers the deleted secret in the specified vault. This operation can only be performed on a soft-delete enabled vault. This operation requires the secrets/recover permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Recovers the deleted secret to the latest version.")
@route("/deletedsecrets/{secret-name}/recover")
@post
op recoverDeletedSecret is KeyVaultOperation<
  {
    /**
     * The name of the deleted secret.
     */
    @path("secret-name")
    @clientName("name", "go")
    secretName: string;
  },
  SecretBundle
>;

/**
 * Requests that a backup of the specified secret be downloaded to the client. All versions of the secret will be downloaded. This operation requires the secrets/backup permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Backs up the specified secret.")
@route("/secrets/{secret-name}/backup")
@post
op backupSecret is KeyVaultOperation<
  {
    /**
     * The name of the secret.
     */
    @path("secret-name")
    @clientName("name", "go")
    secretName: string;
  },
  BackupSecretResult
>;

/**
 * Restores a backed up secret, and all its versions, to a vault. This operation requires the secrets/restore permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Restores a backed up secret to a vault.")
@route("/secrets/restore")
@post
op restoreSecret is KeyVaultOperation<
  {
    /**
     * The parameters to restore the secret.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameters: SecretRestoreParameters;
  },
  SecretBundle
>;
