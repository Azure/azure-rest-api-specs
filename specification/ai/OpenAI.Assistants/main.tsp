import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "@typespec/versioning";

import "./assistants/main.tsp";
import "./threads/main.tsp";
import "./messages/main.tsp";
import "./runs/main.tsp";
import "./run_steps/main.tsp";
import "./files/main.tsp";
import "./streaming/events.tsp";
import "./vector_stores/main.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

using Azure.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
namespace Azure.AI {

}

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
namespace Azure.AI.OpenAI {

}

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://cognitiveservices.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Azure OpenAI" })
@server(
  "{endpoint}",
  "Azure OpenAI APIs for Assistants.",
  {
    @doc("An OpenAI endpoint supporting assistants functionality.")
    endpoint: string,
  }
)
@versioned(ServiceApiVersions)
@doc("Azure OpenAI APIs for Assistants.")
namespace Azure.AI.OpenAI.Assistants {
  @doc("The known set of supported API versions.")
  enum ServiceApiVersions {
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    @doc("The initial version of Azure OpenAI Assistants that corresponds to functionality in OpenAI's first beta release.")
    v2024_02_15_preview: "2024-02-15-preview",

    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    @doc("The May 2024 preview release for Azure OpenAI, including the first availability of assistants V2.")
    v2024_05_01_preview: "2024-05-01-preview",

    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    @doc("The July 2024 preview release for Azure OpenAI.")
    v2024_07_01_preview: "2024-07-01-preview",

    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    @doc("The September 2024 preview release for Azure OpenAI.")
    v2024_09_01_preview: "2024-09-01-preview",

    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    @doc("The October 2024 preview release for Azure OpenAI.")
    v2024_10_01_Preview: "2024-10-01-preview",

    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    @doc("The December 2024 preview release for Azure OpenAI.")
    v2025_01_01_preview: "2025-01-01-preview",
  }
}
