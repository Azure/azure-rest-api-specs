import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.Rest;
using Azure.Core;
using Microsoft.Discovery.DataPlane.Shared;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.Discovery.Workspace.Versions)
namespace Microsoft.Discovery.Workspace;

/** Enum for run status */
@lroStatus
union RunStatus {
  /** Not Running */
  NotRunning: "NotRunning",

  /** Running */
  Running: "Running",

  /** Succeeded */
  @lroSucceeded
  Succeeded: "Succeeded",

  /** Canceled */
  @lroCanceled
  Canceled: "Canceled",

  /** Failed */
  @lroFailed
  Failed: "Failed",

  string,
}

/** Data URI and path where it will be mounted in the tool container. */
model InputDataMount {
  /** URI of input data to mount. */
  @removed(Versions.`2026-02-01-preview`)
  uri: DataUri;

  /** URI of input data to mount. */
  @added(Versions.`2026-02-01-preview`)
  storageUri: StorageUri;

  /** Absolute path within the container at which to mount this input. */
  mountPath: string;
}

/** Definition of a mount for collecting tool output data. */
model OutputDataMount {
  /**
   * URI of location to persist output to. If not specified, a folder will be
   * created on the Storage specified by the storageId property in the tool run
   * request.
   *
   * If a URI is specified, it must not point at Discovery Storage (i.e. it must point
   * at a Storage Asset which is not in a Discovery Storage Data Container). This is
   * because the Supercomputer dataplane owns choosing output locations on
   * Discovery Storage (to provide immutability guarantees).
   */
  @removed(Versions.`2026-02-01-preview`)
  uri: DataUri;

  /** URI of location to persist output to. */
  @added(Versions.`2026-02-01-preview`)
  storageUri: StorageUri;

  /** Absolute path within the container from which to collect output data. */
  mountPath: string;
}

/** Model for providing the URI of the output collected from a specific container path. */
model OutputDataUri {
  /** The URI of the output data. */
  @removed(Versions.`2026-02-01-preview`)
  uri: DataUri;

  /** The URI of the output data. */
  @added(Versions.`2026-02-01-preview`)
  storageUri: StorageUri;

  /** The path within the container from which the output was collected. */
  mountPath: string;
}

/*
 * The interplay between command, inlineFiles, inputData and outputData warrants an example.
 *
 * Imagine a scenario in which an agent generates a Python script wrapper.py which:
 * - Takes a single command line argument, --input, which is a text file containing a list of
 *   SMILES strings.
 * - Reads the SMILES strings from the file, and for each SMILES string uses RDKit to generate
 *   multiple conformers for the molecule, and uses iomanager.py to write the conformers to file
 *
 * If the data plane receives the following request:
 *
 * ```json
 * {
 *   "command": "python /code/wrapper.py --input /inputs/abcdef-input-1/* --output /outputs/abcdef-output-1",
 *   "inlineFiles": [
 *     {
 *       "mountPath": "/code/iomanager.py",
 *       "encodedFile": "IiIiQmFzaWMgb..."
 *     },
 *     {
 *       "mountPath": "/code/wrapper.py",
 *       "encodedFile": "3RlcHMve3NlbG..."
 *     }
 *   ],
 *   "inputData": [
 *     {
 *         "mountPath": "/inputs/abcdef-input-1",
 *         "uri": "discovery://storageassets/<storageAssetArmId>"
 *     }
 *   ],
 *   "outputData": [
 *     {
 *         "mountPath": "/outputs/abcdef-output-1"
 *     }
 *   ],
 *   "nodePoolIds": ["<myNodePoolId>"],
 *   "storageId": "<myStorageId>"
 * }
 * ```
 * where SmilesTxtStorageAsset refers to a blob StorageAsset containing a single smiles.txt file, then the
 * following filesystem layout will be presented to the tool container:
 *
 * /code
 * ├── iomanager.py
 * └── wrapper.py
 * /inputs
 * └── abcdef-input-1/
 *     └── smiles.txt
 * /outputs
 * └── abcdef-output-1/
 *
 * Supercomputer will ensure that the abcdef-output-1/ directory is backed, via filesystem mounts,
 * by a persistent folder on <myStorageId> (the storage specified by storageId).
 *
 * wrapper.py will write its output to /outputs/abcdef-output-1/, meaning it is persisted to the
 * provided folder on <myStorageId>.
 *
 * When the run completes, the status API will provide a URI which identifies the location to which
 * the output has been written, allowing it to be consumed by downstream tools.
 */
