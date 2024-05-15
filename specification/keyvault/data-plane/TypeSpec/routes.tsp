import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

namespace KeyVaultClient;

/**
 * The GetCertificates operation returns the set of certificates resources in the specified key vault. This operation requires the certificates/list permission.
 */
@summary("List certificates in a specified key vault")
@route("/certificates")
@get
op getCertificates(
        ...ApiVersionParameter,

        /**
         * Maximum number of results to return in a page. If not specified the service will return up to 25 results.
         */
        @maxValue(25)
        @minValue(1)
        @query("maxresults")
        maxresults?: int32,

        /**
         * Specifies whether to include certificates which are not completely provisioned.
         */
        @query("includePending")
        includePending?: boolean,
): ArmResponse<CertificateListResult> | ErrorResponse;

/**
 * Deletes all versions of a certificate object along with its associated policy. Delete certificate cannot be used to remove individual versions of a certificate object. This operation requires the certificates/delete permission.
 */
@summary("Deletes a certificate from a specified key vault.")
@route("/certificates/{certificate-name}")
@delete
op deleteCertificate(
        ...ApiVersionParameter,

        /**
         * The name of the certificate.
         */
        @path
        `certificate-name`: string,
): ArmResponse<DeletedCertificateBundle> | ErrorResponse;

/**
 * Sets the certificate contacts for the specified key vault. This operation requires the certificates/managecontacts permission.
 */
@summary("Sets the certificate contacts for the specified key vault.")
@route("/certificates/contacts")
@put
op setCertificateContacts(
        ...ApiVersionParameter,

        /**
         * The contacts for the key vault certificate.
         */
        @body
        contacts: Contacts,
): ArmResponse<Contacts> | ErrorResponse;

/**
 * The GetCertificateContacts operation returns the set of certificate contact resources in the specified key vault. This operation requires the certificates/managecontacts permission.
 */
@summary("Lists the certificate contacts for a specified key vault.")
@route("/certificates/contacts")
@get
op getCertificateContacts(
        ...ApiVersionParameter,
): ArmResponse<Contacts> | ErrorResponse;

/**
 * Deletes the certificate contacts for a specified key vault certificate. This operation requires the certificates/managecontacts permission.
 */
@summary("Deletes the certificate contacts for a specified key vault.")
@route("/certificates/contacts")
@delete
op deleteCertificateContacts(
        ...ApiVersionParameter,
): ArmResponse<Contacts> | ErrorResponse;

/**
 * The GetCertificateIssuers operation returns the set of certificate issuer resources in the specified key vault. This operation requires the certificates/manageissuers/getissuers permission.
 */
@summary("List certificate issuers for a specified key vault.")
@route("/certificates/issuers")
@get
op getCertificateIssuers(
        ...ApiVersionParameter,

        /**
         * Maximum number of results to return in a page. If not specified the service will return up to 25 results.
         */
        @maxValue(25)
        @minValue(1)
        @query("maxresults")
        maxresults?: int32,
): ArmResponse<CertificateIssuerListResult> | ErrorResponse;

/**
 * The SetCertificateIssuer operation adds or updates the specified certificate issuer. This operation requires the certificates/setissuers permission.
 */
@summary("Sets the specified certificate issuer.")
@route("/certificates/issuers/{issuer-name}")
@put
op setCertificateIssuer(
        ...ApiVersionParameter,

        /**
         * The name of the issuer. The value you provide may be copied globally for the purpose of running the service. The value provided should not include personally identifiable or sensitive information.
         */
        @path
        `issuer-name`: string,

        /**
         * Certificate issuer set parameter.
         */
        @body
        @flattenProperty
        parameter: CertificateIssuerSetParameters,
): ArmResponse<IssuerBundle> | ErrorResponse;

/**
 * The UpdateCertificateIssuer operation performs an update on the specified certificate issuer entity. This operation requires the certificates/setissuers permission.
 */
