// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./common.tsp";

using OpenAPI;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Rest.Resource;
using Azure.Core;
using Azure.Core.Traits;

alias DefaultServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;
alias AzureCoreOperations = Azure.Core.ResourceOperations<DefaultServiceTraits>;

@useDependency(DefaultAzureCoreVersion)
namespace Quantum.Workspace.BaseOperations {
  alias ResourceOkOrNoContentResponse<Resource extends TypeSpec.Reflection.Model> = Azure.Core.Foundations.ResourceOkResponse<Resource> | TypeSpec.Http.NoContentResponse;

  /** Generic POST operation. */
  @post
  op PostOperation<
    TRequest extends TypeSpec.Reflection.Model,
    TResponse extends TypeSpec.Reflection.Model
  > is Azure.Core.Foundations.Operation<
    {
      ...CommonParams;
      ...TRequest;
    },
    TResponse
  >;

  /** Operation to create a resource. */
  alias CreateOperation<Resource extends TypeSpec.Reflection.Model> = AzureCoreOperations.ResourceCreateOrReplace<Resource>;

  /** Operation to patch a resource. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" """
    There is no support for JsonPatch in Azure.Core.
    The Azure.Core.ResourceUpdate does not support NoContentResponse and the JsonPatchDocument request body.
    See https://github.com/Azure/typespec-azure/issues/475
    """
  @updatesResource(Resource)
  @patch
  op PatchOperation<Resource extends TypeSpec.Reflection.Model> is Azure.Core.Foundations.ResourceOperation<
    Resource,
    {
      /** This request has a JSON Merge Patch body. */
      @TypeSpec.Http.header("Content-Type")
      contentType: "application/json-patch+json";

      ...Foundations.ResourceBody<JsonPatchDocument>;
      ...Azure.Core.Traits.Private.TraitProperties<
        DefaultServiceTraits,
        TraitLocation.Parameters,
        TraitContext.Update
      >;
    },
    ResourceOkOrNoContentResponse<Resource &
      Azure.Core.Traits.Private.TraitProperties<
        DefaultServiceTraits,
        TraitLocation.Response,
        TraitContext.Update
      >>,
    DefaultServiceTraits,
    Azure.Core.Foundations.ErrorResponse
  >;

  /** Operation to cancel a resource. */
  alias CancelOperation<Resource extends TypeSpec.Reflection.Model> = AzureCoreOperations.ResourceDelete<Resource>;

  /** Operation to get a resource. */
  alias GetOperation<Resource extends TypeSpec.Reflection.Model> = AzureCoreOperations.ResourceRead<Resource>;

  /** Operation to act on a resource. */
  op ActionOperation<Resource extends TypeSpec.Reflection.Model> is AzureCoreOperations.ResourceAction<
    Resource = Resource,
    Parameters = {},
    Response = Resource
  >;

  /** Operation to list a resource. */
  alias ListOperation<Resource extends TypeSpec.Reflection.Model> = AzureCoreOperations.ResourceList<Resource>;

  /** Operation to list a resource. */
  op CustomListOperation<
    Resource extends TypeSpec.Reflection.Model,
    Parameters extends TypeSpec.Reflection.Model = {},
    Response extends TypeSpec.Reflection.Model = Page<Resource>
  > is Azure.Core.Foundations.ResourceList<
    Resource = Resource,
    Parameters = Parameters,
    Response = Response
  >;
}
