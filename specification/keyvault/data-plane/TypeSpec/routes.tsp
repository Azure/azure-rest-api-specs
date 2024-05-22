import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "./models.tsp";

using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace KeyVault;

alias KeyVaultOperations = StandardResourceOperations;

/**
 * The GetCertificates operation returns the set of certificates resources in the
 * specified key vault. This operation requires the certificates/list permission.
 */
@summary("List certificates in a specified key vault")
op getCertificates is Azure.Core.Foundations.NonPagedResourceList<
  CertificateItem,
  ListQueryParametersTrait<{
    /**
     * Maximum number of results to return in a page. If not specified the service
     * will return up to 25 results.
     */
    @maxValue(25)
    @minValue(1)
    @query("maxresults")
    maxresults?: int32;

    /**
     * Specifies whether to include certificates which are not completely provisioned.
     */
    @query("includePending")
    includePending?: boolean;
  }>
>;

/**
 * Deletes all versions of a certificate object along with its associated policy.
 * Delete certificate cannot be used to remove individual versions of a
 * certificate object. This operation requires the certificates/delete permission.
 */
@summary("Deletes a certificate from a specified key vault.")
@route("/certificates/{certificate-name}")
@delete
op deleteCertificate is RpcOperation<
  {
    /**
     * The name of the certificate.
     */
    @path `certificate-name`: string;
  },
  CertificateItem
>;

/**
 * Sets the certificate contacts for the specified key vault. This operation
 * requires the certificates/managecontacts permission.
 */
@summary("Sets the certificate contacts for the specified key vault.")
@route("/certificates/contacts")
@put
op setCertificateContacts is RpcOperation<
  {
    /**
     * The contacts for the key vault certificate.
     */
    @body contacts: Contacts;
  },
  Contacts
>;

/**
 * The GetCertificateContacts operation returns the set of certificate contact
 * resources in the specified key vault. This operation requires the
 * certificates/managecontacts permission.
 */
@summary("Lists the certificate contacts for a specified key vault.")
@route("/certificates/contacts")
@get
op getCertificateContacts is RpcOperation<{}, Contacts>;

/**
 * Deletes the certificate contacts for a specified key vault certificate. This
 * operation requires the certificates/managecontacts permission.
 */
@summary("Deletes the certificate contacts for a specified key vault.")
@route("/certificates/contacts")
@delete
op deleteCertificateContacts is RpcOperation<{}, Contacts>;

/**
 * The GetCertificateIssuers operation returns the set of certificate issuer
 * resources in the specified key vault. This operation requires the
 * certificates/manageissuers/getissuers permission.
 */
@summary("List certificate issuers for a specified key vault.")
op getCertificateIssuers is Azure.Core.Foundations.NonPagedResourceList<
  CertificateIssuerItem,
  ListQueryParametersTrait<{
    /**
     * Maximum number of results to return in a page. If not specified the service
     * will return up to 25 results.
     */
    @maxValue(25)
    @minValue(1)
    @query("maxresults")
    maxresults?: int32;
  }>
>;

/**
 * The SetCertificateIssuer operation adds or updates the specified certificate
 * issuer. This operation requires the certificates/setissuers permission.
 */
@summary("Sets the specified certificate issuer.")
@route("/certificates/issuers/{issuer-name}")
@put
op setCertificateIssuer is RpcOperation<
  {
    /**
     * The name of the issuer. The value you provide may be copied globally for the
     * purpose of running the service. The value provided should not include
     * personally identifiable or sensitive information.
     */
    @path
    `issuer-name`: string;

    /**
     * Certificate issuer set parameter.
     */
    @body
    @flattenProperty
    parameter: CertificateIssuerSetParameters;
  },
  IssuerBundle
>;

/**
 * The UpdateCertificateIssuer operation performs an update on the specified
 * certificate issuer entity. This operation requires the certificates/setissuers
 * permission.
 */
