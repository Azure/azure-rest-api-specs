import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@access(Azure.AI.Client.Connections.list, Access.internal);
@@access(Azure.AI.Client.Connections.listSecrets, Access.internal);
@@access(Azure.AI.Client.ConnectionsListSecretsResponse, Access.internal);
@@access(Azure.AI.Client.ConnectionProperties, Access.internal);
@@access(Azure.AI.Client.AuthenticationType, Access.internal);
@@access(Azure.AI.Client.ConnectionPropertiesApiKeyAuth, Access.internal);
@@access(Azure.AI.Client.ConnectionPropertiesAADAuth, Access.internal);
@@access(Azure.AI.Client.ConnectionPropertiesSASAuth, Access.internal);
@@access(Azure.AI.Client.CredentialsApiKeyAuth, Access.internal);
@@access(Azure.AI.Client.CredentialsSASAuth, Access.internal);
@@access(Azure.AI.Client.ConnectionType, Access.internal);
