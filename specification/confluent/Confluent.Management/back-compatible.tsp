import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Confluent;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConfluentAgreementResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SchemaRegistryClusterRecord.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RegionRecord.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(APIKeyRecord.properties);

@@clientName(OrganizationResources.create::parameters.resource, "body");
@@clientName(OrganizationResources.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OrganizationResource.properties);

@@clientName(SCEnvironmentRecords.createOrUpdate::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SCEnvironmentRecord.properties);

@@clientName(SCClusterRecords.createOrUpdate::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SCClusterRecord.properties);

@@clientName(ConnectorResources.createOrUpdate::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConnectorResource.properties);

@@clientName(TopicRecords.create::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TopicRecord.properties);