@doc("Parameters to run a Tool")
model RunRequest {
  ...WithProjectNamePath;

  /** ID of the tool to execute */
  toolId: ToolId;

  /** Command to pass to tool container entrypoint.
   *
   * If the tool has multiple containers defined, this command is executed on all of them.
   *
   * If omitted, all containers execute their raw entrypoints.
   *
   * This command is parsed into an argument list which is passed to the underlying container runtime.
   * For example, if the command is "python /code/wrapper.py --input /inputs/abcdef-input-1/input.txt --output /outputs/abcdef-output-1",
   * then the container runtime will receive the following argument list:
   * ["python", "/code/wrapper.py", "--input", "/inputs/abcdef-input-1/input.txt", "--output", "/outputs/abcdef-output-1"]
   *
   * The container's entrypoint is not overridden. In Docker terminology, the above argument list becomes
   * the CMD, not the ENTRYPOINT of the launched container.
   *
   * Our parsing includes the following limited interpretation of special characters:
   * - The only special characters are " ' and \.
   * - Backslashes `\` escape the next character if that character is a special character, preserving its literal value.
   * - Double quotes `"` preserve everything inside them literally, with the exception of the characters " and \, which must be escaped with a backslash `\`. Unmatched quotes will throw an error.
   * - Single quotes `'` preserve everything inside them literally. A single-quote cannot occur within single-quotes. Unmatched quotes will throw an error.
   *
   * If you wish to run a command that relies on shell features such as globbing or output redirection, you either need to:
   * - use a container with an entrypoint that is a shell (e.g. `/bin/sh` or `/bin/bash`) and pass a command which is valid for that shell e.g.
   *   `-c 'python /code/wrapper.py --input /inputs/abcdef-input-1/* --output /outputs/abcdef-output-1'`
   * - use a container which has a shell installed, and include the shell in the command, e.g.
   *   `sh -c "python /code/wrapper.py --input /inputs/abcdef-input-1/* --output /outputs/abcdef-output-1"`
   */
  /*
   * Note that we will likely extend this API in M2 to better support tools with
   * heterogeneous pools/containers where we want to run different code in some containers.
   *
   * Doing so will likely involve moving to accept a Dictionary of commands to run on
   * different containers.
   */
  command?: string;

  /*
   * Up to 10 files can be provided inline. This
   * is primarily intended for submitting agent-generated code.
   *
   * We impose a 10 file limit in order to place some bounds on how much
   * code can be submitted in this way. For submitting larger amounts of data,
   * a StorageAsset should be used.
   *
   * Each of these files is made available at the specified path, relative to the
   * container's working directory.
   */
  @doc("Encoded inline files to be mounted into the container, e.g. for generated code.")
  @maxItems(10)
  inlineFiles?: Array<InlineFile>;

  @doc("The Discovery Storage resource to use for this run.")
  storageId?: DiscoveryStorageId;

  @doc("Input data and associated mountPath for each.")
  inputData?: InputDataMount[];

  @doc("Output data mount paths (with optional data URIs to specify persistence location).")
  outputData?: OutputDataMount[];

  @doc("IDs of NodePools to use for this run.")
  nodePoolIds: NodePoolId[];

  @added(Versions.`2025-12-01-preview`)
  @doc("Override the infrastructure requirements in the tool definitions.")
  infraOverrides?: InfraOverrides;
}

