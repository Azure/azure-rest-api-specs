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

alias KeyVaultListParameters = ListQueryParametersTrait<{
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
}>;

/**
 * The GetCertificates operation returns the set of certificates resources in the
 * specified key vault. This operation requires the certificates/list permission.
 */
@summary("List certificates in a specified key vault")
op getCertificates is KeyVaultOperations.ResourceList<
  CertificateItem,
  KeyVaultListParameters
>;

/**
 * Deletes all versions of a certificate object along with its associated policy.
 * Delete certificate cannot be used to remove individual versions of a
 * certificate object. This operation requires the certificates/delete permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Deletes a certificate from a specified key vault.")
@route("/certificates/{certificateName}")
@delete
op deleteCertificate is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate.
     */
    @path certificateName: string;
  },
  DeletedCertificateBundle
>;

/**
 * Sets the certificate contacts for the specified key vault. This operation
 * requires the certificates/managecontacts permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Sets the certificate contacts for the specified key vault.")
@route("/certificates/contacts")
@put
op setCertificateContacts is Azure.Core.Foundations.Operation<
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Lists the certificate contacts for a specified key vault.")
@route("/certificates/contacts")
@get
op getCertificateContacts is Azure.Core.Foundations.Operation<{}, Contacts>;

/**
 * Deletes the certificate contacts for a specified key vault certificate. This
 * operation requires the certificates/managecontacts permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Deletes the certificate contacts for a specified key vault.")
@route("/certificates/contacts")
@delete
op deleteCertificateContacts is Azure.Core.Foundations.Operation<{}, Contacts>;

/**
 * The GetCertificateIssuers operation returns the set of certificate issuer
 * resources in the specified key vault. This operation requires the
 * certificates/manageissuers/getissuers permission.
 */
@summary("List certificate issuers for a specified key vault.")
op getCertificateIssuers is KeyVaultOperations.ResourceList<
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Sets the specified certificate issuer.")
@route("/certificates/issuers/{issuerName}")
@put
op setCertificateIssuer is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the issuer. The value you provide may be copied globally for the
     * purpose of running the service. The value provided should not include
     * personally identifiable or sensitive information.
     */
    @path issuerName: string;

    /**
     * Certificate issuer set parameter.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Updates the specified certificate issuer.")
@route("/certificates/issuers/{issuerName}")
@patch
op updateCertificateIssuer is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the issuer.
     */
    @path issuerName: string;

    /**
     * Certificate issuer update parameter.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameter: CertificateIssuerUpdateParameters;
  },
  IssuerBundle
>;

/**
 * The GetCertificateIssuer operation returns the specified certificate issuer
 * resources in the specified key vault. This operation requires the
 * certificates/manageissuers/getissuers permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Lists the specified certificate issuer.")
@route("/certificates/issuers/{issuerName}")
@get
op getCertificateIssuer is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the issuer.
     */
    @path issuerName: string;
  },
  IssuerBundle
>;

/**
 * The DeleteCertificateIssuer operation permanently removes the specified
 * certificate issuer from the vault. This operation requires the
 * certificates/manageissuers/deleteissuers permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Deletes the specified certificate issuer.")
@route("/certificates/issuers/{issuerName}")
@delete
op deleteCertificateIssuer is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the issuer.
     */
    @path issuerName: string;
  },
  IssuerBundle
>;

/**
 * If this is the first version, the certificate resource is created. This
 * operation requires the certificates/create permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Creates a new certificate.")
@route("/certificates/{certificateName}/create")
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
    certificateName: string;

    /**
     * The parameters to create a certificate.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Imports a certificate into a specified key vault.")
@route("/certificates/{certificateName}/import")
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
    certificateName: string;

    /**
     * The parameters to import the certificate.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("List the versions of a certificate.")
@route("/certificates/{certificateName}/versions")
@get
op getCertificateVersions is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate.
     */
    @path certificateName: string;

    /**
     * Maximum number of results to return in a page. If not specified the service
     * will return up to 25 results.
     */
    @maxValue(25)
    @minValue(1)
    @query("maxresults")
    maxresults?: int32;
  },
  CertificateListResult
>;

/**
 * The GetCertificatePolicy operation returns the specified certificate policy
 * resources in the specified key vault. This operation requires the
 * certificates/get permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Lists the policy for a certificate.")
@route("/certificates/{certificateName}/policy")
@get
op getCertificatePolicy is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate in a given key vault.
     */
    @path certificateName: string;
  },
  CertificatePolicy
>;

