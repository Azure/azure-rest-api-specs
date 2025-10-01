import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "./AppAttachPackage.tsp";
import "./PrivateEndpointConnection.tsp";
import "./Workspace.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.DesktopVirtualization;

@@clientName(CustomPrivateEndpointConnection, "PrivateEndpointConnections");

@@clientName(AppAttachPackages, "AppAttachPackage");

@@clientName(AppAttachPackages.createOrUpdate::parameters.resource,
  "appAttachPackage"
);

@@clientName(Applications.createOrUpdate::parameters.resource, "application");

@@clientName(CustomPrivateEndpointConnection.updateByWorkspace::parameters.resource,
  "connection"
);

@@clientName(CustomPrivateEndpointConnection.updateByHostPool::parameters.resource,
  "connection"
);

@@clientName(HostPools.createOrUpdate::parameters.resource, "hostPool");

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

@@clientName(ControlSessionHostProvisioning.post::parameters.body,
  "hostPoolProvisioningControlParameter"
);

@@clientName(SessionHostManagements.createOrUpdate::parameters.resource,
  "sessionHostManagement"
);

@@clientName(SessionHostConfigurations.createOrUpdate::parameters.resource,
  "sessionHostConfiguration"
);

@@clientName(MSIXPackages.createOrUpdate::parameters.resource, "msixPackage");

@@clientName(MSIXPackages.update::parameters.properties, "msixPackage");

@@pattern(Azure.ResourceManager.ResourceKindProperty.kind,
  "^[-\\w\\._,\\(\\)]+$"
);

@@clientName(MSIXImages, "MsixImages", "autorest");
