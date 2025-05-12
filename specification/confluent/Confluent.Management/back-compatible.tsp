import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Confluent;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConfluentAgreementResource.properties);

@@clientName(ConfluentListMetadata.total_size, "totalSize");

@@clientName(UserRecord.full_name, "fullName");
@@clientName(UserRecord.auth_type, "authType");

@@clientName(MetadataEntity.resource_name, "resourceName");
@@clientName(MetadataEntity.created_at, "createdAt");
@@clientName(MetadataEntity.updated_at, "updatedAt");
@@clientName(MetadataEntity.deleted_at, "deletedAt");

@@clientName(ServiceAccountRecord.display_name, "displayName");

@@clientName(InvitationRecord.auth_type, "authType");
@@clientName(InvitationRecord.accepted_at, "acceptedAt");
@@clientName(InvitationRecord.expires_at, "expiresAt");

@@clientName(AccessInvitedUserDetails.auth_type, "authType");

@@clientName(EnvironmentRecord.display_name, "displayName");

@@clientName(ClusterRecord.display_name, "displayName");

@@clientName(ClusterSpecEntity.display_name, "displayName");
@@clientName(ClusterSpecEntity.kafka_bootstrap_endpoint,
  "kafkaBootstrapEndpoint"
);
@@clientName(ClusterSpecEntity.http_endpoint, "httpEndpoint");
@@clientName(ClusterSpecEntity.api_endpoint, "apiEndpoint");

@@clientName(ClusterEnvironmentEntity.resource_name, "resourceName");

@@clientName(ClusterNetworkEntity.resource_name, "resourceName");

@@clientName(ClusterByokEntity.resource_name, "resourceName");

@@clientName(RoleBindingRecord.role_name, "roleName");
@@clientName(RoleBindingRecord.crn_pattern, "crnPattern");

@@clientName(AccessCreateRoleBindingRequestModel.role_name, "roleName");
@@clientName(AccessCreateRoleBindingRequestModel.crn_pattern, "crnPattern");

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
