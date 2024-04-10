import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using TypeSpec.OpenAPI;

namespace Microsoft.MessagingConnectors;

@doc("Base Parameters for Location Level operation")
model LocationLevelBaseParameters {
  ...ApiVersionParameter;

  ...SubscriptionIdParameter;

  ...LocationResourceParameter;
}


#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
@doc("ActionAsync base operation")
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "location",
  }
)
op ActionAsyncBase<
  Request extends TypeSpec.Reflection.Model | void,
  Response extends TypeSpec.Reflection.Model | void,
  BaseParameters extends TypeSpec.Reflection.Model,
  Parameters extends {} = {},
  Error extends {} = ErrorResponse
>(
  ...BaseParameters,
  ...Parameters,

  @doc("The content of the action request")
  @body
  body: Request,
): Response | Error;


#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
@doc("ActionAsync operation")
op LocationLevelActionAsync<
  Request extends TypeSpec.Reflection.Model | void,
  Response extends TypeSpec.Reflection.Model | void,
  LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader<
    Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
    Response,
    string
  > &
    Azure.Core.Foundations.RetryAfterHeader,
  BaseParameters extends TypeSpec.Reflection.Model = LocationLevelBaseParameters,
  Parameters extends {} = {},
  Error extends {} = ErrorResponse
> is ActionAsyncBase<
  Request,
  ArmAcceptedLroResponse<"Resource operation accepted.", LroHeaders> | Response,
  BaseParameters,
  Parameters,
  Error
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
@route("/subscriptions/{subscriptionId}/providers/Microsoft.MessagingConnectors/locations/{location}/")
interface DataPreviewOperations {
  @route("dataPreview")
  dataPreview is LocationLevelActionAsync<DataPreviewProperties, DataPreviewResults>;
}