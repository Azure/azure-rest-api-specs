import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataProtection;

@@clientName(BackupVaultResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(BackupVaultResources.update::parameters.properties, "parameters");
@@clientName(BackupVaultResources.validateForBackup::parameters.body,
  "parameters"
);

@@clientName(BaseBackupPolicyResources.createOrUpdate::parameters.resource,
  "parameters"
);

@@clientName(BackupInstanceResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(BackupInstanceResources.adhocBackup::parameters.body,
  "parameters"
);
@@clientName(BackupInstanceResources.validateForModifyBackup::parameters.body,
  "parameters"
);
@@clientName(BackupInstanceResources.triggerRehydrate::parameters.body,
  "parameters"
);
@@clientName(BackupInstanceResources.triggerRestore::parameters.body,
  "parameters"
);
@@clientName(BackupInstanceResources.syncBackupInstance::parameters.body,
  "parameters"
);
@@clientName(BackupInstanceResources.validateForRestore::parameters.body,
  "parameters"
);
@@clientName(BackupInstanceResources.find::parameters.body, "parameters");

@@clientName(ResourceGuardResources.put::parameters.resource, "parameters");
@@clientName(ResourceGuardResources.patch::parameters.properties, "parameters");

@@clientName(ResourceGuardProxyBaseResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ResourceGuardProxyBaseResources.unlockDelete::parameters.body,
  "parameters"
);
@@clientName(DataProtectionOperationGroup.checkFeatureSupport::parameters.body,
  "parameters"
);
@@clientName(Operations, "DataProtectionOperations");
@@clientName(EncryptionSettings, "encryptionSettings");
