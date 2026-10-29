import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.ChangeSafety;
using Azure.ClientGenerator.Core;

@@clientName(
  ChangeRecordVerifyChangeValidityRequest,
  "ChangeRecordVerifyChangeValidityContent",
  "csharp"
);
@@clientName(
  ChangeRecordVerifyChangeValidityResponse,
  "ChangeRecordVerifyChangeValidityResult",
  "csharp"
);
