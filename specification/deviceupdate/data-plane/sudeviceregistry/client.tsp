import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using DeviceRegistrySoftwareUpdateClient;

// Organize the generated SDK operation groups for the Device Registry Software Update
// client surface (SoftwareUpdate / DeviceClasses).
@@clientLocation(SoftwareUpdateOperationGroup.listUpdates, "SoftwareUpdate");
@@clientLocation(SoftwareUpdateOperationGroup.importUpdate, "SoftwareUpdate");
@@clientLocation(SoftwareUpdateOperationGroup.getUpdate, "SoftwareUpdate");
@@clientLocation(SoftwareUpdateOperationGroup.deleteUpdate, "SoftwareUpdate");
@@clientLocation(SoftwareUpdateOperationGroup.listProviders, "SoftwareUpdate");
@@clientLocation(SoftwareUpdateOperationGroup.listNames, "SoftwareUpdate");
@@clientLocation(SoftwareUpdateOperationGroup.listVersions, "SoftwareUpdate");
@@clientLocation(SoftwareUpdateOperationGroup.listFiles, "SoftwareUpdate");
@@clientLocation(SoftwareUpdateOperationGroup.getFile, "SoftwareUpdate");
@@clientLocation(
  SoftwareUpdateOperationGroup.listOperationStatuses,
  "SoftwareUpdate"
);
@@clientLocation(
  SoftwareUpdateOperationGroup.getOperationStatus,
  "SoftwareUpdate"
);

@@clientLocation(DeviceClasses.list, "DeviceClasses");
@@clientLocation(DeviceClasses.getDeviceClass, "DeviceClasses");
@@clientLocation(DeviceClasses.delete, "DeviceClasses");

// Rename generic models for .NET to avoid analyzer AZC0012
// (type names too generic / high collision risk with BCL types).
@@clientName(Compatibility, "SoftwareUpdateCompatibility", "csharp");
@@clientName(Instructions, "SoftwareUpdateInstructions", "csharp");
@@clientName(Step, "SoftwareUpdateStep", "csharp");
@@clientName(
  DeviceRegistrySoftwareUpdateClient.Update,
  "UpdateContent",
  "csharp"
);
