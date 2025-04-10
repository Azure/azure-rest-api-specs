import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Batch;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BatchAccountCreateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BatchAccountUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CertificateCreateOrUpdateParameters.properties);

@@clientName(ContainerRegistry.username, "userName");

@@clientName(BatchAccounts.create::parameters.resource, "parameters");
@@clientName(BatchAccounts.update::parameters.properties, "parameters");
@@clientName(BatchAccounts.regenerateKey::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BatchAccount.properties);

@@clientName(PrivateEndpointConnections.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(ApplicationPackages.create::parameters.resource, "parameters");
@@clientName(ApplicationPackages.activate::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApplicationPackage.properties);

@@clientName(Applications.create::parameters.resource, "parameters");
@@clientName(Applications.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Application.properties);

@@clientName(Certificates.create::parameters.resource, "parameters");
@@clientName(Certificates.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Certificate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DetectorResponse.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(Pools.create::parameters.resource, "parameters");
@@clientName(Pools.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Pool.properties);
