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

interface Connections {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get a connection by name.")
  @route("/connections/{name}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the connection.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;
    },
    Connection
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get a connection with credentials by name.")
  @route("/connections/{name}/listsecrets")
  @post
  post is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the connection.")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
      @maxLength(254)
      @path
      name: string;
    },
    Connection
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List all connections in the project.")
  @route("/connections")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      ...StandardListQueryParameters;
    },
    PagedConnection
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List all connections with credentials in the project.")
  @route("/connections/withsecrets")
  @post
  listWithCredentials is Azure.Core.Foundations.Operation<
    {
      ...StandardListQueryParameters;
    },
    PagedConnection
  >;
}