@summary("Updates the specified certificate issuer.")
@route("/certificates/issuers/{issuer-name}")
op updateCertificateIssuer is KeyVaultOperations.ResourceUpdate<
  IssuerBundle,
  {
    /**
     * The name of the issuer.
     */
    @path
    `issuer-name`: string;

    /**
     * Certificate issuer update parameter.
     */
    @body
    @flattenProperty
    parameter: CertificateIssuerUpdateParameters;
  }
>;

/**
 * The GetCertificateIssuer operation returns the specified certificate issuer
 * resources in the specified key vault. This operation requires the
 * certificates/manageissuers/getissuers permission.
 */
@summary("Lists the specified certificate issuer.")
op getCertificateIssuer is KeyVaultOperations.ResourceRead<IssuerBundle>; //Azure.Core.Foundations.Operation<
//   {
//     /**
//      * The name of the issuer.
//      */
//     @path
//     `issuer-name`: string;
//   },
//   IssuerBundle
// >;

/**
 * The DeleteCertificateIssuer operation permanently removes the specified
 * certificate issuer from the vault. This operation requires the
 * certificates/manageissuers/deleteissuers permission.
 */
@summary("Deletes the specified certificate issuer.")
op deleteCertificateIssuer is KeyVaultOperations.ResourceDelete<IssuerBundle>; //Azure.Core.Foundations.Operation<
//   {
//     /**
//      * The name of the issuer.
//      */
//     @path
//     `issuer-name`: string;
//   },
//   IssuerBundle
// >;

/**
 * If this is the first version, the certificate resource is created. This
 * operation requires the certificates/create permission.
 */
@summary("Creates a new certificate.")
@route("/certificates/{certificate-name}/create")
@post
op createCertificate is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate. The value you provide may be copied globally for
     * the purpose of running the service. The value provided should not include
     * personally identifiable or sensitive information.
     */
    @pattern("^[0-9a-zA-Z-]+$")
    @path
    `certificate-name`: string;

    /**
     * The parameters to create a certificate.
     */
    @body
    @flattenProperty
    parameters: CertificateCreateParameters;
  },
  AcceptedResponse & CertificateOperation
>;

/**
 * Imports an existing valid certificate, containing a private key, into Azure Key
 * Vault. This operation requires the certificates/import permission. The
 * certificate to be imported can be in either PFX or PEM format. If the
 * certificate is in PEM format the PEM file must contain the key as well as x509
 * certificates. Key Vault will only accept a key in PKCS#8 format.
 */
@summary("Imports a certificate into a specified key vault.")
@route("/certificates/{certificate-name}/import")
@post
op importCertificate is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate. The value you provide may be copied globally for
     * the purpose of running the service. The value provided should not include
     * personally identifiable or sensitive information.
     */
    @pattern("^[0-9a-zA-Z-]+$")
    @path
    `certificate-name`: string;

    /**
     * The parameters to import the certificate.
     */
    @body
    @flattenProperty
    parameters: CertificateImportParameters;
  },
  CertificateBundle
>;

/**
 * The GetCertificateVersions operation returns the versions of a certificate in
 * the specified key vault. This operation requires the certificates/list
 * permission.
 */
@summary("List the versions of a certificate.")
@route("/certificates/{certificate-name}/versions")
op getCertificateVersions is KeyVaultOperations.ResourceList<CertificateItem>; //Azure.Core.Foundations.Operation<
//   {
//     /**
//      * The name of the certificate.
//      */
//     @path
//     `certificate-name`: string;

//     /**
//      * Maximum number of results to return in a page. If not specified the service
//      * will return up to 25 results.
//      */
//     @maxValue(25)
//     @minValue(1)
//     @query("maxresults")
//     maxresults?: int32;
//   },
//   CertificateListResult
// >;

/**
 * The GetCertificatePolicy operation returns the specified certificate policy
 * resources in the specified key vault. This operation requires the
 * certificates/get permission.
 */
@summary("Lists the policy for a certificate.")
@route("/certificates/{certificate-name}/policy")
@get
op getCertificatePolicy is KeyVaultOperations.ResourceAction<
  CertificatePolicy,
  {
    /**
     * The name of the certificate in a given key vault.
     */
    @path
    `certificate-name`: string;
  },
  CertificatePolicy
