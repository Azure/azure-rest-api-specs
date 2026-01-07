import "./WebModels/CodeScanSite.tsp";
import "./WebModels/CodeScanReport.tsp";
import "./WebModels/CodeScanIssue.tsp";
import "./WebModels/CodeScanMapping.tsp";
import "./CodeScanSitesApiVersions.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.ApplicationMigration;

@armResourceOperations
interface CodeScanSites {
  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<CodeScanSite>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  listByResourceGroup is ArmResourceListByParent<CodeScanSite>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  listBySubscription is ArmListBySubscription<CodeScanSite>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CodeScanSite>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  update is ArmResourcePatchSync<CodeScanSite, CodeScanSiteProperties>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  delete is ArmResourceDeleteWithoutOkAsync<CodeScanSite>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  fetchSasUri is ArmResourceActionSync<CodeScanSite, void, SasUriResponse>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  processReportAsync is ArmResourceActionAsync<
    CodeScanSite,
    ProcessReportRequest,
    ProcessReportOperationStatusResponse,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ProcessReportOperationStatusResponse> &
      ArmLroLocationHeader<FinalResult = ProcessReportOperationStatusResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@armResourceOperations
interface CodeScanReports {
  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<CodeScanReport>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  listByResourceGroup is ArmResourceListByParent<CodeScanReport>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  listBySubscription is ArmListBySubscription<CodeScanReport>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CodeScanReport>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  delete is ArmResourceDeleteWithoutOkAsync<CodeScanReport>;
}

@armResourceOperations
interface CodeScanIssues {
  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<CodeScanIssue>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  listByCodeScanReport is ArmResourceListByParent<CodeScanIssue>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CodeScanIssue>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  delete is ArmResourceDeleteSync<CodeScanIssue>;
}

@armResourceOperations
interface CodeScanMappings {
  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<CodeScanMapping>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  listByResourceGroup is ArmResourceListByParent<CodeScanMapping>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  listBySubscription is ArmListBySubscription<CodeScanMapping>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CodeScanMapping>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  delete is ArmResourceDeleteWithoutOkAsync<CodeScanMapping>;
}
