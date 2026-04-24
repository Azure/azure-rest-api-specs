import "@typespec/rest";
import "@typespec/http";
import "./common/common.tsp";

namespace MapsTimezone;

/** Options for timezone information returned in the result. */
union TimezoneOptions {
  string,

  /**
   * Do not include zoneinfo or transitions in the result.
   */
  none: "none",

  /**
   * Include additional time zone info in the result.
   */
  zoneInfo: "zoneInfo",

  /**
   * Include transition information in the result (The number of transitions is
   * currently capped at 250).
   */
  transitions: "transitions",

  /**
   * Include both zoneinfo and transitions in the result.
   */
  all: "all",
}

/**
 * This object is returned from a successful Timezone By ID call or By Coordinates
 * call
 */
model TimezoneResult {
  /**
   * Version property
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Reference Utc Timestamp property
   */
  @visibility(Lifecycle.Read)
  referenceUtcTimestamp?: utcDateTime;

  /**
   * TimeZoneId array
   */
  @visibility(Lifecycle.Read)
  timeZones?: TimezoneId[];
}

/** Timezone ID information. */
model TimezoneId {
  /**
   * Id property
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * An array of time zone ID aliases. Only returned when [options]=*zoneinfo* or
   * *all*.
   *
   * Note: may be null.
   */
  @visibility(Lifecycle.Read)
  aliases?: string[];

  /**
   * An array of country/region records. Only returned when [options]=*zoneinfo* or
   * *all*.
   */
  @visibility(Lifecycle.Read)
  countries?: CountryRecord[];

  /**
   * Timezone names object.
   */
  names?: TimezoneNames;

  /**
   * Details in effect at the local time.
   */
  @visibility(Lifecycle.Read)
  referenceTime?: ReferenceTime;

  /**
   * Representative point property
   */
  @visibility(Lifecycle.Read)
  representativePoint?: RepresentativePoint;

  /**
   * Time zone DST transitions from [transitionsFrom] until timestamp + 1 year.
   */
  @visibility(Lifecycle.Read)
  timeTransitions?: TimeTransition[];
}

/**
 * A country/region record.
 */
model CountryRecord {
  /**
   * country/region Name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * ISO-3166 2-letter country/region code for the country/region.
   */
  @visibility(Lifecycle.Read)
  code?: string;
}

/**
 * Timezone names object.
 */
model TimezoneNames {
  /**
   * The ISO 639-1 language code of the Names
   */
  @visibility(Lifecycle.Read)
  iso6391LanguageCode?: string;

  /**
   * Generic Name
   */
  @visibility(Lifecycle.Read)
  generic?: string;

  /**
   * Standard Name
   */
  @visibility(Lifecycle.Read)
  standard?: string;

  /**
   * Daylight Name
   */
  @visibility(Lifecycle.Read)
  daylight?: string;
}

/**
 * Details in effect at the local time.
 */
model ReferenceTime {
  /**
   * Time zone name in effect at the reference timestamp (i.e. PST or PDT depending
   * whether Daylight Savings Time is in effect).
   */
  @visibility(Lifecycle.Read)
  tag?: string;

  /**
   * UTC offset in effect at the `ReferenceUTCTimestamp`.
   */
  @visibility(Lifecycle.Read)
  standardOffset?: string;

  /**
   * Time saving in minutes in effect at the `ReferenceUTCTimestamp`.
   */
  @visibility(Lifecycle.Read)
  daylightSavings?: string;

  /**
   * Current wall time at the given time zone as shown in the `Tag` property.
   */
  @visibility(Lifecycle.Read)
  wallTime?: string;

  /**
   * The year this POSIX string is valid for. Note: A POSIX string will only be
   * valid in the given year.
   */
  @visibility(Lifecycle.Read)
  posixTzValidYear?: int32;

  /**
   * POSIX string used to set the time zone environment variable.
   */
  @visibility(Lifecycle.Read)
  posixTz?: string;

  /**
   * Sunrise at the given time zone as shown in the `Tag` property, populated only
   * when the call is `byCoordinates`. The sunrise is described in the [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Note that
   * the Timezone API does not return sunrise and sunset times when solar day is
   * observed in the requested region.
   */
  @visibility(Lifecycle.Read)
  sunrise?: utcDateTime;

  /**
   * Sunset at the given time zone as shown in the `Tag` property, populated only
   * when the call is `byCoordinates`. The sunset is described in the [ISO
   * 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Note that
   * the Timezone API does not return sunrise and sunset times when solar day is
   * observed in the requested region.
   */
  @visibility(Lifecycle.Read)
  sunset?: utcDateTime;
}

/**
 * Representative point property
 */
model RepresentativePoint {
  /**
   * Latitude property
   */
  @visibility(Lifecycle.Read)
  latitude?: float32;

  /**
   * Longitude property
   */
  @visibility(Lifecycle.Read)
  longitude?: float32;
}

/** Represents a time zone transition. */
model TimeTransition {
  /**
   * Tag property
   */
  @visibility(Lifecycle.Read)
  tag?: string;

  /**
   * StandardOffset property
   */
  @visibility(Lifecycle.Read)
  standardOffset?: string;

  /**
   * DaylightSavings property
   */
  @visibility(Lifecycle.Read)
  daylightSavings?: string;

  /**
   * Start date, start time for this transition period
   */
  @visibility(Lifecycle.Read)
  utcStart?: utcDateTime;

  /**
   * End date, end time for this transition period
   */
  @visibility(Lifecycle.Read)
  utcEnd?: utcDateTime;
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

/** Windows timezone information with IANA mappings. */
model TimezoneWindows {
  /**
   * Windows Id property
   */
  @visibility(Lifecycle.Read)
  windowsId?: string;

  /**
   * Territory property
   */
  @visibility(Lifecycle.Read)
  territory?: string;

  /**
   * IanaIds array
   */
  ianaIds?: string[];
}

/** IANA time zone ID information. */
model IanaId {
  /**
   * Id property
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * IsAlias property
   */
  @visibility(Lifecycle.Read)
  isAlias?: boolean;

  /**
   * AliasOf property
   */
  @visibility(Lifecycle.Read)
  aliasOf?: string;

  /**
   * This attribute returns `True` if the IanaId has any country/zone associated
   * with it.
   */
  @visibility(Lifecycle.Read)
  hasZone1970Location?: boolean;
}

/**
 * This object is returned from a successful Timezone IANA Version call
 */
model TimezoneIanaVersionResult {
  /**
   * Version property
   */
  @visibility(Lifecycle.Read)
  version?: string;
}
