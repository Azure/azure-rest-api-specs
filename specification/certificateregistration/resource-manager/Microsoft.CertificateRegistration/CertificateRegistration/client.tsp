import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.CertificateRegistration,
  "CertificateRegistrationManagementClient",
  "javascript"
);

@@clientName(Microsoft.CertificateRegistration,
  "CertificateRegistrationMgmtClient",
  "python"
);
