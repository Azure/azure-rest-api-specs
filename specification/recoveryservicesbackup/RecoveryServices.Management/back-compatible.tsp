import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.RecoveryServices;

@@clientName(BackupResourceConfigResources.update::parameters.resource,
  "parameters"
);
@@clientName(BackupResourceConfigResources.patch::parameters.properties,
  "parameters"
);
@@clientName(BackupResourceConfigResources.bMSPrepareDataMove::parameters.body,
  "parameters"
);
@@clientName(BackupResourceConfigResources.bMSTriggerDataMove::parameters.body,
  "parameters"
);

@@clientName(ProtectionIntentResources.createOrUpdate::parameters.resource,
  "parameters"
);

@@clientName(BackupResourceVaultConfigResources.put::parameters.resource,
  "parameters"
);
@@clientName(BackupResourceVaultConfigResources.update::parameters.properties,
  "parameters"
);

@@clientName(BackupResourceEncryptionConfigExtendedResources.update::parameters.resource,
  "parameters"
);

@@clientName(PrivateEndpointConnectionResources.put::parameters.resource,
  "parameters"
);

@@clientName(ProtectedItemResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ProtectedItemResources.trigger::parameters.body, "parameters");
@@clientName(ProtectedItemResources.list::parameters.body, "parameters");

@@clientName(RecoveryPointResources.moveRecoveryPoint::parameters.body,
  "parameters"
);
@@clientName(RecoveryPointResources.trigger::parameters.body, "parameters");
@@clientName(RecoveryPointResources.provision::parameters.body, "parameters");

@@clientName(ProtectionPolicyResources.createOrUpdate::parameters.resource,
  "parameters"
);

@@clientName(ProtectionContainerResources.register::parameters.resource,
  "parameters"
);

@@clientName(ResourceGuardProxyBaseResources.put::parameters.resource,
  "parameters"
);
@@clientName(ResourceGuardProxyBaseResources.unlockDelete::parameters.body,
  "parameters"
);
