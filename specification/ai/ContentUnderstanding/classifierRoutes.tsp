import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./classifierModels.tsp";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace ContentUnderstanding;

@added(Versions.v2025_05_01_preview)
interface ContentClassifiers {
  @doc("Get the status of a classifier creation operation.")
  getOperationStatus is Operations.GetResourceOperationStatus<
    ContentClassifier,
    ContentClassifier
  >;

  @doc("Create a new classifier asynchronously.")
  @pollingOperation(ContentClassifiers.getOperationStatus)
  createOrReplace is Operations.LongRunningResourceCreateOrReplace<ContentClassifier>;

  @doc("Update classifier properties.")
  update is Operations.ResourceUpdate<ContentClassifier>;

  @doc("Get classifier properties.")
  get is Operations.ResourceRead<ContentClassifier>;

  @doc("Delete classifier.")
  delete is Operations.ResourceDelete<ContentClassifier>;

  @doc("List classifiers.")
  list is Operations.ResourceList<ContentClassifier>;

  @doc("Classify content with optional splitting.")
  @sharedRoute
  @action("classify")
  @pollingOperation(ContentClassifiers.getResult)
  classify is Operations.LongRunningResourceAction<
    ContentClassifier,
    ClassifyRequest,
    ClassifyResult
  >;

  @doc("Classify content with optional splitting.")
  @sharedRoute
  @action("classify")
  @pollingOperation(ContentClassifiers.getResult)
  classifyBinary is Operations.LongRunningResourceAction<
    ContentClassifier,
    ClassifyBinaryRequest,
    ClassifyResult
  >;

  // @added(Versions.v2025_05_01_preview)
  // @doc("Classify input and route to analyzers for processing using adhoc classifier.")
  // @pollingOperation(ContentClassifiers.getResult)
  // @action("classify")
  // adHocClassify is Operations.LongRunningResourceCollectionAction<
  //   ContentClassifier,
  //   AdHocClassifyRequest,
  //   ClassifyResult
  // >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is a custom operation status endpoint."
  @doc("Get the result of a classifier operation.")
  @route("/classifierResults/{operationId}")
  getResult is Foundations.GetOperationStatus<{}, ClassifyResult>;

  // #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  // @added(Versions.v2025_05_01_preview)
  // @doc("Mark the result of a classifier operation for deletion.")
  // @route("/classifierResults/{operationId}")
  // @delete
  // deleteResult is Foundations.Operation<
  //   {
  //     @doc("Classifier identifier.")
  //     @path
  //     classifierId: string;

  //     @doc("Operation identifier.")
  //     @path
  //     operationId: string;
  //   },
  //   TypeSpec.Http.NoContentResponse,
  //   ServiceTraits
  // >;
}
