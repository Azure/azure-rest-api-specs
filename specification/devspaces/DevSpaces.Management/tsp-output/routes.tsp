import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DevSpaces;

interface ContainerHostMappingsOperations {
  @summary("Returns container host mapping object for a container host resource ID if an associated controller exists.")
  @doc("Returns container host mapping object for a container host resource ID if an associated controller exists.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevSpaces/locations/{location}/checkContainerHostMapping")
  @post
  getContainerHostMapping is Azure.Core.Foundations.Operation<
    {
      @doc("Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("Location of the container host.")
      @path
      location: string;

      @body
      containerHostMapping: ContainerHostMapping;
    },
    ContainerHostMapping | void
  >;
}
