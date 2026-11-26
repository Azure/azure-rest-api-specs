import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(
  Microsoft.Speech.VideoTranslation.ApiVersions.v2024_05_20_preview,
  Microsoft.Speech.VideoTranslation.ApiVersions.v2025_05_20
)
namespace Microsoft.Speech.VideoTranslationClient;
