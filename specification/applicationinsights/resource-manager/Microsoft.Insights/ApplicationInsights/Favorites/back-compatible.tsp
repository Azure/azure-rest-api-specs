import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Favorites;

// @@clientName(ApplicationInsightsComponentFavorite.Name, "name");
// @@clientName(ApplicationInsightsComponentFavorite.Config, "config");
// @@clientName(ApplicationInsightsComponentFavorite.Version, "version");
// @@clientName(ApplicationInsightsComponentFavorite.FavoriteId, "favoriteId");
// @@clientName(ApplicationInsightsComponentFavorite.FavoriteType, "favoriteType");
// @@clientName(ApplicationInsightsComponentFavorite.SourceType, "sourceType");
// @@clientName(ApplicationInsightsComponentFavorite.TimeModified, "timeModified");
// @@clientName(ApplicationInsightsComponentFavorite.Tags, "tags");
// @@clientName(ApplicationInsightsComponentFavorite.Category, "category");
// @@clientName(ApplicationInsightsComponentFavorite.UserId, "userId");

@@clientLocation(FavoritesOperationGroup.list, "Favorites");
@@clientLocation(FavoritesOperationGroup.get, "Favorites");
@@clientLocation(FavoritesOperationGroup.add, "Favorites");
@@clientLocation(FavoritesOperationGroup.update, "Favorites");
@@clientLocation(FavoritesOperationGroup.delete, "Favorites");
