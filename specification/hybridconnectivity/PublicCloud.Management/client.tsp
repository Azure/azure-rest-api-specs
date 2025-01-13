import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientNamespace(Microsoft.HybridConnectivity,
  "com.azure.resourcemanager.hybridconnectivity",
  "java"
);

@@clientName(Microsoft.HybridConnectivity, "HybridConnectivityMgmt", "python");

@@clientName(Microsoft.HybridConnectivity, "HybridConnectivityMgmtClient", "java");

// interfaces
@@clientName(Microsoft.HybridConnectivity.GenerateAwsTemplate,
  "GenerateAwsTemplate",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.PublicCloudConnectors,
  "PublicCloudConnectors",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.SolutionConfigurations,
  "SolutionConfigurations",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.Inventory,
  "Inventory",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.SolutionTypes,
  "SolutionTypes",
  "java"
);

// unions and models
@@clientName(Microsoft.HybridConnectivity.GenerateAwsTemplateRequest,
  "GenerateAwsTemplateRequest",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.SolutionTypeSettings,
  "SolutionTypeSettings",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.TestPermissionResult,
  "TestPermissionResult",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.SolutionTypePermissions,
  "SolutionTypePermissions",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.SolutionTypeEnum,
  "SolutionTypeEnum",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.Status,
  "Status",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.PublicCloudConnector,
  "PublicCloudConnector",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.PublicCloudConnectorProperties,
  "PublicCloudConnectorProperties",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.HostType,
  "HostType",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.AwsCloudProfile,
  "AwsCloudProfile",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.SolutionConfiguration,
  "SolutionConfiguration",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.SolutionConfigurationProperties,
  "SolutionConfigurationProperties",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.SolutionConfigurationStatus,
  "SolutionConfigurationStatus",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.SolutionTypeResource,
  "SolutionTypeResource",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.SolutionTypeProperties,
  "SolutionTypeProperties",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.SolutionTypeSettingsProperties,
  "SolutionTypeSettingsProperties",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.InventoryResource,
  "InventoryResource",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.InventoryProperties,
  "InventoryProperties",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.CloudNativeType,
  "CloudNativeType",
  "java"
);

@@clientName(Microsoft.HybridConnectivity.SolutionSettings,
  "SolutionSettings",
  "java"
);