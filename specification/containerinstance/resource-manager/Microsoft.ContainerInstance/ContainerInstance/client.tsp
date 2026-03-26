import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.ContainerInstance;

@@clientName(Microsoft.ContainerInstance,
  "ContainerInstanceManagementClient",
  "javascript,python"
);
@@clientName(Azure.ResourceManager.CommonTypes.Resource,
  "ArmResource",
  "python,javascript"
);
@@clientName(ContainerGroupPropertiesPropertiesInstanceView,
  "ContainerGroupPropertiesInstanceView",
  "go"
);

@@clientName(ContainerGroupPropertiesPropertiesInstanceView,
  "ContainerGroupPropertiesInstanceView",
  "java"
);
@@clientName(ContainerAttachResponse, "ContainerAttachResult", "java");
@@clientName(Microsoft.ContainerInstance.Resource, "ResourcePatch", "java");
@@clientName(ContainerGroupProperties,
  "ContainerGroupPropertiesWrapper",
  "java"
);
@@clientName(ContainerGroupPropertiesProperties,
  "ContainerGroupProperties",
  "java"
);
@@clientName(UserAssignedIdentities,
  "ContainerGroupIdentityUserAssignedIdentities",
  "java"
);
