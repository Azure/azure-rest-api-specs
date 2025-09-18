import "@typespec/openapi";
import "@typespec/http";
using TypeSpec.OpenAPI;
using TypeSpec.Http;
namespace OpenAI;
model ContainerFileListResource {
  /** The type of object returned, must be 'list'. */
  object: "list";

  /** A list of container files. */
  data: ContainerFileResource[];

  /** The ID of the first file in the list. */
  first_id: string;

  /** The ID of the last file in the list. */
  last_id: string;

  /** Whether there are more files available. */
  has_more: boolean;
}

@summary("The container file object")
@extension(
  "x-oaiMeta",
  #{
    name: "The container file object",
    example: "{\n    \"id\": \"cfile_682e0e8a43c88191a7978f477a09bdf5\",\n    \"object\": \"container.file\",\n    \"created_at\": 1747848842,\n    \"bytes\": 880,\n    \"container_id\": \"cntr_682e0e7318108198aa783fd921ff305e08e78805b9fdbb04\",\n    \"path\": \"/mnt/data/88e12fa445d32636f190a0b33daed6cb-tsconfig.json\",\n    \"source\": \"user\"\n}\n",
  }
)
model ContainerFileResource {
  /** Unique identifier for the file. */
  id: string;

  /** The type of this object (`container.file`). */
  object: "container.file";

  /** The container this file belongs to. */
  container_id: string;

  /** Unix timestamp (in seconds) when the file was created. */
  created_at: integer;

  /** Size of the file in bytes. */
  bytes: integer;

  /** Path of the file in the container. */
  path: string;

  /** Source of the file (e.g., `user`, `assistant`). */
  source: string;
}

model ContainerListResource {
  /** The type of object returned, must be 'list'. */
  object: "list";

  /** A list of containers. */
  data: ContainerResource[];

  /** The ID of the first container in the list. */
  first_id: string;

  /** The ID of the last container in the list. */
  last_id: string;

  /** Whether there are more containers available. */
  has_more: boolean;
}

@summary("The container object")
@extension(
  "x-oaiMeta",
  #{
    name: "The container object",
    example: "{\n   \"id\": \"cntr_682dfebaacac8198bbfe9c2474fb6f4a085685cbe3cb5863\",\n   \"object\": \"container\",\n   \"created_at\": 1747844794,\n   \"status\": \"running\",\n   \"expires_after\": {\n     \"anchor\": \"last_active_at\",\n     \"minutes\": 20\n   },\n   \"last_active_at\": 1747844794,\n   \"name\": \"My Container\"\n}\n",
  }
)
model ContainerResource {
  /** Unique identifier for the container. */
  id: string;

  /** The type of this object. */
  object: string;

  /** Name of the container. */
  name: string;

  /** Unix timestamp (in seconds) when the container was created. */
  created_at: integer;

  /** Status of the container (e.g., active, deleted). */
  status: string;

  /**The container will expire after this time period.
  The anchor is the reference point for the expiration.
  The minutes is the number of minutes after the anchor before the container expires.*/
  expires_after?: {
    anchor?: "last_active_at";
    minutes?: integer;
  };
}

model CreateContainerBody {
  /** Name of the container to create. */
  name: string;

  /** IDs of files to copy to the container. */
  file_ids?: string[];

  /** Container expiration time in seconds relative to the 'anchor' time. */
  expires_after?: {
    anchor: "last_active_at";
    minutes: integer;
  };
}

model CreateContainerFileBody {
  /** Name of the file to create. */
  file_id?: HttpPart<string>;

  /** The File object (not file name) to be uploaded. */
  file?: HttpPart<bytes>;
}
