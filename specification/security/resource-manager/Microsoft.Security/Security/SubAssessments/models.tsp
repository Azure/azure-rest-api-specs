import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Common;

namespace SubAssessmentsAPI;

/**
 * Programmatic code for the status of the assessment
 */
union SubAssessmentStatusCode {
  string,

  /**
   * The resource is healthy
   */
  Healthy: "Healthy",

  /**
   * The resource has a security issue that needs to be addressed
   */
  Unhealthy: "Unhealthy",

  /**
   * Assessment for this resource did not happen
   */
  NotApplicable: "NotApplicable",
}

/**
 * Sub-assessment resource type
 */
union AssessedResourceType {
  string,

  /**
   * SqlServerVulnerability
   */
  SqlServerVulnerability: "SqlServerVulnerability",

  /**
   * ContainerRegistryVulnerability
   */
  ContainerRegistryVulnerability: "ContainerRegistryVulnerability",

  /**
   * ServerVulnerability
   */
  ServerVulnerability: "ServerVulnerability",
}

/**
 * List of security sub-assessments
 */
model SecuritySubAssessmentList {
  /** List of security sub-assessments */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SecuritySubAssessment[];

  /** The URI to fetch the next page. */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Describes properties of an sub-assessment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecuritySubAssessmentProperties {
  /**
   * Vulnerability ID
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * User friendly display name of the sub-assessment
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Status of the sub-assessment
   */
  status?: SubAssessmentStatus;

  /**
   * Information on how to remediate this sub-assessment
   */
  @visibility(Lifecycle.Read)
  remediation?: string;

  /**
   * Description of the impact of this sub-assessment
   */
  @visibility(Lifecycle.Read)
  impact?: string;

  /**
   * Category of the sub-assessment
   */
  @visibility(Lifecycle.Read)
  category?: string;

  /**
   * Human readable description of the assessment status
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The date and time the sub-assessment was generated
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeGenerated?: utcDateTime;

  /**
   * Details of the resource that was assessed
   */
  resourceDetails?: ResourceDetails;

  /**
   * Details of the sub-assessment
   */
  additionalData?: AdditionalData;
}

/**
 * Status of the sub-assessment
 */
model SubAssessmentStatus {
  /**
   * Programmatic code for the status of the assessment
   */
  @visibility(Lifecycle.Read)
  code?: SubAssessmentStatusCode;

  /**
   * Programmatic code for the cause of the assessment status
   */
  @visibility(Lifecycle.Read)
  cause?: string;

  /**
   * Human readable description of the assessment status
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The sub-assessment severity level
   */
  @visibility(Lifecycle.Read)
  severity?: Severity;
}

/**
 * Details of the sub-assessment
 */
@discriminator("assessedResourceType")
model AdditionalData {
  /**
   * Sub-assessment resource type
   */
  assessedResourceType: AssessedResourceType;
}

/**
 * Details of the resource that was assessed
 */
model SqlServerVulnerabilityProperties extends AdditionalData {
  /**
   * The resource type the sub assessment refers to in its resource details
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The T-SQL query that runs on your SQL database to perform the particular check
   */
  @visibility(Lifecycle.Read)
  query?: string;

  /**
   * Sub-assessment resource type
   */
  assessedResourceType: "SqlServerVulnerability";
}

/**
 * Additional context fields for container registry Vulnerability assessment
 */
model ContainerRegistryVulnerabilityProperties extends AdditionalData {
  /**
   * Vulnerability Type. e.g: Vulnerability, Potential Vulnerability, Information Gathered, Vulnerability
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Dictionary from cvss version to cvss details object
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  cvss?: Record<CVSS>;

  /**
   * Indicates whether a patch is available or not
   */
  @visibility(Lifecycle.Read)
  patchable?: boolean;

  /**
   * List of CVEs
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  cve?: CVE[];

  /**
   * Published time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  publishedTime?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  vendorReferences?: VendorReference[];

  /**
   * Name of the repository which the vulnerable image belongs to
   */
  @visibility(Lifecycle.Read)
  repositoryName?: string;

  /**
   * Digest of the vulnerable image
   */
  @visibility(Lifecycle.Read)
  imageDigest?: string;

  /**
   * Sub-assessment resource type
   */
  assessedResourceType: "ContainerRegistryVulnerability";
}

/**
 * CVSS details
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CVSS {
  /**
   * CVSS base
   */
  @visibility(Lifecycle.Read)
  base?: float32;
}

/**
 * CVE details
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CVE {
  /**
   * CVE title
   */
  @visibility(Lifecycle.Read)
  title?: string;

  /**
   * Link url
   */
  @visibility(Lifecycle.Read)
  link?: string;
}

/**
 * Vendor reference
 */
model VendorReference {
  /**
   * Link title
   */
  @visibility(Lifecycle.Read)
  title?: string;

  /**
   * Link url
   */
  @visibility(Lifecycle.Read)
  link?: string;
}

/**
 * Additional context fields for server vulnerability assessment
 */
model ServerVulnerabilityProperties extends AdditionalData {
  /**
   * Vulnerability Type. e.g: Vulnerability, Potential Vulnerability, Information Gathered
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Dictionary from cvss version to cvss details object
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  cvss?: Record<CVSS>;

  /**
   * Indicates whether a patch is available or not
   */
  @visibility(Lifecycle.Read)
  patchable?: boolean;

  /**
   * List of CVEs
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  cve?: CVE[];

  /**
   * Threat name
   */
  @visibility(Lifecycle.Read)
  threat?: string;

  /**
   * Published time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  publishedTime?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  vendorReferences?: VendorReference[];

  /**
   * Sub-assessment resource type
   */
  assessedResourceType: "ServerVulnerabilityAssessment";
}

