import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AlertsManagement;

@@clientName(Alerts.changeStateTenant::parameters.body, "comment");
@@clientLocation(AlertOperationGroup.getById, Alerts);
@@clientLocation(AlertOperationGroup.getAll, Alerts);
@@clientLocation(AlertOperationGroup.changeState, Alerts);
@@clientName(AlertOperationGroup.changeState::parameters.body, "comment");
@@clientLocation(AlertOperationGroup.getHistory, Alerts);
@@clientLocation(AlertOperationGroup.getEnrichments, Alerts);

@@clientLocation(AlertsOperationGroup.metaData, Alerts);
@@clientLocation(AlertsOperationGroup.getSummary, Alerts);
@@clientLocation(AlertGetAllTenantOperation.getAllTenant, Alerts);
