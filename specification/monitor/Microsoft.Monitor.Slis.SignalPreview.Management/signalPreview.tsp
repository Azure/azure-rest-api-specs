import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.Monitor;

@doc("Defines the available preview types for signal preview.")
union PreviewType {
  @doc("Preview for good signal.")
  GoodSignal: "goodsignal",

  @doc("Preview for total signal.")
  TotalSignal: "totalsignal",

  @doc("Preview for signal.")
  Signal: "signal",

  @doc("Preview for SLO evaluation.")
  Slo: "slo",

  string,
}

@doc("Specifies how the SLI is evaluated.")
union EvaluationType {
  @doc("Evaluates SLI based on time windows.")
  "WindowBased",

  @doc("Evaluates SLI based on request counts.")
  "RequestBased",

  string,
}

alias SignalPreviewServiceGroupRoute = "/providers/Microsoft.Management/serviceGroups";

@doc("ServiceGroup as parameter")
model ServiceGroupBaseParameters {
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("The name of the service group.")
  serviceGroupName: string;
}

@doc("Defines the properties for signal preview SLI.")
model SignalPreviewSliProperties {
  @doc("The preview type for the signal preview operation.")
  previewType: PreviewType;

  @doc("Determines how the SLI is evaluated—either based on request counts or time windows.")
  evaluationType: EvaluationType;

  @doc("Defines the SLO baseline associated with the SLI.")
  baselineProperties?: BaselineProperties;

  // Window-based properties (used when evaluationType is WindowBased)
  @doc("Defines the uptime criteria for window-based SLIs.")
  windowUptimeCriteria?: WindowUptimeCriteria;

  @doc("Signals used for window-based SLI calculations.")
  signals?: Signal;

  // Request-based properties (used when evaluationType is RequestBased)
  @doc("Represents good signals used in request-based SLI calculations.")
  goodSignals?: Signal;

  @doc("Represents total signals used in request-based SLI calculations.")
  totalSignals?: Signal;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only metadata resource."
@armResourceOperations
@doc("Defines operations for previewing signal.")
interface SloView {
  /**
  POST Actions
  */
  @route(SignalPreviewServiceGroupRoute)
  @post
  @armResourceCollectionAction
  @action("providers/Microsoft.Monitor/sliSignalPreview")
  @doc("Returns preview data for the signal.")
  sliSignalPreview(
    @path
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    @doc("The name of the service group.")
    serviceGroupName: string,

    ...Azure.ResourceManager.ApiVersionParameter,

    @body
    @doc("The signal preview properties.")
    body: SignalPreviewSliProperties,
  ): {
    @statusCode statusCode: 200;
    @body body: KqlmQueryResult;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;
}
