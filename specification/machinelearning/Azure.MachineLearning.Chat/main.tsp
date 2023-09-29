import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./operations.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@service({
  title: "Azure ML Chat",
})
@server(
  "{endpoint}",
  "Azure ML Chat APIs",
  {
    endpoint: string,
  }
)
@versioned(APIVersion)
namespace Azure.AI.Chat;

enum APIVersion {
    v20231001Preview: "2023-10-01-preview",
}