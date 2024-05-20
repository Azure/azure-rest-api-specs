- Install typespec as per instructions
https://github.com/Microsoft/typespec

- Install providerhub controller
npm i @azure-tools/typespec-providerhub-controller

- Initialize directory
tsp init

- Compile typespec and generate swagger and code
tsp compile . --emit @azure-tools/typespec-autorest --emit @azure-tools/typespec-providerhub-controller
