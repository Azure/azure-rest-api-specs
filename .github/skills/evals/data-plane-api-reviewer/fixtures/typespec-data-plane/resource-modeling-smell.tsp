import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "Document Pipeline" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://documentpipeline.azure.com/.default"],
    }
  ]>
)
@server("https://{endpoint}", "Document Pipeline service", { endpoint: string })
namespace DocumentPipeline;

enum Versions {
  v2026_01_01: "2026-01-01",
}

@doc("A pipeline configuration. Created and read only through actions.")
model PipelineConfig {
  @doc("The unique identifier of the configuration.")
  configId: string;

  @doc("Human-readable name of the configuration.")
  name: string;

  @doc("Maximum number of documents processed per batch.")
  batchSize: int32;
}

@doc("Request to create a pipeline configuration.")
model CreateConfigRequest {
  @doc("Human-readable name of the configuration.")
  name: string;

  @doc("Maximum number of documents processed per batch.")
  batchSize: int32;
}

@doc("Request identifying a single configuration.")
model ConfigIdRequest {
  @doc("The unique identifier of the configuration.")
  configId: string;
}

interface Pipeline {
  @doc("Creates a pipeline configuration.")
  @route("/createConfig")
  @post
  createConfig(@body body: CreateConfigRequest): PipelineConfig;

  @doc("Gets a pipeline configuration.")
  @route("/getConfig")
  @post
  getConfig(@body body: ConfigIdRequest): PipelineConfig;

  @doc("Gets all pipeline configurations.")
  @route("/getAllConfigs")
  @post
  getAllConfigs(): PipelineConfig[];

  @doc("Deletes a pipeline configuration.")
  @route("/deleteConfig")
  @post
  deleteConfig(@body body: ConfigIdRequest): void;
}
