import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@access(AzureAI.Endpoints.list, Access.internal);
@@access(AzureAI.Endpoints.listSecrets, Access.internal);
@@access(AzureAI.ConnectionsListSecretsResponse, Access.internal);
@@access(AzureAI.ConnectionProperties, Access.internal);
@@access(AzureAI.ConnectionPropertiesApiKeyAuth, Access.internal);
@@access(AzureAI.ConnectionPropertiesAADAuth, Access.internal);
@@access(AzureAI.ConnectionPropertiesSASAuth, Access.internal);
@@access(AzureAI.CredentialsApiKeyAuth, Access.internal);
@@access(AzureAI.CredentialsSASAuth, Access.internal);

/*
@@access(Azure.AI.Client.AuthenticationType, Access.internal);
@@access(Azure.AI.Client.EndpointType, Access.internal);
*/
