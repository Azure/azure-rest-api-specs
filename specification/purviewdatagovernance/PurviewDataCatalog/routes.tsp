import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace PurviewDataCatalog;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataElements")
@post
op postCriticalDataElement is Azure.Core.Foundations.Operation<
  MicrosoftPurviewDataGovernanceCatalogModelCriticalDataElement,
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/criticalDataElements")
@get
op getCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    /** The unique identifier (UUID) of the resource. */
    @query("domainId")
    domainId?: string;

    /** to avoid */
    @query("keyword")
    keyword?: string;

    /** to avoid */
    @query("skip")
    skip?: int32;

    /** to avoid */
    @query("top")
    top?: int32;

    /** to avoid */
    @query("orderBy")
    orderBy?: string;
  },
  void
>;
