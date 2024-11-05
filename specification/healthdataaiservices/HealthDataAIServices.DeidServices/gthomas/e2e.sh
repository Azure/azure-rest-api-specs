pwd

printf "🪓Regenerating OpenAPI and examples from Typespec.\n"
printf "Written by: gthomas\n\n"

VERSION_TYPE="stable"
VERSION="2024-11-15"
TIME_GAP=0.3
printf "Working Version: $VERSION\n\n"
sleep 1

printf "🪒 Removing old files.\n"
rm ../data-plane/HealthDataAIServices.DeidServices/$VERSION_TYPE/$VERSION/examples/*.json
rm ../data-plane/HealthDataAIServices.DeidServices/$VERSION_TYPE/$VERSION/*.json
rm examples/$VERSION/*.json
sleep $TIME_GAP

printf "🪒 Compiling OpenAPI Spec\n"
mkdir -p examples/$VERSION
. gthomas/compile.sh
sleep $TIME_GAP

printf "🪒 Generating examples\n"
. gthomas/generate.sh > /dev/null
sleep $TIME_GAP

printf "🪒 Hydrating Examples\n"
python gthomas/hydrate_examples.py "../data-plane/HealthDataAIServices.DeidServices/$VERSION_TYPE/$VERSION/examples"
sleep $TIME_GAP

printf "🪒 Prettier\n"
npx prettier --write ../data-plane/HealthDataAIServices.DeidServices/$VERSION_TYPE/$VERSION/examples/*.json --config ../../../.prettierrc.json
sleep $TIME_GAP

printf "🪒 Recompiling...\n"
mv ../data-plane/HealthDataAIServices.DeidServices/$VERSION_TYPE/$VERSION/examples/*.json examples/$VERSION/
. gthomas/compile.sh

printf "✅ Done.\n"