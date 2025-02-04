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
