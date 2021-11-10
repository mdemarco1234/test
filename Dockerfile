FROM mcr.microsoft.com/dotnet/runtime:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443


FROM mcr.microsoft.com/dotnet/runtime:5.0 AS build
#WORKDIR /src
#COPY ["consoletest.csproj", "/"]
RUN dotnet restore "consoletest.csproj"
COPY . .
#WORKDIR "/src/MyApp"
RUN dotnet build "consoletest.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "consoletest.csproj" -c Release -o /app/publish

FROM base AS final
#WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "consoletest.exe"]
