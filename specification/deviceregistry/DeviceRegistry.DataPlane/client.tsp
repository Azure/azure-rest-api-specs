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
@@access(Microsoft.DeviceRegistry.ProvisionDeviceResults.get, Access.internal);
@@access(Microsoft.DeviceRegistry.Devices.reprovision, Access.internal);
@@access(Microsoft.DeviceRegistry.ReprovisionDeviceResults.get,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.Devices.query, Access.internal);
@@access(Microsoft.DeviceRegistry.Devices.getDeviceByExternalId,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.Devices.getDeviceByUuid, Access.internal);

@@access(Microsoft.DeviceRegistry.Groups.getGroupByUuid, Access.internal);

@@access(Microsoft.DeviceRegistry.DeviceCapabilities.createOrReplace,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.DeviceCapabilities.update, Access.internal);
@@access(Microsoft.DeviceRegistry.DeviceCapabilities.delete, Access.internal);
@@access(Microsoft.DeviceRegistry.DeviceCapabilities.getCapabilityByUuid,
  Access.internal
);

@@access(Microsoft.DeviceRegistry.DeviceStates.createOrReplace,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.DeviceStates.get, Access.internal);
@@access(Microsoft.DeviceRegistry.DeviceStates.update, Access.internal);
@@access(Microsoft.DeviceRegistry.DeviceStates.list, Access.internal);

@@access(Microsoft.DeviceRegistry.DeviceAttributes.createOrReplace,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.DeviceAttributes.update, Access.internal);
@@access(Microsoft.DeviceRegistry.DeviceAttributes.delete, Access.internal);

@@access(Microsoft.DeviceRegistry.DeviceAuthenticationProfiles.createOrReplace,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.DeviceAuthenticationProfiles.update,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.DeviceAuthenticationProfiles.delete,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.DeviceAuthenticationProfiles.issueCert,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.DeviceAuthenticationProfiles.getAuthenticationProfileByUuid,
  Access.internal
);
@@access(Microsoft.DeviceRegistry.IssueCertResults.get, Access.internal);
