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

namespace ComplianceResultsAPI;

/**
 * The status of the resource regarding a single assessment
 */
union ResourceStatus {
  string,

  /**
   * This assessment on the resource is healthy
   */
  Healthy: "Healthy",

  /**
   * This assessment is not applicable to this resource
   */
  NotApplicable: "NotApplicable",

  /**
   * This assessment is turned off by policy on this subscription
   */
  OffByPolicy: "OffByPolicy",

  /**
   * This assessment on the resource is not healthy
   */
  NotHealthy: "NotHealthy",
}

/**
 * List of compliance results response
 */
model ComplianceResultList is Azure.Core.Page<ComplianceResult>;

/**
 * Compliance result data
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ComplianceResultProperties {
  /**
   * The status of the resource regarding a single assessment
   */
  @visibility(Lifecycle.Read)
  resourceStatus?: ResourceStatus;
}

