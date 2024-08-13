import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "../VDI.BatchRegistration/main.tsp";
import "./routes/videoDescription.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Versioning;
using VdiBatchRegistration;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.contoso.com/common/oauth2/v2.0/authorize",
      scopes: ["https://widget.contoso.com/.default"],
    }
  ]>
)
@service({
  title: "VDI VideoAnalysis service",
})
@versioned(VdiVideoAnalysis.Versions)
namespace VdiVideoAnalysis;

@doc("The VdiVideoAnalysis service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-05-01-preview version of the VDI.VideoAnalysis service.")
  v2024_05_01_preview: "2024-05-01-preview",
}
