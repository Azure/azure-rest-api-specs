import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataMigration;

@@clientLocation(DatabaseMigrationCosmosDbMongos.get,
  "DatabaseMigrationsMongoToCosmosDbRUMongo"
);
@@clientLocation(DatabaseMigrationCosmosDbMongos.create,
  "DatabaseMigrationsMongoToCosmosDbRUMongo"
);
@@clientName(DatabaseMigrationCosmosDbMongos.create::parameters.resource,
  "parameters"
);
@@clientLocation(DatabaseMigrationCosmosDbMongos.delete,
  "DatabaseMigrationsMongoToCosmosDbRUMongo"
);
@@clientLocation(DatabaseMigrationCosmosDbMongos.getForScope,
  "DatabaseMigrationsMongoToCosmosDbRUMongo"
);
@@clientName(DatabaseMigrationsMongoToCosmosDbvCoreMongo.create::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DatabaseMigrationCosmosDbMongo.properties);

@@clientLocation(DatabaseMigrationSqlDbs.get, "DatabaseMigrationsSqlDb");
@@clientLocation(DatabaseMigrationSqlDbs.createOrUpdate,
  "DatabaseMigrationsSqlDb"
);
@@clientName(DatabaseMigrationSqlDbs.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(DatabaseMigrationSqlDbs.delete, "DatabaseMigrationsSqlDb");
@@clientLocation(DatabaseMigrationSqlDbs.cancel, "DatabaseMigrationsSqlDb");
@@clientName(DatabaseMigrationSqlDbs.cancel, "cancel");
@@clientName(DatabaseMigrationSqlDbs.cancel::parameters.body, "parameters");
@@clientLocation(DatabaseMigrationSqlDbs.retry, "DatabaseMigrationsSqlDb");
@@clientName(DatabaseMigrationSqlDbs.retry, "retry");
@@clientName(DatabaseMigrationSqlDbs.retry::parameters.body,
  "migrationOperationInput"
);

@@clientLocation(DatabaseMigrationSqlMis.get, "DatabaseMigrationsSqlMi");
@@clientLocation(DatabaseMigrationSqlMis.createOrUpdate,
  "DatabaseMigrationsSqlMi"
);
@@clientName(DatabaseMigrationSqlMis.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(DatabaseMigrationSqlMis.delete, "DatabaseMigrationsSqlMi");
@@clientLocation(DatabaseMigrationSqlMis.cancel, "DatabaseMigrationsSqlMi");
@@clientName(DatabaseMigrationSqlMis.cancel, "cancel");
@@clientName(DatabaseMigrationSqlMis.cancel::parameters.body, "parameters");
@@clientLocation(DatabaseMigrationSqlMis.cutover, "DatabaseMigrationsSqlMi");
@@clientName(DatabaseMigrationSqlMis.cutover, "cutover");
@@clientName(DatabaseMigrationSqlMis.cutover::parameters.body, "parameters");

@@clientLocation(DatabaseMigrationSqlVms.get, "DatabaseMigrationsSqlVm");
@@clientLocation(DatabaseMigrationSqlVms.createOrUpdate,
  "DatabaseMigrationsSqlVm"
);
@@clientName(DatabaseMigrationSqlVms.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(DatabaseMigrationSqlVms.delete, "DatabaseMigrationsSqlVm");
@@clientLocation(DatabaseMigrationSqlVms.cancel, "DatabaseMigrationsSqlVm");
@@clientName(DatabaseMigrationSqlVms.cancel, "cancel");
@@clientName(DatabaseMigrationSqlVms.cancel::parameters.body, "parameters");
@@clientLocation(DatabaseMigrationSqlVms.cutover, "DatabaseMigrationsSqlVm");
@@clientName(DatabaseMigrationSqlVms.cutover, "cutover");
@@clientName(DatabaseMigrationSqlVms.cutover::parameters.body, "parameters");

@@clientName(MigrationServices.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(MigrationServices.update::parameters.properties, "parameters");
@@clientName(MigrationServices.listMigrations, "listMigrations");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MigrationService.properties);

@@clientName(SqlMigrationServices.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(SqlMigrationServices.update::parameters.properties, "parameters");
@@clientName(SqlMigrationServices.listAuthKeys, "listAuthKeys");
@@clientName(SqlMigrationServices.regenerateAuthKeys, "regenerateAuthKeys");
@@clientName(SqlMigrationServices.regenerateAuthKeys::parameters.body,
  "parameters"
);
@@clientName(SqlMigrationServices.deleteNode, "deleteNode");
@@clientName(SqlMigrationServices.deleteNode::parameters.body, "parameters");
@@clientName(SqlMigrationServices.listMigrations, "listMigrations");
@@clientName(SqlMigrationServices.listMonitoringData, "listMonitoringData");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlMigrationService.properties);

@@clientLocation(DataMigrationServices.get, "Services");
@@clientLocation(DataMigrationServices.createOrUpdate, "Services");
@@clientName(DataMigrationServices.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(DataMigrationServices.update, "Services");
@@clientName(DataMigrationServices.update::parameters.properties, "parameters");
@@clientLocation(DataMigrationServices.delete, "Services");
@@clientLocation(DataMigrationServices.listByResourceGroup, "Services");
@@clientLocation(DataMigrationServices.list, "Services");
@@clientLocation(DataMigrationServices.checkStatus, "Services");
@@clientLocation(DataMigrationServices.start, "Services");
@@clientLocation(DataMigrationServices.stop, "Services");
@@clientLocation(DataMigrationServices.listSkus, "Services");
@@clientLocation(DataMigrationServices.checkChildrenNameAvailability,
  "Services"
);
@@clientName(DataMigrationServices.checkChildrenNameAvailability::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DataMigrationService.properties);

@@clientLocation(ProjectTasks.get, "Tasks");
@@clientLocation(ProjectTasks.createOrUpdate, "Tasks");
@@clientName(ProjectTasks.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(ProjectTasks.update, "Tasks");
@@clientName(ProjectTasks.update::parameters.properties, "parameters");
@@clientLocation(ProjectTasks.delete, "Tasks");
@@clientLocation(ProjectTasks.list, "Tasks");
@@clientLocation(ProjectTasks.cancel, "Tasks");
@@clientLocation(ProjectTasks.command, "Tasks");
@@clientName(ProjectTasks.command::parameters.body, "parameters");
@@clientName(ServiceTasks.createOrUpdate::parameters.resource, "parameters");
@@clientName(ServiceTasks.update::parameters.properties, "parameters");

@@clientName(Projects.createOrUpdate::parameters.resource, "parameters");
@@clientName(Projects.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Project.properties);

@@clientLocation(ProjectFiles.get, "Files");
@@clientLocation(ProjectFiles.createOrUpdate, "Files");
@@clientName(ProjectFiles.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(ProjectFiles.update, "Files");
@@clientName(ProjectFiles.update::parameters.properties, "parameters");
@@clientLocation(ProjectFiles.delete, "Files");
@@clientLocation(ProjectFiles.list, "Files");
@@clientLocation(ProjectFiles.read, "Files");
@@clientLocation(ProjectFiles.readWrite, "Files");

@@clientLocation(ResourceSkusOperationGroup.listSkus, "ResourceSkus");

@@clientLocation(ServicesOperationGroup.checkNameAvailability, "Services");

@@clientLocation(UsagesOperationGroup.list, "Usages");
