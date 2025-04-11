import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(KeyVault, "Certificate", "java");
@@clientName(KeyVault, "Client", "go");
@@clientName(KeyVault, "Certificate", "rust");

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

// rename Go operations
@@clientName(setCertificateContacts, "SetContacts", "go");

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

@@clientName(getCertificates, "ListCertificateProperties", "go");
@@clientName(getCertificateIssuers, "ListIssuerProperties", "go");
@@clientName(getCertificateVersions, "ListCertificatePropertiesVersions", "go");
@@clientName(getDeletedCertificates, "ListDeletedCertificateProperties", "go");
@@clientName(CertificateListResult, "CertificatePropertiesListResult", "go");
@@clientName(DeletedCertificateListResult,
  "DeletedCertificatePropertiesListResult",
  "go"
);

@@clientName(getCertificateContacts, "GetContacts", "go");
@@clientName(deleteCertificateContacts, "DeleteContacts", "go");
@@clientName(setCertificateIssuer, "SetIssuer", "go");
@@clientName(updateCertificateIssuer, "UpdateIssuer", "go");
@@clientName(getCertificateIssuer, "GetIssuer", "go");
@@clientName(deleteCertificateIssuer, "DeleteIssuer", "go");
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
