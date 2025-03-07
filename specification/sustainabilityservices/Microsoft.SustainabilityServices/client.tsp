import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace Microsoft.SustainabilityServices;

@client({
  name: "SustainabilityServiceClient",
  service: Microsoft.SustainabilityServices,
})
interface SustainabilityServiceClient {
  @clientName("ListFactorLibraries", "csharp")
  @clientName("list_factor_libraries", "python")
  listFactorLibraries is SustainabilityService.listFactorLibraries;

  @clientName("GetFactorLibrary", "csharp")
  @clientName("get_factor_library", "python")
  getFactorLibrary is SustainabilityService.getFactorLibrary;

  @clientName("ListEstimationFactorsByFactorLibrary", "csharp")
  @clientName("list_estimation_factors_by_factor_library", "python")
  listEstimationFactorsByFactorLibrary is SustainabilityService.listEstimationFactorsByFactorLibrary;

  @clientName("GetEstimationFactor", "csharp")
  @clientName("get_estimation_factor", "python")
  getEstimationFactor is SustainabilityService.getEstimationFactor;

  @clientName("ListEmissionFactorsByFactorLibrary", "csharp")
  @clientName("list_emission_factors_by_factor_library", "python")
  listEmissionFactorsByFactorLibrary is SustainabilityService.listEmissionFactorsByFactorLibrary;

  @clientName("GetEmissionFactor", "csharp")
  @clientName("get_emission_factor", "python")
  getEmissionFactor is SustainabilityService.getEmissionFactor;

  @clientName("ListFactorMappings", "csharp")
  @clientName("list_factor_mappings", "python")
  listFactorMappings is SustainabilityService.listFactorMappings;

  @clientName("GetFactorMapping", "csharp")
  @clientName("get_factor_mapping", "python")
  getFactorMapping is SustainabilityService.getFactorMapping;

  @clientName("ListCalculationModels", "csharp")
  @clientName("list_calculation_models", "python")
  listCalculationModels is SustainabilityService.listCalculationModels;

  @clientName("GetCalculationModel", "csharp")
  @clientName("get_calculation_model", "python")
  getCalculationModel is SustainabilityService.getCalculationModel;

  @clientName("ListReferenceEntities", "csharp")
  @clientName("list_reference_entities", "python")
  listReferenceEntities is SustainabilityService.listReferenceEntities;

  @clientName("ListReferenceEntityData", "csharp")
  @clientName("list_reference_entity_data", "python")
  listReferenceEntityRecords is SustainabilityService.listReferenceEntityRecords;

  @clientName("GetReferenceEntityData", "csharp")
  @clientName("get_reference_entity_data", "python")
  getReferenceEntityRecords is SustainabilityService.getReferenceEntityRecord;

  @clientName("Calculate", "csharp")
  calculate is SustainabilityService.calculateEmissions;
}
