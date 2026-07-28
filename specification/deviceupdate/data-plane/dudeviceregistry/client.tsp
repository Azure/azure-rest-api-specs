import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using DeviceRegistryUpdateClient;

// Preserve the existing Device Update Error model names in C# while avoiding
// collisions with the standard Azure.Core error models used by LRO metadata.
@@clientName(
  Azure.Core.Foundations.ErrorResponse,
  "AzureCoreErrorResponse",
  "csharp"
);
@@clientName(Azure.Core.Foundations.Error, "AzureCoreError", "csharp");
@@clientName(
  Azure.Core.Foundations.InnerError,
  "AzureCoreInnerError",
  "csharp"
);

// Organize the generated SDK operation groups for the Device Registry Update
// client surface (DeviceUpdate / DeviceClasses).
@@clientLocation(DeviceUpdateOperationGroup.listUpdates, "DeviceUpdate");
@@clientLocation(DeviceUpdateOperationGroup.importUpdate, "DeviceUpdate");
@@clientLocation(DeviceUpdateOperationGroup.getUpdate, "DeviceUpdate");
@@clientLocation(DeviceUpdateOperationGroup.deleteUpdate, "DeviceUpdate");
@@clientLocation(DeviceUpdateOperationGroup.listProviders, "DeviceUpdate");
@@clientLocation(DeviceUpdateOperationGroup.listNames, "DeviceUpdate");
@@clientLocation(DeviceUpdateOperationGroup.listVersions, "DeviceUpdate");
@@clientLocation(DeviceUpdateOperationGroup.listFiles, "DeviceUpdate");
@@clientLocation(DeviceUpdateOperationGroup.getFile, "DeviceUpdate");
@@clientLocation(
  DeviceUpdateOperationGroup.listOperationStatuses,
  "DeviceUpdate"
);
@@clientLocation(DeviceUpdateOperationGroup.getOperationStatus, "DeviceUpdate");

@@clientLocation(DeviceClasses.list, "DeviceClasses");
@@clientLocation(DeviceClasses.getDeviceClass, "DeviceClasses");
@@clientLocation(DeviceClasses.delete, "DeviceClasses");
