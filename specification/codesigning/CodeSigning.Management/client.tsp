import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.CodeSigning;
using Azure.Core;

@@clientName(Microsoft.CodeSigning, "TrustedSigningMgmtClient", "python");
@@clientName(Microsoft.CodeSigning, "TrustedSigningManagementClient", "java");

@@clientName(AccountSku, "TrustedSigningAccountSku", "csharp");
@@clientName(Certificate, "TrustedSigningCertificate", "csharp");
@@clientName(CertificateProfile, "TrustedSigningCertificateProfile", "csharp");
@@clientName(CertificateStatus, "TrustedSigningCertificateStatus", "csharp");
@@clientName(ProvisioningState, "TrustedSigningProvisioningState", "csharp");
@@clientName(CheckNameAvailability,
  "TrustedSigningAccountNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailability.type, "ResourceType", "csharp");
@@clientName(CheckNameAvailabilityResult,
  "TrustedSigningAccountNameAvailabilityResult",
  "csharp"
);
@@clientName(CheckNameAvailabilityResult.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(NameUnavailabilityReason,
  "TrustedSigningAccountNameUnavailabilityReason",
  "csharp"
);
@@clientName(CodeSigningAccount, "TrustedSigningAccount", "csharp");
@@clientName(ProfileType, "CertificateProfileType", "csharp");
@@clientName(ProfileType.VBSEnclave, "VbsEnclave", "csharp");
@@clientName(RevocationStatus, "CertificateRevocationStatus", "csharp");
@@clientName(RevokeCertificate, "RevokeCertificateContent", "csharp");
@@clientName(Certificate.createdDate, "CreateOn", "csharp");
@@clientName(Certificate.expiryDate, "ExpireOn", "csharp");
@@clientName(Revocation.status, "RevocationStatus", "csharp");

@@clientName(CodeSigningAccounts.checkNameAvailability,
  "CheckTrustedSigningAccountNameAvailability",
  "csharp"
);
@@clientName(CodeSigningAccounts.checkNameAvailability::parameters.body,
  "content",
  "csharp"
);
@@clientName(CertificateProfiles.revokeCertificate::parameters.body,
  "content",
  "csharp"
);

@@alternateType(Certificate.createdDate, utcDateTime, "csharp");
@@alternateType(Certificate.expiryDate, utcDateTime, "csharp");
@@alternateType(CheckNameAvailability.type, armResourceType, "csharp");
@@alternateType(CodeSigningAccountProperties.accountUri, url, "csharp");
