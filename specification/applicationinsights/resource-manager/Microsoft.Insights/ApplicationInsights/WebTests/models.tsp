import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Insights;

/**
 * The kind of WebTest that this web test watches. Choices are ping, multistep and standard.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum WebTestKind {
  /**
   * ping
   */
  ping,

  /**
   * multistep
   */
  multistep,

  /**
   * standard
   */
  standard,
}

/**
 * Metadata describing a web test for an Azure resource.
 */
model WebTestProperties {
  /**
   * Unique ID of this WebTest. This is typically the same value as the Name field.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SyntheticMonitorId: string;

  /**
   * User defined name if this WebTest.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Name: string;

  /**
   * User defined description for this WebTest.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Description?: string;

  /**
   * Is the test actively being monitored.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled?: boolean;

  /**
   * Interval in seconds between test runs for this WebTest. Default value is 300.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Frequency?: int32 = 300;

  /**
   * Seconds until this WebTest will timeout and fail. Default value is 30.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Timeout?: int32 = 30;

  /**
   * The kind of web test this is, valid choices are ping, multistep and standard.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Kind: WebTestKind = WebTestKind.ping;

  /**
   * Allow for retries should this WebTest fail.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RetryEnabled?: boolean;

  /**
   * A list of where to physically run the tests from to give global coverage for accessibility of your application.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["Id"])
  Locations: WebTestGeolocation[];

  /**
   * An XML configuration specification for a WebTest.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Configuration?: WebTestPropertiesConfiguration;

  /**
   * Current state of this component, whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Succeeded, Deploying, Canceled, and Failed.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The collection of request properties
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Request?: WebTestPropertiesRequest;

  /**
   * The collection of validation rule properties
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ValidationRules?: WebTestPropertiesValidationRules;
}

/**
 * Geo-physical location to run a WebTest from. You must specify one or more locations for the test to run from.
 */
model WebTestGeolocation {
  /**
   * Location ID for the WebTest to run from.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Id?: string;
}

/**
 * An XML configuration specification for a WebTest.
 */
model WebTestPropertiesConfiguration {
  /**
   * The XML specification of a WebTest to run against an application.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WebTest?: string;
}

/**
 * The collection of request properties
 */
model WebTestPropertiesRequest {
  /**
   * Url location to test.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RequestUrl?: string;

  /**
   * List of headers and their values to add to the WebTest call.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["key"])
  Headers?: HeaderField[];

  /**
   * Http verb to use for this web test.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  HttpVerb?: string;

  /**
   * Base64 encoded string body to send with this web test.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RequestBody?: string;

  /**
   * Parse Dependent request for this WebTest.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ParseDependentRequests?: boolean;

  /**
   * Follow redirects for this web test.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FollowRedirects?: boolean;
}

/**
 * A header to add to the WebTest.
 */
model HeaderField {
  /**
   * The name of the header.
   */
  key?: string;

  /**
   * The value of the header.
   */
  value?: string;
}

/**
 * The collection of validation rule properties
 */
model WebTestPropertiesValidationRules {
  /**
   * The collection of content validation properties
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ContentValidation?: WebTestPropertiesValidationRulesContentValidation;

  /**
   * Checks to see if the SSL cert is still valid.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SSLCheck?: boolean;

  /**
   * A number of days to check still remain before the the existing SSL cert expires.  Value must be positive and the SSLCheck must be set to true.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SSLCertRemainingLifetimeCheck?: int32;

  /**
   * Validate that the WebTest returns the http status code provided.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ExpectedHttpStatusCode?: int32;

  /**
   * When set, validation will ignore the status code.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IgnoreHttpStatusCode?: boolean;
}

/**
 * The collection of content validation properties
 */
model WebTestPropertiesValidationRulesContentValidation {
  /**
   * Content to look for in the return of the WebTest.  Must not be null or empty.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ContentMatch?: string;

  /**
   * When set, this value makes the ContentMatch validation case insensitive.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IgnoreCase?: boolean;

  /**
   * When true, validation will pass if there is a match for the ContentMatch string.  If false, validation will fail if there is a match
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PassIfTextFound?: boolean;
}

/**
 * An azure resource object
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model WebtestsResource {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Azure resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model webTestListResult is Azure.Core.Page<WebTest>;
