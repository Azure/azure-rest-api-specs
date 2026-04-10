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

namespace RegulatoryComplianceAPI;

/**
 * List of regulatory compliance standards response
 */
model RegulatoryComplianceStandardList
  is Azure.Core.Page<RegulatoryComplianceStandard>;

/**
 * Regulatory compliance standard data
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RegulatoryComplianceStandardProperties {
  /**
   * Aggregative state based on the standard's supported controls states
   */
  state?: State;

  /**
   * The number of supported regulatory compliance controls of the given standard with a passed state
   */
  @visibility(Lifecycle.Read)
  passedControls?: int32;

  /**
   * The number of supported regulatory compliance controls of the given standard with a failed state
   */
  @visibility(Lifecycle.Read)
  failedControls?: int32;

  /**
   * The number of supported regulatory compliance controls of the given standard with a skipped state
   */
  @visibility(Lifecycle.Read)
  skippedControls?: int32;

  /**
   * The number of regulatory compliance controls of the given standard which are unsupported by automated assessments
   */
  @visibility(Lifecycle.Read)
  unsupportedControls?: int32;
}

/**
 * List of regulatory compliance controls response
 */
model RegulatoryComplianceControlList
  is Azure.Core.Page<RegulatoryComplianceControl>;

/**
 * Regulatory compliance control data
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RegulatoryComplianceControlProperties {
  /**
   * The description of the regulatory compliance control
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Aggregative state based on the control's supported assessments states
   */
  state?: State;

  /**
   * The number of supported regulatory compliance assessments of the given control with a passed state
   */
  @visibility(Lifecycle.Read)
  passedAssessments?: int32;

  /**
   * The number of supported regulatory compliance assessments of the given control with a failed state
   */
  @visibility(Lifecycle.Read)
  failedAssessments?: int32;

  /**
   * The number of supported regulatory compliance assessments of the given control with a skipped state
   */
  @visibility(Lifecycle.Read)
  skippedAssessments?: int32;
}

/**
 * List of regulatory compliance assessment response
 */
model RegulatoryComplianceAssessmentList
  is Azure.Core.Page<RegulatoryComplianceAssessment>;

/**
 * Regulatory compliance assessment data
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RegulatoryComplianceAssessmentProperties {
  /**
   * The description of the regulatory compliance assessment
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The expected type of assessment contained in the AssessmentDetailsLink
   */
  @visibility(Lifecycle.Read)
  assessmentType?: string;

  /**
   * Link to more detailed assessment results data. The response type will be according to the assessmentType field
   */
  @visibility(Lifecycle.Read)
  assessmentDetailsLink?: string;

  /**
   * Aggregative state based on the assessment's scanned resources states
   */
  state?: State;

  /**
   * The given assessment's related resources count with passed state.
   */
  @visibility(Lifecycle.Read)
  passedResources?: int32;

  /**
   * The given assessment's related resources count with failed state.
   */
  @visibility(Lifecycle.Read)
  failedResources?: int32;

  /**
   * The given assessment's related resources count with skipped state.
   */
  @visibility(Lifecycle.Read)
  skippedResources?: int32;

  /**
   * The given assessment's related resources count with unsupported state.
   */
  @visibility(Lifecycle.Read)
  unsupportedResources?: int32;
}

