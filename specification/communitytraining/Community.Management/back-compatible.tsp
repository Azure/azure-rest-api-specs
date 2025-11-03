// Contains overrides to make the Autorest Swagger2.0 back compatible
namespace Microsoft.Community;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CommunityTraining.properties,
  "autorest"
);
// For CommunityTrainingUpdate
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
