import "@typespec/versioning";
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

/**
 * Type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * Tier of the compute assigned to a server.
 */
union SkuTier {
  string,

  /** Cost-effective tier for infrequent CPU usage, ideal for development and testing workloads with low performance requirements. */
  Burstable: "Burstable",

  /** Balanced compute and memory for most workloads, offering scalable performance and I/O throughput. */
  GeneralPurpose: "GeneralPurpose",

  /** High memory-to-core ratio for demanding workloads needing fast in-memory processing and high concurrency. */
  MemoryOptimized: "MemoryOptimized",
}

/**
 * Major version of PostgreSQL database engine.
 */
@removed(Versions.v2026_10_01)
union PostgresMajorVersion {
  string,

  /** PostgreSQL 19. */
  @added(Versions.v2026_07_01)
  `19`: "19",

  /** PostgreSQL 18. */
  `18`: "18",

  /** PostgreSQL 17. */
  `17`: "17",

  /** PostgreSQL 16. */
  `16`: "16",

  /** PostgreSQL 15. */
  `15`: "15",

  /** PostgreSQL 14. */
  `14`: "14",

  /** PostgreSQL 13. */
  `13`: "13",

  /** PostgreSQL 12. */
  `12`: "12",

  /** PostgreSQL 11. */
  `11`: "11",
}

alias LocationParameter = {
  /**
   * The name of the location.
   */
  @minLength(1)
  @pattern("^[-\\w\\._]+$")
  @path
  @segment("locations")
  locationName: string;
};
