FROM mcr.microsoft.com/dotnet/sdk:6.0 AS base
WORKDIR /app
EXPOSE 80

#opy /Bin/Debug .

#ENTRYPOINT ["consoletest.exe"]


FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app        
COPY ["consoletest.csproj", "/app"]
RUN dotnet restore "/app/consoletest.csproj"
COPY . .
WORKDIR /app              
RUN dotnet build "/app/consoletest.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "consoletest.exe" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "consoletest.exe"]
