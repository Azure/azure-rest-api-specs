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
@removed(Versions.v2026_09_30_preview)
@renamedFrom(Versions.v2026_09_30_preview, "Drills")
interface DrillsOld {
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  get is ArmResourceRead<Drill, ServiceGroupParameters>;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  create is ArmResourceCreateOrReplaceAsync<Drill, ServiceGroupParameters>;

  #suppress "@typespec/http/deprecated-implicit-optionality" "Legacy implicit optionality - DO NOT COPY"
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @patch(#{ implicitOptionality: true })
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
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

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<Drill, ServiceGroupParameters>;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  list is ArmResourceListByParent<Drill, ServiceGroupTenantParameters>;

  /**
  POST Actions
  */
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @added(Versions.v2026_03_01_preview)
  @armResourceAction(Drill)
  @post
  @doc("This returns eligible resource to be faulted or failed over.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
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
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @armResourceAction(Drill)
  @post
  @doc("This starts a new running instance of the Drill.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  start is ArmResourceActionAsync<
    Drill,
    DrillStartRequest,
    DrillActionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @armResourceAction(Drill)
  @post
  @doc("This ends the currently running instance of the Drill.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  end is ArmResourceActionAsync<
    Drill,
    DrillEndRequest,
    DrillActionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @removed(Versions.v2026_04_01_preview)
  @renamedFrom(Versions.v2026_04_01_preview, "addOrUpdateResources")
  @sharedRoute
  @armResourceAction(Drill)
  @post
  @doc("This enables the user to include, exclude or update resources from their Drill.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
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
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @added(Versions.v2026_04_01_preview)
  @sharedRoute
  @armResourceAction(Drill)
  @post
  @doc("This enables the user to include, exclude or update resources from their Drill.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
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
  #deprecated "The refreshReadinessState operation is deprecated. Use Drills_ResyncReadinessCheck with API version 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @removed(Versions.v2026_04_01_preview)
  @armResourceAction(Drill)
  @post
  @doc("This triggers detection of any drifts from the desired state of Resources and RBAC.")
  @summary("Deprecated. Use Drills_ResyncReadinessCheck in 2026-09-30-preview or a later supported API version.")
  @sharedRoute
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
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @added(Versions.v2026_03_01_preview)
  @armResourceAction(Drill)
  @post
  @doc("This triggers detection of any drifts from the desired state of Resources and RBAC.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
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

@armResourceOperations(Drill)
@added(Versions.v2026_09_30_preview)
interface Drills {
  @route(ServiceGroupRoute)
  @sharedRoute
  get is ArmResourceRead<Drill, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  @sharedRoute
  create is ArmResourceCreateOrReplaceAsync<Drill, ServiceGroupParameters>;

  #suppress "@typespec/http/deprecated-implicit-optionality" "Legacy implicit optionality - DO NOT COPY"
  @route(ServiceGroupRoute)
  @patch(#{ implicitOptionality: true })
  @sharedRoute
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
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<Drill, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  @sharedRoute
  list is ArmResourceListByParent<Drill, ServiceGroupTenantParameters>;

  /**
  POST Actions
  */
  @route(ServiceGroupRoute)
  @armResourceAction(Drill)
  @post
  @doc("This returns eligible resource to be faulted or failed over.")
  @sharedRoute
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
  @sharedRoute
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
  @sharedRoute
  end is ArmResourceActionAsync<
    Drill,
    DrillEndRequest,
    DrillActionResponse,
    ServiceGroupAndRequestHeadersParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Per Azure REST API guidelines and the Spectral PostResponseCodes rule, LRO POST operations with no final body must return 202 + 204 + default. This TSP ARM library rule conflicts with that requirement; we follow the official guideline."
  @route(ServiceGroupRoute)
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
  @armResourceAction(Drill)
  @post
  @doc("This triggers detection of any drifts from the desired state of Resources and RBAC.")
  @sharedRoute
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
