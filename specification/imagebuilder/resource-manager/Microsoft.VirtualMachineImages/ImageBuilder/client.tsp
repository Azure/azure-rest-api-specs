import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.VirtualMachineImages;

@@clientName(ImageTemplateProperties.validate, "validation", "java");
@@clientName(AutoRunState.AutoRunEnabled, "Enabled", "java");
@@clientName(AutoRunState.AutoRunDisabled, "Disabled", "java");
@@clientName(Microsoft.VirtualMachineImages,
  "ImageBuilderClient",
  "javascript,python,java"
);
