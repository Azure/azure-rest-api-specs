import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using WebPubSubService;

namespace Customizations;

model WebSubPubClientOptions {
  /** Target hub name, which should start with alphabetic characters and only contain
     alpha-numeric characters or underscore. */
  hub: string;
}

@@clientInitialization(WebPubSubService,
  {
    parameters: WebSubPubClientOptions,
  }
);

@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.addConnectionsToGroups,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.closeAllConnections,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.getClientAccessToken,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.removeConnectionsFromGroups,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.sendToAll,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.closeConnection,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.connectionExists,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.sendToConnection,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.removeConnectionFromAllGroups,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.groupExists,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.closeGroupConnections,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.sendToGroup,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.listConnections,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.removeConnectionFromGroup,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.addConnectionToGroup,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.revokePermission,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.hasPermission,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.grantPermission,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.userExists,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.closeUserConnections,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.sendToUser,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.removeUserFromAllGroups,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.removeUserFromGroup,
  WebPubSubService
);
@@clientLocation(WebPubSubService.WebPubSubServiceOperationGroup.addUserToGroup,
  WebPubSubService
);
@@clientLocation(WebPubSubService.HealthApiOperationGroup.getServiceStatus,
  WebPubSubService
);
