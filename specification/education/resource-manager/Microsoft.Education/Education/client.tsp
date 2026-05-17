import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Education;

@@clientName(
  Microsoft.Education,
  "EducationManagementClient",
  "python,javascript"
);
@@visibility(
  Azure.ResourceManager.CommonTypes.OperationListResult.nextLink,
  Lifecycle.Read
);
@@visibility(
  Azure.ResourceManager.CommonTypes.OperationListResult.value,
  Lifecycle.Read
);
@@clientLocation(redeemInvitationCode, "ManagementClient", "go");
