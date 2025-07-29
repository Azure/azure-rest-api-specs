import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DevCenter;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DevCenterUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EncryptionSetUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProjectPolicyUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProjectUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CatalogUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EnvironmentTypeUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProjectEnvironmentTypeUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DevBoxDefinitionUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PoolUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScheduleUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkConnectionUpdate.properties);

@@clientName(DevCenters.createOrUpdate::parameters.resource, "body");
@@clientName(DevCenters.update::parameters.properties, "body");
@@clientLocation(DevCenters.listByDevCenter, "Images");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DevCenter.properties);

@@clientLocation(DevCenterEncryptionSets.get, "EncryptionSets");
@@clientLocation(DevCenterEncryptionSets.createOrUpdate, "EncryptionSets");
@@clientName(DevCenterEncryptionSets.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(DevCenterEncryptionSets.update, "EncryptionSets");
@@clientName(DevCenterEncryptionSets.update::parameters.properties, "body");
@@clientLocation(DevCenterEncryptionSets.delete, "EncryptionSets");
@@clientLocation(DevCenterEncryptionSets.list, "EncryptionSets");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DevCenterEncryptionSet.properties);

@@clientName(ProjectPolicies.createOrUpdate::parameters.resource, "body");
@@clientName(ProjectPolicies.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProjectPolicy.properties);

@@clientName(Projects.createOrUpdate::parameters.resource, "body");
@@clientName(Projects.update::parameters.properties, "body");
@@clientLocation(Projects.listByProject, "Skus");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Project.properties);

@@clientLocation(AttachedNetworkConnections.getByProject, "AttachedNetworks");
@@clientLocation(AttachedNetworkConnections.listByProject, "AttachedNetworks");
@@clientName(AttachedNetworks.createOrUpdate::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AttachedNetworkConnection.properties);

@@clientLocation(Catalogs.get, "ProjectCatalogs");
@@clientLocation(Catalogs.createOrUpdate, "ProjectCatalogs");
@@clientName(Catalogs.createOrUpdate::parameters.resource, "body");
@@clientLocation(Catalogs.patch, "ProjectCatalogs");
@@clientName(Catalogs.patch::parameters.properties, "body");
@@clientLocation(Catalogs.delete, "ProjectCatalogs");
@@clientLocation(Catalogs.list, "ProjectCatalogs");
@@clientLocation(Catalogs.getSyncErrorDetails, "ProjectCatalogs");
@@clientLocation(Catalogs.sync, "ProjectCatalogs");
@@clientLocation(Catalogs.connect, "ProjectCatalogs");
@@clientLocation(CatalogOperationGroup.get, "Catalogs");
@@clientLocation(CatalogOperationGroup.createOrUpdate, "Catalogs");
@@clientName(CatalogOperationGroup.createOrUpdate::parameters.resource, "body");
@@clientLocation(CatalogOperationGroup.update, "Catalogs");
@@clientName(CatalogOperationGroup.update::parameters.properties, "body");
@@clientLocation(CatalogOperationGroup.delete, "Catalogs");
@@clientLocation(CatalogOperationGroup.listByDevCenter, "Catalogs");
@@clientLocation(CatalogOperationGroup.getSyncErrorDetails, "Catalogs");
@@clientLocation(CatalogOperationGroup.sync, "Catalogs");
@@clientLocation(CatalogOperationGroup.connect, "Catalogs");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Catalog.properties);

@@clientLocation(EnvironmentDefinitions.getErrorDetails,
  "ProjectCatalogEnvironmentDefinitions"
);
@@clientLocation(EnvironmentDefinitionOperationGroup.get,
  "EnvironmentDefinitions"
);
@@clientLocation(EnvironmentDefinitionOperationGroup.listByCatalog,
  "EnvironmentDefinitions"
);
@@clientLocation(EnvironmentDefinitionOperationGroup.getErrorDetails,
  "EnvironmentDefinitions"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EnvironmentDefinition.properties);

@@clientName(Galleries.createOrUpdate::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Gallery.properties);

