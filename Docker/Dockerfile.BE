# Use the official .NET image as a build environment
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["GamePriceComparator.BE.dotnet8/GamePriceComparator.BE.dotnet8.sln", "./"]
COPY ["GamePriceComparator.BE.dotnet8/Host/Host.csproj", "Host/"]
RUN dotnet restore "Host/Host.csproj"
COPY . .
WORKDIR "/src/GamePriceComparator.BE.dotnet8/Host"
RUN dotnet build "Host.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Host.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Host.dll"]


