import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using PurviewDataMap;

@TypeSpec.Versioning.useDependency(PurviewDataMap.ApiVersions.v2023_09_01)
@client({
  name: "DataMapClient",
  service: PurviewDataMap,
})
namespace Customizations;

@@clientName(MoveEntitiesOptions, "MoveEntitiesConfig", "csharp");
@@clientName(DateFormat, "AtlasDateFormat", "csharp");
@@clientName(NumberFormat, "AtlasNumberFormat", "csharp");
@@clientName(TimeZone, "AtlasTimeZone", "csharp");
@@clientName(SortType, "AtlasSortType", "csharp");
@@clientName(ClassificationAssociateOptions,
  "ClassificationAssociateConfig",
  "csharp"
);
@@clientName(QueryOptions, "QueryConfig", "csharp");
@@clientName(SuggestOptions, "SuggestConfig", "csharp");
@@clientName(AutoCompleteOptions, "AutoCompleteConfig", "csharp");

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@operationGroup
interface Entity {
  createOrUpdate is PurviewDataMap.Entity.createOrUpdate;
  getByIds is PurviewDataMap.Entity.listByGuids;
  batchCreateOrUpdate is PurviewDataMap.Entity.bulkCreateOrUpdate;
  batchDelete is PurviewDataMap.Entity.bulkDelete;
  addClassification is PurviewDataMap.Entity.addClassification;
  get is PurviewDataMap.Entity.get;
  updateAttributeById is PurviewDataMap.Entity.partialUpdateAttributeByGuid;
  delete is PurviewDataMap.Entity.delete;
  getClassification is PurviewDataMap.Entity.getClassification;
  removeClassification is PurviewDataMap.Entity.removeClassification;
  getClassifications is PurviewDataMap.Entity.getClassifications;
  addClassifications is PurviewDataMap.Entity.addClassifications;
  updateClassifications is PurviewDataMap.Entity.updateClassifications;
  getByUniqueAttribute is PurviewDataMap.Entity.getByUniqueAttributes;
  updateByUniqueAttribute is PurviewDataMap.Entity.partialUpdateByUniqueAttributes;
  deleteByUniqueAttribute is PurviewDataMap.Entity.deleteByUniqueAttribute;
  removeClassificationByUniqueAttribute is PurviewDataMap.Entity.removeClassificationByUniqueAttribute;
  addClassificationsByUniqueAttribute is PurviewDataMap.Entity.addClassificationsByUniqueAttribute;
  updateClassificationsUniqueByAttribute is PurviewDataMap.Entity.updateClassificationsByUniqueAttribute;
  batchSetClassifications is PurviewDataMap.Entity.bulkSetClassifications;
  batchGetByUniqueAttributes is PurviewDataMap.Entity.listByUniqueAttributes;
  getHeader is PurviewDataMap.Entity.getHeader;
  removeBusinessMetadata is PurviewDataMap.Entity.removeBusinessMetadata;
  addOrUpdateBusinessMetadata is PurviewDataMap.Entity.addOrUpdateBusinessMetadata;
  removeBusinessMetadataAttributes is PurviewDataMap.Entity.removeBusinessMetadataAttributes;
  addOrUpdateBusinessMetadataAttributes is PurviewDataMap.Entity.addOrUpdateBusinessMetadataAttributes;
  getBusinessMetadataTemplate is PurviewDataMap.Entity.getSampleBusinessMetadataTemplate;
  #suppress "@azure-tools/typespec-azure-core/byos" "This is Atlas API"
  importBusinessMetadata is PurviewDataMap.Entity.importBusinessMetadata;
  removeLabels is PurviewDataMap.Entity.removeLabels;
  setLabels is PurviewDataMap.Entity.setLabels;
  addLabel is PurviewDataMap.Entity.addLabel;
  removeLabelsByUniqueAttribute is PurviewDataMap.Entity.removeLabelsByUniqueAttribute;
  setLabelsByUniqueAttribute is PurviewDataMap.Entity.setLabelsByUniqueAttribute;
  addLabelsByUniqueAttribute is PurviewDataMap.Entity.addLabelsByUniqueAttribute;
  moveEntitiesToCollection is PurviewDataMap.Entity.moveEntitiesToCollection;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@operationGroup
interface Glossary {
  batchGet is PurviewDataMap.Glossary.list;
  create is PurviewDataMap.Glossary.create;
  createCategories is PurviewDataMap.Glossary.createCategories;
  createCategory is PurviewDataMap.Glossary.createCategory;
  getCategory is PurviewDataMap.Glossary.getCategory;
  updateCategory is PurviewDataMap.Glossary.updateCategory;
  deleteCategory is PurviewDataMap.Glossary.deleteCategory;
  partialUpdateCategory is PurviewDataMap.Glossary.partialUpdateCategory;
  getRelatedCategories is PurviewDataMap.Glossary.listRelatedCategories;
  getCategoryTerms is PurviewDataMap.Glossary.listCategoryTerms;
  createTerm is PurviewDataMap.Glossary.createTerm;
  getTerm is PurviewDataMap.Glossary.getTerm;
  updateTerm is PurviewDataMap.Glossary.updateTerm;
  deleteTerm is PurviewDataMap.Glossary.deleteTerm;
  partialUpdateTerm is PurviewDataMap.Glossary.partialUpdateTerm;
  createTerms is PurviewDataMap.Glossary.createTerms;
  getEntitiesAssignedWithTerm is PurviewDataMap.Glossary.listEntitiesAssignedWithTerm;
  assignTermToEntities is PurviewDataMap.Glossary.assignTermToEntities;
  deleteTermAssignmentFromEntities is PurviewDataMap.Glossary.deleteTermAssignmentFromEntities;
  getRelatedTerms is PurviewDataMap.Glossary.listRelatedTerms;
  get is PurviewDataMap.Glossary.get;
  update is PurviewDataMap.Glossary.update;
  delete is PurviewDataMap.Glossary.delete;
  getCategories is PurviewDataMap.Glossary.listCategories;
  getCategoriesHeaders is PurviewDataMap.Glossary.listCategoriesHeaders;
  getDetailed is PurviewDataMap.Glossary.getDetailed;
  partialUpdate is PurviewDataMap.Glossary.partialUpdate;
  getTerms is PurviewDataMap.Glossary.listTerms;
  getTermHeaders is PurviewDataMap.Glossary.listTermHeaders;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@operationGroup
interface Discovery {
  query is PurviewDataMap.Discovery.query;
  suggest is PurviewDataMap.Discovery.suggest;
  autoComplete is PurviewDataMap.Discovery.autoComplete;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@operationGroup
interface Lineage {
  get is PurviewDataMap.Lineage.get;
  getNextPage is PurviewDataMap.Lineage.getNextPage;
  getByUniqueAttribute is PurviewDataMap.Lineage.getByUniqueAttribute;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@operationGroup
interface Relationship {
  create is PurviewDataMap.Relationship.create;
  update is PurviewDataMap.Relationship.update;
  get is PurviewDataMap.Relationship.get;
  delete is PurviewDataMap.Relationship.delete;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@operationGroup
interface TypeDefinition {
  getBusinessMetadataById is PurviewDataMap.Type.getBusinessMetadataDefByGuid;
  getBusinessMetadataByName is PurviewDataMap.Type.getBusinessMetadataDefByName;
  getClassificationById is PurviewDataMap.Type.getClassificationDefByGuid;
  getClassificationByName is PurviewDataMap.Type.getClassificationDefByName;
  getEntityById is PurviewDataMap.Type.getEntityDefByGuid;
  getEntityByName is PurviewDataMap.Type.getEntityDefByName;
  getEnumById is PurviewDataMap.Type.getEnumDefByGuid;
  getEnumByName is PurviewDataMap.Type.getEnumDefByName;
  getRelationshipById is PurviewDataMap.Type.getRelationshipDefByGuid;
  getRelationshipByName is PurviewDataMap.Type.getRelationshipDefByName;
  getStructById is PurviewDataMap.Type.getStructDefByGuid;
  getStructByName is PurviewDataMap.Type.getStructDefByName;
  getById is PurviewDataMap.Type.getByGuid;
  getByName is PurviewDataMap.Type.getByName;
  delete is PurviewDataMap.Type.delete;
  get is PurviewDataMap.Type.list;
  batchCreate is PurviewDataMap.Type.bulkCreate;
  batchUpdate is PurviewDataMap.Type.bulkUpdate;
  batchDelete is PurviewDataMap.Type.bulkDelete;
  getHeaders is PurviewDataMap.Type.listHeaders;
  getTermTemplateById is PurviewDataMap.Type.getTermTemplateDefByGuid;
  getTermTemplateByName is PurviewDataMap.Type.getTermTemplateDefByName;
}
