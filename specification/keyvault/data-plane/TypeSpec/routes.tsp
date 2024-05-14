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


@summary("List certificates in a specified key vault")
/**
* The GetCertificates operation returns the set of certificates resources in the specified key vault. This operation requires the certificates/list permission.
*/
@route("/certificates")
@get op getCertificates(
        ...ApiVersionParameter,
        /**
        * Maximum number of results to return in a page. If not specified the service will return up to 25 results.
        */
        @maxValue(25)
        @minValue(1)
        @query("maxresults")
        "maxresults?": int32,
        /**
        * Specifies whether to include certificates which are not completely provisioned.
        */
        @query("includePending")
        "includePending?": boolean
): ArmResponse<CertificateListResult> | ErrorResponse;



@summary("Deletes a certificate from a specified key vault.")
/**
* Deletes all versions of a certificate object along with its associated policy. Delete certificate cannot be used to remove individual versions of a certificate object. This operation requires the certificates/delete permission.
*/
@route("/certificates/{certificate-name}")
@delete op deleteCertificate(
        ...ApiVersionParameter,
        /**
        * The name of the certificate.
        */
        @path
        "certificate-name": string
): ArmResponse<DeletedCertificateBundle> | ErrorResponse;



@summary("Sets the certificate contacts for the specified key vault.")
/**
* Sets the certificate contacts for the specified key vault. This operation requires the certificates/managecontacts permission.
*/
@route("/certificates/contacts")
@put op setCertificateContacts(
        ...ApiVersionParameter,
        /**
        * The contacts for the key vault certificate.
        */
        @body
        "contacts": Contacts
): ArmResponse<Contacts> | ErrorResponse;



@summary("Lists the certificate contacts for a specified key vault.")
/**
* The GetCertificateContacts operation returns the set of certificate contact resources in the specified key vault. This operation requires the certificates/managecontacts permission.
*/
@route("/certificates/contacts")
@get op getCertificateContacts(
        ...ApiVersionParameter
): ArmResponse<Contacts> | ErrorResponse;



@summary("Deletes the certificate contacts for a specified key vault.")
/**
* Deletes the certificate contacts for a specified key vault certificate. This operation requires the certificates/managecontacts permission.
*/
@route("/certificates/contacts")
@delete op deleteCertificateContacts(
        ...ApiVersionParameter
): ArmResponse<Contacts> | ErrorResponse;



@summary("List certificate issuers for a specified key vault.")
/**
* The GetCertificateIssuers operation returns the set of certificate issuer resources in the specified key vault. This operation requires the certificates/manageissuers/getissuers permission.
*/
@route("/certificates/issuers")
@get op getCertificateIssuers(
        ...ApiVersionParameter,
        /**
        * Maximum number of results to return in a page. If not specified the service will return up to 25 results.
        */
        @maxValue(25)
        @minValue(1)
        @query("maxresults")
        "maxresults?": int32
): ArmResponse<CertificateIssuerListResult> | ErrorResponse;



@summary("Sets the specified certificate issuer.")
/**
* The SetCertificateIssuer operation adds or updates the specified certificate issuer. This operation requires the certificates/setissuers permission.
*/
@route("/certificates/issuers/{issuer-name}")
@put op setCertificateIssuer(
        ...ApiVersionParameter,
        /**
        * The name of the issuer. The value you provide may be copied globally for the purpose of running the service. The value provided should not include personally identifiable or sensitive information.
        */
        @path
        "issuer-name": string,
        /**
        * Certificate issuer set parameter.
        */
        @body
        @flattenProperty
        "parameter": CertificateIssuerSetParameters
): ArmResponse<IssuerBundle> | ErrorResponse;



@summary("Updates the specified certificate issuer.")
/**
* The UpdateCertificateIssuer operation performs an update on the specified certificate issuer entity. This operation requires the certificates/setissuers permission.
*/
@route("/certificates/issuers/{issuer-name}")
@patch op updateCertificateIssuer(
        ...ApiVersionParameter,
        /**
        * The name of the issuer.
        */
        @path
        "issuer-name": string,
        /**
        * Certificate issuer update parameter.
        */
        @body
        @flattenProperty
        "parameter": CertificateIssuerUpdateParameters
): ArmResponse<IssuerBundle> | ErrorResponse;



@summary("Lists the specified certificate issuer.")
/**
* The GetCertificateIssuer operation returns the specified certificate issuer resources in the specified key vault. This operation requires the certificates/manageissuers/getissuers permission.
*/
@route("/certificates/issuers/{issuer-name}")
@get op getCertificateIssuer(
        ...ApiVersionParameter,
        /**
        * The name of the issuer.
        */
        @path
        "issuer-name": string
): ArmResponse<IssuerBundle> | ErrorResponse;



@summary("Deletes the specified certificate issuer.")
/**
* The DeleteCertificateIssuer operation permanently removes the specified certificate issuer from the vault. This operation requires the certificates/manageissuers/deleteissuers permission.
*/
@route("/certificates/issuers/{issuer-name}")
@delete op deleteCertificateIssuer(
        ...ApiVersionParameter,
        /**
        * The name of the issuer.
        */
        @path
        "issuer-name": string
): ArmResponse<IssuerBundle> | ErrorResponse;



