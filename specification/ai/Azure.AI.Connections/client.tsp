import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Azure.AI.Connections, "AIConnectionsClient");

@@access(Azure.AI.Connections.getWorkspace, Access.internal);
@@access(Azure.AI.Connections.listConnections, Access.internal);
@@access(Azure.AI.Connections.getConnection, Access.internal);
@@access(Azure.AI.Connections.getConnectionWithSecrets, Access.internal);
@@access(Azure.AI.GetConnectionResponse, Access.internal);
@@access(Azure.AI.InternalConnectionProperties, Access.internal);
@@access(Azure.AI.InternalConnectionPropertiesApiKeyAuth, Access.internal);
@@access(Azure.AI.InternalConnectionPropertiesAADAuth, Access.internal);
@@access(Azure.AI.InternalConnectionPropertiesSASAuth, Access.internal);
@@access(Azure.AI.CredentialsApiKeyAuth, Access.internal);
@@access(Azure.AI.CredentialsSASAuth, Access.internal);

// The SDK has a hand-written public EndpointProperties class, with two properties of the type below.
// Need to explicilty mention them as "public" here, because otherwise they would not be made public
// since the auto-generated operations that use them are marked as internal above.
@@access(Azure.AI.AuthenticationType, Access.public);
@@access(Azure.AI.ConnectionType, Access.public);
