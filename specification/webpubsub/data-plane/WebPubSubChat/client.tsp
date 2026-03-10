import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Customizations;

/** Client options for Azure Web PubSub Chat. */
model WebPubSubChatClientOptions {
  /** Target hub name, which should start with alphabetic characters and only contain
     alpha-numeric characters or underscore. */
  hub: string;
}

@@clientName(WebPubSubChat.Chat, "WebPubSubChat");

@@clientInitialization(WebPubSubChat.Chat,
  {
    parameters: WebPubSubChatClientOptions,
  }
);
