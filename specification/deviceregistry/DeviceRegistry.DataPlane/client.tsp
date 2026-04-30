import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.DeviceRegistry, "DeviceRegistryClient", "python");
@@clientName(Microsoft.DeviceRegistry, "DeviceRegistryClient", "java");
@@clientName(Microsoft.DeviceRegistry, "DeviceRegistryClient", "javascript");
@@clientName(Microsoft.DeviceRegistry, "DeviceRegistryClient", "csharp");

// Internal operations — hidden from public SDK surface.
// Remove @@access lines below to promote an operation to public.
@@access(Microsoft.DeviceRegistry.Devices.provision, Access.internal);
@@access(Microsoft.DeviceRegistry.Devices.getDeviceByExternalId,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.Devices.getDeviceByUuid, Access.internal);
@@access(Microsoft.DeviceRegistry.Devices.executeAction, Access.internal);

@@access(Microsoft.DeviceRegistry.Groups.getGroupsForDevice, Access.internal);

@@access(Microsoft.DeviceRegistry.DeviceCapabilities.createOrReplace,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.DeviceCapabilities.get, Access.internal);
@@access(Microsoft.DeviceRegistry.DeviceCapabilities.update, Access.internal);
@@access(Microsoft.DeviceRegistry.DeviceCapabilities.delete, Access.internal);
@@access(Microsoft.DeviceRegistry.DeviceCapabilities.list, Access.internal);
@@access(Microsoft.DeviceRegistry.DeviceCapabilities.getCapabilityByUuid,
  Access.internal
);

@@access(Microsoft.DeviceRegistry.TwinDeviceStates.createOrReplace,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.TwinDeviceStates.get, Access.internal);
@@access(Microsoft.DeviceRegistry.TwinDeviceStates.update, Access.internal);
@@access(Microsoft.DeviceRegistry.TwinDeviceStates.list, Access.internal);

@@access(Microsoft.DeviceRegistry.CloudDeviceStates.createOrReplace,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.CloudDeviceStates.update, Access.internal);
@@access(Microsoft.DeviceRegistry.CloudDeviceStates.list, Access.internal);

@@access(Microsoft.DeviceRegistry.Operations.get, Access.internal);
@@access(Microsoft.DeviceRegistry.Operations.list, Access.internal);
