FROM microsoft/windowsservercore AS tools

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Install Git
RUN Invoke-WebRequest https://github.com/git-for-windows/git/releases/download/v2.14.1.windows.1/MinGit-2.14.1-64-bit.zip -OutFile git.zip; \
    Expand-Archive git.zip -DestinationPath $Env:ProgramFiles\Git ; \
    Remove-Item -Force git.zip

# Install Mercurial
RUN Invoke-WebRequest https://bitbucket.org/tortoisehg/files/downloads/mercurial-4.2.1-x64.msi -OutFile hg.msi; \
    Start-Process msiexec -Wait -ArgumentList /q, /i, hg.msi ; \
    Remove-Item -Force hg.msi

# Install Open JDK
RUN Invoke-WebRequest https://github.com/ojdkbuild/ojdkbuild/releases/download/1.8.0.131-1/java-1.8.0-openjdk-1.8.0.131-1.b11.ojdkbuild.windows.x86_64.zip -OutFile openjdk.zip; \
    Expand-Archive openjdk.zip -DestinationPath $Env:ProgramFiles\Java\OpenJDK; \
    Remove-Item -Force openjdk.zip

# Install .NET Core SDK
RUN Invoke-WebRequest https://download.microsoft.com/download/1/B/4/1B4DE605-8378-47A5-B01B-2C79D6C55519/dotnet-sdk-2.0.0-win-x64.zip -OutFile dotnet.zip; \
    Expand-Archive dotnet.zip -DestinationPath $Env:ProgramFiles\dotnet; \
    Remove-Item -Force dotnet.zip

FROM teamcity-minimal-agent:latest-windowsservercore

ENV GIT_HOME="C:\Program Files\Git" \
    HG_HOME="C:\Program Files\Mercurial" \
    JAVA_HOME="C:\Program Files\Java\OpenJDK" \
    DOTNET_HOME="C:\Program Files\dotnet" \
    NUGET_XMLDOC_MODE=skip \
    DOTNET_CLI_TELEMETRY_OPTOUT=true \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true

COPY --from=tools $GIT_HOME $GIT_HOME
COPY --from=tools $HG_HOME $HG_HOME
COPY --from=tools $JAVA_HOME $JAVA_HOME
COPY --from=tools $DOTNET_HOME $DOTNET_HOME

RUN setx /M PATH "%PATH%;%GIT_HOME%\cmd;%HG_HOME%;%DOTNET_HOME%"

# Trigger the population of the local package cache
RUN powershell -Command \
    $ErrorActionPreference = 'Stop'; \
    $ProgressPreference = 'SilentlyContinue'; \
    New-Item -Type Directory warmup; \
    cd warmup; \
    dotnet new; \
    cd ..; \
    Remove-Item -Force -Recurse warmup