import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace ClientCustomizations;

@@clientName(Anyscale.Platform, "AnyscaleMgmtClient", "python");

@@clientName(Anyscale.Platform.Clouds.get, "GetAnyscaleCloud", "csharp");
@@clientName(
  Anyscale.Platform.CloudResources.get,
  "GetAnyscaleComputeResource",
  "csharp"
);
