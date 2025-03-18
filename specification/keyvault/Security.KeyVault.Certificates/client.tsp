import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(KeyVault.Versions.`v7.6_preview.2`)
@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace ClientCustomizations;

@@clientName(KeyVault, "Certificate", "java");
@@clientName(KeyVault, "Client", "go");

using KeyVault;

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
 * The key vault client performs cryptographic key operations and vault operations against the Key Vault service.
 */
@client(
  {
    name: "Client",
    service: KeyVault,
  },
  "go"
)
interface Client {
  /**
   * The GetCertificates operation returns the set of certificates resources in the specified key vault. This operation requires the certificates/list permission.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  @summary("List certificates in a specified key vault")
  @route("/certificates")
  @get
  listCertificateProperties is KeyVaultOperation<
    {
      /**
       * Specifies whether to include certificates which are not completely provisioned.
       */
      @query("includePending")
      includePending?: boolean;
    },
    CertificateListResult
  >;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteCertificate is deleteCertificate;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  setContacts is setCertificateContacts;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getContacts is getCertificateContacts;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteContacts is deleteCertificateContacts;
  /**
   * The GetCertificateIssuers operation returns the set of certificate issuer resources in the specified key vault. This operation requires the certificates/manageissuers/getissuers permission.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  @summary("List certificate issuers for a specified key vault.")
  @route("/certificates/issuers")
  @get
  listIssuerProperties is KeyVaultOperation<{}, CertificateIssuerListResult>;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  setIssuer is setCertificateIssuer;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateIssuer is updateCertificateIssuer;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getIssuer is getCertificateIssuer;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteIssuer is deleteCertificateIssuer;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createCertificate is createCertificate;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  importCertificate is importCertificate;
  /**
   * The GetCertificateVersions operation returns the versions of a certificate in the specified key vault. This operation requires the certificates/list permission.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  @summary("List the versions of a certificate.")
  @route("/certificates/{certificate-name}/versions")
  @get
  listCertificatePropertiesVersions is KeyVaultOperation<
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getCertificatePolicy is getCertificatePolicy;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateCertificatePolicy is updateCertificatePolicy;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateCertificate is updateCertificate;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getCertificate is getCertificate;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateCertificateOperation is updateCertificateOperation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getCertificateOperation is getCertificateOperation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteCertificateOperation is deleteCertificateOperation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  mergeCertificate is mergeCertificate;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  backupCertificate is backupCertificate;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  restoreCertificate is restoreCertificate;
  /**
   * The GetDeletedCertificates operation retrieves the certificates in the current vault which are in a deleted state and ready for recovery or purging. This operation includes deletion-specific information. This operation requires the certificates/get/list permission. This operation can only be enabled on soft-delete enabled vaults.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  @summary("Lists the deleted certificates in the specified vault currently available for recovery.")
  @route("/deletedcertificates")
  @get
  listDeletedCertificateProperties is KeyVaultOperation<
    {
      /**
       * Specifies whether to include certificates which are not completely provisioned.
       */
      @query("includePending")
      includePending?: boolean;
    },
    DeletedCertificateListResult
  >;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getDeletedCertificate is getDeletedCertificate;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  purgeDeletedCertificate is purgeDeletedCertificate;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  recoverDeletedCertificate is recoverDeletedCertificate;
}

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
