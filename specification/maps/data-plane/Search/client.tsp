import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using SearchClient;

@@clientLocation(SearchOperationGroup.getGeocoding, "Search");
@@clientLocation(SearchOperationGroup.getGeocodingBatch, "Search");
@@clientLocation(SearchOperationGroup.getPolygon, "Search");
@@clientLocation(SearchOperationGroup.getReverseGeocoding, "Search");
@@clientLocation(SearchOperationGroup.getReverseGeocodingBatch, "Search");
@@clientLocation(SearchOperationGroup.getGeocodeAutocomplete, "Search");
