FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY ["LCMservice.csproj", "./"]
RUN dotnet restore "./LCMservice.csproj"
COPY . .
RUN dotnet publish "LCMservice.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "LCMservice.dll"]
