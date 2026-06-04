import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MapsSearch;

@@clientName(FeatureCollectionEnum, "FeatureCollection");
@@clientName(FeatureTypeEnum, "FeatureType");
@@clientName(ConfidenceEnum, "Confidence");
@@clientName(MatchCodesEnum, "MatchCodes");
@@clientName(CalculationMethodEnum, "CalculationMethod");
@@clientName(UsageTypeEnum, "UsageType");
@@clientName(BoundaryResultTypeEnum, "BoundaryResultType");
@@clientName(ResolutionEnum, "Resolution");
@@clientName(ReverseGeocodingResultTypeEnum, "ReverseGeocodingResultType");
@@clientName(ResultTypeEnum, "ResultType");
@@clientName(AutocompleteResultTypeGroupsEnum, "AutocompleteResultTypeGroups");
@@clientName(AutocompleteResultTypeEnum, "AutocompleteResultType");

// Flatten operations onto client instead of having an operation group attribute
@client({
  name: "MapsSearchClient",
  service: MapsSearch,
})
interface MapsSearchClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getGeocoding is Search.getGeocoding;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getGeocodingBatch is Search.getGeocodingBatch;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getPolygon is Search.getPolygon;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getReverseGeocoding is Search.getReverseGeocoding;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getReverseGeocodingBatch is Search.getReverseGeocodingBatch;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getGeocodeAutocomplete is Search.getGeocodeAutocomplete;
}
