import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
<<<<<<< HEAD
using Microsoft.ResourceConnector;

// Fix for breaking change: models.SshKey was removed and models.SSHKey was added
@@clientName(Microsoft.ResourceConnector.SSHKey, "SshKey", "java");

// Fix property name case changes to maintain backward compatibility
@@clientName(Microsoft.ResourceConnector.SSHKey.expirationTimeStamp,
  "expirationTimestamp",
  "java"
);
@@clientName(Microsoft.ResourceConnector.SSHKey.creationTimeStamp,
  "creationTimestamp",
  "java"
=======

@@clientName(Microsoft.ResourceConnector,
  "ResourceConnectorManagementClient",
  "javascript"
>>>>>>> a7a23cc3f20c807a00573e2c6124b257427e9513
);
