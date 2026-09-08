import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureArcData;

@@clientName(
  SqlManagedInstances.create::parameters.resource,
  "sqlManagedInstance"
);
@@clientName(SqlManagedInstances.update::parameters.properties, "parameters");

@@clientLocation(FailoverGroupResources.get, "FailoverGroups");
@@clientLocation(FailoverGroupResources.create, "FailoverGroups");
@@clientName(
  FailoverGroupResources.create::parameters.resource,
  "failoverGroupResource"
);
@@clientLocation(FailoverGroupResources.delete, "FailoverGroups");
@@clientLocation(FailoverGroupResources.list, "FailoverGroups");

@@clientName(
  SqlServerInstances.create::parameters.resource,
  "sqlServerInstance"
);
@@clientName(SqlServerInstances.update::parameters.properties, "parameters");
@@clientName(SqlServerInstances.getTelemetry, "getTelemetry");
@@clientName(
  SqlServerInstances.getTelemetry::parameters.body,
  "sqlServerInstanceTelemetryRequest"
);
@@clientName(
  SqlServerInstances.getBestPracticesAssessment,
  "getBestPracticesAssessment"
);
@@clientName(
  SqlServerInstances.getBestPracticesAssessment::parameters.body,
  "sqlServerInstanceBpaRequest"
);
@@clientName(
  SqlServerInstances.runMigrationAssessment,
  "runMigrationAssessment"
);
@@clientName(
  SqlServerInstances.runTargetRecommendationJob::parameters.body,
  "sqlServerInstanceRunTargetRecommendationJobRequest"
);
@@clientName(
  SqlServerInstances.getTargetRecommendationReports::parameters.body,
  "sqlServerInstanceTargetRecommendationReportsRequest"
);
@@clientName(
  SqlServerInstances.runBestPracticesAssessment,
  "runBestPracticesAssessment"
);
@@clientName(
  SqlServerInstances.runBestPracticeAssessment,
  "runBestPracticeAssessment"
);
@@clientName(
  SqlServerInstances.runMigrationReadinessAssessment,
  "runMigrationReadinessAssessment"
);
@@clientName(SqlServerInstances.getJobsStatus, "getJobsStatus");
@@clientName(
  SqlServerInstances.getJobsStatus::parameters.body,
  "SqlServerInstanceJobsStatusRequest"
);
@@clientName(SqlServerInstances.getJobs, "getJobs");
@@clientName(
  SqlServerInstances.getJobs::parameters.body,
  "SqlServerInstanceJobsRequest"
);
@@clientName(SqlServerInstances.preUpgrade, "preUpgrade");
@@clientName(SqlServerInstances.postUpgrade, "postUpgrade");
@@clientName(
  SqlServerInstances.runManagedInstanceLinkAssessment,
  "runManagedInstanceLinkAssessment"
);
@@clientName(
  SqlServerInstances.runManagedInstanceLinkAssessment::parameters.body,
  "sqlServerInstanceManagedInstanceLinkAssessmentRequest"
);
@@clientName(
  SqlServerInstances.getAllAvailabilityGroups::parameters.body,
  "availabilityGroupRetrievalFilters"
);
@@clientLocation(
  SqlServerInstances.createAvailabilityGroup,
  "SqlServerAvailabilityGroups"
);
@@clientName(
  SqlServerInstances.createAvailabilityGroup::parameters.body,
  "createAgConfiguration"
);
@@clientLocation(
  SqlServerInstances.createDistributedAvailabilityGroup,
  "SqlServerAvailabilityGroups"
);
@@clientName(
  SqlServerInstances.createDistributedAvailabilityGroup::parameters.body,
  "createDagConfiguration"
);
@@clientLocation(
  SqlServerInstances.createManagedInstanceLink,
  "SqlServerAvailabilityGroups"
);
@@clientName(
  SqlServerInstances.createManagedInstanceLink::parameters.body,
  "createManagedInstanceLinkConfiguration"
);

@@clientName(SqlServerLicenses.create::parameters.resource, "sqlServerLicense");
@@clientName(SqlServerLicenses.update::parameters.properties, "parameters");

