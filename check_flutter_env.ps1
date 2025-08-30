Write-Host "Checking Flutter environment..." -ForegroundColor Cyan

# 1. Check Flutter
if (Get-Command flutter -ErrorAction SilentlyContinue) {
    flutter --version
    flutter doctor -v
} else {
    Write-Host "Flutter not found in PATH" -ForegroundColor Red
}

# 2. Check Dart
if (Get-Command dart -ErrorAction SilentlyContinue) {
    dart --version
} else {
    Write-Host "Dart not found in PATH" -ForegroundColor Red
}

# 3. Check Java / JDK
if (Get-Command java -ErrorAction SilentlyContinue) {
    java -version
} else {
    Write-Host "Java (JDK) not found in PATH" -ForegroundColor Red
}

# 4. Check Android SDK
if ($env:ANDROID_HOME -or $env:ANDROID_SDK_ROOT) {
    Write-Host "ANDROID_SDK found at $env:ANDROID_HOME$env:ANDROID_SDK_ROOT"
} else {
    Write-Host "ANDROID_SDK not set (set ANDROID_HOME or ANDROID_SDK_ROOT)" -ForegroundColor Red
}

# 5. Check Gradle Wrapper files in android/
$gradleWrapperPath = "android\gradle\wrapper\gradle-wrapper.properties"
$gradleJarPath = "android\gradle\wrapper\gradle-wrapper.jar"
$gradlew = "android\gradlew"
$gradlewBat = "android\gradlew.bat"

if (Test-Path $gradleWrapperPath -PathType Leaf -and Test-Path $gradleJarPath -PathType Leaf) {
    Write-Host "Gradle wrapper files found"
} else {
    Write-Host "Gradle wrapper files missing. Run 'gradle wrapper' or 'flutter create .' inside android/" -ForegroundColor Red
}

if (Test-Path $gradlew -PathType Leaf -and Test-Path $gradlewBat -PathType Leaf) {
    Write-Host "gradlew and gradlew.bat found"
} else {
    Write-Host "gradlew scripts missing in android/ folder" -ForegroundColor Red
}

# 6. Check pubspec.yaml
if (Test-Path "pubspec.yaml" -PathType Leaf) {
    Write-Host "pubspec.yaml found. Running flutter pub get..."
    flutter pub get
} else {
    Write-Host "pubspec.yaml missing in project root" -ForegroundColor Red
}

Write-Host "Check completed!" -ForegroundColor Green
