import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DBforPostgreSQL;

// Server-scoped log listing uses Servers.listByServer in Server.tsp.

/**
 * List of log files.
 */
model CapturedLogList is Azure.Core.Page<CapturedLog>;

/**
 * Log file.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CapturedLog extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Properties of a log file.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: CapturedLogProperties;
}

/**
 * Properties of a log file.
 */
model CapturedLogProperties {
  /**
   * Creation timestamp of the log file.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Last modified timestamp of the log file.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Size (in KB) of the log file.
   */
  sizeInKb?: int64;

  /**
   * Type of log file. Can be 'ServerLogs' or 'UpgradeLogs'.
   */
  type?: string;

  /**
   * URL to download the log file from.
   */
  url?: string;
}
