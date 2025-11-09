import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

@@clientName(NetworkApiVersion.`2020-11-01`, "TwoThousandTwenty1101", "go");
@@clientName(NetworkApiVersion.`2022-11-01`, "TwoThousandTwentyTwo1101", "go");

@@alternateType(VirtualMachineScaleSetStorageProfile.diskControllerType,
  string,
  "go"
);
@@alternateType(VirtualMachineScaleSetUpdateStorageProfile.diskControllerType,
  string,
  "go"
);

@@clientName(VirtualMachineSizeTypes.Standard_B1ms, "StandardB1Ms", "go");
@@clientName(VirtualMachineSizeTypes.Standard_B2ms, "StandardB2Ms", "go");
@@clientName(VirtualMachineSizeTypes.Standard_B4ms, "StandardB4Ms", "go");
@@clientName(VirtualMachineSizeTypes.Standard_B8ms, "StandardB8Ms", "go");
@@clientName(VirtualMachineSizeTypes.`Standard_M128-32ms`,
  "StandardM12832Ms",
  "go"
);
@@clientName(VirtualMachineSizeTypes.`Standard_M128-64ms`,
  "StandardM12864Ms",
  "go"
);
@@clientName(VirtualMachineSizeTypes.Standard_M128ms, "StandardM128Ms", "go");
@@clientName(VirtualMachineSizeTypes.`Standard_M64-16ms`,
  "StandardM6416Ms",
  "go"
);
@@clientName(VirtualMachineSizeTypes.`Standard_M64-32ms`,
  "StandardM6432Ms",
  "go"
);
@@clientName(VirtualMachineSizeTypes.Standard_M64ms, "StandardM64Ms", "go");

@@alternateType(AdditionalUnattendContent.passName, "OobeSystem", "go");
@@alternateType(AdditionalUnattendContent.componentName,
  "Microsoft-Windows-Shell-Setup",
  "go"
);
