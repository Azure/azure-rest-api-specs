import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@access(AzureAI.Endpoints.list, Access.internal);
@@access(AzureAI.Endpoints.listSecrets, Access.internal);
@@access(AzureAI.Endpoints.ConnectionsListSecretsResponse, Access.internal);
@@access(AzureAI.Endpoints.ConnectionProperties, Access.internal);
@@access(AzureAI.Endpoints.ConnectionPropertiesApiKeyAuth, Access.internal);
@@access(AzureAI.Endpoints.ConnectionPropertiesAADAuth, Access.internal);
@@access(AzureAI.Endpoints.ConnectionPropertiesSASAuth, Access.internal);
@@access(AzureAI.Endpoints.CredentialsApiKeyAuth, Access.internal);
@@access(AzureAI.Endpoints.CredentialsSASAuth, Access.internal);

/*
@@access(Azure.AI.Client.AuthenticationType, Access.internal);
@@access(Azure.AI.Client.EndpointType, Access.internal);
*/