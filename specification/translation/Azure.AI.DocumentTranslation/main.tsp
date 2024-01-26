import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

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
@versioned(DocumentTranslationRestClient.Versions)
namespace DocumentTranslationRestClient;

/** The Azure.AI.DocumentTranslation versions. */
enum Versions {
  /** DocumentTranslationClient versions. */
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  `v1.0`,
}