@summary("Creates a new certificate.")
/**
* If this is the first version, the certificate resource is created. This operation requires the certificates/create permission.
*/
@route("/certificates/{certificate-name}/create")
@post op createCertificate(
        ...ApiVersionParameter,
        /**
        * The name of the certificate. The value you provide may be copied globally for the purpose of running the service. The value provided should not include personally identifiable or sensitive information.
        */
        @pattern("^[0-9a-zA-Z-]+$")
        @path
        "certificate-name": string,
        /**
        * The parameters to create a certificate.
        */
        @body
        @flattenProperty
        "parameters": CertificateCreateParameters
): ArmResponse<CertificateOperation> | ErrorResponse;



@summary("Imports a certificate into a specified key vault.")
/**
* Imports an existing valid certificate, containing a private key, into Azure Key Vault. This operation requires the certificates/import permission. The certificate to be imported can be in either PFX or PEM format. If the certificate is in PEM format the PEM file must contain the key as well as x509 certificates. Key Vault will only accept a key in PKCS#8 format.
*/
@route("/certificates/{certificate-name}/import")
@post op importCertificate(
        ...ApiVersionParameter,
        /**
        * The name of the certificate. The value you provide may be copied globally for the purpose of running the service. The value provided should not include personally identifiable or sensitive information.
        */
        @pattern("^[0-9a-zA-Z-]+$")
        @path
        "certificate-name": string,
        /**
        * The parameters to import the certificate.
        */
        @body
        @flattenProperty
        "parameters": CertificateImportParameters
): ArmResponse<CertificateBundle> | ErrorResponse;



@summary("List the versions of a certificate.")
/**
* The GetCertificateVersions operation returns the versions of a certificate in the specified key vault. This operation requires the certificates/list permission.
*/
@route("/certificates/{certificate-name}/versions")
@get op getCertificateVersions(
        ...ApiVersionParameter,
        /**
        * The name of the certificate.
        */
        @path
        "certificate-name": string,
        /**
        * Maximum number of results to return in a page. If not specified the service will return up to 25 results.
        */
        @maxValue(25)
        @minValue(1)
        @query("maxresults")
        "maxresults?": int32
): ArmResponse<CertificateListResult> | ErrorResponse;



@summary("Lists the policy for a certificate.")
/**
* The GetCertificatePolicy operation returns the specified certificate policy resources in the specified key vault. This operation requires the certificates/get permission.
*/
@route("/certificates/{certificate-name}/policy")
@get op getCertificatePolicy(
        ...ApiVersionParameter,
        /**
        * The name of the certificate in a given key vault.
        */
        @path
        "certificate-name": string
): ArmResponse<CertificatePolicy> | ErrorResponse;



@summary("Updates the policy for a certificate.")
/**
* Set specified members in the certificate policy. Leave others as null. This operation requires the certificates/update permission.
*/
@route("/certificates/{certificate-name}/policy")
@patch op updateCertificatePolicy(
        ...ApiVersionParameter,
        /**
        * The name of the certificate in the given vault.
        */
        @path
        "certificate-name": string,
        /**
        * The policy for the certificate.
        */
        @body
        "certificatePolicy": CertificatePolicy
): ArmResponse<CertificatePolicy> | ErrorResponse;



@summary("Updates the specified attributes associated with the given certificate.")
/**
* The UpdateCertificate operation applies the specified update on the given certificate; the only elements updated are the certificate's attributes. This operation requires the certificates/update permission.
*/
@route("/certificates/{certificate-name}/{certificate-version}")
@patch op updateCertificate(
        ...ApiVersionParameter,
        /**
        * The name of the certificate in the given key vault.
        */
        @path
        "certificate-name": string,
        /**
        * The version of the certificate.
        */
        @path
        "certificate-version": string,
        /**
        * The parameters for certificate update.
        */
        @body
        @flattenProperty
        "parameters": CertificateUpdateParameters
): ArmResponse<CertificateBundle> | ErrorResponse;



@summary("Gets information about a certificate.")
/**
* Gets information about a specific certificate. This operation requires the certificates/get permission.
*/
@route("/certificates/{certificate-name}/{certificate-version}")
@get op getCertificate(
        ...ApiVersionParameter,
        /**
        * The name of the certificate in the given vault.
        */
        @path
        "certificate-name": string,
        /**
        * The version of the certificate. This URI fragment is optional. If not specified, the latest version of the certificate is returned.
        */
        @path
        "certificate-version": string
): ArmResponse<CertificateBundle> | ErrorResponse;



@summary("Updates a certificate operation.")
/**
* Updates a certificate creation operation that is already in progress. This operation requires the certificates/update permission.
*/
@route("/certificates/{certificate-name}/pending")
@patch op updateCertificateOperation(
        ...ApiVersionParameter,
        /**
        * The name of the certificate.
        */
        @path
        "certificate-name": string,
        /**
        * The certificate operation response.
        */
        @body
        @flattenProperty
        "certificateOperation": CertificateOperationUpdateParameter
): ArmResponse<CertificateOperation> | ErrorResponse;



