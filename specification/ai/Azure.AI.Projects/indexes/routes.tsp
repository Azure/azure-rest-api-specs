import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "../servicepatterns.tsp";
import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ListIndexVersionParameters = {
  @doc("Top count of results, top count cannot be greater than the page size. If topCount > page size, results with be default page size count will be returned")
  @query
  top?: int32;

  @doc("Continuation token for pagination.")
  @query
  skip?: string;

  @doc("Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2")
  @query
  tags?: string;

  @doc("[ListViewType.ActiveOnly, ListViewType.ArchivedOnly, ListViewType.All] View type for including/excluding (for example) archived entities.")
  @query
  listViewType?: ListViewType;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@added(Versions.v2025_05_01)
interface Indexes
  extends ServicePatterns.VersionedOperations<
      Index,
      ListIndexVersionParameters,
      ListIndexVersionParameters
    > {}
