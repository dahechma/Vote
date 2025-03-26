

# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Define build arguments with default values
ARG BUILDPLATFORM
ARG TARGETPLATFORM
ARG TARGETARCH

# Print build arguments for debugging
RUN echo "BUILDPLATFORM: $BUILDPLATFORM" && \
    echo "TARGETPLATFORM: $TARGETPLATFORM" && \
    echo "TARGETARCH: ${TARGETARCH}"

# Set working directory for build
WORKDIR /source

# Copy all worker files from the local 'source' directory into the container
COPY source/ ./

# Restore dependencies using the target architecture (use ${TARGETARCH} for expansion)
RUN dotnet restore -a $TARGETARCH

# Publish the application into the /app directory
RUN dotnet publish -c Release -o /app -a $TARGETARCH --self-contained false --no-restore

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/runtime:8.0

# Set working directory for runtime
WORKDIR /app

# Copy published output from the build stage
COPY --from=build /app .

# Launch the worker application
CMD ["dotnet", "Worker.dll"]
