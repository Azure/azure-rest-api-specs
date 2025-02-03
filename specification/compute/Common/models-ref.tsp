import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager.Legacy;

namespace Microsoft.Compute;

@@externalTypeRef(ApiError,
  "./../../../../Custom.Common.Types/commonTypes.json#/definitions/ApiError"
);
@@externalTypeRef(ApiErrorBase,
  "./../../../../Custom.Common.Types/commonTypes.json#/definitions/ApiErrorBase"
);
@@externalTypeRef(CloudError,
  "./../../../../Custom.Common.Types/commonTypes.json#/definitions/CloudError"
);
@@externalTypeRef(InnerError,
  "./../../../../Custom.Common.Types/commonTypes.json#/definitions/InnerError"
);
@@externalTypeRef(Plan,
  "./../../../../Custom.Common.Types/commonTypes.json#/definitions/Plan"
);
@@externalTypeRef(Sku, "./../../../../Custom.Common.Types/commonTypes.json#");