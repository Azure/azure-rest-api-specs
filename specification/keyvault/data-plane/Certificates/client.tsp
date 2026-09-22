import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;

@versioned(KeyVault.Versions)
namespace Customizations;

@@clientName(KeyVault, "CertificateClient", "java");
@@clientName(KeyVault, "Client", "go");
@@clientName(KeyVault, "Certificate", "rust");

// C# customizations: the public Key Vault Certificates surface in .NET is the
// hand-written `CertificateClient`, so the generated low-level transport is
// renamed to avoid name collisions. The TypeSpec emitter places generated
// types in the same `Azure.Security.KeyVault.Certificates` namespace as the
// existing hand-written types (model-namespace: true is honored
// inconsistently), so every wire model whose default name matches a
// hand-written type needs a `csharp`-scoped rename. This is purely additive
// — every rule is gated by the `"csharp"` discriminator and leaves Java /
// Python / Go / JS / Rust output unchanged.
@@clientName(KeyVault, "KeyVaultCertificatesClient", "csharp");
@@clientName(CertificateAttributes, "CertificateAttributesBundle", "csharp");
@@clientName(CertificateOperation, "CertificateOperationBundle", "csharp");
@@clientName(CertificatePolicy, "CertificatePolicyBundle", "csharp");
@@clientName(LifetimeAction, "LifetimeActionBundle", "csharp");
@@clientName(
  SubjectAlternativeNames,
  "SubjectAlternativeNamesProperties",
  "csharp"
);
@@clientName(
  CertificateCreateParameters,
  "CertificateCreateParametersBundle",
  "csharp"
);
@@clientName(
  CertificateUpdateParameters,
  "CertificateUpdateParametersBundle",
  "csharp"
);
@@clientName(IssuerParameters, "IssuerParametersBundle", "csharp");

@@access(KeyVault, Access.internal, "csharp");

using KeyVault;

/** A required certificate version parameter. */
model RequiredCertificateVersionParameter {
  /**
   * The version of the certificate.
   */
  @path("certificate-version")
  @clientName("version", "go")
  certificateVersion: string;
}

@@override(
  KeyVault.updateCertificate,
  replaceParameter(
    KeyVault.updateCertificate,
    "certificateVersion",
    RequiredCertificateVersionParameter.certificateVersion
  ),
  "!rust"
);
@@override(
  KeyVault.getCertificate,
  replaceParameter(
    KeyVault.getCertificate,
    "certificateVersion",
    RequiredCertificateVersionParameter.certificateVersion
  ),
  "!rust"
);

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
@@clientName(
  SubjectAlternativeNames.uris,
  "uniformResourceIdentifiers",
  "java"
);

// Go configuration

@@override(
  getCertificates,
  removeParameter(getCertificates, "maxresults"),
  "go"
);
@@override(
  getCertificateIssuers,
  removeParameter(getCertificateIssuers, "maxresults"),
  "go"
);
@@override(
  getCertificateVersions,
  removeParameter(getCertificateVersions, "maxresults"),
  "go"
);
@@override(
  getDeletedCertificates,
  removeParameter(getDeletedCertificates, "maxresults"),
  "go"
);

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
@@clientName(
  CertificateOperationUpdateParameter,
  "UpdateCertificateOperationParameter",
  "go"
);
@@clientName(
  CertificateRestoreParameters,
  "RestoreCertificateParameters",
  "go"
);
@@clientName(CertificateUpdateParameters, "UpdateCertificateParameters", "go");
@@clientName(CertificateListResult, "CertificatePropertiesListResult", "go");
@@clientName(
  DeletedCertificateListResult,
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
@@clientName(
  CertificateRestoreParameters.certificateBundleBackup,
  "CertificateBackup",
  "go"
);

@@clientName(AdministratorDetails, "AdministratorContact", "go");
@@clientName(OrganizationDetails.admin_details, "AdminContacts", "go");
@@clientName(Contact.EmailAddress, "Email", "go");
@@clientName(AdministratorDetails.EmailAddress, "Email", "go");

@@clientName(SubjectAlternativeNames.upns, "UserPrincipalNames", "go");
@@clientName(SubjectAlternativeNames.uris, "URIs", "go");
@@clientName(SubjectAlternativeNames.ipAddresses, "IPAddresses", "go");
@@clientName(X509CertificateProperties.ekus, "EnhancedKeyUsage", "go");

@@clientName(CertificateBundle.cer, "CER", "go");
@@clientName(CertificateBundle.kid, "KID", "go");
@@clientName(CertificateBundle.sid, "SID", "go");
@@clientName(CertificateOperation.csr, "CSR", "go");

@@clientName(JsonWebKeyCurveName, "CurveName", "go");
@@clientName(JsonWebKeyType, "KeyType", "go");

@@alternateType(CertificateAttributes.recoveryLevel, string, "go");
@@alternateType(CertificateOperation.error, string, "go");

// Rust configuration
@@clientName(setCertificateContacts, "SetContacts", "rust");

// Elide createCertificate but keep the request model for a convenience poller (LRO).
@@scope(KeyVault.createCertificate, "!rust");
@@usage(CertificateCreateParameters, Usage.input, "rust");
@@clientName(
  CertificateCreateParameters,
  "CreateCertificateParameters",
  "rust"
);

@@clientName(
  CertificateImportParameters,
  "ImportCertificateParameters",
  "rust"
);
@@clientName(CertificateIssuerSetParameters, "SetIssuerParameters", "rust");
@@clientName(
  CertificateIssuerUpdateParameters,
  "UpdateIssuerParameters",
  "rust"
);
@@clientName(CertificateMergeParameters, "MergeCertificateParameters", "rust");
@@clientName(
  CertificateOperationUpdateParameter,
  "UpdateCertificateOperationParameter",
  "rust"
);
@@clientName(
  CertificateRestoreParameters,
  "RestoreCertificateParameters",
  "rust"
);
@@clientName(
  CertificateUpdateParameters,
  "UpdateCertificatePropertiesParameters",
  "rust"
);
@@clientName(
  DeletedCertificateListResult,
  "ListDeletedCertificatePropertiesResult",
  "rust"
);
@@clientName(CertificateListResult, "ListCertificatePropertiesResult", "rust");
@@clientName(CertificateIssuerListResult, "ListIssuerPropertiesResult", "rust");

@@clientName(getCertificates, "ListCertificateProperties", "rust");
@@clientName(getCertificateIssuers, "ListIssuerProperties", "rust");
@@clientName(
  getCertificateVersions,
  "ListCertificatePropertiesVersions",
  "rust"
);
@@clientName(
  getDeletedCertificates,
  "ListDeletedCertificateProperties",
  "rust"
);
// Work around issue where previous @override prevent the following line from working without "KeyVault." prefix.
@@clientName(KeyVault.updateCertificate, "UpdateCertificateProperties", "rust");

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
@@clientName(
  CertificateRestoreParameters.certificateBundleBackup,
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
