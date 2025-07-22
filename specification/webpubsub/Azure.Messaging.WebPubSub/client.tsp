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

@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.addConnectionsToGroups,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.closeAllConnections,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.getClientAccessToken,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.removeConnectionsFromGroups,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.sendToAll,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.closeConnection,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.connectionExists,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.sendToConnection,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.removeConnectionFromAllGroups,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.groupExists,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.closeGroupConnections,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.sendToGroup,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.listConnections,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.removeConnectionFromGroup,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.addConnectionToGroup,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.revokePermission,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.hasPermission,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.grantPermission,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.userExists,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.closeUserConnections,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.sendToUser,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.removeUserFromAllGroups,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.removeUserFromGroup,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.WebPubSubServiceOperationGroup.addUserToGroup,
  Azure.Messaging.WebPubSubService
);
@@clientLocation(Azure.Messaging.WebPubSubService.HealthApiOperationGroup.getServiceStatus,
  Azure.Messaging.WebPubSubService
);
