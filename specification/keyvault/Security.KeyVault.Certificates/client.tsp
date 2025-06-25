import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;

@versioned(KeyVault.Versions)
namespace Customizations;

@@clientName(KeyVault, "Certificate", "java");
@@clientName(KeyVault, "Client", "go");
@@clientName(KeyVault, "Certificate", "rust");

using KeyVault;

// Make optional path parameter required for all languages

/**
 * The UpdateCertificate operation applies the specified update on the given certificate; the only elements updated are the certificate's attributes. This operation requires the certificates/update permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Updates the specified attributes associated with the given certificate.")
@route("/certificates/{certificate-name}/{certificate-version}")
@patch(#{ implicitOptionality: true })
op updateCertificate is KeyVaultOperation<
  {
    /**
     * The name of the certificate in the given key vault.
     */
    @path("certificate-name")
    @clientName("name", "go")
    certificateName: string;

    /**
     * The version of the certificate.
     */
    @path("certificate-version")
    @clientName("version", "go")
    certificateVersion: string;

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
 * Gets information about a specific certificate. This operation requires the certificates/get permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Gets information about a certificate.")
@route("/certificates/{certificate-name}/{certificate-version}")
@get
op getCertificate is KeyVaultOperation<
  {
    /**
     * The name of the certificate in the given vault.
     */
    @path("certificate-name")
    @clientName("name", "go")
    certificateName: string;

    /**
     * The version of the certificate. This URI fragment is optional. If not specified, the latest version of the certificate is returned.
     */
    @path("certificate-version")
    @clientName("version", "go")
    certificateVersion: string;
  },
  CertificateBundle
>;

@@override(KeyVault.updateCertificate, updateCertificate);
@@override(KeyVault.getCertificate, getCertificate);

// Java configuration
@@usage(CertificateIssuerItem, Usage.input, "java");
@@usage(CertificateOperation, Usage.input, "java");
@@usage(IssuerBundle, Usage.input, "java");
@@clientName(AdministratorDetails, "AdministratorContact", "java");
@@clientName(AdministratorDetails.EmailAddress, "email", "java");
@@clientName(CertificateAttributes.recoveryLevel, "adminContacts", "java");
@@clientName(Contact, "CertificateContact", "java");
@@clientName(Contact.EmailAddress, "email", "java");
@@clientName(Error, "CertificateOperationError", "java");
@@clientName(JsonWebKeyCurveName, "CertificateKeyCurveName", "java");
@@clientName(JsonWebKeyType, "CertificateKeyType", "java");
@@clientName(KeyUsageType, "CertificateKeyUsage", "java");
@@clientName(SubjectAlternativeNames.upns, "userPrincipalNames", "java");

// Go configuration

/**
 * The GetCertificates operation returns the set of certificates resources in the specified key vault. This operation requires the certificates/list permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@summary("List certificates in a specified key vault")
@route("/certificates")
@get
op listCertificateProperties is KeyVaultOperation<
  {
    /**
     * Specifies whether to include certificates which are not completely provisioned.
     */
    @query("includePending")
    includePending?: boolean;
  },
  CertificateListResult
>;

/**
 * The GetCertificateIssuers operation returns the set of certificate issuer resources in the specified key vault. This operation requires the certificates/manageissuers/getissuers permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@summary("List certificate issuers for a specified key vault.")
@route("/certificates/issuers")
@get
op listIssuerProperties is KeyVaultOperation<{}, CertificateIssuerListResult>;

/**
 * The GetCertificateVersions operation returns the versions of a certificate in the specified key vault. This operation requires the certificates/list permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@summary("List the versions of a certificate.")
@route("/certificates/{certificate-name}/versions")
@get
op listCertificatePropertiesVersions is KeyVaultOperation<
  {
    /**
     * The name of the certificate.
     */
    @path("certificate-name")
    @clientName("name", "go")
    certificateName: string;
  },
  CertificateListResult
