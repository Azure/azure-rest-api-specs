import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Azure.AI.Connections, "AIConnectionsClient");

@@access(Azure.AI.Connections.getWorkspace, Access.internal);
@@access(Azure.AI.Connections.listConnections, Access.internal);
@@access(Azure.AI.Connections.getConnection, Access.internal);
@@access(Azure.AI.Connections.getConnectionWithSecrets, Access.internal);
@@access(Azure.AI.Connections.GetConnectionResponse, Access.internal);
@@access(Azure.AI.Connections.InternalConnectionProperties, Access.internal);
@@access(Azure.AI.Connections.InternalConnectionPropertiesApiKeyAuth,
  Access.internal
);
@@access(Azure.AI.Connections.InternalConnectionPropertiesAADAuth,
  Access.internal
);
@@access(Azure.AI.Connections.InternalConnectionPropertiesSASAuth,
  Access.internal
);
@@access(Azure.AI.Connections.CredentialsApiKeyAuth, Access.internal);
@@access(Azure.AI.Connections.CredentialsSASAuth, Access.internal);

// The SDK has a hand-written public EndpointProperties class, with two properties of the type below.
// Need to explicitly mention them as "public" here, because otherwise they would not be made public
// since the auto-generated operations that use them are marked as internal above.
@@access(Azure.AI.Connections.AuthenticationType, Access.public);
@@access(Azure.AI.Connections.ConnectionType, Access.public);
