import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Messaging.WebPubSubService;

namespace Customizations;

model WebSubPubClientOptions {
  /** Target hub name, which should start with alphabetic characters and only contain
     alpha-numeric characters or underscore. */
  hub: string;
}

@@clientInitialization(Azure.Messaging.WebPubSubService,
  {
    parameters: WebSubPubClientOptions,
  }
);

@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.addConnectionsToGroups,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.closeAllConnections,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.getClientAccessToken,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.removeConnectionsFromGroups,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.sendToAll,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.closeConnection,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.connectionExists,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.sendToConnection,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.removeConnectionFromAllGroups,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.groupExists,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.closeGroupConnections,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.sendToGroup,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.listConnections,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.removeConnectionFromGroup,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.addConnectionToGroup,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.revokePermission,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.checkPermission,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.grantPermission,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.userExists,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.closeUserConnections,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.sendToUser,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.removeUserFromAllGroups,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.removeUserFromGroup,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubService.addUserToGroup,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.HealthApiOperationGroup.getServiceStatus,
  Azure.Messaging.WebPubSubService
);
