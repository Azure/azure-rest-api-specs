import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// @TypeSpec.Versioning.versioned(HealthDataAIServices.DeidServices.Versions)
namespace HealthDataAIServices.DeidServices {
  @@clientName(CustomizationOptions, "CustomizationConfig", "csharp");

  @@clientName(JobCustomizationOptions, "JobCustomizationConfig", "csharp");
}
