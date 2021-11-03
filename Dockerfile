FROM mcr.microsoft.com/dotnet/core/sdk/5.0-alpine

WORKDIR /

COPY consoletest.csproj .

run dotnet restore

COPY . .


run dotnet build -c Release
#dotnet test
run dotnet publish -c Release -o /dist   

FROM mcr.microsoft.com/dotnet/core/sdk/5.0-alpine

WORKDIR /dist

COPY ..from build /dist   

CMD["dotnet", "test.dll"]   