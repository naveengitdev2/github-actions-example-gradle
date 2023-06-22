name: build_image
on:
  push:
    paths:
      - "src/docker/**"
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: ACR build
        id: acr
        uses: azure/acr-build@v1
        with:
          service_principal: ${{ secrets.service_principal }}
          service_principal_password: ${{ secrets.service_principal_password }}
          tenant: ${{ secrets.tenant }}
          registry: ${{ secrets.registry }}
          repository: ${{ secrets.repository }}
          image: image
          git_access_token: ${{ secrets.git_access_token }}
          folder: src/docker
          dockerfile: ../../dockerfiles/Dockerfile
          branch: main
          build_args: '[{"arg_one":"value_one"}, {"arg_two":"value_two"}]'