@summary("Updates the specified certificate issuer.")
@route("/certificates/issuers/{issuer-name}")
@patch
op updateCertificateIssuer(
        ...ApiVersionParameter,

        /**
         * The name of the issuer.
         */
        @path
        `issuer-name`: string,

        /**
         * Certificate issuer update parameter.
         */
        @body
        @flattenProperty
        parameter: CertificateIssuerUpdateParameters,
): ArmResponse<IssuerBundle> | ErrorResponse;

/**
 * The GetCertificateIssuer operation returns the specified certificate issuer resources in the specified key vault. This operation requires the certificates/manageissuers/getissuers permission.
 */
@summary("Lists the specified certificate issuer.")
@route("/certificates/issuers/{issuer-name}")
@get
op getCertificateIssuer(
        ...ApiVersionParameter,

        /**
         * The name of the issuer.
         */
        @path
        `issuer-name`: string,
): ArmResponse<IssuerBundle> | ErrorResponse;

/**
 * The DeleteCertificateIssuer operation permanently removes the specified certificate issuer from the vault. This operation requires the certificates/manageissuers/deleteissuers permission.
 */
@summary("Deletes the specified certificate issuer.")
@route("/certificates/issuers/{issuer-name}")
@delete
op deleteCertificateIssuer(
        ...ApiVersionParameter,

        /**
         * The name of the issuer.
         */
        @path
        `issuer-name`: string,
): ArmResponse<IssuerBundle> | ErrorResponse;

/**
 * If this is the first version, the certificate resource is created. This operation requires the certificates/create permission.
 */
@summary("Creates a new certificate.")
@route("/certificates/{certificate-name}/create")
@post
op createCertificate(
        ...ApiVersionParameter,

        /**
         * The name of the certificate. The value you provide may be copied globally for the purpose of running the service. The value provided should not include personally identifiable or sensitive information.
         */
        @pattern("^[0-9a-zA-Z-]+$")
        @path
        `certificate-name`: string,

        /**
         * The parameters to create a certificate.
         */
        @body
        @flattenProperty
        parameters: CertificateCreateParameters,
): ArmAcceptedResponse<CertificateOperation> | ErrorResponse;

/**
 * Imports an existing valid certificate, containing a private key, into Azure Key Vault. This operation requires the certificates/import permission. The certificate to be imported can be in either PFX or PEM format. If the certificate is in PEM format the PEM file must contain the key as well as x509 certificates. Key Vault will only accept a key in PKCS#8 format.
 */
@summary("Imports a certificate into a specified key vault.")
@route("/certificates/{certificate-name}/import")
@post
op importCertificate(
        ...ApiVersionParameter,

        /**
         * The name of the certificate. The value you provide may be copied globally for the purpose of running the service. The value provided should not include personally identifiable or sensitive information.
         */
        @pattern("^[0-9a-zA-Z-]+$")
        @path
        `certificate-name`: string,

        /**
         * The parameters to import the certificate.
         */
        @body
        @flattenProperty
        parameters: CertificateImportParameters,
): ArmResponse<CertificateBundle> | ErrorResponse;

/**
 * The GetCertificateVersions operation returns the versions of a certificate in the specified key vault. This operation requires the certificates/list permission.
 */
@summary("List the versions of a certificate.")
@route("/certificates/{certificate-name}/versions")
@get
op getCertificateVersions(
        ...ApiVersionParameter,

        /**
         * The name of the certificate.
         */
        @path
        `certificate-name`: string,

        /**
         * Maximum number of results to return in a page. If not specified the service will return up to 25 results.
         */
        @maxValue(25)
        @minValue(1)
        @query("maxresults")
        maxresults?: int32,
): ArmResponse<CertificateListResult> | ErrorResponse;

/**
 * The GetCertificatePolicy operation returns the specified certificate policy resources in the specified key vault. This operation requires the certificates/get permission.
 */
