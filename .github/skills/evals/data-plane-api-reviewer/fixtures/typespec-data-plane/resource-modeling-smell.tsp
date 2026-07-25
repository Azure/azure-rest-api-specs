// FIXTURE (positive): RPC over HTTP. Nothing is addressable; every operation is
// a POST to a verb-shaped path. Seeded violations: DP-MODEL-01, DP-MODEL-02,
// DP-MODEL-04.
// Not a real service. Not under specification/; not compiled by CI.

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
@server("https://{endpoint}", "Document Pipeline service", { endpoint: string })
namespace DocumentPipeline;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
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

// VIOLATION (DP-MODEL-02): PipelineConfig has an identity (`configId`) and a
// full lifecycle, but no addressable path. Nothing can link to a config.
// VIOLATION (DP-MODEL-01) x4: create/get/list/delete expressed as POST actions.
// VIOLATION (DP-MODEL-04): there is no update path at all -- a config can be
// created and deleted but never modified.
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
