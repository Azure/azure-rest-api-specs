import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@access(Azure.AI.Project.Connections.get, Access.internal);
@@access(Azure.AI.Project.Connections.list, Access.internal);
@@access(Azure.AI.Project.Connections.listSecrets, Access.internal);
@@access(Azure.AI.Project.ConnectionsListSecretsResponse, Access.internal);
@@access(Azure.AI.Project.ConnectionProperties, Access.internal);
@@access(Azure.AI.Project.ConnectionPropertiesApiKeyAuth, Access.internal);
@@access(Azure.AI.Project.ConnectionPropertiesAADAuth, Access.internal);
@@access(Azure.AI.Project.ConnectionPropertiesSASAuth, Access.internal);
@@access(Azure.AI.Project.CredentialsApiKeyAuth, Access.internal);
@@access(Azure.AI.Project.CredentialsSASAuth, Access.internal);

// The SDK has a hand-written public EndpointProperties class, with two properties of the type below.
// Need to explicilty mention them as "public" here, because otherwise they would not be made public
// since the auto-generated operations that use them are marked as internal above.
@@access(Azure.AI.Project.AuthenticationType, Access.public);
@@access(Azure.AI.Project.ConnectionType, Access.public);