@summary("Lists the policy for a certificate.")
@route("/certificates/{certificate-name}/policy")
@get
op getCertificatePolicy(
        ...ApiVersionParameter,

        /**
         * The name of the certificate in a given key vault.
         */
        @path
        `certificate-name`: string,
): ArmResponse<CertificatePolicy> | ErrorResponse;

/**
 * Set specified members in the certificate policy. Leave others as null. This operation requires the certificates/update permission.
 */
@summary("Updates the policy for a certificate.")
@route("/certificates/{certificate-name}/policy")
@patch
op updateCertificatePolicy(
        ...ApiVersionParameter,

        /**
         * The name of the certificate in the given vault.
         */
        @path
        `certificate-name`: string,

        /**
         * The policy for the certificate.
         */
        @body
        certificatePolicy: CertificatePolicy,
): ArmResponse<CertificatePolicy> | ErrorResponse;

/**
 * The UpdateCertificate operation applies the specified update on the given certificate; the only elements updated are the certificate's attributes. This operation requires the certificates/update permission.
 */
@summary("Updates the specified attributes associated with the given certificate.")
@route("/certificates/{certificate-name}/{certificate-version}")
@patch
op updateCertificate(
        ...ApiVersionParameter,

        /**
         * The name of the certificate in the given key vault.
         */
        @path
        `certificate-name`: string,

        /**
         * The version of the certificate.
         */
        @path
        `certificate-version`: string,

        /**
         * The parameters for certificate update.
         */
        @body
        @flattenProperty
        parameters: CertificateUpdateParameters,
): ArmResponse<CertificateBundle> | ErrorResponse;

/**
 * Gets information about a specific certificate. This operation requires the certificates/get permission.
 */
@summary("Gets information about a certificate.")
@route("/certificates/{certificate-name}/{certificate-version}")
@get
op getCertificate(
        ...ApiVersionParameter,

        /**
         * The name of the certificate in the given vault.
         */
        @path
        `certificate-name`: string,

        /**
         * The version of the certificate. This URI fragment is optional. If not specified, the latest version of the certificate is returned.
         */
        @path
        `certificate-version`: string,
): ArmResponse<CertificateBundle> | ErrorResponse;

/**
 * Updates a certificate creation operation that is already in progress. This operation requires the certificates/update permission.
 */
@summary("Updates a certificate operation.")
@route("/certificates/{certificate-name}/pending")
@patch
op updateCertificateOperation(
        ...ApiVersionParameter,

        /**
         * The name of the certificate.
         */
        @path
        `certificate-name`: string,

        /**
         * The certificate operation response.
         */
        @body
        @flattenProperty
        certificateOperation: CertificateOperationUpdateParameter,
): ArmResponse<CertificateOperation> | ErrorResponse;

/**
 * Gets the creation operation associated with a specified certificate. This operation requires the certificates/get permission.
 */
@summary("Gets the creation operation of a certificate.")
@route("/certificates/{certificate-name}/pending")
@get
op getCertificateOperation(
        ...ApiVersionParameter,

        /**
         * The name of the certificate.
         */
        @path
        `certificate-name`: string,
): ArmResponse<CertificateOperation> | ErrorResponse;

/**
 * Deletes the creation operation for a specified certificate that is in the process of being created. The certificate is no longer created. This operation requires the certificates/update permission.
 */
@summary("Deletes the creation operation for a specific certificate.")
@route("/certificates/{certificate-name}/pending")
@delete
op deleteCertificateOperation(
        ...ApiVersionParameter,

        /**
         * The name of the certificate.
         */
        @path
        `certificate-name`: string,
): ArmResponse<CertificateOperation> | ErrorResponse;

/**
 * The MergeCertificate operation performs the merging of a certificate or certificate chain with a key pair currently available in the service. This operation requires the certificates/create permission.
 */
