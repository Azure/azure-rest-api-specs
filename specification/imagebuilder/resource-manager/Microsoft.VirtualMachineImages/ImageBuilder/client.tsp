import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.VirtualMachineImages;

@@clientName(ImageTemplateProperties.validate, "validation", "java");
@@clientName(Microsoft.VirtualMachineImages,
  "ImageBuilderClient",
  "javascript"
);
@@clientName(Microsoft.VirtualMachineImages,
  "ImageBuilderClient",
  "python"
);
