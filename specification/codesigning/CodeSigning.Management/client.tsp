import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.CodeSigning;
using Azure.Core;

@@clientName(Microsoft.CodeSigning, "ArtifactSigningMgmtClient", "python");
@@clientName(Microsoft.CodeSigning, "ArtifactSigningManagementClient", "java");

@@clientName(AccountSku, "ArtifactSigningAccountSku", "csharp");
@@clientName(Certificate, "ArtifactSigningCertificate", "csharp");
@@clientName(CertificateProfile, "ArtifactSigningCertificateProfile", "csharp");
@@clientName(CertificateStatus, "ArtifactSigningCertificateStatus", "csharp");
@@clientName(ProvisioningState, "ArtifactSigningProvisioningState", "csharp");
@@clientName(CheckNameAvailability,
  "ArtifactSigningAccountNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailability.type, "ResourceType", "csharp");
@@clientName(CheckNameAvailabilityResult,
  "ArtifactSigningAccountNameAvailabilityResult",
  "csharp"
);
@@clientName(CheckNameAvailabilityResult.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(NameUnavailabilityReason,
  "ArtifactSigningAccountNameUnavailabilityReason",
  "csharp"
);
@@clientName(CodeSigningAccount, "ArtifactSigningAccount", "csharp");
@@clientName(ProfileType, "CertificateProfileType", "csharp");
@@clientName(ProfileType.VBSEnclave, "VbsEnclave", "csharp");
@@clientName(RevocationStatus, "CertificateRevocationStatus", "csharp");
@@clientName(RevokeCertificate, "RevokeCertificateContent", "csharp");
@@clientName(Certificate.createdDate, "CreateOn", "csharp");
@@clientName(Certificate.expiryDate, "ExpireOn", "csharp");
@@clientName(Revocation.status, "RevocationStatus", "csharp");

@@clientName(CodeSigningAccounts.checkNameAvailability,
  "CheckArtifactSigningAccountNameAvailability",
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
