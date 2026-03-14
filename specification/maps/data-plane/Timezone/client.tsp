import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MapsTimezone;

namespace Customizations;

@@clientName(TimezoneResult.Version, "version");
@@clientName(TimezoneResult.ReferenceUtcTimestamp, "referenceUtcTimestamp");
@@clientName(TimezoneResult.TimeZones, "timeZones");

@@clientName(TimezoneId.Id, "id");
@@clientName(TimezoneId.Aliases, "aliases");
@@clientName(TimezoneId.Countries, "countries");
@@clientName(TimezoneId.Names, "names");
@@clientName(TimezoneId.ReferenceTime, "referenceTime");
@@clientName(TimezoneId.RepresentativePoint, "representativePoint");
@@clientName(TimezoneId.TimeTransitions, "timeTransitions");

@@clientName(CountryRecord.Name, "name");
@@clientName(CountryRecord.Code, "code");

@@clientName(TimezoneNames.Generic, "generic");
@@clientName(TimezoneNames.Standard, "standard");
@@clientName(TimezoneNames.Daylight, "daylight");

@@clientName(ReferenceTime.Tag, "tag");
@@clientName(ReferenceTime.StandardOffset, "standardOffset");
@@clientName(ReferenceTime.DaylightSavings, "daylightSavings");
@@clientName(ReferenceTime.WallTime, "wallTime");
@@clientName(ReferenceTime.PosixTzValidYear, "posixTzValidYear");
@@clientName(ReferenceTime.PosixTz, "posixTz");
@@clientName(ReferenceTime.Sunrise, "sunrise");
@@clientName(ReferenceTime.Sunset, "sunset");

@@clientName(RepresentativePoint.Latitude, "latitude");
@@clientName(RepresentativePoint.Longitude, "longitude");

@@clientName(TimeTransition.Tag, "tag");
@@clientName(TimeTransition.StandardOffset, "standardOffset");
@@clientName(TimeTransition.DaylightSavings, "daylightSavings");
@@clientName(TimeTransition.UtcStart, "utcStart");
@@clientName(TimeTransition.UtcEnd, "utcEnd");

@@clientName(TimezoneWindows.WindowsId, "windowsId");
@@clientName(TimezoneWindows.Territory, "territory");
@@clientName(TimezoneWindows.IanaIds, "ianaIds");

@@clientName(IanaId.Id, "id");
@@clientName(IanaId.AliasOf, "aliasOf");
@@clientName(IanaId.HasZone1970Location, "hasZone1970Location");

@@clientName(TimezoneIanaVersionResult.Version, "version");

@@clientName(getWindowsToIana, "convertWindowsTimezoneToIANA");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Legacy.clientDefaultValue(ResponseFormatParameters.format, "json");
