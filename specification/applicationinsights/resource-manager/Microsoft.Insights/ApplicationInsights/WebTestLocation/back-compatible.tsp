import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using WebTestLocation;

// @@clientName(ApplicationInsightsComponentWebTestLocation.DisplayName,
//   "displayName"
// );
// @@clientName(ApplicationInsightsComponentWebTestLocation.Tag, "tag");

@@clientLocation(webTestLocationsOperationGroup.list, "webTestLocations");
