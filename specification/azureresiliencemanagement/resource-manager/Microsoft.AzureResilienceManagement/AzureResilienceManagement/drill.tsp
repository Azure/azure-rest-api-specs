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

  #suppress "@typespec/http/deprecated-implicit-optionality" "Legacy implicit optionality - DO NOT COPY"
  @route(ServiceGroupRoute)
  @patch(#{ implicitOptionality: true })
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
  @added(Versions.v2026_03_01_preview)
  @armResourceAction(Drill)
  @post
  @doc("This returns eligible resource to be faulted or failed over.")
  validateForExecution is ArmResourceActionAsync<
    Drill,
    ValidateForExecutionRequest,
    ValidateForExecutionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

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
  @removed(Versions.v2026_04_01_preview)
  @renamedFrom(Versions.v2026_04_01_preview, "addOrUpdateResources")
  @sharedRoute
  @armResourceAction(Drill)
  @post
  @doc("This enables the user to include, exclude or update resources from their Drill.")
  addOrUpdateResourcesOld is ArmResourceActionAsync<
    Drill,
    AddOrUpdateResourcesRequest,
    AddOrUpdateResourcesResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Per Azure REST API guidelines and the Spectral PostResponseCodes rule, LRO POST operations with no final body must return 202 + 204 + default. This TSP ARM library rule conflicts with that requirement; we follow the official guideline."
  @route(ServiceGroupRoute)
  @added(Versions.v2026_04_01_preview)
  @sharedRoute
  @armResourceAction(Drill)
  @post
  @doc("This enables the user to include, exclude or update resources from their Drill.")
  addOrUpdateResources is ArmResourceActionAsync<
    Drill,
    AddOrUpdateResourcesRequest,
    ArmNoContentResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Per Azure REST API guidelines and the Spectral PostResponseCodes rule, LRO POST operations with no final body must return 202 + 204 + default. This TSP ARM library rule conflicts with that requirement; we follow the official guideline."
  @route(ServiceGroupRoute)
  @removed(Versions.v2026_04_01_preview)
  @armResourceAction(Drill)
  @post
  @doc("This triggers detection of any drifts from the desired state of Resources and RBAC.")
  refreshReadinessState is ArmResourceActionAsync<
    Drill,
    void,
    ArmNoContentResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Per Azure REST API guidelines and the Spectral PostResponseCodes rule, LRO POST operations with no final body must return 202 + 204 + default. This TSP ARM library rule conflicts with that requirement; we follow the official guideline."
  @route(ServiceGroupRoute)
  @added(Versions.v2026_03_01_preview)
  @armResourceAction(Drill)
  @post
  @doc("This triggers detection of any drifts from the desired state of Resources and RBAC.")
  resyncReadinessCheck is ArmResourceActionAsync<
    Drill,
    void,
    ArmNoContentResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}