>;

/**
 * Set specified members in the certificate policy. Leave others as null. This
 * operation requires the certificates/update permission.
 */
@summary("Updates the policy for a certificate.")
@route("/certificates/{certificate-name}/policy")
@patch
op updateCertificatePolicy is KeyVaultOperations.ResourceCreateOrUpdate<CertificatePolicy>; //Azure.Core.Foundations.Operation<
//   {
//     /**
//      * The name of the certificate in the given vault.
//      */
//     @path
//     `certificate-name`: string;

//     /**
//      * The policy for the certificate.
//      */
//     @body
//     certificatePolicy: CertificatePolicy;
//   },
//   CertificatePolicy
// >;

/**
 * The UpdateCertificate operation applies the specified update on the given
 * certificate; the only elements updated are the certificate's attributes. This
 * operation requires the certificates/update permission.
 */
@summary("Updates the specified attributes associated with the given certificate.")
@route("/certificates/{certificate-name}/{certificate-version}")
@patch
op updateCertificate is KeyVaultOperations.ResourceCreateOrUpdate<CertificateBundle>; //Azure.Core.Foundations.Operation<
//   {
//     /**
//      * The name of the certificate in the given key vault.
//      */
//     @path
//     `certificate-name`: string;

//     /**
//      * The version of the certificate.
//      */
//     @path
//     `certificate-version`: string;

//     /**
//      * The parameters for certificate update.
//      */
//     @body
//     @flattenProperty
//     parameters: CertificateUpdateParameters;
//   },
//   CertificateBundle
// >;

/**
 * Gets information about a specific certificate. This operation requires the
 * certificates/get permission.
 */
@summary("Gets information about a certificate.")
@route("/certificates/{certificate-name}/{certificate-version}")
op getCertificate is KeyVaultOperations.ResourceRead<CertificateBundle>; //Azure.Core.Foundations.Operation<
//   {
//     /**
//      * The name of the certificate in the given vault.
//      */
//     @path
//     `certificate-name`: string;

//     /**
//      * The version of the certificate. This URI fragment is optional. If not
//      * specified, the latest version of the certificate is returned.
//      */
//     @path
//     `certificate-version`: string;
//   },
//   CertificateBundle
// >;

/**
 * Updates a certificate creation operation that is already in progress. This
 * operation requires the certificates/update permission.
 */
@summary("Updates a certificate operation.")
@route("/certificates/{certificate-name}/pending")
@patch
op updateCertificateOperation is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate.
     */
    @path
    `certificate-name`: string;

    /**
     * The certificate operation response.
     */
    @body
    @flattenProperty
    certificateOperation: CertificateOperationUpdateParameter;
  },
  CertificateOperation
>;

/**
 * Gets the creation operation associated with a specified certificate. This
 * operation requires the certificates/get permission.
 */
@summary("Gets the creation operation of a certificate.")
@route("/certificates/{certificate-name}/pending")
@get
op getCertificateOperation is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate.
     */
    @path
    `certificate-name`: string;
  },
  CertificateOperation
>;

/**
 * Deletes the creation operation for a specified certificate that is in the
 * process of being created. The certificate is no longer created. This operation
 * requires the certificates/update permission.
 */
@summary("Deletes the creation operation for a specific certificate.")
@route("/certificates/{certificate-name}/pending")
@delete
op deleteCertificateOperation is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate.
     */
    @path
    `certificate-name`: string;
  },
  CertificateOperation
>;

/**
 * The MergeCertificate operation performs the merging of a certificate or
 * certificate chain with a key pair currently available in the service. This
 * operation requires the certificates/create permission.
 */
@summary("""
Merges a certificate or a certificate chain with a key pair existing on the
server.
""")
@route("/certificates/{certificate-name}/pending/merge")
@post
op mergeCertificate is RpcOperation<
  {
    /**
     * The name of the certificate.
     */
    @path
    `certificate-name`: string;

    /**
     * The parameters to merge certificate.
     */
    @body
    @flattenProperty
    parameters: CertificateMergeParameters;
  },
  CreatedResponse & CertificateBundle
