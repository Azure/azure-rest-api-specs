import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models/drill/drill.models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.CommonTypes;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureResilienceManagement;

@armResourceOperations(Drill)
interface Drills {
  @route(ServiceGroupRoute)
  get is ArmResourceRead<Drill, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  create is ArmResourceCreateOrReplaceAsync<Drill, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  update is ArmCustomPatchAsync<
    Drill,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Drill,
      DrillPatchProperties
    >,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  delete is ArmResourceDeleteWithoutOkAsync<Drill, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<Drill, ServiceGroupTenantParameters>;

  /**
  POST Actions
  */
  @route(ServiceGroupRoute)
  @armResourceAction(Drill)
  @post
  @doc("This starts a new running instance of the Drill.")
  start is ArmResourceActionAsync<
    Drill,
    DrillStartRequest,
    DrillActionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @armResourceAction(Drill)
  @post
  @doc("This ends the currently running instance of the Drill.")
  end is ArmResourceActionAsync<
    Drill,
    DrillEndRequest,
    DrillActionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @armResourceAction(Drill)
  @post
  @doc("This enables the user to include, exclude or update resources from their Drill.")
  addOrUpdateResources is ArmResourceActionAsync<
    Drill,
    AddOrUpdateResourcesRequest,
    AddOrUpdateResourcesResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @armResourceAction(Drill)
  @post
  @doc("This triggers detection of any drifts from the desired state of Target and capabilities and RBAC.")
  refreshReadinessState is ArmResourceActionNoResponseContentAsync<
    Drill,
    void,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}
