import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/common";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/containers";
using TypeSpec.Http;
using OpenAI;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@route("openai/v1/containers")
@tag("Containers")
interface Containers {
  @list
  @get
  @summary("List Containers")
  ListContainers is OpenAIOperation<
    {
      /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum = OrderEnum.desc;

      /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** Filter results by container name. */
      @query(#{ explode: true })
      name?: string;
    },
    OpenAI.ContainerListResource
  >;

  @post
  @summary("Create Container")
  CreateContainer is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateContainerBody;
    },
    OpenAI.ContainerResource
  >;

  @route("{container_id}")
  @delete
  @summary("Delete Container")
  DeleteContainer is OpenAIOperation<
    {
      /** The ID of the container to delete. */
      @path
      container_id: string;
    },
    TypeSpec.Http.OkResponse
  >;

  @route("{container_id}")
  @get
  @summary("Retrieve Container")
  RetrieveContainer is OpenAIOperation<
    {
      @path
      container_id: string;
    },
    OpenAI.ContainerResource
  >;

  @list
  @route("{container_id}/files")
  @get
  @summary("List Container files")
  ListContainerFiles is OpenAIOperation<
    {
      @path
      container_id: string;

      /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum = OrderEnum.desc;

      /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;
    },
    OpenAI.ContainerFileListResource
  >;

  @sharedRoute
  @route("{container_id}/files")
  @post
  @summary("""
    Create a Container File
    
    You can send either a multipart/form-data request with the raw file content, or a JSON request with a file ID.
    
    """)
  CreateContainerFileMultipart is OpenAIOperation<
    {
      @path
      container_id: string;

      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateContainerFileBody;
    },
    OpenAI.ContainerFileResource
  >;

  @sharedRoute
  @route("{container_id}/files")
  @post
  @summary("""
    Create a Container File
    
    You can send either a multipart/form-data request with the raw file content, or a JSON request with a file ID.
    
    """)
  CreateContainerFileJson is OpenAIOperation<
    {
      @path
      container_id: string;

      @body
      body: OpenAI.CreateContainerFileBody;
    },
    OpenAI.ContainerFileResource
  >;

  @route("{container_id}/files/{file_id}")
  @delete
  @summary("Delete Container File")
  DeleteContainerFile is OpenAIOperation<
    {
      @path
      container_id: string;

      @path
      file_id: string;
    },
    TypeSpec.Http.OkResponse
  >;

  @route("{container_id}/files/{file_id}")
  @get
  @summary("Retrieve Container File")
  RetrieveContainerFile is OpenAIOperation<
    {
      @path
      container_id: string;

      @path
      file_id: string;
    },
    OpenAI.ContainerFileResource
  >;

  @route("{container_id}/files/{file_id}/content")
  @get
  @summary("Retrieve Container File Content")
  RetrieveContainerFileContent is OpenAIOperation<
    {
      @path
      container_id: string;

      @path
      file_id: string;
    },
    TypeSpec.Http.OkResponse
  >;
}
