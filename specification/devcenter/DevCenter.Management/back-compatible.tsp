import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ClientGenerator.Core;
using Microsoft.DevCenter;

@@clientName(DevCenters.createOrUpdate::parameters.resource, "body");
@@clientName(DevCenters.update::parameters.properties, "body");
@@clientLocation(DevCenters.listByDevCenter, Images);

@@clientLocation(DevCenterEncryptionSets.get, "EncryptionSets");
@@clientLocation(DevCenterEncryptionSets.createOrUpdate, "EncryptionSets");
@@clientName(DevCenterEncryptionSets.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(DevCenterEncryptionSets.update, "EncryptionSets");
@@clientName(DevCenterEncryptionSets.update::parameters.properties, "body");
@@clientLocation(DevCenterEncryptionSets.delete, "EncryptionSets");
@@clientLocation(DevCenterEncryptionSets.list, "EncryptionSets");

@@clientName(ProjectPolicies.createOrUpdate::parameters.resource, "body");
@@clientName(ProjectPolicies.update::parameters.properties, "body");

@@clientName(Projects.createOrUpdate::parameters.resource, "body");
@@clientName(Projects.update::parameters.properties, "body");
@@clientLocation(Projects.listByProject, "Skus");

@@clientLocation(AttachedNetworkConnections.getByProject, AttachedNetworks);
@@clientLocation(AttachedNetworkConnections.listByProject, AttachedNetworks);
@@clientName(AttachedNetworks.createOrUpdate::parameters.resource, "body");

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
@@clientLocation(CatalogOperationGroup.get, Catalogs);
@@clientLocation(CatalogOperationGroup.createOrUpdate, Catalogs);
@@clientName(CatalogOperationGroup.createOrUpdate::parameters.resource, "body");
@@clientLocation(CatalogOperationGroup.update, Catalogs);
@@clientName(CatalogOperationGroup.update::parameters.properties, "body");
@@clientLocation(CatalogOperationGroup.delete, Catalogs);
@@clientLocation(CatalogOperationGroup.listByDevCenter, Catalogs);
@@clientLocation(CatalogOperationGroup.getSyncErrorDetails, Catalogs);
@@clientLocation(CatalogOperationGroup.sync, Catalogs);
@@clientLocation(CatalogOperationGroup.connect, Catalogs);

@@clientLocation(EnvironmentDefinitions.getErrorDetails,
  "ProjectCatalogEnvironmentDefinitions"
);
@@clientLocation(EnvironmentDefinitionOperationGroup.get,
  EnvironmentDefinitions
);
@@clientLocation(EnvironmentDefinitionOperationGroup.listByCatalog,
  EnvironmentDefinitions
);
@@clientLocation(EnvironmentDefinitionOperationGroup.getErrorDetails,
  EnvironmentDefinitions
);

@@clientName(Galleries.createOrUpdate::parameters.resource, "body");

@@clientLocation(ImageOperationGroup.getByProject, Images);
@@clientLocation(ImageOperationGroup.listByProject, Images);

@@clientLocation(ImageVersionOperationGroup.getByProject, ImageVersions);
@@clientLocation(ImageVersionOperationGroup.listByProject, ImageVersions);

@@clientName(EnvironmentTypes.createOrUpdate::parameters.resource, "body");
@@clientName(EnvironmentTypes.update::parameters.properties, "body");

@@clientLocation(AllowedEnvironmentTypes.get, "ProjectAllowedEnvironmentTypes");
@@clientLocation(AllowedEnvironmentTypes.list,
  "ProjectAllowedEnvironmentTypes"
);

@@clientName(ProjectEnvironmentTypes.createOrUpdate::parameters.resource,
  "body"
);
@@clientName(ProjectEnvironmentTypes.update::parameters.properties, "body");

@@clientName(DevBoxDefinitions.createOrUpdate::parameters.resource, "body");
@@clientName(DevBoxDefinitions.update::parameters.properties, "body");
@@clientLocation(DevBoxDefinitionOperationGroup.getByProject,
  DevBoxDefinitions
);
@@clientLocation(DevBoxDefinitionOperationGroup.listByProject,
  DevBoxDefinitions
);

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

@@clientName(Pools.createOrUpdate::parameters.resource, "body");
@@clientName(Pools.update::parameters.properties, "body");

@@clientName(Schedules.createOrUpdate::parameters.resource, "body");
@@clientName(Schedules.update::parameters.properties, "body");

@@clientName(NetworkConnections.createOrUpdate::parameters.resource, "body");
@@clientName(NetworkConnections.update::parameters.properties, "body");

@@clientLocation(HealthCheckStatusDetailsOperationGroup.getHealthDetails,
  NetworkConnections
);
@@clientLocation(HealthCheckStatusDetailsOperationGroup.listHealthDetails,
  NetworkConnections
);

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

@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentity,
  "CustomerManagedKeyEncryptionKeyIdentity",
  "python,javascript"
);
@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentityType,
  "IdentityType",
  "python,javascript"
);

// Flatten properties for backward compatibility
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AllowedEnvironmentType.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AttachedNetworkConnection.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Catalog.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CustomizationTask.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DevBoxDefinition.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DevCenterEncryptionSet.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DevCenter.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(EnvironmentDefinition.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(EnvironmentType.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Gallery.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(HealthCheckStatusDetails.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ImageDefinitionBuild.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ImageDefinition.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Image.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ImageVersion.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NetworkConnection.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Pool.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProjectEnvironmentType.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProjectPolicy.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Project.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Schedule.properties,
  "autorest"
);
