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

  @doc("Generic POST operation.")
  @Foundations.Private.ensureVerb("PostOperation", "POST")
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

  @doc("Operation to create a resource.")
  op CreateOperation<TResource extends TypeSpec.Reflection.Model> is AzureCoreOperations.ResourceCreateOrReplace<TResource>;

  @doc("Operation to patch a resource.")
  @updatesResource(Resource)
  @patch
  @Azure.Core.Foundations.Private.ensureVerb("PatchOperation", "PATCH")
  op PatchOperation<Resource extends TypeSpec.Reflection.Model> is Azure.Core.Foundations.ResourceOperation<
    Resource,
    {
      @doc("This request has a JSON Merge Patch body.")
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

  @doc("Operation to cancel a resource.")
  op CancelOperation<TResource extends TypeSpec.Reflection.Model> is AzureCoreOperations.ResourceDelete<TResource>;

  @doc("Operation to get a resource.")
  op GetOperation<TResource extends TypeSpec.Reflection.Model> is AzureCoreOperations.ResourceRead<TResource>;

  @doc("Operation to act on a resource.")
  op ActionOperation<TResource extends TypeSpec.Reflection.Model> is AzureCoreOperations.ResourceAction<
    TResource,
    {},
    TResource
  >;

  @doc("Operation to list a resource.")
  op ListOperation<TResource extends TypeSpec.Reflection.Model> is AzureCoreOperations.ResourceList<TResource>;
}