/**
 * Set specified members in the certificate policy. Leave others as null. This
 * operation requires the certificates/update permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Updates the policy for a certificate.")
@route("/certificates/{certificateName}/policy")
@patch
op updateCertificatePolicy is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate in the given vault.
     */
    @path certificateName: string;

    /**
     * The policy for the certificate.
     */
    @body certificatePolicy: CertificatePolicy;
  },
  CertificatePolicy
>;

/**
 * The UpdateCertificate operation applies the specified update on the given
 * certificate; the only elements updated are the certificate's attributes. This
 * operation requires the certificates/update permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Updates the specified attributes associated with the given certificate.")
@route("/certificates/{certificateName}/{certificateVersion}")
@patch
op updateCertificate is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate in the given key vault.
     */
    @path certificateName: string;

    /**
     * The version of the certificate.
     */
    @path certificateVersion: string;

    /**
     * The parameters for certificate update.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    parameters: CertificateUpdateParameters;
  },
  CertificateBundle
>;

/**
 * Gets information about a specific certificate. This operation requires the
 * certificates/get permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Gets information about a certificate.")
@route("/certificates/{certificateName}/{certificateVersion}")
@get
op getCertificate is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate in the given vault.
     */
    @path certificateName: string;

    /**
     * The version of the certificate. This URI fragment is optional. If not
     * specified, the latest version of the certificate is returned.
     */
    @path certificateVersion: string;
  },
  CertificateBundle
>;

/**
 * Updates a certificate creation operation that is already in progress. This
 * operation requires the certificates/update permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Updates a certificate operation.")
@route("/certificates/{certificateName}/pending")
@patch
op updateCertificateOperation is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate.
     */
    @path certificateName: string;

    /**
     * The certificate operation response.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Gets the creation operation of a certificate.")
@route("/certificates/{certificateName}/pending")
@get
op getCertificateOperation is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate.
     */
    @path certificateName: string;
  },
  CertificateOperation
>;

/**
 * Deletes the creation operation for a specified certificate that is in the
 * process of being created. The certificate is no longer created. This operation
 * requires the certificates/update permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Deletes the creation operation for a specific certificate.")
@route("/certificates/{certificateName}/pending")
@delete
op deleteCertificateOperation is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate.
     */
    @path certificateName: string;
  },
  CertificateOperation
>;

/**
 * The MergeCertificate operation performs the merging of a certificate or
 * certificate chain with a key pair currently available in the service. This
 * operation requires the certificates/create permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("""
Merges a certificate or a certificate chain with a key pair existing on the
server.
""")
@route("/certificates/{certificateName}/pending/merge")
@post
op mergeCertificate is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate.
     */
    @path certificateName: string;

    /**
     * The parameters to merge certificate.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Backs up the specified certificate.")
@route("/certificates/{certificateName}/backup")
@post
op backupCertificate is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate.
     */
    @path certificateName: string;
  },
  BackupCertificateResult
>;

/**
 * Restores a backed up certificate, and all its versions, to a vault. This
 * operation requires the certificates/restore permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Restores a backed up certificate to a vault.")
@route("/certificates/restore")
@post
op restoreCertificate is Azure.Core.Foundations.Operation<
  {
    /**
     * The parameters to restore the certificate.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
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
op getDeletedCertificates is KeyVaultOperations.ResourceList<
  DeletedCertificateItem,
  KeyVaultListParameters
>;

/**
 * The GetDeletedCertificate operation retrieves the deleted certificate
 * information plus its attributes, such as retention interval, scheduled
 * permanent deletion and the current deletion recovery level. This operation
 * requires the certificates/get permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Retrieves information about the specified deleted certificate.")
@route("/deletedcertificates/{certificateName}")
@get
op getDeletedCertificate is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate
     */
    @path certificateName: string;
  },
  DeletedCertificateBundle
>;

/**
 * The PurgeDeletedCertificate operation performs an irreversible deletion of the
 * specified certificate, without possibility for recovery. The operation is not
 * available if the recovery level does not specify 'Purgeable'. This operation
 * requires the certificate/purge permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Permanently deletes the specified deleted certificate.")
@route("/deletedcertificates/{certificateName}")
@delete
op purgeDeletedCertificate is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the certificate
     */
    @path certificateName: string;
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
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("""
Recovers the deleted certificate back to its current version under
/certificates.
""")
@route("/deletedcertificates/{certificateName}/recover")
@post
op recoverDeletedCertificate is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the deleted certificate
     */
    @path certificateName: string;
  },
  CertificateBundle
>;
