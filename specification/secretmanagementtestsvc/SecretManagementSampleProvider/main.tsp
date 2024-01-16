//---------------------------------------------------------------------------------------------
// <copyright file="main.tsp" company="Microsoft">
// Copyright (c) Microsoft.  All rights reserved.
// </copyright>
//---------------------------------------------------------------------------------------------
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

// Documentation: https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-type
@armProviderNamespace
@service({
  title: "Secret Management Test Service",
  version: "2022-08-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.SecretManagementSampleProvider;

@doc("The properties of WeatherForecast")
model WeatherForecastProperties {
  @doc("City name for the forecast")
  city: string;

  @doc("Date of the forecast")
  date: string; // Workaround for github issue https://github.com/Azure/typespec-azure/issues/1834 with plainDate TypeSpec type.

  @doc("High temperature in Fahrenheit")
  highTemperatureF: int32;

  @doc("Low temperature in Fahrenheit")
  lowTemperatureF: int32;

  @doc("Summary of the weather")
  summary?: string;
}

@lroStatus
@doc("Provisioning state of the resource")
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The resource is accepted")
  Accepted,

  @doc("The resource is being created")
  Creating,

  @doc("The resource is being updated")
  Updating,

  @doc("The resource is being deleted")
  Deleting,
}

@doc("The properties of WeatherForecastResource")
model WeatherForecastResourceProperties {
  @doc("Provisioning state of the resource")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @extension("x-ms-identifiers", ["city"])
  @doc("Collection of weather forecasts")
  weatherForecastProperties: WeatherForecastProperties[];
}

@doc("A WeatherForecastResource")
model WeatherForecastResource
  is TrackedResource<WeatherForecastResourceProperties> {
  @doc("Weather forecast resource name")
  @key("weatherForecastResourceName")
  @segment("forecasts")
  @visibility("read")
  @path
  name: string;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Forecasts
  extends TrackedResourceOperations<
      WeatherForecastResource,
      WeatherForecastResourceProperties
    > {}
