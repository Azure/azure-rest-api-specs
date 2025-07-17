import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace PurviewDataCatalog;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataColumns")
@post
op postCriticalDataColumn is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelCriticalDataColumn,
  void
>;

#suppress "@azure-tools/typespec-openapi/example-validation"
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataElements")
@post
op postCriticalDataElement is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelCriticalDataElement,
  void
>;
/**
 * Example: GetCriticalDataElement_MaximumSet_Gen
 * See: ./examples/GetCriticalDataElement_MaximumSet_Gen.json
 */
#suppress "@azure-tools/typespec-openapi/example-validation"
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataElements")
@get
op getCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    @doc("The name of the domainId.")
    @query("domainId")
    domainId?: string;

    @doc("The name of the keyword.")
    @query("keyword")
    keyword?: string;

    @doc("The name of the skip.")
    @query("skip")
    skip?: int32;

    @doc("The name of the top.")
    @query("top")
    top?: int32;

    @doc("The name of the orderBy.")
    @query("orderBy")
    orderBy?: string;
  },
  void
>;
#suppress "@azure-tools/typespec-openapi/example-validation"
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataElements/{criticalDataElementId}")
@get
op getCriticalDataElementCriticalDataElementId is Azure.Core.Foundations.Operation<
  {
    @doc("The globally unique identifier of the entity.")
    @path
    criticalDataElementId: string;
  },
  void
>;
