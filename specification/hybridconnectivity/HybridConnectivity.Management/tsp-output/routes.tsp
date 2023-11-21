import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace HybridConnectivityManagementAPI;

interface OperationsOperations {
  @doc("Lists the available Hybrid Connectivity REST API operations.")
  @route("/providers/Microsoft.HybridConnectivity/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface EndpointsOperations {
  @doc("List of endpoints to the target resource.")
  @route("/{resourceUri}/providers/Microsoft.HybridConnectivity/endpoints")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The fully qualified Azure Resource manager identifier of the resource to be
connected.
""")
      @path
      resourceUri: string;
    },
    EndpointsList
  >;

  @doc("Gets the endpoint to the resource.")
  @route("/{resourceUri}/providers/Microsoft.HybridConnectivity/endpoints/{endpointName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The fully qualified Azure Resource manager identifier of the resource to be
connected.
""")
      @path
      resourceUri: string;

      @doc("The endpoint name.")
      @path
      endpointName: string;
    },
    EndpointResource
  >;

  @doc("Create or update the endpoint to the target resource.")
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [EndpointResource]
  @route("/{resourceUri}/providers/Microsoft.HybridConnectivity/endpoints/{endpointName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The fully qualified Azure Resource manager identifier of the resource to be
connected.
""")
      @path
      resourceUri: string;

      @doc("The endpoint name.")
      @path
      endpointName: string;

      @doc("Endpoint details")
      @body
      EndpointResource: EndpointResource;
    },
    EndpointResource
  >;

  @doc("Update the endpoint to the target resource.")
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [EndpointResource]
  @route("/{resourceUri}/providers/Microsoft.HybridConnectivity/endpoints/{endpointName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
The fully qualified Azure Resource manager identifier of the resource to be
connected.
""")
      @path
      resourceUri: string;

      @doc("The endpoint name.")
      @path
      endpointName: string;

      @doc("Endpoint details")
      @body
      EndpointResource: EndpointResource;
    },
    EndpointResource
  >;

  @doc("Deletes the endpoint access to the target resource.")
  @route("/{resourceUri}/providers/Microsoft.HybridConnectivity/endpoints/{endpointName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The fully qualified Azure Resource manager identifier of the resource to be
connected.
""")
      @path
      resourceUri: string;

      @doc("The endpoint name.")
      @path
      endpointName: string;
    },
    void
  >;

  @doc("Gets the endpoint access credentials to the resource.")
  @route("/{resourceUri}/providers/Microsoft.HybridConnectivity/endpoints/{endpointName}/listCredentials")
  @post
  ListCredentials is Azure.Core.Foundations.Operation<
    {
      @doc("""
The fully qualified Azure Resource manager identifier of the resource to be
connected.
""")
      @path
      resourceUri: string;

      @doc("The endpoint name.")
      @path
      endpointName: string;

      @doc("The is how long the endpoint access token is valid (in seconds).")
      @query
      expiresin: int32;
    },
    EndpointAccessResource
  >;
}
