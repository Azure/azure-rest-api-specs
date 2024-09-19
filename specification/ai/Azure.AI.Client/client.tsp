import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@access(Azure.AI.Client.Connections.getConnections, Access.internal);
@@access(Azure.AI.Client.Connections.getConnectionSecrets, Access.internal);
@@access(Azure.AI.Client.ConnectionDetails, Access.internal);
@@access(Azure.AI.Client.ConnectionProperties, Access.internal);
@@access(Azure.AI.Client.AuthType, Access.internal);
@@access(Azure.AI.Client.ConnectionPropertiesApiKeyAuth, Access.internal);
@@access(Azure.AI.Client.ConnectionPropertiesAADAuth, Access.internal);
@@access(Azure.AI.Client.ConnectionPropertiesSASAuth, Access.internal);
@@access(Azure.AI.Client.CredentialsApiKeyAuth, Access.internal);
@@access(Azure.AI.Client.CredentialsSASAuth, Access.internal);
@@access(Azure.AI.Client.ConnectionCategory, Access.internal);
