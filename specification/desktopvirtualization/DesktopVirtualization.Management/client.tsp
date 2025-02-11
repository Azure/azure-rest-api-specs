import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "./AppAttachPackage.tsp";
import "./PrivateEndpointConnection.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;
using Microsoft.DesktopVirtualization;

@@clientName(CustomPrivateEndpointConnection, "PrivateEndpointConnections");

@@clientName(AppAttachPackages, "AppAttachPackage");

@@clientName(AppAttachPackages.createOrUpdate::parameters.resource,
  "appAttachPackage"
);

@@clientName(Applications.createOrUpdate::parameters.resource, "application");

@@clientName(CustomPrivateEndpointConnection.updateByWorkspace::parameters.body,
  "connection"
);

@@clientName(CustomPrivateEndpointConnection.updateByHostPool::parameters.body,
  "connection"
);

@@clientName(HostPools.createOrUpdate::parameters.resource, "hostPool");

@@clientName(AppAttachPackageInfo.`import`::parameters.body,
  "importPackageInfoRequest"
);

@@clientName(MSIXImages.expand::parameters.body, "msixImageURI");

@@clientName(ScalingPlans.create::parameters.resource, "scalingPlan");

@@clientName(ScalingPlanPersonalSchedules.create::parameters.resource,
  "scalingPlanSchedule"
);

@@clientName(ScalingPlanPooledSchedules.create::parameters.resource,
  "scalingPlanSchedule"
);

@@clientName(Workspaces.createOrUpdate::parameters.resource, "workspace");

@@clientName(ControlSessionHostUpdate.post::parameters.body,
  "hostPoolUpdateControlParameter"
);

@@clientName(SessionHostManagements.createOrUpdate::parameters.resource,
  "sessionHostManagement"
);

@@clientName(SessionHostConfigurations.createOrUpdate::parameters.resource,
  "sessionHostConfiguration"
);

@@clientName(InitiateSessionHostUpdate.post::parameters.body,
  "updateSessionHostsRequestBody"
);

@@clientName(Applications.update::parameters.properties, "application");

@@clientName(Desktops.update::parameters.properties, "desktop");

@@clientName(UserSessions.sendMessage::parameters.body, "sendMessage");

@@clientName(HostPools.update::parameters.properties, "hostPool");

@@clientName(SessionHostConfigurations.update::parameters.properties,
  "sessionHostConfiguration"
);

@@clientName(SessionHostManagements.update::parameters.properties,
  "sessionHostManagement"
);

@@clientName(SessionHosts.update::parameters.properties, "sessionHost");

@@clientName(ScalingPlans.update::parameters.properties, "scalingPlan");

@@clientName(ScalingPlanPersonalSchedules.update::parameters.properties,
  "scalingPlanSchedule"
);

@@clientName(ScalingPlanPooledSchedules.update::parameters.properties,
  "scalingPlanSchedule"
);

@@clientName(Workspaces.update::parameters.properties, "workspace");

@@pattern(Azure.ResourceManager.ResourceKindProperty.kind,
  "^[-\\w\\._,\\(\\)]+$"
);
