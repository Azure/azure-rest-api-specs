import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./videoDescription.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@useAuth(AADToken)
@service({
    title: "Video Analysis",
})
@versioned(VideoAnalysis.Versions)
@server(
    "{endpoint}/videoanalysis",
    "Azure AI Video Analysis API",
    {
        @doc("The Video Analysis service endpoint.")
        endpoint: string,

        @doc("API Version")
        @query
        apiVersion: Versions,
    }
)
namespace VideoAnalysis;

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style for AAD"
@doc("The Azure Active Directory OAuth2 Flow")
model AADToken
    is OAuth2Auth<[
        {
            type: OAuth2FlowType.authorizationCode;
            authorizationUrl: "https://api.example.com/oauth2/authorize";
            tokenUrl: "https://api.example.com/oauth2/token";
            scopes: ["https://cognitiveservices.azure.com/.default"];
        }
    ]>;

@doc("The VideoAnalyis service versions.")
enum Versions {
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    @doc("The 2024-05-01-preview version of the VideoAnalysis service.")
    v2024_05_01_preview: "v2024-05-01-preview",
}
