import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../lib/main.tsp";

using TypeSpec.Http;
using Microsoft.Foundry.Core;

/** A minimal sample service that reports failures as Azure range errors. */
@service(#{ title: "Error Handling Sample" })
namespace ErrorHandlingSample;

model Widget {
  @visibility(Lifecycle.Read)
  id: string;
}

@route("/widgets/{id}")
@get
op getWidget(@path id: string): Widget | AzureRangeErrorResponse;
