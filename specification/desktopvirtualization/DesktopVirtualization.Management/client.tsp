import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";


using Azure.ClientGenerator.Core;
using Microsoft.DesktopVirtualization;



#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.`properties`)


#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkspacePatch.`properties`)


#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.`properties`)


#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScalingPlanPatch.`properties`)


#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScalingPlanPooledSchedulePatch.`properties`)


#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScalingPlanPersonalSchedulePatch.`properties`)


#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApplicationGroupPatch.`properties`)


#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StartMenuItem.`properties`)


#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApplicationPatch.`properties`)


#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DesktopPatch.`properties`)


#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HostPoolPatch.`properties`)


#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SessionHostManagementPatch.`properties`)


#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SessionHostManagementUpdateStatus.`properties`)


@@clientName(ImageInfoProperties.`type`, "imageType")


#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SessionHostConfigurationPatch.`properties`)


@@clientName(ImageInfoPatchProperties.`type`, "imageType")


#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SessionHostPatch.`properties`)


#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MsixPackagePatch.`properties`)


#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ExpandMsixImage.`properties`)


@@clientName(Workspaces.createOrUpdate::parameters.resource, "workspace")
@@clientName(Workspaces.update::parameters.properties, "workspace")
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Workspace.properties)

@@clientName(PrivateEndpointConnectionWithSystemDataOperationGroup, "PrivateEndpointConnectionWithSystemData")
@@clientName(PrivateEndpointConnections.updateByWorkspace::parameters.resource, "connection")
@@clientName(PrivateEndpointConnectionWithSystemDataOperationGroup.updateByHostPool::parameters.resource, "connection")

@@clientName(ScalingPlans.create::parameters.resource, "scalingPlan")
@@clientName(ScalingPlans.update::parameters.properties, "scalingPlan")
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScalingPlan.properties)

@@clientName(ScalingPlanPooledSchedules.create::parameters.resource, "scalingPlanSchedule")
@@clientName(ScalingPlanPooledSchedules.update::parameters.properties, "scalingPlanSchedule")
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScalingPlanPooledSchedule.properties)

@@clientName(ScalingPlanPersonalSchedules.create::parameters.resource, "scalingPlanSchedule")
@@clientName(ScalingPlanPersonalSchedules.update::parameters.properties, "scalingPlanSchedule")
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScalingPlanPersonalSchedule.properties)

@@clientName(ApplicationGroups.createOrUpdate::parameters.resource, "applicationGroup")
@@clientName(ApplicationGroups.update::parameters.properties, "applicationGroup")
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApplicationGroup.properties)

@@clientName(Applications.createOrUpdate::parameters.resource, "application")
@@clientName(Applications.update::parameters.properties, "application")
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Application.properties)

@@clientName(Desktops.update::parameters.properties, "desktop")
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Desktop.properties)

@@clientName(HostPools.createOrUpdate::parameters.resource, "hostPool")
@@clientName(HostPools.update::parameters.properties, "hostPool")
@@clientName(HostPools.import::parameters.body, "importPackageInfoRequest")
@@clientName(HostPools.expand::parameters.body, "msixImageURI")
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HostPool.properties)

@@clientName(SessionHostManagements.createOrUpdate::parameters.resource, "sessionHostManagement")
@@clientName(SessionHostManagements.update::parameters.properties, "sessionHostManagement")
@@clientName(SessionHostManagements.controlSessionHostUpdatePost::parameters.body, "hostPoolUpdateControlParameter")
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SessionHostManagement.properties)

@@clientName(SessionHostConfigurations.createOrUpdate::parameters.resource, "sessionHostConfiguration")
@@clientName(SessionHostConfigurations.update::parameters.properties, "sessionHostConfiguration")
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SessionHostConfiguration.properties)

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ActiveSessionHostConfiguration.properties)

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UserSession.properties)

@@clientName(SessionHosts.update::parameters.properties, "sessionHost")
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SessionHost.properties)

@@clientName(MsixPackages.createOrUpdate::parameters.resource, "msixPackage")
@@clientName(MsixPackages.update::parameters.properties, "msixPackage")
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MsixPackage.properties)

@@clientName(AppAttachPackages.createOrUpdate::parameters.resource, "appAttachPackage")
@@clientName(AppAttachPackages.update::parameters.properties, "appAttachPackagePatch")


