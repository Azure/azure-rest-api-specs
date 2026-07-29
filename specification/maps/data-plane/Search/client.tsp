import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MapsSearch;

@@clientName(FeatureCollectionEnum, "FeatureCollection", "!autorest");
@@clientName(FeatureTypeEnum, "FeatureType", "!autorest");
@@clientName(ConfidenceEnum, "Confidence", "!autorest");
@@clientName(MatchCodesEnum, "MatchCodes", "!autorest");
@@clientName(CalculationMethodEnum, "CalculationMethod", "!autorest");
@@clientName(UsageTypeEnum, "UsageType", "!autorest");
@@clientName(BoundaryResultTypeEnum, "BoundaryResultType", "!autorest");
@@clientName(ResolutionEnum, "Resolution", "!autorest");
@@clientName(
  ReverseGeocodingResultTypeEnum,
  "ReverseGeocodingResultType",
  "!autorest"
);
@@clientName(ResultTypeEnum, "ResultType", "!autorest");
@@clientName(
  AutocompleteResultTypeGroupsEnum,
  "AutocompleteResultTypeGroups",
  "!autorest"
);
@@clientName(AutocompleteResultTypeEnum, "AutocompleteResultType", "!autorest");

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