@summary("Merges a certificate or a certificate chain with a key pair existing on the server.")
@route("/certificates/{certificate-name}/pending/merge")
@post
op mergeCertificate(
        ...ApiVersionParameter,

        /**
         * The name of the certificate.
         */
        @path
        `certificate-name`: string,

        /**
         * The parameters to merge certificate.
         */
        @body
        @flattenProperty
        parameters: CertificateMergeParameters,
): ArmCreatedResponse<CertificateBundle> | ErrorResponse;

/**
 * Requests that a backup of the specified certificate be downloaded to the client. All versions of the certificate will be downloaded. This operation requires the certificates/backup permission.
 */
@summary("Backs up the specified certificate.")
@route("/certificates/{certificate-name}/backup")
@post
op backupCertificate(
        ...ApiVersionParameter,

        /**
         * The name of the certificate.
         */
        @path
        `certificate-name`: string,
): ArmResponse<BackupCertificateResult> | ErrorResponse;

/**
 * Restores a backed up certificate, and all its versions, to a vault. This operation requires the certificates/restore permission.
 */
@summary("Restores a backed up certificate to a vault.")
@route("/certificates/restore")
@post
op restoreCertificate(
        ...ApiVersionParameter,

        /**
         * The parameters to restore the certificate.
         */
        @body
        @flattenProperty
        parameters: CertificateRestoreParameters,
): ArmResponse<CertificateBundle> | ErrorResponse;

/**
 * The GetDeletedCertificates operation retrieves the certificates in the current vault which are in a deleted state and ready for recovery or purging. This operation includes deletion-specific information. This operation requires the certificates/get/list permission. This operation can only be enabled on soft-delete enabled vaults.
 */
@summary("Lists the deleted certificates in the specified vault currently available for recovery.")
@route("/deletedcertificates")
@get
op getDeletedCertificates(
        ...ApiVersionParameter,

        /**
         * Maximum number of results to return in a page. If not specified the service will return up to 25 results.
         */
        @maxValue(25)
        @minValue(1)
        @query("maxresults")
        maxresults?: int32,

        /**
         * Specifies whether to include certificates which are not completely provisioned.
         */
        @query("includePending")
        includePending?: boolean,
): ArmResponse<DeletedCertificateListResult> | ErrorResponse;

/**
 * The GetDeletedCertificate operation retrieves the deleted certificate information plus its attributes, such as retention interval, scheduled permanent deletion and the current deletion recovery level. This operation requires the certificates/get permission.
 */
@summary("Retrieves information about the specified deleted certificate.")
@route("/deletedcertificates/{certificate-name}")
@get
op getDeletedCertificate(
        ...ApiVersionParameter,

        /**
         * The name of the certificate
         */
        @path
        `certificate-name`: string,
): ArmResponse<DeletedCertificateBundle> | ErrorResponse;

/**
 * The PurgeDeletedCertificate operation performs an irreversible deletion of the specified certificate, without possibility for recovery. The operation is not available if the recovery level does not specify 'Purgeable'. This operation requires the certificate/purge permission.
 */
@summary("Permanently deletes the specified deleted certificate.")
@route("/deletedcertificates/{certificate-name}")
@delete
op purgeDeletedCertificate(
        ...ApiVersionParameter,

        /**
         * The name of the certificate
         */
        @path
        `certificate-name`: string,
): NoContentResponse | ErrorResponse;

/**
 * The RecoverDeletedCertificate operation performs the reversal of the Delete operation. The operation is applicable in vaults enabled for soft-delete, and must be issued during the retention interval (available in the deleted certificate's attributes). This operation requires the certificates/recover permission.
 */
@summary("Recovers the deleted certificate back to its current version under /certificates.")
@route("/deletedcertificates/{certificate-name}/recover")
@post
op recoverDeletedCertificate(
        ...ApiVersionParameter,

        /**
         * The name of the deleted certificate
         */
        @path
        `certificate-name`: string,
): ArmResponse<CertificateBundle> | ErrorResponse;
