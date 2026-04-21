import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.OffAzure;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HypervSiteUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HypervMachineUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ImportSiteUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MasterSiteUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlSiteUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlServerV2Update.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WebAppSiteUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IisWebApplicationsUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WebApplication.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WebServer.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServerSiteResourceUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServerUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(VmwareSiteUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MachineResourceUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HypervOperationsStatusResource.properties);

@@clientLocation(HypervSites.get, "HypervSitesController");
@@clientLocation(HypervSites.create, "HypervSitesController");
@@clientName(HypervSites.create::parameters.resource, "body");
@@clientLocation(HypervSites.update, "HypervSitesController");
@@clientName(HypervSites.update::parameters.properties, "body");
@@clientLocation(HypervSites.delete, "HypervSitesController");
@@clientLocation(HypervSites.computeErrorSummary, "HypervSitesController");
@@clientLocation(HypervSites.computeusage, "HypervSitesController");
@@clientLocation(HypervSites.exportApplications, "HypervSitesController");
@@clientLocation(HypervSites.exportMachineErrors, "HypervSitesController");
@@clientLocation(HypervSites.listHealthSummary, "HypervSitesController");
@@clientLocation(HypervSites.summary, "HypervSitesController");
@@clientLocation(HypervSites.clientGroupMembers,
  "HypervDependencyMapController"
);
@@clientName(HypervSites.clientGroupMembers::parameters.body, "mapRequest");
@@clientLocation(HypervSites.exportDependencies,
  "HypervDependencyMapController"
);
@@clientName(HypervSites.exportDependencies::parameters.body, "requestBody");
@@clientLocation(HypervSites.generateCoarseMap,
  "HypervDependencyMapController"
);
@@clientName(HypervSites.generateCoarseMap::parameters.body, "mapRequest");
@@clientLocation(HypervSites.generateDetailedMap,
  "HypervDependencyMapController"
);
@@clientName(HypervSites.generateDetailedMap::parameters.body, "mapRequest");
@@clientLocation(HypervSites.serverGroupMembers,
  "HypervDependencyMapController"
);
@@clientName(HypervSites.serverGroupMembers::parameters.body, "mapRequest");
@@clientLocation(HypervSites.updateDependencyMapStatus,
  "HypervDependencyMapController"
);
@@clientName(HypervSites.updateDependencyMapStatus::parameters.body,
  "mapRequest"
);
@@clientLocation(HypervSites.updateProperties, "HypervMachinesController");
@@clientName(HypervSites.updateProperties::parameters.body, "metaData");
@@clientLocation(HypervSites.getHypervOperationsStatus,
  "HypervOperationsStatusController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HypervSite.properties);

@@clientLocation(ImportSites.get, "ImportSitesController");
@@clientLocation(ImportSites.create, "ImportSitesController");
@@clientName(ImportSites.create::parameters.resource, "body");
@@clientLocation(ImportSites.update, "ImportSitesController");
@@clientName(ImportSites.update::parameters.properties, "body");
@@clientLocation(ImportSites.delete, "ImportSitesController");
@@clientLocation(ImportSites.listByResourceGroup, "ImportSitesController");
@@clientLocation(ImportSites.listBySubscription, "ImportSitesController");
@@clientLocation(ImportSites.deleteImportedMachines, "ImportSitesController");
@@clientLocation(ImportSites.exportUri, "ImportSitesController");
@@clientLocation(ImportSites.importUri, "ImportSitesController");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ImportSite.properties);

