import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core;

namespace DeviceRegistrySoftwareUpdateClient;

@tag("Update management")
interface SoftwareUpdateOperationGroup {
  /**
   * Get a list of all updates that have been imported to Software Update for Device
   * Registry.
   */
  @route("/updates")
  @get
  @list
  listUpdates is ServiceOperation<
    {
      /**
       * Request updates matching a free-text search expression.
       */
      @query("search")
      search?: string;

      /**
       * Optional to filter updates by isDeployable property.
       */
      @query("filter")
      filter?: string;
    },
    UpdateList
  >;

  /**
   * Import new update version. This is a long-running-operation; use
   * Operation-Location response header value to check for operation status.
   */
  @route("/updates:import")
  @post
  @pollingOperation(SoftwareUpdateOperationGroup.getOperationStatus)
  @useFinalStateVia("operation-location")
  importUpdate is ServiceOperation<
    {
      /**
       * The update to be imported (see schema
       * https://json.schemastore.org/azure-deviceupdate-import-manifest-5.0.json for
       * details).
       */
      @bodyRoot
      importUpdateRequest: ImportUpdateRequest;
    },
    | Update
    | {
        @statusCode _: 202;
        ...Foundations.LongRunningStatusLocation;
      }
  >;

  /**
   * Get a specific update version.
   */
  @route("/updates/providers/{provider}/names/{name}/versions/{version}")
  @get
  getUpdate is ServiceOperation<
    {
      ...UpdateProviderParameter;
      ...UpdateNameParameter;
      ...UpdateVersionParameter;
      ...IfNoneMatchParameter;
    },
    Update
  >;

  /**
   * Delete a specific update version. This is a long-running-operation; use
   * Operation-Location response header value to check for operation status.
   */
  @route("/updates/providers/{provider}/names/{name}/versions/{version}")
  @delete
  @pollingOperation(SoftwareUpdateOperationGroup.getOperationStatus)
  @useFinalStateVia("operation-location")
  deleteUpdate is ServiceOperation<
    {
      ...UpdateProviderParameter;
      ...UpdateNameParameter;
      ...UpdateVersionParameter;
    },
    {
      @statusCode _: 202;
      ...Foundations.LongRunningStatusLocation;
    }
  >;

  /**
   * Get a list of all update providers that have been imported to Software Update for
   * Device Registry.
   */
  @route("/updates/providers")
  @get
  @list
  listProviders is ServiceOperation<{}, StringsList>;

  /**
   * Get a list of all update names that match the specified provider.
   */
  @route("/updates/providers/{provider}/names")
  @get
  @list
  listNames is ServiceOperation<
    {
      ...UpdateProviderParameter;
    },
    StringsList
  >;

  /**
   * Get a list of all update versions that match the specified provider and name.
   */
  @route("/updates/providers/{provider}/names/{name}/versions")
  @get
  @list
  listVersions is ServiceOperation<
    {
      ...UpdateProviderParameter;
      ...UpdateNameParameter;

      /**
       * Optional to filter updates by isDeployable property.
       */
      @query("filter")
      filter?: string;
    },
    StringsList
  >;

  /**
   * Get a list of all update file identifiers for the specified version.
   */
  @route("/updates/providers/{provider}/names/{name}/versions/{version}/files")
  @get
  @list
  listFiles is ServiceOperation<
    {
      ...UpdateProviderParameter;
      ...UpdateNameParameter;
      ...UpdateVersionParameter;
    },
    StringsList
  >;

  /**
   * Get a specific update file from the version.
   */
  @route("/updates/providers/{provider}/names/{name}/versions/{version}/files/{fileId}")
  @get
  getFile is ServiceOperation<
    {
      ...UpdateProviderParameter;
      ...UpdateNameParameter;
      ...UpdateVersionParameter;
      ...FileIdParameter;
      ...IfNoneMatchParameter;
    },
    UpdateFile
  >;

  /**
   * Get a list of all import update operations. Completed operations are kept for 7
   * days before auto-deleted. Delete operations are not returned by this API
   * version.
   */
  @route("/updates/operations")
  @get
  @list
  listOperationStatuses is ServiceOperation<
    {
      /**
       * Optional to filter operations by status property. Only one specific filter is
       * supported: "status eq 'NotStarted' or status eq 'Running'"
       */
      @query("filter")
      filter?: string;

      /**
       * Specifies a non-negative integer n that limits the number of items returned
       * from a collection. The service returns the number of available items up to but
       * not greater than the specified value n.
       */
      @query("maxpagesize")
      maxPageSize?: int32;
    },
    UpdateOperationsList
  >;

  /**
   * Retrieve operation status.
   */
  @route("/updates/operations/{operationId}")
  @get
  getOperationStatus is ServiceOperation<
    {
      ...OperationIdParameter;
      ...IfNoneMatchParameter;
    },
    {
      /**
       * Number of seconds to wait before checking the operation status again.
       */
      @header("Retry-After")
      retryAfter?: string;

      ...UpdateOperation;
    }
  >;
}