@@clientLocation(ImageOperationGroup.getByProject, "Images");
@@clientLocation(ImageOperationGroup.listByProject, "Images");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Image.properties);

@@clientLocation(ImageVersionOperationGroup.getByProject, "ImageVersions");
@@clientLocation(ImageVersionOperationGroup.listByProject, "ImageVersions");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ImageVersion.properties);

@@clientName(EnvironmentTypes.createOrUpdate::parameters.resource, "body");
@@clientName(EnvironmentTypes.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EnvironmentType.properties);

@@clientLocation(AllowedEnvironmentTypes.get, "ProjectAllowedEnvironmentTypes");
@@clientLocation(AllowedEnvironmentTypes.list,
  "ProjectAllowedEnvironmentTypes"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AllowedEnvironmentType.properties);

@@clientName(ProjectEnvironmentTypes.createOrUpdate::parameters.resource,
  "body"
);
@@clientName(ProjectEnvironmentTypes.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProjectEnvironmentType.properties);

@@clientName(DevBoxDefinitions.createOrUpdate::parameters.resource, "body");
@@clientName(DevBoxDefinitions.update::parameters.properties, "body");
@@clientLocation(DevBoxDefinitionOperationGroup.getByProject,
  "DevBoxDefinitions"
);
@@clientLocation(DevBoxDefinitionOperationGroup.listByProject,
  "DevBoxDefinitions"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DevBoxDefinition.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CustomizationTask.properties);

@@clientLocation(ImageDefinitions.getByDevCenterCatalog,
  "DevCenterCatalogImageDefinitions"
);
@@clientLocation(ImageDefinitions.listByDevCenterCatalog,
  "DevCenterCatalogImageDefinitions"
);
@@clientLocation(ImageDefinitions.getErrorDetails,
  "DevCenterCatalogImageDefinitions"
);
@@clientLocation(ImageDefinitions.buildImage,
  "DevCenterCatalogImageDefinitions"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ImageDefinition.properties);

@@clientLocation(ImageDefinitionBuilds.get,
  "DevCenterCatalogImageDefinitionBuild"
);
@@clientLocation(ImageDefinitionBuilds.listByImageDefinition,
  "DevCenterCatalogImageDefinitionBuilds"
);
@@clientLocation(ImageDefinitionBuilds.cancel,
  "DevCenterCatalogImageDefinitionBuild"
);
@@clientLocation(ImageDefinitionBuilds.getBuildDetails,
  "DevCenterCatalogImageDefinitionBuild"
);
@@clientLocation(ProjectCatalogImageDefinitionBuild.listByImageDefinition,
  "ProjectCatalogImageDefinitionBuilds"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ImageDefinitionBuild.properties);

@@clientName(Pools.createOrUpdate::parameters.resource, "body");
@@clientName(Pools.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Pool.properties);

@@clientName(Schedules.createOrUpdate::parameters.resource, "body");
@@clientName(Schedules.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Schedule.properties);

@@clientName(NetworkConnections.createOrUpdate::parameters.resource, "body");
@@clientName(NetworkConnections.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkConnection.properties);

@@clientLocation(HealthCheckStatusDetailsOperationGroup.getHealthDetails,
  "NetworkConnections"
);
@@clientLocation(HealthCheckStatusDetailsOperationGroup.listHealthDetails,
  "NetworkConnections"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HealthCheckStatusDetails.properties);

@@clientLocation(SkusOperationGroup.listBySubscription, "Skus");

@@clientLocation(OperationStatusesOperationGroup.get, "OperationStatuses");

@@clientLocation(UsagesOperationGroup.listByLocation, "Usages");

@@clientLocation(CheckNameAvailabilityOperationGroup.execute,
  "CheckNameAvailability"
);

@@clientLocation(CheckScopedNameAvailabilityOperationGroup.execute,
  "CheckScopedNameAvailability"
);
@@clientName(CheckNameAvailabilityOperationGroup.execute::parameters.body,
  "nameAvailabilityRequest"
);
@@clientName(CheckScopedNameAvailabilityOperationGroup.execute::parameters.body,
  "nameAvailabilityRequest"
);