@@clientLocation(MasterSites.get, "MasterSitesController");
@@clientLocation(MasterSites.create, "MasterSitesController");
@@clientName(MasterSites.create::parameters.resource, "body");
@@clientLocation(MasterSites.update, "MasterSitesController");
@@clientLocation(MasterSites.delete, "MasterSitesController");
@@clientLocation(MasterSites.listByResourceGroup, "MasterSitesController");
@@clientLocation(MasterSites.listBySubscription, "MasterSitesController");
@@clientLocation(MasterSites.errorSummary, "MasterSitesController");
@@clientLocation(MasterSites.refreshArcStatus, "MasterSitesController");
@@clientLocation(MasterSites.getVmwareOperationStatus,
  "MasterSitesOperationsStatusController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MasterSite.properties);

@@clientLocation(PrivateEndpointConnections.get,
  "PrivateEndpointConnectionController"
);
@@clientLocation(PrivateEndpointConnections.create,
  "PrivateEndpointConnectionController"
);
@@clientName(PrivateEndpointConnections.create::parameters.resource, "body");
@@clientLocation(PrivateEndpointConnections.delete,
  "PrivateEndpointConnectionController"
);
@@clientLocation(PrivateEndpointConnections.listByMasterSite,
  "PrivateEndpointConnectionController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

@@clientLocation(ServerSiteResources.get, "ServerSitesController");
@@clientLocation(ServerSiteResources.create, "ServerSitesController");
@@clientName(ServerSiteResources.create::parameters.resource, "body");
@@clientLocation(ServerSiteResources.update, "ServerSitesController");
@@clientName(ServerSiteResources.update::parameters.properties, "body");
@@clientLocation(ServerSiteResources.delete, "ServerSitesController");
@@clientLocation(ServerSiteResources.listByResourceGroup,
  "ServerSitesController"
);
@@clientLocation(ServerSiteResources.listBySubscription,
  "ServerSitesController"
);
@@clientLocation(ServerSiteResources.computeErrorSummary,
  "ServerSitesController"
);
@@clientLocation(ServerSiteResources.computeusage, "ServerSitesController");
@@clientLocation(ServerSiteResources.exportApplications,
  "ServerSitesController"
);
@@clientLocation(ServerSiteResources.exportMachineErrors,
  "ServerSitesController"
);
@@clientLocation(ServerSiteResources.listHealthSummary,
  "ServerSitesController"
);
@@clientLocation(ServerSiteResources.refreshSite, "ServerSitesController");
@@clientLocation(ServerSiteResources.summary, "ServerSitesController");
@@clientLocation(ServerSiteResources.updateDependencyMapStatus,
  "ServerSitesController"
);
@@clientName(ServerSiteResources.updateDependencyMapStatus::parameters.body,
  "mapRequest"
);
@@clientLocation(ServerSiteResources.updateProperties, "ServerSitesController");
@@clientName(ServerSiteResources.updateProperties::parameters.body, "metaData");
@@clientLocation(ServerSiteResources.clientGroupMembers,
  "ServerDependencyMapController"
);
@@clientName(ServerSiteResources.clientGroupMembers::parameters.body,
  "mapRequest"
);
@@clientLocation(ServerSiteResources.exportDependencies,
  "ServerDependencyMapController"
);
@@clientName(ServerSiteResources.exportDependencies::parameters.body,
  "requestBody"
);
@@clientLocation(ServerSiteResources.generateCoarseMap,
  "ServerDependencyMapController"
);
@@clientName(ServerSiteResources.generateCoarseMap::parameters.body,
  "mapRequest"
);
@@clientLocation(ServerSiteResources.generateDetailedMap,
  "ServerDependencyMapController"
);
@@clientName(ServerSiteResources.generateDetailedMap::parameters.body,
  "mapRequest"
);
@@clientLocation(ServerSiteResources.serverGroupMembers,
  "ServerDependencyMapController"
);
@@clientName(ServerSiteResources.serverGroupMembers::parameters.body,
  "mapRequest"
);
@@clientLocation(ServerSiteResources.getServerSiteOperationsStatus,
  "ServerOperationsStatusController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServerSiteResource.properties);

@@clientLocation(VmwareSites.get, "SitesController");
@@clientLocation(VmwareSites.create, "SitesController");
@@clientName(VmwareSites.create::parameters.resource, "body");
@@clientLocation(VmwareSites.update, "SitesController");
@@clientName(VmwareSites.update::parameters.properties, "body");
@@clientLocation(VmwareSites.delete, "SitesController");
@@clientLocation(VmwareSites.listByResourceGroup, "SitesController");
@@clientLocation(VmwareSites.listBySubscription, "SitesController");
@@clientLocation(VmwareSites.computeErrorSummary, "SitesController");
@@clientLocation(VmwareSites.computeusage, "SitesController");
@@clientLocation(VmwareSites.exportApplications, "SitesController");
@@clientLocation(VmwareSites.exportMachineErrors, "SitesController");
@@clientLocation(VmwareSites.exportMachines, "SitesController");
@@clientLocation(VmwareSites.listHealthSummary, "SitesController");
@@clientLocation(VmwareSites.summary, "SitesController");
@@clientLocation(VmwareSites.clientGroupMembers, "DependencyMapController");
@@clientName(VmwareSites.clientGroupMembers::parameters.body, "mapRequest");
@@clientLocation(VmwareSites.exportDependencies, "DependencyMapController");
@@clientName(VmwareSites.exportDependencies::parameters.body, "requestBody");
@@clientLocation(VmwareSites.generateCoarseMap, "DependencyMapController");
@@clientName(VmwareSites.generateCoarseMap::parameters.body, "mapRequest");
@@clientLocation(VmwareSites.generateDetailedMap, "DependencyMapController");
@@clientName(VmwareSites.generateDetailedMap::parameters.body, "mapRequest");
@@clientLocation(VmwareSites.serverGroupMembers, "DependencyMapController");
@@clientName(VmwareSites.serverGroupMembers::parameters.body, "mapRequest");
@@clientLocation(VmwareSites.getVmwareOperationStatus,
  "VmwareOperationsStatus"
);
@@clientLocation(VmwareSites.updateDependencyMapStatus,
  "VmwarePropertiesController"
);
@@clientName(VmwareSites.updateDependencyMapStatus::parameters.body,
  "updateMachineDepMapStatus"
);
@@clientLocation(VmwareSites.updateProperties, "VmwarePropertiesController");
@@clientName(VmwareSites.updateProperties::parameters.body, "metaData");
@@clientLocation(VmwareSites.updateRunAsAccount, "VmwarePropertiesController");
@@clientName(VmwareSites.updateRunAsAccount::parameters.body,
  "updateMachineRunAsAccount"
);
@@clientLocation(VmwareSites.updateTags, "VmwarePropertiesController");
@@clientName(VmwareSites.updateTags::parameters.body, "updateMachineTags");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(VmwareSite.properties);

@@clientLocation(HypervClusters.getCluster, "HypervClusterController");
@@clientLocation(HypervClusters.createCluster, "HypervClusterController");
@@clientName(HypervClusters.createCluster::parameters.resource, "body");
@@clientLocation(HypervClusters.delete, "HypervClusterController");
@@clientLocation(HypervClusters.listByHypervSite, "HypervClusterController");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HypervCluster.properties);

@@clientLocation(HypervHosts.get, "HypervHostController");
@@clientLocation(HypervHosts.create, "HypervHostController");
@@clientName(HypervHosts.create::parameters.resource, "body");
@@clientLocation(HypervHosts.delete, "HypervHostController");
@@clientLocation(HypervHosts.listByHypervSite, "HypervHostController");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HypervHost.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HypervJob.properties);

@@clientLocation(HypervMachines.get, "HypervMachinesController");
@@clientLocation(HypervMachines.update, "HypervMachinesController");
@@clientName(HypervMachines.update::parameters.properties, "body");
@@clientLocation(HypervMachines.listByHypervSite, "HypervMachinesController");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HypervMachine.properties);

