// Contains overrides to make the Autorest Swagger2.0 back compatible
using Microsoft.Community;

<<<<<<< HEAD
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CommunityTraining.properties,
  "autorest"
);
// For CommunityTrainingUpdate
<<<<<<< HEAD
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
