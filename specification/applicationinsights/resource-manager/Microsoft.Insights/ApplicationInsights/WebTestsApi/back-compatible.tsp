import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using WebTestsApi;

// @@clientName(WebTestProperties.SyntheticMonitorId, "syntheticMonitorId");
@@clientName(WebTestProperties.Name, "WebTestName");
// @@clientName(WebTestProperties.Description, "description");
// @@clientName(WebTestProperties.Enabled, "enabled");
// @@clientName(WebTestProperties.Frequency, "frequency");
// @@clientName(WebTestProperties.Timeout, "timeout");
@@clientName(WebTestProperties.Kind, "WebTestKind");
// @@clientName(WebTestProperties.RetryEnabled, "retryEnabled");
// @@clientName(WebTestProperties.Locations, "locations");
// @@clientName(WebTestProperties.Configuration, "configuration");
// @@clientName(WebTestProperties.Request, "request");
// @@clientName(WebTestProperties.ValidationRules, "validationRules");

@@clientName(WebTestGeolocation.Id, "location");

// @@clientName(WebTestPropertiesConfiguration.WebTest, "webTest");

// @@clientName(WebTestPropertiesRequest.RequestUrl, "requestUrl");
// @@clientName(WebTestPropertiesRequest.Headers, "headers");
// @@clientName(WebTestPropertiesRequest.HttpVerb, "httpVerb");
// @@clientName(WebTestPropertiesRequest.RequestBody, "requestBody");
// @@clientName(WebTestPropertiesRequest.ParseDependentRequests,
//   "parseDependentRequests"
// );
// @@clientName(WebTestPropertiesRequest.FollowRedirects, "followRedirects");

@@clientName(HeaderField.key, "headerFieldName");
@@clientName(HeaderField.value, "headerFieldValue");

// @@clientName(WebTestPropertiesValidationRules.ContentValidation,
//   "contentValidation"
// );
// @@clientName(WebTestPropertiesValidationRules.ExpectedHttpStatusCode,
//   "expectedHttpStatusCode"
// );
// @@clientName(WebTestPropertiesValidationRules.IgnoreHttpStatusCode,
//   "ignoreHttpStatusCode"
// );

// @@clientName(WebTestPropertiesValidationRulesContentValidation.ContentMatch,
//   "contentMatch"
// );
// @@clientName(WebTestPropertiesValidationRulesContentValidation.IgnoreCase,
//   "ignoreCase"
// );
// @@clientName(WebTestPropertiesValidationRulesContentValidation.PassIfTextFound,
//   "passIfTextFound"
// );

@@clientName(WebTests.createOrUpdate::parameters.resource, "WebTestDefinition");
@@clientName(WebTests.updateTags::parameters.properties, "WebTestTags");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WebTest.properties);

@@clientLocation(WebTestsOperationGroup.listByComponent, WebTests);