@summary("Gets the creation operation of a certificate.")
/**
* Gets the creation operation associated with a specified certificate. This operation requires the certificates/get permission.
*/
@route("/certificates/{certificate-name}/pending")
@get op getCertificateOperation(
        ...ApiVersionParameter,
        /**
        * The name of the certificate.
        */
        @path
        "certificate-name": string
): ArmResponse<CertificateOperation> | ErrorResponse;



@summary("Deletes the creation operation for a specific certificate.")
/**
* Deletes the creation operation for a specified certificate that is in the process of being created. The certificate is no longer created. This operation requires the certificates/update permission.
*/
@route("/certificates/{certificate-name}/pending")
@delete op deleteCertificateOperation(
        ...ApiVersionParameter,
        /**
        * The name of the certificate.
        */
        @path
        "certificate-name": string
): ArmResponse<CertificateOperation> | ErrorResponse;



@summary("Merges a certificate or a certificate chain with a key pair existing on the server.")
/**
* The MergeCertificate operation performs the merging of a certificate or certificate chain with a key pair currently available in the service. This operation requires the certificates/create permission.
*/
@route("/certificates/{certificate-name}/pending/merge")
@post op mergeCertificate(
        ...ApiVersionParameter,
        /**
        * The name of the certificate.
        */
        @path
        "certificate-name": string,
        /**
        * The parameters to merge certificate.
        */
        @body
        @flattenProperty
        "parameters": CertificateMergeParameters
): ArmResponse<CertificateBundle> | ErrorResponse;



@summary("Backs up the specified certificate.")
/**
* Requests that a backup of the specified certificate be downloaded to the client. All versions of the certificate will be downloaded. This operation requires the certificates/backup permission.
*/
@route("/certificates/{certificate-name}/backup")
@post op backupCertificate(
        ...ApiVersionParameter,
        /**
        * The name of the certificate.
        */
        @path
        "certificate-name": string
): ArmResponse<BackupCertificateResult> | ErrorResponse;



@summary("Restores a backed up certificate to a vault.")
/**
* Restores a backed up certificate, and all its versions, to a vault. This operation requires the certificates/restore permission.
*/
@route("/certificates/restore")
@post op restoreCertificate(
        ...ApiVersionParameter,
        /**
        * The parameters to restore the certificate.
        */
        @body
        @flattenProperty
        "parameters": CertificateRestoreParameters
): ArmResponse<CertificateBundle> | ErrorResponse;



@summary("Lists the deleted certificates in the specified vault currently available for recovery.")
/**
* The GetDeletedCertificates operation retrieves the certificates in the current vault which are in a deleted state and ready for recovery or purging. This operation includes deletion-specific information. This operation requires the certificates/get/list permission. This operation can only be enabled on soft-delete enabled vaults.
*/
@route("/deletedcertificates")
@get op getDeletedCertificates(
        ...ApiVersionParameter,
        /**
        * Maximum number of results to return in a page. If not specified the service will return up to 25 results.
        */
        @maxValue(25)
        @minValue(1)
        @query("maxresults")
        "maxresults?": int32,
        /**
        * Specifies whether to include certificates which are not completely provisioned.
        */
        @query("includePending")
        "includePending?": boolean
): ArmResponse<DeletedCertificateListResult> | ErrorResponse;



@summary("Retrieves information about the specified deleted certificate.")
/**
* The GetDeletedCertificate operation retrieves the deleted certificate information plus its attributes, such as retention interval, scheduled permanent deletion and the current deletion recovery level. This operation requires the certificates/get permission.
*/
@route("/deletedcertificates/{certificate-name}")
@get op getDeletedCertificate(
        ...ApiVersionParameter,
        /**
        * The name of the certificate
        */
        @path
        "certificate-name": string
): ArmResponse<DeletedCertificateBundle> | ErrorResponse;



@summary("Permanently deletes the specified deleted certificate.")
/**
* The PurgeDeletedCertificate operation performs an irreversible deletion of the specified certificate, without possibility for recovery. The operation is not available if the recovery level does not specify 'Purgeable'. This operation requires the certificate/purge permission.
*/
@route("/deletedcertificates/{certificate-name}")
@delete op purgeDeletedCertificate(
        ...ApiVersionParameter,
        /**
        * The name of the certificate
        */
        @path
        "certificate-name": string
): NoContentResponse | ErrorResponse;



@summary("Recovers the deleted certificate back to its current version under /certificates.")
/**
* The RecoverDeletedCertificate operation performs the reversal of the Delete operation. The operation is applicable in vaults enabled for soft-delete, and must be issued during the retention interval (available in the deleted certificate's attributes). This operation requires the certificates/recover permission.
*/
@route("/deletedcertificates/{certificate-name}/recover")
@post op recoverDeletedCertificate(
        ...ApiVersionParameter,
        /**
        * The name of the deleted certificate
        */
        @path
        "certificate-name": string
): ArmResponse<CertificateBundle> | ErrorResponse;


