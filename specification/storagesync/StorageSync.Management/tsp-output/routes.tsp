import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.StorageSync;

interface OperationStatusOperations {
  @doc("Get Operation status")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/locations/{locationName}/workflows/{workflowId}/operations/{operationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The desired region to obtain information from.")
      @path
      locationName: string;

      @doc("workflow Id")
      @path
      workflowId: string;

      @doc("operation Id")
      @path
      operationId: string;
    },
    OperationStatus
  >;
}

@doc("Get Operation status")
// FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
// Problematic names: [LocationOperationStatus]
@route("/subscriptions/{subscriptionId}/providers/Microsoft.StorageSync/locations/{locationName}/operations/{operationId}")
@get
op LocationOperationStatus is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @minLength(1)
    @path
    subscriptionId: string;

    @doc("The desired region to obtain information from.")
    @path
    locationName: string;

    @doc("operation Id")
    @path
    operationId: string;
  },
  LocationOperationStatus
>;
