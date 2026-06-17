import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.ProgramEnrollment;
using Azure.ClientGenerator.Core;

@@clientName(DomainGroup, "ProgramEnrollmentDomainGroup", "csharp");
@@clientName(DomainGroupState, "ProgramEnrollmentDomainGroupState", "csharp");
@@clientName(ProvisioningState, "ProgramEnrollmentProvisioningState", "csharp");

@@clientName(
  Microsoft.ProgramEnrollment,
  "ProgramEnrollmentMgmtClient",
  "python"
);
