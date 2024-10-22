import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@access(Azure.AI.Client.Connections.get, Access.internal);
@@access(Azure.AI.Client.Connections.list, Access.internal);
@@access(Azure.AI.Client.Connections.listSecrets, Access.internal);
@@access(Azure.AI.Client.ConnectionsListSecretsResponse, Access.internal);
@@access(Azure.AI.Client.ConnectionProperties, Access.internal);
@@access(Azure.AI.Client.ConnectionPropertiesApiKeyAuth, Access.internal);
@@access(Azure.AI.Client.ConnectionPropertiesAADAuth, Access.internal);
@@access(Azure.AI.Client.ConnectionPropertiesSASAuth, Access.internal);
@@access(Azure.AI.Client.CredentialsApiKeyAuth, Access.internal);
@@access(Azure.AI.Client.CredentialsSASAuth, Access.internal);

// The SDK has a hand-written public EndpointProperties class, with two properties of the type below.
// Need to explicilty mention them as "public" here, because otherwise they would not be made public
// since the auto-generated operations that use them are marked as internal above.
@@access(Azure.AI.Client.AuthenticationType, Access.public);
@@access(Azure.AI.Client.ConnectionType, Access.public);