@@clientLocation(HypervVmSoftwareInventories.getMachineSoftwareInventory,
  "HypervSoftwareInventoriesController"
);
@@clientLocation(HypervVmSoftwareInventories.listByHypervMachine,
  "HypervSoftwareInventoriesController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HypervVmSoftwareInventory.properties);

@@clientLocation(HypervRunAsAccountResources.get,
  "HypervRunAsAccountsController"
);
@@clientLocation(HypervRunAsAccountResources.listByHypervSite,
  "HypervRunAsAccountsController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HypervRunAsAccountResource.properties);

@@clientLocation(DeleteImportMachinesJobs.getDeletejob, "ImportJobsController");
@@clientLocation(DeleteImportMachinesJobs.listDeletejobs,
  "ImportJobsController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DeleteImportMachinesJob.properties);

@@clientLocation(ExportImportedMachinesJobs.getExportjob,
  "ImportJobsController"
);
@@clientLocation(ExportImportedMachinesJobs.listExportjobs,
  "ImportJobsController"
);

@@clientLocation(ImportMachinesJobs.getImportjob, "ImportJobsController");
@@clientLocation(ImportMachinesJobs.listImportjobs, "ImportJobsController");

@@clientLocation(ImportJobs.get, "ImportJobsController");
@@clientLocation(ImportJobs.listByImportSite, "ImportJobsController");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ImportJob.properties);

@@clientLocation(ImportMachines.get, "ImportMachinesController");
@@clientLocation(ImportMachines.delete, "ImportMachinesController");
@@clientLocation(ImportMachines.listByImportSite, "ImportMachinesController");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ImportMachine.properties);

@@clientLocation(PrivateLinkResources.get, "PrivateLinkResourcesController");
@@clientLocation(PrivateLinkResources.listByMasterSite,
  "PrivateLinkResourcesController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateLinkResource.properties);

@@clientLocation(SqlSites.get, "SqlSitesController");
@@clientLocation(SqlSites.create, "SqlSitesController");
@@clientName(SqlSites.create::parameters.resource, "body");
@@clientLocation(SqlSites.update, "SqlSitesController");
@@clientLocation(SqlSites.delete, "SqlSitesController");
@@clientLocation(SqlSites.listByMasterSite, "SqlSitesController");
@@clientLocation(SqlSites.errorSummary, "SqlSitesController");
@@clientLocation(SqlSites.exportUri, "SqlSitesController");
@@clientLocation(SqlSites.exportSqlServerErrors, "SqlSitesController");
@@clientLocation(SqlSites.exportSqlServers, "SqlSitesController");
@@clientLocation(SqlSites.refresh, "SqlSitesController");
@@clientLocation(SqlSites.summary, "SqlSitesController");
@@clientLocation(SqlSites.importUri, "SqlSitesController");
@@clientLocation(SqlSites.validateAndImportUri, "SqlSitesController");
@@clientLocation(SqlSites.getSqlOperationStatus,
  "SqlOperationsStatusController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlSite.properties);

@@clientLocation(SqlDiscoverySiteDataSources.get,
  "SqlDiscoverySiteDataSourceController"
);
@@clientLocation(SqlDiscoverySiteDataSources.create,
  "SqlDiscoverySiteDataSourceController"
);
@@clientName(SqlDiscoverySiteDataSources.create::parameters.resource, "body");
@@clientLocation(SqlDiscoverySiteDataSources.delete,
  "SqlDiscoverySiteDataSourceController"
);
@@clientLocation(SqlDiscoverySiteDataSources.listBySqlSite,
  "SqlDiscoverySiteDataSourceController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlDiscoverySiteDataSource.properties);

@@clientLocation(ImportSqlInventoryJobs.getImportjob,
  "SqlImportJobsController"
);
@@clientLocation(ImportSqlInventoryJobs.listImportjobs,
  "SqlImportJobsController"
);

@@clientLocation(SqlJobs.get, "SqlJobsController");
@@clientLocation(SqlJobs.listBySqlSite, "SqlJobsController");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlJob.properties);

@@clientLocation(SqlRunAsAccounts.get, "SqlRunAsAccountsController");
@@clientLocation(SqlRunAsAccounts.listBySqlSite, "SqlRunAsAccountsController");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlRunAsAccount.properties);

@@clientLocation(SqlAvailabilityGroups.get, "SqlAvailabilityGroupsController");
@@clientLocation(SqlAvailabilityGroups.listBySqlSite,
  "SqlAvailabilityGroupsController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlAvailabilityGroup.properties);

@@clientLocation(SqlDatabaseV2s.get, "SqlDatabasesController");
@@clientLocation(SqlDatabaseV2s.listBySqlSite, "SqlDatabasesController");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlDatabaseV2.properties);

@@clientLocation(SqlServerV2s.get, "SqlServersController");
@@clientLocation(SqlServerV2s.update, "SqlServersController");
@@clientName(SqlServerV2s.update::parameters.properties, "body");
@@clientLocation(SqlServerV2s.listBySqlSite, "SqlServersController");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlServerV2.properties);

@@clientLocation(WebAppSites.get, "WebAppSitesController");
@@clientLocation(WebAppSites.create, "WebAppSitesController");
@@clientName(WebAppSites.create::parameters.resource, "body");
@@clientLocation(WebAppSites.update, "WebAppSitesController");
@@clientLocation(WebAppSites.delete, "WebAppSitesController");
@@clientLocation(WebAppSites.listByMasterSite, "WebAppSitesController");
@@clientLocation(WebAppSites.errorSummary, "WebAppSitesController");
@@clientLocation(WebAppSites.exportInventory, "WebAppSitesController");
@@clientLocation(WebAppSites.refresh, "WebAppSitesController");
@@clientLocation(WebAppSites.summary, "WebAppSitesController");
@@clientLocation(WebAppSites.updateProperties, "WebAppPropertiesController");
@@clientLocation(WebAppSites.listByWebAppSite, "WebApplicationsController");
@@clientLocation(WebAppSites.webServersControllerListByWebAppSite,
  "WebServersController"
);
@@clientName(WebAppSites.webServersControllerListByWebAppSite,
  "ListByWebAppSite"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WebAppSite.properties);

@@clientLocation(DiscoverySiteDataSources.get,
  "WebAppDiscoverySiteDataSourcesController"
);
@@clientLocation(DiscoverySiteDataSources.create,
  "WebAppDiscoverySiteDataSourcesController"
);
@@clientName(DiscoverySiteDataSources.create::parameters.resource, "body");
@@clientLocation(DiscoverySiteDataSources.delete,
  "WebAppDiscoverySiteDataSourcesController"
);
@@clientLocation(DiscoverySiteDataSources.listByWebAppSite,
  "WebAppDiscoverySiteDataSourcesController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DiscoverySiteDataSource.properties);

@@clientLocation(WebAppExtendedMachines.get,
  "WebAppExtendedMachinesController"
);
@@clientLocation(WebAppExtendedMachines.listByWebAppSite,
  "WebAppExtendedMachinesController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WebAppExtendedMachine.properties);

@@clientName(IisWebApplicationsController.update::parameters.properties,
  "body"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IisWebApplications.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IisWebServers.properties);

@@clientLocation(WebAppRunAsAccounts.get, "WebAppRunAsAccountsController");
@@clientLocation(WebAppRunAsAccounts.listByWebAppSite,
  "WebAppRunAsAccountsController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WebAppRunAsAccount.properties);

@@clientName(TomcatWebApplicationsController.update::parameters.properties,
  "body"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TomcatWebApplications.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TomcatWebServers.properties);

@@clientLocation(ServerJobs.get, "ServerJobsController");
@@clientLocation(ServerJobs.listByServerSiteResource, "ServerJobsController");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServerJob.properties);

@@clientLocation(Servers.getMachine, "ServersController");
@@clientLocation(Servers.updateMachine, "ServersController");
@@clientName(Servers.updateMachine::parameters.properties, "body");
@@clientLocation(Servers.deleteMachine, "ServersController");
@@clientLocation(Servers.listByServerSiteResource, "ServersController");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Server.properties);

@@clientLocation(ServerSoftwareInventories.getMachineSoftwareInventory,
  "ServerSoftwareInventoriesController"
);
@@clientLocation(ServerSoftwareInventories.listByServer,
  "ServerSoftwareInventoriesController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServerSoftwareInventory.properties);

@@clientLocation(ServerRunAsAccounts.get, "ServerRunAsAccountsController");
@@clientLocation(ServerRunAsAccounts.listByServerSiteResource,
  "ServerRunAsAccountsController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServerRunAsAccount.properties);

@@clientLocation(VmwareHosts.get, "VmwareHostController");
@@clientLocation(VmwareHosts.listByVmwareSite, "VmwareHostController");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(VmwareHost.properties);

@@clientLocation(VmwareJobs.get, "HypervJobsController");
@@clientLocation(VmwareJobs.listByVmwareSite, "HypervJobsController");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(VmwareJob.properties);

@@clientLocation(MachineResources.get, "MachinesController");
@@clientLocation(MachineResources.update, "MachinesController");
@@clientName(MachineResources.update::parameters.properties, "body");
@@clientLocation(MachineResources.listByVmwareSite, "MachinesController");
@@clientLocation(MachineResources.start, "MachinesController");
@@clientLocation(MachineResources.stop, "MachinesController");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MachineResource.properties);

@@clientLocation(VmwareMachineSoftwareInventories.getMachineSoftwareInventory,
  "VmwareSoftwareInventoriesController"
);
@@clientLocation(VmwareMachineSoftwareInventories.listByMachineResource,
  "VmwareSoftwareInventoriesController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(VmwareMachineSoftwareInventory.properties);

@@clientLocation(VmwareRunAsAccountResources.get, "RunAsAccountsController");
@@clientLocation(VmwareRunAsAccountResources.listByVmwareSite,
  "RunAsAccountsController"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(VmwareRunAsAccountResource.properties);

@@clientLocation(Vcenters.get, "VcenterController");
@@clientLocation(Vcenters.create, "VcenterController");
@@clientName(Vcenters.create::parameters.resource, "body");
@@clientLocation(Vcenters.delete, "VcenterController");
@@clientLocation(Vcenters.listByVmwareSite, "VcenterController");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Vcenter.properties);

@@visibility(DeleteImportMachinesJob.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(DiscoverySiteDataSource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(HypervCluster.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(HypervHost.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(HypervJob.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(HypervMachine.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(HypervRunAsAccountResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(HypervSite.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(HypervVmSoftwareInventory.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(IisWebApplications.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(IisWebServers.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(ImportJob.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(ImportMachine.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(ImportSite.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(MachineResource.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(MasterSite.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(PrivateEndpointConnection.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(PrivateLinkResource.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(Server.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(ServerJob.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(ServerRunAsAccount.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(ServerSiteResource.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(ServerSoftwareInventory.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(SqlAvailabilityGroup.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(SqlDatabaseV2.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(SqlDiscoverySiteDataSource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(SqlJob.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(SqlRunAsAccount.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(SqlServerV2.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(SqlSite.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(TomcatWebApplications.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(TomcatWebServers.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(Vcenter.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(VmwareHost.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(VmwareJob.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(VmwareMachineSoftwareInventory.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(VmwareRunAsAccountResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(VmwareSite.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(WebAppExtendedMachine.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
@@visibility(WebAppRunAsAccount.properties, Lifecycle.Read, Lifecycle.Create);
@@visibility(WebAppSite.properties, Lifecycle.Read, Lifecycle.Create);
