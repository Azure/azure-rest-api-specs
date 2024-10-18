import "@typespec/versioning";

import "./Microsoft.ApiCenter/ApiCenter.tsp";
import "./Microsoft.ApiManagement/ApiManagement.tsp";
import "./Microsoft.AppConfiguration/AppConfiguration.tsp";
import "./Microsoft.AVS/AVS.tsp";
import "./Microsoft.Communication/AzureCommunicationServices.tsp";
import "./Microsoft.ContainerRegistry/ContainerRegistry.tsp";
import "./Microsoft.ContainerService/ContainerService.tsp";
import "./Microsoft.DataBox/DataBox.tsp";
import "./Microsoft.EventHub/EventHub.tsp";
import "./Microsoft.Maps/Maps.tsp";
import "./Microsoft.Devices/IotHub.tsp";
import "./Microsoft.HealthcareApis/HealthcareApis.tsp";
import "./Microsoft.KeyVault/KeyVault.tsp";
import "./Microsoft.MachineLearningServices/MachineLearningServices.tsp";
import "./Microsoft.Media/MediaServices.tsp";
import "./Microsoft.PolicyInsights/PolicyInsights.tsp";
import "./Microsoft.Cache/RedisCache.tsp";
import "./Microsoft.Resources/Resources.tsp";
import "./Microsoft.ServiceBus/ServiceBus.tsp";
import "./Microsoft.SignalRService/SignalRService.tsp";
import "./Microsoft.Storage/Storage.tsp";
import "./Microsoft.Web/Web.tsp";
import "./Microsoft.EventGrid/EventGrid.tsp";
import "./Microsoft.ResourceNotifications/ResourceNotifications.tsp";

import "./propertyNameOverride.tsp";

/** Azure Messaging EventGrid SystemEvents */
@service({
  title: "Azure.Messaging.SystemEvents",
})
@versioned(ServiceApiVersions)
namespace Microsoft.EventGrid.SystemEvents {
  using TypeSpec.Versioning;

  enum ServiceApiVersions {
    v2018_01_01: "2018-01-01",
    v2024_01_01: "2024-01-01",
  }
}
