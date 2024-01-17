import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Batch Document Translation Client",
})
@server(
  "{endpoint}/translator/text/batch/v1.1",
  "// FIXME: (miissing-service-description) Add service description",
  {
    endpoint: string,
  }
)
@doc("// FIXME: (miissing-service-description) Add service description")
namespace BatchDocumentTranslationClient;
