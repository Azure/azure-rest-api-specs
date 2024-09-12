import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.ApiCenter;

@@clientName(Apis.createOrUpdate::parameters.resource, "payload");
@@clientName(ApiDefinitions.createOrUpdate::parameters.resource, "payload");
@@clientName(ApiVersions.createOrUpdate::parameters.resource, "payload");
@@clientName(Deployments.createOrUpdate::parameters.resource, "payload");
@@clientName(Environments.createOrUpdate::parameters.resource, "payload");
@@clientName(MetadataSchemas.createOrUpdate::parameters.resource, "payload");
@@clientName(Services.update::parameters.properties, "payload");
@@clientName(Workspaces.createOrUpdate::parameters.resource, "payload");
@@clientName(ApiDefinitions.importSpecification::parameters.body, "payload");
@@clientName(ApiDefinitions.exportSpecification::parameters.body, "payload");
@@clientName(Services.exportMetadataSchema::parameters.body, "payload");
