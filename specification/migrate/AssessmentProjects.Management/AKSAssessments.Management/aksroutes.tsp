import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./ArmModels/Assessed/AssessedWebApplication.tsp";
import "./ArmModels/Assessment/AKSAssessment.tsp";
import "./ArmModels/Cluster/AKSCluster.tsp";
import "./ArmModels/CostDetails/AKSCostDetails.tsp";
import "./ArmModels/Options/AKSAssessmentOptions.tsp";
import "./ArmModels/Summary/AKSSummary.tsp";
import "../Common/DataModels/DownloadUrl.tsp";

import "./AKSApiVersions.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@armResourceOperations
interface AKSAssessmentOperations {
  @added(AKSApiVersions.v2024_03_03_preview)
  create is ArmResourceCreateOrUpdateAsync<AKSAssessment>;

  @added(AKSApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<AKSAssessment>;

  @added(AKSApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<AKSAssessment>;

  @added(AKSApiVersions.v2024_03_03_preview)
  delete is ArmResourceDeleteSync<AKSAssessment>;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Download URL Post Action body is empty."
  @added(AKSApiVersions.v2024_03_03_preview)
  @doc("Get URL for downloading AKS Assessment Report.")
  downloadUrl is ArmResourceActionAsync<AKSAssessment, {}, DownloadUrl>;
}

@armResourceOperations
interface AssessedWebApplicationOperations {
  @added(AKSApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<AssessedWebApplication>;

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @added(AKSApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<AssessedWebApplication>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@armResourceOperations
interface AKSOptionsOperations {
  @added(AKSApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<AKSAssessmentOptions>;

  @added(AKSApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<AKSAssessmentOptions>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@armResourceOperations
interface AKSSummaryOperations {
  @added(AKSApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<AKSSummary>;

  @added(AKSApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<AKSSummary>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@armResourceOperations
interface AKSClusterOperations {
  @added(AKSApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<AKSCluster>;

  @added(AKSApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<AKSCluster>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@armResourceOperations
interface AKSCostDetailOperations {
  @added(AKSApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<AKSCostDetail>;
}