>;

/**
 * The GetDeletedCertificates operation retrieves the certificates in the current vault which are in a deleted state and ready for recovery or purging. This operation includes deletion-specific information. This operation requires the certificates/get/list permission. This operation can only be enabled on soft-delete enabled vaults.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
@summary("Lists the deleted certificates in the specified vault currently available for recovery.")
@route("/deletedcertificates")
@get
op listDeletedCertificateProperties is KeyVaultOperation<
  {
    /**
     * Specifies whether to include certificates which are not completely provisioned.
     */
    @query("includePending")
    includePending?: boolean;
  },
  DeletedCertificateListResult
>;

@@override(getCertificates, listCertificateProperties, "go");
@@override(getCertificateIssuers, listIssuerProperties, "go");
@@override(getCertificateVersions, listCertificatePropertiesVersions, "go");
@@override(getDeletedCertificates, listDeletedCertificateProperties, "go");

@@clientName(setCertificateContacts, "SetContacts", "go");
@@clientName(getCertificates, "ListCertificateProperties", "go");
@@clientName(getCertificateIssuers, "ListIssuerProperties", "go");
@@clientName(getCertificateVersions, "ListCertificatePropertiesVersions", "go");
@@clientName(getDeletedCertificates, "ListDeletedCertificateProperties", "go");
@@clientName(getCertificateContacts, "GetContacts", "go");
@@clientName(deleteCertificateContacts, "DeleteContacts", "go");
@@clientName(setCertificateIssuer, "SetIssuer", "go");
@@clientName(updateCertificateIssuer, "UpdateIssuer", "go");
@@clientName(getCertificateIssuer, "GetIssuer", "go");
@@clientName(deleteCertificateIssuer, "DeleteIssuer", "go");

@@clientName(CertificateCreateParameters, "CreateCertificateParameters", "go");
@@clientName(CertificateImportParameters, "ImportCertificateParameters", "go");
@@clientName(CertificateIssuerSetParameters, "SetIssuerParameters", "go");
@@clientName(CertificateIssuerUpdateParameters, "UpdateIssuerParameters", "go");
@@clientName(CertificateMergeParameters, "MergeCertificateParameters", "go");
@@clientName(CertificateOperationUpdateParameter,
  "UpdateCertificateOperationParameter",
  "go"
);
@@clientName(CertificateRestoreParameters,
  "RestoreCertificateParameters",
  "go"
);
@@clientName(CertificateUpdateParameters, "UpdateCertificateParameters", "go");
@@clientName(CertificateListResult, "CertificatePropertiesListResult", "go");
@@clientName(DeletedCertificateListResult,
  "DeletedCertificatePropertiesListResult",
  "go"
);
@@clientName(CertificateIssuerListResult, "IssuerPropertiesListResult", "go");

@@clientName(Action, "LifetimeActionType", "go");
@@clientName(Trigger, "LifetimeActionTrigger", "go");
@@clientName(CertificateBundle, "Certificate", "go");
@@clientName(CertificateItem, "CertificateProperties", "go");
@@clientName(DeletedCertificateBundle, "DeletedCertificate", "go");
@@clientName(DeletedCertificateItem, "DeletedCertificateProperties", "go");
@@clientName(IssuerBundle, "Issuer", "go");
@@clientName(CertificateIssuerItem, "IssuerProperties", "go");
@@clientName(CertificateRestoreParameters.certificateBundleBackup,
  "CertificateBackup",
  "go"
);

@@clientName(AdministratorDetails, "AdministratorContact", "go");
@@clientName(OrganizationDetails.admin_details, "AdminContacts", "go");
@@clientName(Contact.EmailAddress, "Email", "go");
@@clientName(AdministratorDetails.EmailAddress, "Email", "go");

@@clientName(SubjectAlternativeNames.upns, "UserPrincipalNames", "go");
@@clientName(X509CertificateProperties.ekus, "EnhancedKeyUsage", "go");

