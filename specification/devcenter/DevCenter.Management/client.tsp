import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.DevCenter, "DevCenterMgmtClient", "python");

@@clientName(Microsoft.DevCenter.DevCenterProjectCatalogSettings,
  "ProjectCatalogSettingsInfo",
  "go"
);

@@clientName(Microsoft.DevCenter.DevCenterSku, "SkuInfo", "go");

@@clientName(Microsoft.DevCenter.UserRoleAssignment, "UserRoleAssignmentValue");

@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentity,
  "CustomerManagedKeyEncryptionKeyIdentity",
  "java"
);

@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentityType,
  "IdentityType",
  "java"
);

@@alternateType(Microsoft.DevCenter.OperationStatus.properties,
  unknown,
  "java"
);
