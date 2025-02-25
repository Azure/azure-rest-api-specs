import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager.Legacy;

namespace Microsoft.Compute;

@@externalTypeRef(ApiError,
  "../../../common-types/v1/common.json#/definitions/ApiError"
);
@@externalTypeRef(ApiErrorBase,
  "../../../common-types/v1/common.json#/definitions/ApiErrorBase"
);
@@externalTypeRef(CloudError,
  "../../../common-types/v1/common.json#/definitions/CloudError"
);
@@externalTypeRef(InnerError,
  "../../../common-types/v1/common.json#/definitions/InnerError"
);

@@externalTypeRef(SubResource,
  "../../../common-types/v1/common.json#/definitions/SubResource"
);
@@externalTypeRef(SubResourceReadOnly,
  "../../../common-types/v1/common.json#/definitions/SubResourceReadOnly"
);

@@externalTypeRef(ExtendedLocation,
  "../../../common-types/v1/common.json#/definitions/ExtendedLocation"
);

@@externalTypeRef(ExtendedLocationTypes,
  "../../../common-types/v1/common.json#/definitions/ExtendedLocationTypes"
);
