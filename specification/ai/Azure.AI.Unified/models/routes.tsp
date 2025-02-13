import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Unified;

interface ModelContainers {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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
}

interface ModelVersions {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get a model version.")
  @route("/models/{name}/versions/{version}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the model version.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;

      @doc("Model version")
      version: string;
    },
    ModelVersion
  >;
}
