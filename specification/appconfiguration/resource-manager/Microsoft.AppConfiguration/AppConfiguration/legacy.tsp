import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace Microsoft.AppConfiguration;

interface Operations
  extends Azure.ResourceManager.Legacy.Operations<
      Response = ArmResponse<OperationDefinitionListResult>,
      Parameters = {
        /**
         * A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
         */
        @query("$skipToken")
        $skipToken?: string,
      }
    > {}
