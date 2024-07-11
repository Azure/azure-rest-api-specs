import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./model.radiologyinsights.tsp";
import "./model.radiologyinsights.valuesets.tsp";
import "../HealthInsights.Common/primitives.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureHealthInsights;

interface RadiologyInsights {
  @summary("Get Radiology Insights job details")
  @tag("RadiologyInsights")
  @doc("Gets the status and details of the Radiology Insights job.")
  @get
  getJob is HealthInsightsOperations.ResourceRead<RadiologyInsightsJob>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit standard operation"
  @summary("Create Radiology Insights job")
  @tag("RadiologyInsights")
  @doc("Creates a Radiology Insights job with the given request body.")
  @pollingOperation(RadiologyInsights.getJob)
  @route("radiology-insights/jobs/{id}")
  @put
  createJob is Foundations.Operation<
    {
      @doc("The unique ID of the job.")
      @maxLength(36)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]+[a-zA-Z0-9]$")
      @path
      id: string;

      ...Azure.Core.ExpandQueryParameter;

      @doc("The Radiology Insights request.")
      @body
      resource: RadiologyInsightsJob;
    },
    (RadiologyInsightsInferenceResult & {
      @doc("An opaque, globally-unique, server-generated string identifier for the request.")
      @header("x-ms-request-id")
      requestId: RequestIdResponseHeader;

      @doc("The location for monitoring the operation state.")
      @header("Operation-Location")
      operationLocation: url;
    }) | (RadiologyInsightsInferenceResult & {
      @statusCode _: 201;

      @doc("An opaque, globally-unique, server-generated string identifier for the request.")
      @header("x-ms-request-id")
      requestId: RequestIdResponseHeader;

      @doc("The location for monitoring the operation state.")
      @header("Operation-Location")
      operationLocation: url;
    }),
    ServiceTraits,
    HealthInsightsErrorResponse
  >;
}
