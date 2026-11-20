import "@typespec/http";
import "../lib/main.tsp";

using TypeSpec.Http;
using Microsoft.Foundry.Core;

/** A minimal sample service that lists widgets using the shared pagination helpers. */
@service(#{ title: "Pagination Sample" })
namespace PaginationSample;

model Widget {
  @visibility(Lifecycle.Read)
  id: string;

  name: string;
}

@route("/widgets")
@get
@list
op listWidgets(...CommonPageQueryParameters): AgentsPagedResult<Widget>;
