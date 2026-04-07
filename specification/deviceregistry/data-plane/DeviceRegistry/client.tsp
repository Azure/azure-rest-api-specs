import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.DeviceRegistry, "DeviceRegistryClient", "python");
@@clientName(Microsoft.DeviceRegistry, "DeviceRegistryClient", "java");
@@clientName(Microsoft.DeviceRegistry, "DeviceRegistryClient", "javascript");
@@clientName(Microsoft.DeviceRegistry, "DeviceRegistryClient", "csharp");

// Internal operations — hidden from public SDK surface.
// Remove @@access lines below to promote an operation to public.
@@access(Microsoft.DeviceRegistry.Devices.importDevices, Access.internal);
@@access(Microsoft.DeviceRegistry.Devices.updateDevices, Access.internal);
@@access(Microsoft.DeviceRegistry.Devices.exportDevices, Access.internal);
@@access(Microsoft.DeviceRegistry.Devices.getDeviceByExternalId,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.Devices.getGroupMemberships, Access.internal);
@@access(Microsoft.DeviceRegistry.Devices.getDeviceCapabilityByUuid,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.Devices.queryDevices, Access.internal);
@@access(Microsoft.DeviceRegistry.Devices.executeAction, Access.internal);
@@access(Microsoft.DeviceRegistry.DeviceCapabilities.createOrReplace,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.DeviceCapabilities.get, Access.internal);
@@access(Microsoft.DeviceRegistry.DeviceCapabilities.update, Access.internal);
@@access(Microsoft.DeviceRegistry.DeviceCapabilities.delete, Access.internal);
@@access(Microsoft.DeviceRegistry.DeviceCapabilities.list, Access.internal);
@@access(Microsoft.DeviceRegistry.DeviceStates.createOrReplace,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.DeviceStates.get, Access.internal);
@@access(Microsoft.DeviceRegistry.DeviceStates.update, Access.internal);