@@clientLocation(DataControllerResources.getDataController, "DataControllers");
@@clientLocation(DataControllerResources.putDataController, "DataControllers");
@@clientName(
  DataControllerResources.putDataController::parameters.resource,
  "dataControllerResource"
);
@@clientLocation(
  DataControllerResources.patchDataController,
  "DataControllers"
);
@@clientName(
  DataControllerResources.patchDataController::parameters.properties,
  "dataControllerResource"
);
@@clientLocation(
  DataControllerResources.deleteDataController,
  "DataControllers"
);
@@clientLocation(DataControllerResources.listInGroup, "DataControllers");
@@clientLocation(DataControllerResources.listInSubscription, "DataControllers");

@@clientLocation(
  ActiveDirectoryConnectorResources.get,
  "ActiveDirectoryConnectors"
);
@@clientLocation(
  ActiveDirectoryConnectorResources.create,
  "ActiveDirectoryConnectors"
);
@@clientName(
  ActiveDirectoryConnectorResources.create::parameters.resource,
  "activeDirectoryConnectorResource"
);
@@clientLocation(
  ActiveDirectoryConnectorResources.delete,
  "ActiveDirectoryConnectors"
);
@@clientLocation(
  ActiveDirectoryConnectorResources.list,
  "ActiveDirectoryConnectors"
);

@@clientName(PostgresInstances.update::parameters.properties, "parameters");

@@clientLocation(
  SqlServerAvailabilityGroupResources.get,
  "SqlServerAvailabilityGroups"
);
@@clientLocation(
  SqlServerAvailabilityGroupResources.create,
  "SqlServerAvailabilityGroups"
);
@@clientName(
  SqlServerAvailabilityGroupResources.create::parameters.resource,
  "sqlServerAvailabilityGroupResource"
);
@@clientLocation(
  SqlServerAvailabilityGroupResources.update,
  "SqlServerAvailabilityGroups"
);
@@clientName(
  SqlServerAvailabilityGroupResources.update::parameters.properties,
  "sqlServerAvailabilityGroupUpdate"
);
@@clientLocation(
  SqlServerAvailabilityGroupResources.delete,
  "SqlServerAvailabilityGroups"
);
@@clientLocation(
  SqlServerAvailabilityGroupResources.list,
  "SqlServerAvailabilityGroups"
);
@@clientLocation(
  SqlServerAvailabilityGroupResources.detailView,
  "SqlServerAvailabilityGroups"
);
@@clientLocation(
  SqlServerAvailabilityGroupResources.failover,
  "SqlServerAvailabilityGroups"
);
@@clientLocation(
  SqlServerAvailabilityGroupResources.forceFailoverAllowDataLoss,
  "SqlServerAvailabilityGroups"
);
@@clientLocation(
  SqlServerAvailabilityGroupResources.addDatabases,
  "SqlServerAvailabilityGroups"
);
@@clientName(
  SqlServerAvailabilityGroupResources.addDatabases::parameters.body,
  "databases"
);
@@clientLocation(
  SqlServerAvailabilityGroupResources.failoverMiLink,
  "SqlServerAvailabilityGroups"
);
@@clientName(
  SqlServerAvailabilityGroupResources.failoverMiLink,
  "failoverMiLink"
);
@@clientName(
  SqlServerAvailabilityGroupResources.failoverMiLink::parameters.body,
  "managedInstanceResourceId"
);
@@clientLocation(
  SqlServerAvailabilityGroupResources.deleteMiLink,
  "SqlServerAvailabilityGroups"
);
@@clientName(SqlServerAvailabilityGroupResources.deleteMiLink, "deleteMiLink");
@@clientLocation(
  SqlServerAvailabilityGroupResources.removeDatabases,
  "SqlServerAvailabilityGroups"
);
@@clientName(
  SqlServerAvailabilityGroupResources.removeDatabases::parameters.body,
  "databases"
);

@@clientLocation(SqlServerDatabaseResources.get, "SqlServerDatabases");
@@clientLocation(SqlServerDatabaseResources.create, "SqlServerDatabases");
@@clientName(
  SqlServerDatabaseResources.create::parameters.resource,
  "sqlServerDatabaseResource"
);
@@clientLocation(SqlServerDatabaseResources.update, "SqlServerDatabases");
@@clientName(
  SqlServerDatabaseResources.update::parameters.properties,
  "sqlServerDatabaseUpdate"
);
@@clientLocation(SqlServerDatabaseResources.delete, "SqlServerDatabases");
@@clientLocation(SqlServerDatabaseResources.list, "SqlServerDatabases");

@@clientName(
  SqlServerEsuLicenses.create::parameters.resource,
  "sqlServerEsuLicense"
);
@@clientName(SqlServerEsuLicenses.update::parameters.properties, "parameters");
