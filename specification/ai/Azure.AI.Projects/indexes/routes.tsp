import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Projects;

alias ListIndexVersionParameters = {
  @doc("View type for including/excluding (for example) archived entities.")
  @query
  listViewType: string = "ActiveOnly";

  @doc("Ordering of list: Please choose orderby value from ['createdAt', 'lastModifiedAt'].")
  @query
  orderBy?: string;

  @doc("Ordering of list: Please choose orderby value from ['createdAt', 'lastModifiedAt'].")
  @query
  orderby?: string;

  @doc("Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2.")
  @query
  tags?: string;

  ...StandardListQueryParameters;
};

alias ListLatestIndexParameters = {
  @doc("View type for including/excluding (for example) archived entities.")
  @query("listViewType")
  listViewType?: ListViewType;
};
interface Indexes
  extends ServicePatterns.VersionedOperations<
      Index,
      ListLatestIndexParameters,
      ListIndexVersionParameters
    > {}
