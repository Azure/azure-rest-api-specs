import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices;

interface ModelContainers {
  /**
   * Get model container.
   */
  @doc("Get a model container.")
  @route("/models/{name}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the model container.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;
    },
    ModelContainer
  >;

  @doc("Creates or updates a model container.")
  @route("/models/{name}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the model container.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;
    },
    ResourceCreatedOrOkResponse<ModelContainer>
  >;
}

interface ModelVersions {
  @doc("List model versions.")
  @route("/models/{name}/versions")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the model container.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;

      @doc("$skip")
      @query("$skip")
      $skip?: string;

      @doc("$orderBy")
      @query("$orderBy")
      $orderBy?: string;

      @doc("$top")
      @query("$top")
      $top?: int32;

      @doc("Model version")
      @query("version")
      version?: string;

      @doc("Model description")
      @query("description")
      description?: string;

      @doc("Number of initial results to skip.")
      @query("offset")
      offset?: int32;

      @doc("Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2")
      @query("tags")
      tags?: string;

      @doc("Comma-separated list of property names (and optionally values). Example: prop1,prop2=value2")
      @query("properties")
      properties?: string;

      @doc("Name of the feed.")
      @query("feed")
      feed?: string;

      @doc("View type for including/excluding (for example) archived entities.")
      @query("listViewType")
      listViewType?: ListViewType;
    },
    PagedModelVersion
  >;
}
