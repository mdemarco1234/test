FROM FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build-env
WORKDIR .

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim
WORKDIR .
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "aspnet-core-dotnet-core.dll"]
