import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@access(Azure.AI.Projects.Connections.getWorkspace, Access.internal);
@@access(Azure.AI.Projects.Connections.listConnections, Access.internal);
@@access(Azure.AI.Projects.Connections.getConnection, Access.internal);
@@access(Azure.AI.Projects.Connections.getConnectionWithSecrets,
  Access.internal
);
@@access(Azure.AI.Projects.GetConnectionResponse, Access.internal);
@@access(Azure.AI.Projects.InternalConnectionProperties, Access.internal);
@@access(Azure.AI.Projects.InternalConnectionPropertiesApiKeyAuth,
  Access.internal
);
@@access(Azure.AI.Projects.InternalConnectionPropertiesAADAuth,
  Access.internal
);
@@access(Azure.AI.Projects.InternalConnectionPropertiesSASAuth,
  Access.internal
);
@@access(Azure.AI.Projects.CredentialsApiKeyAuth, Access.internal);
@@access(Azure.AI.Projects.CredentialsSASAuth, Access.internal);

// The SDK has a hand-written public EndpointProperties class, with two properties of the type below.
// Need to explicilty mention them as "public" here, because otherwise they would not be made public
// since the auto-generated operations that use them are marked as internal above.
@@access(Azure.AI.Projects.AuthenticationType, Access.public);
@@access(Azure.AI.Projects.ConnectionType, Access.public);
