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
@@externalTypeRef(Sku,
  "./../../../../Custom.Common.Types/commonTypes.json#/definitions/Sku"
);

@@externalTypeRef(ResourceWithOptionalLocation,
  "./../../../../Custom.Common.Types/commonTypes.json#/definitions/ResourceWithOptionalLocation"
);

@@externalTypeRef(Resource,
  "./../../../../Custom.Common.Types/commonTypes.json#/definitions/Resource"
);

@@externalTypeRef(SubResourceReadOnly,
  "./../../../../Custom.Common.Types/commonTypes.json#/definitions/SubResourceReadOnly"
);

@@externalTypeRef(ExtendedLocation,
  "./../../../../Custom.Common.Types/commonTypes.json#/definitions/ExtendedLocation"
);

@@externalTypeRef(ExtendedLocationTypes,
  "./../../../../Custom.Common.Types/commonTypes.json#/definitions/ExtendedLocationTypes"
);
