import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";
import "./models/factorlibrary.tsp";
import "./models/emissioncalculation.tsp";
import "./models/referencedata.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core.Traits;
using Azure.Core;

namespace Microsoft.SustainabilityServices;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId &
  ResponseHeadersTrait<ResponseHeaders>;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

@route("sustainability")
interface SustainabilityService {
  @doc("Lists factor libraries.")
  listFactorLibraries is Operations.ResourceList<
    FactorLibrary,
    ListQueryParametersTrait<MaxPageSizeQueryParameter>
  >;

  @doc("Gets factor library by id.")
  getFactorLibrary is Operations.ResourceRead<FactorLibrary>;

  @doc("Lists estimation factors within the given factor library id.")
  listEstimationFactorsByFactorLibrary is Operations.ResourceList<
    EstimationFactor,
    ListQueryParametersTrait<MaxPageSizeQueryParameter>
  >;

  @doc("Gets estimation factor by id.")
  getEstimationFactor is Operations.ResourceRead<EstimationFactor>;

  @doc("Lists emission factors within the given factor library id.")
  listEmissionFactorsByFactorLibrary is Operations.ResourceList<
    EmissionFactor,
    ListQueryParametersTrait<MaxPageSizeQueryParameter>
  >;

  @doc("Gets emission factor by id.")
  getEmissionFactor is Operations.ResourceRead<EmissionFactor>;

  @doc("Lists factor mappings belonging to the factor library.")
  listFactorMappings is Operations.ResourceList<
    FactorMapping,
    ListQueryParametersTrait<MaxPageSizeQueryParameter>
  >;

  @doc("Gets factor mapping by id.")
  getFactorMapping is Operations.ResourceRead<FactorMapping>;

  @doc("Lists calculation models for the given activity source.")
  listCalculationModels is Operations.ResourceList<
    CalculationModel,
    ListQueryParametersTrait<MaxPageSizeQueryParameter>
  >;

  @doc("Gets calculation model by id.")
  getCalculationModel is Operations.ResourceRead<CalculationModel>;

  @doc("Lists reference data entities.")
  listReferenceEntities is Operations.ResourceList<
    ReferenceDataEntities,
    ListQueryParametersTrait<MaxPageSizeQueryParameter>
  >;

  @doc("Fetch records of the given reference data entity.")
  listReferenceEntityRecords is Operations.ResourceList<
    EntityRecord,
    ListQueryParametersTrait<MaxPageSizeQueryParameter>
  >;

  @doc("Gets reference data entity record by id.")
  getReferenceEntityRecord is Operations.ResourceRead<EntityRecord>;

  @doc("Calculate emissions.")
  calculateEmissions is Operations.ResourceCollectionAction<
    EmissionActivity,
    EmissionCalculationRequest,
    EmissionCalculationResult
  >;
}
