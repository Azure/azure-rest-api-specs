import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceFabric;

@@clientName(Microsoft.ServiceFabric,
  "ServiceFabricManagementClient",
  "javascript,python"
);
@@clientName(Azure.ResourceManager.CommonTypes.ProxyResource,
  "ArmProxyResource",
  "python,java,javascript"
);

@@clientName(Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "ManagedIdentity",
  "java"
);

@@clientName(Azure.ResourceManager.CommonTypes.ManagedServiceIdentityType,
  "ManagedIdentityType",
  "java"
);
