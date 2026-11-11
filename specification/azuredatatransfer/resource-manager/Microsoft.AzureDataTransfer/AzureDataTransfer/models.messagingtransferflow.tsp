import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "./models.flowcommon.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Versioning;

@versioned(Versions)
namespace Microsoft.AzureDataTransfer;

/**
 * Properties of a messaging flow
 */
@added(Versions.v2026_06_29_preview)
model MessagingTransferFlowProperties {
  ...CommonTransferFlowProperties;

  /**
   * ARM resource ID of the Service Bus queue or Event Hub used for this flow. The
   * messaging namespace and messaging type are derived from this ID.
   */
  messagingDataResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ServiceBus/namespaces/queues";
    },
    {
      type: "Microsoft.EventHub/namespaces/eventhubs";
    }
  ]>;

  /**
   * Event Hub consumer group. Only valid when messagingDataResourceId is an Event Hub. Defaults to "$Default".
   */
  consumerGroup?: string;

  /**
   * The messaging options for this flow.
   */
  messagingOptions?: MessagingOptions;
}

/**
 * The messaging transfer flow resource patch definition.
 */
@added(Versions.v2026_06_29_preview)
model MessagingTransferFlowsPatch {
  ...ManagedServiceIdentityProperty;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