@doc("A file to be included in the input data for a tool run and the path where it will be mounted, relative to the working directory.")
model InlineFile {
  @doc("Absolute path within the container at which to mount this file.")
  mountPath: string;

  /*
   * Expected reasonable limit for small code files,
   * which are the primary use case for this feature.
   *
   * For reference, at the time of writing, iomanager.py was 7kB without
   * zipping or encoding it.
   */
  @doc("File contents: Compressed using .gz then base64-encoded.")
  @maxLength(12000) // ~12kB - any larger threw an exception on the Batch API - commandLine too long. May be able to relax for AKS but easier to start strict.
  encodedFile: string;
}

@added(Versions.`2025-12-01-preview`)
@doc("Explicitly set tool run requirements - overrides the tool definition.")
model InfraOverrides {
  @doc("Override CPU requirements (e.g. 1, or 500m for 500 milli-CPUs)")
  cpu?: string;

  @doc("Override RAM requirements (e.g. 500Mi or 1Gi).")
  ram?: string;

  @doc("Override GPU count requirements.")
  gpu?: string;

  @doc("Override the number of replicas of the tool image to run.")
  replicaCount?: int32;

  @doc("Override the image to use for this tool run.")
  imageUri?: string;
}

/** For tracking when it completed. */
@access(Access.internal)
model WithCompletedAt {
  @visibility(Lifecycle.Read)
  @doc("The time the run completed.")
  completedAt?: utcDateTime;
}

@doc("Run result")
model RunResult {
  @doc("Status of the run.")
  status: RunStatus;

  @doc("Human-readable details about the run status.")
  runtimeDetails: string;

  ...WithCreatedAt;
  ...WithCompletedAt;

  @added(Versions.`2025-12-01-preview`)
  @doc("The user that started the tool run.")
  createdBy?: string;

  @doc("Details provided by the tool (rather than the platform).")
  toolReport?: {
    /** Percentage compete */
    percentageComplete: int32;

    statusInformation?: {};

    /** Logs from the tool. */
    logs?: string[];
  };

  /** Output data URIs.
   *
   * This array will contain the same set of mountPaths specified in the outputData property of initial tool run request,
   * but every mountPath will have a corresponding URI that points to the location where the output data was persisted:
   * * for mount paths which had a URI specified in the outputData property, the URI will be the same as the one
   *   specified in the request, and the data will have been persisted to the location specified by that URI.
   * * for mount paths which did not have a URI specified in the outputData property, the URI will point to a
   *   folder created by the service on the Storage specified by the storageId property in the tool run request.
   *
   * E.g. if the following run request is made:
   * ```json
   * {
   *   "toolId": "testTool",
   *   "command": "echo 'hello world' > /output1/hello.txt",
   *   "inlineFiles": [],
   *   "inputData": [],
   *   "outputData": [
   *       {
   *           "mountPath": "/output1"
   *       }
   *   ],
   *   "nodePoolIds": ["<nodePoolId>"],
   *   "storageId": "<storageARMId"
   * }
   * ```
   * then once the tool completes, the status API response will contain the following:
   * ```json
   * {
   *   "status": "Succeeded",
   *   ...
   *   "outputData": [
   *      {
   *        "uri": "discovery://storages/<storageARMId>/paths/<some-generated-path>/output1",
   *        "mountPath": "/output1"
   *      }
   *   ]
   * }
   * ```
   * `discovery://storages/<storageARMId>/paths/<some-generated-path>/output1` can then be used as an
   * input to another tool run. Any valid subpaths can also be used, e.g.
   * `discovery://storages/<storageARMId>/paths/<some-generated-path>/output1/hello.txt` to refer specifically
   * to the hello.txt file.
   */
  outputData: OutputDataUri[];

  /*
   * The intention is to place the original request payload in this field as
   * an escaped JSON string. We do this instead of making this model an extension
   * of RunRequest to avoid consumers taking a hard dependency on this
   * information being present.
   */
  @doc("Debugging information.")
  debugInfo: string;
}

