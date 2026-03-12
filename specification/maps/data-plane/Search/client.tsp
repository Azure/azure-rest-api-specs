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
