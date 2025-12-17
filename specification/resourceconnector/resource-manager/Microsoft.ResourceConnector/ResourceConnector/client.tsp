import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.ResourceConnector;

@@clientName(Microsoft.ResourceConnector,
  "ResourceConnectorManagementClient",
  "javascript"
);
@@clientName(Microsoft.ResourceConnector,
  "ResourceConnectorMgmtClient",
  "python"
);

@@clientName(Microsoft.ResourceConnector.SSHKey, "SshKey", "java");

// Fix property name case changes to maintain backward compatibility
@@clientName(Microsoft.ResourceConnector.SSHKey.expirationTimeStamp,
  "expirationTimestamp",
  "java"
);
@@clientName(Microsoft.ResourceConnector.SSHKey.creationTimeStamp,
  "creationTimestamp",
  "java"
);

@@clientName(Microsoft.ResourceConnector.Appliance, "Appliance", "csharp");
@@clientName(Microsoft.ResourceConnector.SupportedVersionCatalogVersionData,
  "SupportedVersionCatalogVersionDataField",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.ApplianceOperation,
  "OperationEntity",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.ApplianceOperationValueDisplay,
  "OperationDisplay",
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
