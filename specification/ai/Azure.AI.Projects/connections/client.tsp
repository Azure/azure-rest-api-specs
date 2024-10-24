import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@access(Azure.AI.Projects.Connections.get, Access.internal);
@@access(Azure.AI.Projects.Connections.list, Access.internal);
@@access(Azure.AI.Projects.Connections.listSecrets, Access.internal);
@@access(Azure.AI.Projects.ConnectionsListSecretsResponse, Access.internal);
@@access(Azure.AI.Projects.ConnectionProperties, Access.internal);
@@access(Azure.AI.Projects.ConnectionPropertiesApiKeyAuth, Access.internal);
@@access(Azure.AI.Projects.ConnectionPropertiesAADAuth, Access.internal);
@@access(Azure.AI.Projects.ConnectionPropertiesSASAuth, Access.internal);
@@access(Azure.AI.Projects.CredentialsApiKeyAuth, Access.internal);
@@access(Azure.AI.Projects.CredentialsSASAuth, Access.internal);

// The SDK has a hand-written public EndpointProperties class, with two properties of the type below.
// Need to explicilty mention them as "public" here, because otherwise they would not be made public
// since the auto-generated operations that use them are marked as internal above.
@@access(Azure.AI.Projects.AuthenticationType, Access.public);
@@access(Azure.AI.Projects.ConnectionType, Access.public);
