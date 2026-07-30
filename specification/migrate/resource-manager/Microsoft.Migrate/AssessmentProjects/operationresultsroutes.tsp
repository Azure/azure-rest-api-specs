import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./WebModels/OperationResults.tsp";
import "./AssessmentProjectsVersions.tsp";

using Http;
using Rest;
using Versioning;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@armResourceOperations
interface OperationStatuses {
  @added(AssessmentProjectApiVersions.v2025_09_09_preview)
  getSubscriptionStatus is GetResourceOperationStatus<
    OperationResults,
    SubscriptionLocationActionScope
  >;
}
