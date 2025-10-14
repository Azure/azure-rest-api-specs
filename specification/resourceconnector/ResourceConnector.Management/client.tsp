import "./main.tsp";

using Microsoft.ResourceConnector;

// Fix for breaking change: models.SshKey was removed and models.SSHKey was added
@@clientName(Microsoft.ResourceConnector.SSHKey, "SshKey", "java");