/** Project name path parameter for URL routing */
model WithProjectNamePath {
  /** Name of the associated Project. */
  @path
  @maxLength(24)
  @pattern(resourceNamePattern)
  projectName: string;
}

/** Operation ID path parameter */
model WithOperationId {
  /** ID of the operation to cancel. */
  @path
  @maxLength(38)
  operationId: string;
}

/** Summary information for an operation. */
@added(Versions.`2025-12-01-preview`)
model Operation {
  /** Operation id. */
  id: string;

  /** The nodepool the operation targets. */
  nodePoolId: string;

  /** Current status of the operation. */
  status: RunStatus;

  /** Human-readable details about the run status. */
  runtimeDetails: string;

  /** When the operation was submitted. */
  createdAt: utcDateTime;

  /** When the operation completed. */
  completedAt?: utcDateTime;

  /** The user who created the operation. */
  createdBy?: string;
}

/** Overview of compute usage for a project. */
@added(Versions.`2025-12-01-preview`)
model ComputeUsage {
  /** Index of information for each supercomputer in the workspace of a project.
   *  Indexed by the (short) name of the supercomputer. */
  supercomputers: Record<SupercomputerUsage>;
}

/** Overview of compute usage for a supercomputer. */
@added(Versions.`2025-12-01-preview`)
model SupercomputerUsage {
  /** Number of active jobs on the supercomputer. */
  activeJobs: int64;

  /** Number of pending jobs on the supercomputer. */
  pendingJobs: int64;

  /** Nodepool utilization for each nodepool for a supercomputer. */
  nodePools: Record<NodepoolUsage>;
}

/** Overview of compute usage for a nodepool. */
@added(Versions.`2025-12-01-preview`)
model NodepoolUsage {
  /** CPUs in use (e.g. 1, or 500m for 500 milli-CPUs)
   *  across all nodes in the nodepool. */
  reservedCpus: string;

  /** CPUs which are free to use (e.g. 1, or 500m for 500 milli-CPUs)
   *  across all nodes in the nodepool. */
  allocatableCpus: string;

  /** Memory which is in use (e.g. 500Mi or 1Gi). */
  reservedMemory: string;

  /** Memory which is free to use (e.g. 500Mi or 1Gi). */
  allocatableMemory: string;

  /** GPUs which are in use. */
  reservedGpus: string;

  /** GPUs which are free to use. */
  allocatableGpus: string;
}

/** Get operations parameters. */
@added(Versions.`2025-12-01-preview`)
model GetOperationsParameters {
  /** Skip results (pagination control). */
  @query
  skip?: int32;

  /** Query the top results (pagination control). */
  @query
  top?: int32;

  /** Bound the number of results that come back in one response (pagination control). */
  @query
  maxPageSize?: int32;
}

interface Tools {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Used for to poll status of a Tool run.")
  @route("/tools/projects/{projectName}/operations")
  getRunStatus is Foundations.GetOperationStatus<
    WithProjectNamePath,
    RunResult
  >;

  /** Run the specified tool in the context of the specified project. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/tools/projects/{projectName}:run")
  @pollingOperation(Tools.getRunStatus)
  run is Foundations.LongRunningOperation<
    RunRequest,
    AcceptedResponse & Foundations.OperationStatus<RunResult>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Cancel an ongoing tool run.")
  @route("/tools/projects/{projectName}/operations/{operationId}:cancel")
  @post
  cancelRun is Foundations.Operation<
    WithProjectNamePath & WithOperationId,
    AcceptedResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @added(Versions.`2025-12-01-preview`)
  @doc("List tool runs.")
  @route("/tools/projects/{projectName}/operations")
  getOperations is Foundations.Operation<
    WithProjectNamePath & GetOperationsParameters,
    Foundations.CustomPage<Operation>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @added(Versions.`2025-12-01-preview`)
  @doc("Examine compute usage.")
  @route("/tools/projects/{projectName}/computeUsage")
  getComputeUsage is Foundations.Operation<WithProjectNamePath, ComputeUsage>;
}
