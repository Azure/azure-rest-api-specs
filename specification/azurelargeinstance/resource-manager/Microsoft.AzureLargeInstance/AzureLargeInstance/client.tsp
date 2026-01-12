import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.AzureLargeInstance;

@@clientName(AzureLargeStorageInstance, "LargeStorageInstance", "csharp");
@@clientName(AzureLargeInstance, "LargeInstance", "csharp");
@@clientName(AzureLargeInstanceForcePowerState,
  "LargeInstanceForcePowerState",
  "csharp"
);
@@clientName(AzureLargeInstanceHardwareTypeNamesEnum,
  "LargeInstanceHardwareTypeName",
  "csharp"
);
// @@clientName(AzureLargeInstanceHardwareTypeNamesEnum."Cisco_UCS",
//   "CiscoUcs",
//   "csharp"
// );
// @@clientName(AzureLargeInstanceHardwareTypeNamesEnum."HPE", "Hpe", "csharp");
// @@clientName(AzureLargeInstanceHardwareTypeNamesEnum."SDFLEX",
//   "SDFlex",
//   "csharp"
// );
@@clientName(AzureLargeInstancePowerStateEnum,
  "LargeInstancePowerState",
  "csharp"
);
@@clientName(AzureLargeInstanceProvisioningStatesEnum,
  "LargeInstanceProvisioningState",
  "csharp"
);
@@clientName(AzureLargeInstanceSizeNamesEnum,
  "LargeInstanceSizeName",
  "csharp"
);
// @@clientName(AzureLargeInstanceSizeNamesEnum.S72m, "S72m", "csharp");
// @@clientName(AzureLargeInstanceSizeNamesEnum.S144m, "S144m", "csharp");
// @@clientName(AzureLargeInstanceSizeNamesEnum.S192m, "S192m", "csharp");
// @@clientName(AzureLargeInstanceSizeNamesEnum.S224m, "S224m", "csharp");
// @@clientName(AzureLargeInstanceSizeNamesEnum.S384m, "S384m", "csharp");
// @@clientName(AzureLargeInstanceSizeNamesEnum.S448m, "S448m", "csharp");
// @@clientName(AzureLargeInstanceSizeNamesEnum.S576m, "S576m", "csharp");
// @@clientName(AzureLargeInstanceSizeNamesEnum.S672m, "S672m", "csharp");
// @@clientName(AzureLargeInstanceSizeNamesEnum.S768m, "S768m", "csharp");
// @@clientName(AzureLargeInstanceSizeNamesEnum.S896m, "S896m", "csharp");
// @@clientName(AzureLargeInstanceSizeNamesEnum.S960m, "S960m", "csharp");