>;

/**
 * Requests that a backup of the specified certificate be downloaded to the
 * client. All versions of the certificate will be downloaded. This operation
 * requires the certificates/backup permission.
 */
@summary("Backs up the specified certificate.")
@route("/certificates/{certificate-name}/backup")
@post
op backupCertificate is KeyVaultOperations.ResourceAction<
  BackupCertificateResult,
  {
    /**
     * The name of the certificate.
     */
    @path
    `certificate-name`: string;
  },
  BackupCertificateResult
>;

/**
 * Restores a backed up certificate, and all its versions, to a vault. This
 * operation requires the certificates/restore permission.
 */
@summary("Restores a backed up certificate to a vault.")
@route("/certificates/restore")
@post
op restoreCertificate is KeyVaultOperations.ResourceAction<
  CertificateBundle,
  {
    /**
     * The parameters to restore the certificate.
     */
    @body
    @flattenProperty
    parameters: CertificateRestoreParameters;
  },
  CertificateBundle
>;

/**
 * The GetDeletedCertificates operation retrieves the certificates in the current
 * vault which are in a deleted state and ready for recovery or purging. This
 * operation includes deletion-specific information. This operation requires the
 * certificates/get/list permission. This operation can only be enabled on
 * soft-delete enabled vaults.
 */
@summary("""
Lists the deleted certificates in the specified vault currently available for
recovery.
""")
op getDeletedCertificates is KeyVaultOperations.ResourceList<DeletedCertificateItem>; //Azure.Core.Foundations.Operation<
//   {
//     /**
//      * Maximum number of results to return in a page. If not specified the service
//      * will return up to 25 results.
//      */
//     @maxValue(25)
//     @minValue(1)
//     @query("maxresults")
//     maxresults?: int32;

//     /**
//      * Specifies whether to include certificates which are not completely provisioned.
//      */
//     @query("includePending")
//     includePending?: boolean;
//   },
//   DeletedCertificateListResult
// >;

/**
 * The GetDeletedCertificate operation retrieves the deleted certificate
 * information plus its attributes, such as retention interval, scheduled
 * permanent deletion and the current deletion recovery level. This operation
 * requires the certificates/get permission.
 */
@summary("Retrieves information about the specified deleted certificate.")
@route("/deletedcertificates/{certificate-name}")
@get
op getDeletedCertificate is KeyVaultOperations.ResourceRead<DeletedCertificateItem>; //Azure.Core.Foundations.Operation<
//   {
//     /**
//      * The name of the certificate
//      */
//     @path
//     `certificate-name`: string;
//   },
//   DeletedCertificateBundle
// >;

/**
 * The PurgeDeletedCertificate operation performs an irreversible deletion of the
 * specified certificate, without possibility for recovery. The operation is not
 * available if the recovery level does not specify 'Purgeable'. This operation
 * requires the certificate/purge permission.
 */
@summary("Permanently deletes the specified deleted certificate.")
@route("/deletedcertificates/{certificate-name}")
@delete
op purgeDeletedCertificate is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate
     */
    @path
    `certificate-name`: string;
  },
  void
>;

/**
 * The RecoverDeletedCertificate operation performs the reversal of the Delete
 * operation. The operation is applicable in vaults enabled for soft-delete, and
 * must be issued during the retention interval (available in the deleted
 * certificate's attributes). This operation requires the certificates/recover
 * permission.
 */
@summary("""
Recovers the deleted certificate back to its current version under
/certificates.
""")
@route("/deletedcertificates/{certificate-name}/recover")
@post
op recoverDeletedCertificate is KeyVaultOperations.ResourceAction<
  DeletedCertificateItem,
  {
    /**
     * The name of the deleted certificate
     */
    @path
    `certificate-name`: string;
  },
  CertificateBundle
>;
