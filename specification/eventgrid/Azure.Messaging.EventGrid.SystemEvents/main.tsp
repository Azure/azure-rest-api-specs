import "@typespec/versioning";

import "./ApiManagement.tsp";
import "./AppConfiguration.tsp";
import "./AVS.tsp";
import "./AzureCommunicationServices.tsp";
import "./ContainerRegistry.tsp";
import "./ContainerService.tsp";
import "./DataBox.tsp";
import "./EventHub.tsp";
import "./Maps.tsp";
import "./IotHub.tsp";
import "./HealthcareApis.tsp";
import "./KeyVault.tsp";
import "./MachineLearningServices.tsp";
import "./MediaServices.tsp";
import "./PolicyInsights.tsp";
import "./RedisCache.tsp";
import "./Resources.tsp";
import "./ServiceBus.tsp";
import "./SignalRService.tsp";
import "./Storage.tsp";
import "./Web.tsp";
import "./EventGrid.tsp";
import "./ResourceNotifications.tsp";

import "./propertyNameOverride.tsp";

/** Azure Messaging EventGrid SystemEvents */
@service({
  title: "Azure.Messaging.SystemEvents",
})
@versioned(ServiceApiVersions)
namespace Microsoft.EventGrid.SystemEvents {
  using TypeSpec.Versioning;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
  enum ServiceApiVersions {
    v2024_01_01: "2024-01-01",
  }
}
