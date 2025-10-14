import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.ResourceConnector;

// Fix for breaking change: models.SshKey was removed and models.SSHKey was added
@@clientName(Microsoft.ResourceConnector.SSHKey, "SshKey", "java");
