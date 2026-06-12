FROM ://microsoft.com AS build
WORKDIR /src
COPY ["LcmService.csproj", "./"]
RUN dotnet restore "./LcmService.csproj"
COPY . .
RUN dotnet publish "LcmService.csproj" -c Release -o /app/publish

FROM ://microsoft.com AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "LcmService.dll"]
