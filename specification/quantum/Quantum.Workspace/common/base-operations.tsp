// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;

alias DefaultServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;
alias AzureCoreOperations = Azure.Core.ResourceOperations<DefaultServiceTraits>;

namespace Quantum.Workspace.Services {
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
  @patch(#{ implicitOptionality: true })
  @updatesResource(Resource)
  op PatchOperation<Resource extends Reflection.Model> is AzureCoreOperations.ResourceUpdate<
    Resource,
    {
      /** This request uses a JSON Merge Patch body. */
      @header("Content-Type")
      contentType: "application/merge-patch+json";

      @body
      update: Resource;
            ...Azure.Core.Traits.Private.TraitProperties<
        DefaultServiceTraits,
        TraitLocation.Parameters,
        TraitContext.Update
      >;
        }
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
