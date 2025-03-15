import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace MicrosoftPlanetaryComputerPro;

/**
 * SAS Token response
 */
model SasToken {
  /**
   * Msft:Expiry
   */
  @encodedName("application/json", "msft:expiry")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  msftexpiry: utcDateTime;

  /**
   * Token
   */
  token: string;
}

/**
 * Response Signed Href Api Sign Get
 */
model ResponseSignedHrefApiSignGet {}

/**
 * Signed SAS URL response
 */
model SignedLink {
  /**
   * Msft:Expiry
   */
  @encodedName("application/json", "msft:expiry")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  msftexpiry: utcDateTime;

  /**
   * Href
   */
  href: string;
}

/**
 * Link that was not signed. Will include a null expiry
 */
model UnsignedLink {
  /**
   * Msft:Expiry
   */
  @encodedName("application/json", "msft:expiry")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  msftexpiry?: utcDateTime;

  /**
   * Href
   */
  href: string;
}
