import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.RedHatOpenShift,
  "AzureRedHatOpenShiftClient",
  "javascript,python"
);

@@clientName(Microsoft.RedHatOpenShift.APIServerProfile,
  "ApiServerProfile",
  "java"
);
@@clientName(Microsoft.RedHatOpenShift.EffectiveOutboundIP,
  "EffectiveOutboundIp",
  "java"
);
@@clientName(Microsoft.RedHatOpenShift.PreconfiguredNSG,
  "PreconfiguredNsg",
  "java"
);
@@clientName(Microsoft.RedHatOpenShift.NetworkProfile.preconfiguredNSG,
  "preconfiguredNsg",
  "java"
);
