ARG SDK_TAG=8.0
ARG RUNTIME_TAG=8.0

FROM registry.suse.com/bci/dotnet-sdk:${SDK_TAG} AS build
WORKDIR /src
COPY app/ ./
RUN dotnet publish ./HelloWorld.csproj -c Release -o /app/publish

FROM registry.suse.com/bci/dotnet-runtime:${RUNTIME_TAG}
LABEL maintainer="erico.mendonca@suse.com"

WORKDIR /app
COPY --from=build --chown=app:app /app/publish .

USER app
ENTRYPOINT ["dotnet", "HelloWorld.dll"]
