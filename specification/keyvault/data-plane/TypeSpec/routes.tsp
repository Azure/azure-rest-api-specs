import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace KeyVaultClient;

/**
 *  The SET operation adds a secret to the Azure Key Vault. If the named secret
 * already exists, Azure Key Vault creates a new version of that secret. This
 * operation requires the secrets/set permission.
 */
@summary("Sets a secret in a specified key vault.")
@route("/secrets/{secret-name}")
@put
op setSecret is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the secret. The value you provide may be copied globally for the
     * purpose of running the service. The value provided should not include
     * personally identifiable or sensitive information.
     */
    @pattern("^[0-9a-zA-Z-]+$")
    @path
    `secret-name`: string;

    /**
     * The parameters for setting the secret.
     */
    @body
    parameters: SecretSetParameters;
  },
  SecretBundle
>;

/**
 * The DELETE operation applies to any secret stored in Azure Key Vault. DELETE
 * cannot be applied to an individual version of a secret. This operation requires
 * the secrets/delete permission.
 */
@summary("Deletes a secret from a specified key vault.")
@route("/secrets/{secret-name}")
@delete
op deleteSecret is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the secret.
     */
    @path
    `secret-name`: string;
  },
  DeletedSecretBundle
>;

/**
 * The UPDATE operation changes specified attributes of an existing stored secret.
 * Attributes that are not specified in the request are left unchanged. The value
 * of a secret itself cannot be changed. This operation requires the secrets/set
 * permission.
 */
@summary("Updates the attributes associated with a specified secret in a given key vault.")
@route("/secrets/{secret-name}/{secret-version}")
@patch
op updateSecret is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the secret.
     */
    @path
    `secret-name`: string;

    /**
     * The version of the secret.
     */
    @path
    `secret-version`: string;

    /**
     * The parameters for update secret operation.
     */
    @body
    parameters: SecretUpdateParameters;
  },
  SecretBundle
>;

/**
 * The GET operation is applicable to any secret stored in Azure Key Vault. This
 * operation requires the secrets/get permission.
 */
@summary("Get a specified secret from a given key vault.")
@route("/secrets/{secret-name}/{secret-version}")
@get
op getSecret is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the secret.
     */
    @path
    `secret-name`: string;

    /**
     * The version of the secret. This URI fragment is optional. If not specified, the
     * latest version of the secret is returned.
     */
    @path
    `secret-version`: string;
  },
  SecretBundle
>;

/**
 * The Get Secrets operation is applicable to the entire vault. However, only the
 * base secret identifier and its attributes are provided in the response.
 * Individual secret versions are not listed in the response. This operation
 * requires the secrets/list permission.
 */
@summary("List secrets in a specified key vault.")
@route("/secrets")
@get
op getSecrets is Azure.Core.Foundations.Operation<
  {
    /**
     * Maximum number of results to return in a page. If not specified, the service
     * will return up to 25 results.
     */
    @maxValue(25)
    @minValue(1)
    @query("maxresults")
    maxresults?: int32;
  },
  SecretListResult
>;

/**
 * The full secret identifier and attributes are provided in the response. No
 * values are returned for the secrets. This operations requires the secrets/list
 * permission.
 */
@summary("List all versions of the specified secret.")
@route("/secrets/{secret-name}/versions")
@get
op getSecretVersions is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the secret.
     */
    @path
    `secret-name`: string;

    /**
     * Maximum number of results to return in a page. If not specified, the service
     * will return up to 25 results.
     */
    @maxValue(25)
    @minValue(1)
    @query("maxresults")
    maxresults?: int32;
  },
  SecretListResult
>;

/**
 * The Get Deleted Secrets operation returns the secrets that have been deleted
 * for a vault enabled for soft-delete. This operation requires the secrets/list
 * permission.
 */
@summary("Lists deleted secrets for the specified vault.")
@route("/deletedsecrets")
@get
op getDeletedSecrets is Azure.Core.Foundations.Operation<
  {
    /**
     * Maximum number of results to return in a page. If not specified the service
     * will return up to 25 results.
     */
    @maxValue(25)
    @minValue(1)
    @query("maxresults")
    maxresults?: int32;
  },
  DeletedSecretListResult
>;

/**
 * The Get Deleted Secret operation returns the specified deleted secret along
 * with its attributes. This operation requires the secrets/get permission.
 */
@summary("Gets the specified deleted secret.")
@route("/deletedsecrets/{secret-name}")
@get
op getDeletedSecret is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the secret.
     */
    @path
    `secret-name`: string;
  },
  DeletedSecretBundle
>;

/**
 * The purge deleted secret operation removes the secret permanently, without the
 * possibility of recovery. This operation can only be enabled on a soft-delete
 * enabled vault. This operation requires the secrets/purge permission.
 */
@summary("Permanently deletes the specified secret.")
@route("/deletedsecrets/{secret-name}")
@delete
op purgeDeletedSecret is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the secret.
     */
    @path
    `secret-name`: string;
  },
  void
>;

/**
 * Recovers the deleted secret in the specified vault. This operation can only be
 * performed on a soft-delete enabled vault. This operation requires the
 * secrets/recover permission.
 */
@summary("Recovers the deleted secret to the latest version.")
@route("/deletedsecrets/{secret-name}/recover")
@post
op recoverDeletedSecret is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the deleted secret.
     */
    @path
    `secret-name`: string;
  },
  SecretBundle
>;

/**
 * Requests that a backup of the specified secret be downloaded to the client. All
 * versions of the secret will be downloaded. This operation requires the
 * secrets/backup permission.
 */
@summary("Backs up the specified secret.")
@route("/secrets/{secret-name}/backup")
@post
op backupSecret is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the secret.
     */
    @path
    `secret-name`: string;
  },
  BackupSecretResult
>;

/**
 * Restores a backed up secret, and all its versions, to a vault. This operation
 * requires the secrets/restore permission.
 */
@summary("Restores a backed up secret to a vault.")
@route("/secrets/restore")
@post
op restoreSecret is Azure.Core.Foundations.Operation<
  SecretRestoreParameters,
  SecretBundle
>;
