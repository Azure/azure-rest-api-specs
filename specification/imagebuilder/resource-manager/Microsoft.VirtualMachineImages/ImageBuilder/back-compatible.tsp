import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.VirtualMachineImages;

@@clientLocation(ImageTemplates.get, "VirtualMachineImageTemplates");
@@clientLocation(ImageTemplates.createOrUpdate, "VirtualMachineImageTemplates");
@@clientName(ImageTemplates.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(ImageTemplates.update, "VirtualMachineImageTemplates");
@@clientName(ImageTemplates.update::parameters.properties, "parameters");
@@clientLocation(ImageTemplates.delete, "VirtualMachineImageTemplates");
@@clientLocation(ImageTemplates.listByResourceGroup,
  "VirtualMachineImageTemplates"
);
@@clientLocation(ImageTemplates.list, "VirtualMachineImageTemplates");
@@clientLocation(ImageTemplates.run, "VirtualMachineImageTemplates");
@@clientLocation(ImageTemplates.cancel, "VirtualMachineImageTemplates");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ImageTemplate.properties);

@@clientLocation(RunOutputs.getRunOutput, "VirtualMachineImageTemplates");
@@clientLocation(RunOutputs.listRunOutputs, "VirtualMachineImageTemplates");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RunOutput.properties);

@@clientName(Triggers.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Trigger.properties);
