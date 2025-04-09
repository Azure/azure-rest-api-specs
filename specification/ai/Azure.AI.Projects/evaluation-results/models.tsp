import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

@doc("Evaluation Result resource Definition")
@Rest.resource("evaluationResult")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model EvaluationResult {
  @doc("Type of Evaluation result")
  ResultType?: ResultType;

  @doc("Blob URI")
  BlobUri?: string;

  ...AssetBase;
}

@doc("Type of Evaluation result")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
union ResultType {
  string,

  @doc("Benchmark result")
  Benchmark: "Benchmark";

  @doc("Evaluations Result")
  Evaluation: "Evaluation";

  @doc("Red Team Result")
  Redteam: "Redteam";

  @doc("Simulation Result")
  Simulation: "Simulation";
}

@doc("Asset Credential Request")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model AssetCredentialRequest {
  @doc("Blob URI")
  BlobUri: string;
}

@doc("Asset Credential Response")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model AssetCredentialResponse {
  @doc("Blob Reference for Consumption")
  BlobReferenceForConsumption: AssetBlobReferenceForConsumptionDto;
}
@doc("Blob Reference for Consumption DTO")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model AssetBlobReferenceForConsumptionDto {
  @doc("Blob URI path for client to upload data. Example: https://blob.windows.core.net/Container/Path")
  BlobUri: string;

  @doc("ARM ID of the storage account to use")
  StorageAccountArmId: string;

  @doc("Credential info to access storage account")
  Credential: SASCredential;
}

@doc("Blob Reference Credential Type")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
union BlobReferenceCredentialType {
  string,

  @doc("Shared Access Signature")
  SAS: "SAS";
}

@doc("SAS Credential")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model SASCredential {
  @doc("Credential Type")
  CredentialType: BlobReferenceCredentialType.SAS;

  @doc("Full SAS URI, including the storage, container/blob path and SAS token")
  SASUri: string;
}