@@clientName(CertificateBundle.cer, "CER", "go");
@@clientName(CertificateBundle.kid, "KID", "go");
@@clientName(CertificateBundle.sid, "SID", "go");
@@clientName(CertificateOperation.csr, "CSR", "go");

@@clientName(JsonWebKeyCurveName, "CurveName", "go");
@@clientName(JsonWebKeyType, "KeyType", "go");

// Rust configuration
@@clientName(setCertificateContacts, "SetContacts", "rust");

@@clientName(CertificateCreateParameters,
  "CreateCertificateParameters",
  "rust"
);
@@clientName(CertificateImportParameters,
  "ImportCertificateParameters",
  "rust"
);
@@clientName(CertificateIssuerSetParameters, "SetIssuerParameters", "rust");
@@clientName(CertificateIssuerUpdateParameters,
  "UpdateIssuerParameters",
  "rust"
);
@@clientName(CertificateMergeParameters, "MergeCertificateParameters", "rust");
@@clientName(CertificateOperationUpdateParameter,
  "UpdateCertificateOperationParameter",
  "rust"
);
@@clientName(CertificateRestoreParameters,
  "RestoreCertificateParameters",
  "rust"
);
@@clientName(CertificateUpdateParameters,
  "UpdateCertificatePropertiesParameters",
  "rust"
);
@@clientName(DeletedCertificateListResult,
  "ListDeletedCertificatePropertiesResult",
  "rust"
);
@@clientName(CertificateListResult, "ListCertificatePropertiesResult", "rust");
@@clientName(CertificateIssuerListResult, "ListIssuerPropertiesResult", "rust");

@@clientName(getCertificates, "ListCertificateProperties", "rust");
@@clientName(getCertificateIssuers, "ListIssuerProperties", "rust");
@@clientName(getCertificateVersions,
  "ListCertificatePropertiesVersions",
  "rust"
);
@@clientName(getDeletedCertificates,
  "ListDeletedCertificateProperties",
  "rust"
);
@@clientName(updateCertificate, "UpdateCertificateProperties", "rust");

@@clientName(getCertificateContacts, "GetContacts", "rust");
@@clientName(deleteCertificateContacts, "DeleteContacts", "rust");
@@clientName(setCertificateIssuer, "SetIssuer", "rust");
@@clientName(updateCertificateIssuer, "UpdateIssuer", "rust");
@@clientName(getCertificateIssuer, "GetIssuer", "rust");
@@clientName(deleteCertificateIssuer, "DeleteIssuer", "rust");

@@clientName(Action, "LifetimeActionType", "rust");
@@clientName(Trigger, "LifetimeActionTrigger", "rust");
@@clientName(CertificateBundle, "Certificate", "rust");
@@clientName(CertificateItem, "CertificateProperties", "rust");
@@clientName(DeletedCertificateBundle, "DeletedCertificate", "rust");
@@clientName(DeletedCertificateItem, "DeletedCertificateProperties", "rust");
@@clientName(IssuerBundle, "Issuer", "rust");
@@clientName(CertificateIssuerItem, "IssuerProperties", "rust");
@@clientName(CertificateRestoreParameters.certificateBundleBackup,
  "CertificateBackup",
  "rust"
);

@@clientName(AdministratorDetails, "AdministratorContact", "rust");
@@clientName(OrganizationDetails.admin_details, "AdminContacts", "rust");
@@clientName(Contact.EmailAddress, "Email", "rust");
@@clientName(AdministratorDetails.EmailAddress, "Email", "rust");

@@clientName(SubjectAlternativeNames.upns, "UserPrincipalNames", "rust");
@@clientName(X509CertificateProperties.ekus, "EnhancedKeyUsage", "rust");

@@clientName(JsonWebKeyCurveName, "CurveName", "rust");
@@clientName(JsonWebKeyType, "KeyType", "rust");
