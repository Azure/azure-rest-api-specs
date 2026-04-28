import "@typespec/rest";
import "@typespec/http";
import "./common/common.tsp";

namespace MapsGeolocation;

/**
 * This object is returned from a successful call to IP Address to country/region
 * API
 */
model IpAddressToLocationResult {
  /**
   * The object containing the country/region information.
   */
  @visibility(Lifecycle.Read)
  countryRegion?: CountryRegion;

  /**
   * The IP Address of the request.
   */
  @visibility(Lifecycle.Read)
  ipAddress?: string;
}

/**
 * The object containing the country/region information.
 */
model CountryRegion {
  /**
   * The IP address's 2-character country or region code ([ISO
   * 3166-1](https://www.iso.org/iso-3166-country-codes.html)). Note that IP
   * addresses in ranges reserved for special purposes will return Null for
   * country/region.
   */
  @visibility(Lifecycle.Read)
  isoCode?: string;
}

/**
 * Common error response for all Azure Resource Manager APIs to return error
 * details for failed operations. (This also follows the OData error response
 * format.).
 */
@error
model ErrorResponse {
  /**
   * The error object.
   */
  error?: ErrorDetail;
}

/**
 * The error detail.
 */
model ErrorDetail {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The error target.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * The error details.
   */
  @visibility(Lifecycle.Read)
  details?: ErrorDetail[];

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  additionalInfo?: ErrorAdditionalInfo[];
}
