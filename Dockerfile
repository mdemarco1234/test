FROM mcr.microsoft.com/dotnet/runtime:5.0 AS base
WORKDIR /bin/sh
EXPOSE 80

#opy /Bin/Debug .

#ENTRYPOINT ["consoletest.exe"]


FROM mcr.microsoft.com/dotnet/runtime:5.0 AS build
WORKDIR /bin/sh
COPY ["consoletest.csproj", "/bin/sh"]
RUN dotnet restore "consoletest.csproj"
#COPY . .
#WORKDIR "/src/MyApp"
RUN dotnet build "consoletest.csproj" -c Release -o /bin/sh

#FROM build AS publish
#RUN dotnet publish "consoletest.csproj" -c Release -o /app/publish

#FROM base AS final
#WORKDIR /app
#COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "consoletest.exe"]
