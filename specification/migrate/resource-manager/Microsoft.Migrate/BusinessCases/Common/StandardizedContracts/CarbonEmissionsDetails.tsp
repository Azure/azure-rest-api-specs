import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@doc("Details of carbon emissions.")
model CarbonEmissionsDetails {
  @doc("Scope 1 emissions in metric tons of CO2 equivalent (MTCO2e).")
  @visibility(Lifecycle.Read)
  scope1: CarbonEmissionsScopeDetails;

  @doc("Scope 2 emissions in metric tons of CO2 equivalent (MTCO2e).")
  @visibility(Lifecycle.Read)
  scope2: CarbonEmissionsScopeDetails;

  @doc("Scope 3 emissions in metric tons of CO2 equivalent (MTCO2e).")
  @visibility(Lifecycle.Read)
  scope3: CarbonEmissionsScopeDetails;
}

@doc("Details of carbon emissions scope.")
model CarbonEmissionsScopeDetails {
  @doc("The compute emissions in metric tons of CO2 equivalent (MTCO2e).")
  @visibility(Lifecycle.Read)
  compute: float32;

  @doc("The storage emissions in metric tons of CO2 equivalent (MTCO2e).")
  @visibility(Lifecycle.Read)
  storage: float32;
}
