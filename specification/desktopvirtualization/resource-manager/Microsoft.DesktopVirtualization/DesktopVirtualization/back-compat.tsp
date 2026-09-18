import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "./AppAttachPackage.tsp";
import "./PrivateEndpointConnection.tsp";
import "./Workspace.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.DesktopVirtualization;

@@clientName(CustomPrivateEndpointConnection, "PrivateEndpointConnections");

@@clientName(AppAttachPackages, "AppAttachPackage");

@@clientName(
  AppAttachPackages.createOrUpdate::parameters.resource,
  "appAttachPackage"
);

@@clientName(Applications.createOrUpdate::parameters.resource, "application");

@@clientName(
  CustomPrivateEndpointConnection.updateByWorkspace::parameters.resource,
  "connection"
);

@@clientName(
  CustomPrivateEndpointConnection.updateByHostPool::parameters.resource,
  "connection"
);

@@clientName(HostPools.createOrUpdate::parameters.resource, "hostPool");

@@clientName(ScalingPlans.create::parameters.resource, "scalingPlan");

@@clientName(
  ScalingPlanPersonalSchedules.create::parameters.resource,
  "scalingPlanSchedule"
);

@@clientName(
  ScalingPlanPooledSchedules.create::parameters.resource,
  "scalingPlanSchedule"
);

@@clientName(Workspaces.createOrUpdate::parameters.resource, "workspace");

@@clientName(
  ControlSessionHostUpdate.post::parameters.body,
  "hostPoolUpdateControlParameter"
);

@@clientName(
  ControlSessionHostProvisioning.post::parameters.body,
  "hostPoolProvisioningControlParameter"
);

@@clientName(
  SessionHostManagements.createOrUpdate::parameters.resource,
  "sessionHostManagement"
);

@@clientName(
  SessionHostConfigurations.createOrUpdate::parameters.resource,
  "sessionHostConfiguration"
);

@@clientName(MSIXPackages.createOrUpdate::parameters.resource, "msixPackage");

@@clientName(MSIXPackages.update::parameters.properties, "msixPackage");

@@pattern(
  Azure.ResourceManager.ResourceKindProperty.kind,
  "^[-\\w\\._,\\(\\)]+$"
);

@@clientName(MSIXImages, "MsixImages", "autorest,java");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ActiveSessionHostConfiguration.properties,
  "autorest,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ApplicationGroup.properties,
  "autorest,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  AppAttachPackage.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Application.properties,
  "autorest,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Desktop.properties,
  "autorest,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  HostPool.properties,
  "autorest,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  MSIXPackage.properties,
  "autorest,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Workspace.properties,
  "autorest,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  PrivateEndpointConnectionWithSystemData.properties,
  "autorest,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  PrivateLinkResource.properties,
  "java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ScalingPlanPersonalSchedule.properties,
  "autorest,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ScalingPlan.properties,
  "autorest,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ScalingPlanPooledSchedule.properties,
  "autorest,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  SessionHost.properties,
  "autorest,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  SessionHostConfiguration.properties,
  "autorest,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  SessionHostManagement.properties,
  "autorest,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  UserSession.properties,
  "autorest,java"
);

@@Azure.ClientGenerator.Core.clientName(
  AppAttachPackageInfo.`import`::parameters.body,
  "importPackageInfoRequest"
);
@@doc(
  AppAttachPackageInfo.`import`::parameters.body,
  "Information to import app attach package"
);
@@Azure.ClientGenerator.Core.clientName(
  MSIXImages.expand::parameters.body,
  "msixImageURI"
);
@@doc(
  MSIXImages.expand::parameters.body,
  "Represents URI referring to MSIX Image"
);
@@Azure.ClientGenerator.Core.clientName(
  InitiateSessionHostUpdate.post::parameters.body,
  "updateSessionHostsRequestBody"
);
@@doc(
  InitiateSessionHostUpdate.post::parameters.body,
  "The resource properties to be updated"
);
